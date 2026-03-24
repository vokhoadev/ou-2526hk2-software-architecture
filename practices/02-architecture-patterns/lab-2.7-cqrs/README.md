# Lab 2.7: CQRS Pattern (Command Query Responsibility Segregation)

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 4 giờ |
| **Độ khó** | Advanced |
| **CLO** | CLO2, CLO3, CLO6 |
| **Công nghệ** | Node.js, EventStore/PostgreSQL |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu CQRS pattern và lý do sử dụng
2. Phân biệt Command và Query
3. Triển khai CQRS với separate models
4. Hiểu mối quan hệ với Event Sourcing

---

## Phần 1: CQRS Theory (45 phút)

### 1.1 Vấn đề với Traditional CRUD

```
┌─────────────────────────────────────────────────────────┐
│ Traditional CRUD │
│ │
│ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ │
│ │ Create │ │ Read │ │ Update │ │
│ │ Delete │ │ (Query) │ │ │ │
│ └──────┬──────┘ └──────┬──────┘ └──────┬──────┘ │
│ │ │ │ │
│ └──────────────────┼──────────────────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────┐ │
│ │ Same Model │ │
│ │ Same Database │ │
│ └─────────────────┘ │
└─────────────────────────────────────────────────────────┘

Problems:
- Read và Write có requirements khác nhau
- Complex queries chậm do normalized data
- Scalability issues
- Model trở nên phức tạp
```

### 1.2 CQRS Solution

```
┌──────────────────────────────────────────────────────────────────┐
│ CQRS │
│ │
│ ┌─────────────────────────┐ ┌─────────────────────────┐ │
│ │ Command Side │ │ Query Side │ │
│ │ │ │ │ │
│ │ ┌─────────────────┐ │ │ ┌─────────────────┐ │ │
│ │ │ Command Handler │ │ │ │ Query Handler │ │ │
│ │ └────────┬────────┘ │ │ └────────┬────────┘ │ │
│ │ │ │ │ │ │ │
│ │ ▼ │ │ ▼ │ │
│ │ ┌─────────────────┐ │ │ ┌─────────────────┐ │ │
│ │ │ Write Model │ │ │ │ Read Model │ │ │
│ │ │ (Domain) │ │ │ │ (Projections) │ │ │
│ │ └────────┬────────┘ │ │ └────────┬────────┘ │ │
│ │ │ │ │ │ │ │
│ │ ▼ │ │ ▼ │ │
│ │ ┌─────────────────┐ │ │ ┌─────────────────┐ │ │
│ │ │ Write Database │───sync──│ │ Read Database │ │ │
│ │ │ (Normalized) │ │ │ │ (Denormalized) │ │ │
│ │ └─────────────────┘ │ │ └─────────────────┘ │ │
│ └─────────────────────────┘ └─────────────────────────┘ │
└──────────────────────────────────────────────────────────────────┘
```

### 1.3 Key Concepts

| Concept | Description |
|---------|-------------|
| **Command** | Intent to change state (CreateOrder, UpdateProfile) |
| **Query** | Request for data, no side effects (GetOrders, FindUser) |
| **Write Model** | Optimized for business logic, validation |
| **Read Model** | Optimized for queries, denormalized |
| **Projection** | Process that updates Read Model from events |

### 1.4 When to Use CQRS

**Good fit:**
- Complex domain logic
- Different read/write workloads
- Need to scale reads and writes independently
- Event sourcing requirements

**Bad fit:**
- Simple CRUD applications
- Small teams
- Low read/write disparity
- No complex queries

---

## Phần 2: Hands-on CQRS Implementation (120 phút)

### 2.1 Project Structure

```
cqrs-demo/
├── src/
│ ├── commands/ # Command side
│ │ ├── handlers/
│ │ │ ├── CreateOrderHandler.ts
│ │ │ └── UpdateOrderHandler.ts
│ │ ├── commands/
│ │ │ ├── CreateOrderCommand.ts
│ │ │ └── UpdateOrderCommand.ts
│ │ └── CommandBus.ts
│ │
│ ├── queries/ # Query side
│ │ ├── handlers/
│ │ │ ├── GetOrderHandler.ts
│ │ │ └── GetOrdersHandler.ts
│ │ ├── queries/
│ │ │ ├── GetOrderQuery.ts
│ │ │ └── GetOrdersQuery.ts
│ │ └── QueryBus.ts
│ │
│ ├── domain/ # Domain (Write) model
│ │ ├── Order.ts
│ │ └── OrderRepository.ts
│ │
│ ├── read-models/ # Read models (projections)
│ │ ├── OrderReadModel.ts
│ │ └── OrderProjection.ts
│ │
│ ├── events/ # Domain events
│ │ ├── OrderCreatedEvent.ts
│ │ └── EventBus.ts
│ │
│ ├── infrastructure/
│ │ ├── WriteDatabase.ts
│ │ └── ReadDatabase.ts
│ │
│ └── api/
│ └── OrderController.ts
├── package.json
└── tsconfig.json
```

### 2.2 Commands

```typescript
// src/commands/commands/CreateOrderCommand.ts
export class CreateOrderCommand {
 constructor(
 public readonly customerId: string,
 public readonly items: Array<{
 productId: string;
 productName: string;
 quantity: number;
 price: number;
 }>
 ) {}
}
```

```typescript
// src/commands/commands/UpdateOrderStatusCommand.ts
export class UpdateOrderStatusCommand {
 constructor(
 public readonly orderId: string,
 public readonly status: 'confirmed' | 'shipped' | 'delivered' | 'cancelled'
 ) {}
}
```

### 2.3 Command Handlers

```typescript
// src/commands/handlers/CreateOrderHandler.ts
import { v4 as uuidv4 } from 'uuid';
import { CreateOrderCommand } from '../commands/CreateOrderCommand';
import { Order, OrderStatus } from '../../domain/Order';
import { OrderRepository } from '../../domain/OrderRepository';
import { EventBus } from '../../events/EventBus';
import { OrderCreatedEvent } from '../../events/OrderCreatedEvent';

export class CreateOrderHandler {
 constructor(
 private readonly orderRepository: OrderRepository,
 private readonly eventBus: EventBus
 ) {}

 async handle(command: CreateOrderCommand): Promise<string> {
 // Create domain entity
 const orderId = uuidv4();

 const order = new Order(
 orderId,
 command.customerId,
 command.items,
 OrderStatus.PENDING
 );

 // Validate business rules
 order.validate();

 // Persist to write database
 await this.orderRepository.save(order);

 // Publish event for read model synchronization
 await this.eventBus.publish(new OrderCreatedEvent(
 orderId,
 command.customerId,
 command.items,
 order.calculateTotal(),
 new Date()
 ));

 return orderId;
 }
}
```

```typescript
// src/commands/handlers/UpdateOrderStatusHandler.ts
import { UpdateOrderStatusCommand } from '../commands/UpdateOrderStatusCommand';
import { OrderRepository } from '../../domain/OrderRepository';
import { EventBus } from '../../events/EventBus';
import { OrderStatusUpdatedEvent } from '../../events/OrderStatusUpdatedEvent';

export class UpdateOrderStatusHandler {
 constructor(
 private readonly orderRepository: OrderRepository,
 private readonly eventBus: EventBus
 ) {}

 async handle(command: UpdateOrderStatusCommand): Promise<void> {
 const order = await this.orderRepository.findById(command.orderId);

 if (!order) {
 throw new Error('Order not found');
 }

 // Apply business logic
 order.updateStatus(command.status);

 // Persist
 await this.orderRepository.save(order);

 // Publish event
 await this.eventBus.publish(new OrderStatusUpdatedEvent(
 command.orderId,
 command.status,
 new Date()
 ));
 }
}
```

### 2.4 Command Bus

```typescript
// src/commands/CommandBus.ts
type CommandHandler<T> = {
 handle(command: T): Promise<any>;
};

export class CommandBus {
 private handlers = new Map<string, CommandHandler<any>>();

 register<T>(commandName: string, handler: CommandHandler<T>): void {
 this.handlers.set(commandName, handler);
 }

 async dispatch<T>(command: T): Promise<any> {
 const commandName = command.constructor.name;
 const handler = this.handlers.get(commandName);

 if (!handler) {
 throw new Error(`No handler registered for ${commandName}`);
 }

 return handler.handle(command);
 }
}
```

### 2.5 Queries

```typescript
// src/queries/queries/GetOrderQuery.ts
export class GetOrderQuery {
 constructor(public readonly orderId: string) {}
}
```

```typescript
// src/queries/queries/GetOrdersQuery.ts
export class GetOrdersQuery {
 constructor(
 public readonly customerId?: string,
 public readonly status?: string,
 public readonly page: number = 1,
 public readonly limit: number = 10
 ) {}
}
```

### 2.6 Query Handlers

```typescript
// src/queries/handlers/GetOrderHandler.ts
import { GetOrderQuery } from '../queries/GetOrderQuery';
import { OrderReadModel } from '../../read-models/OrderReadModel';
import { ReadDatabase } from '../../infrastructure/ReadDatabase';

export interface OrderView {
 id: string;
 customerId: string;
 customerName: string;
 items: Array<{
 productId: string;
 productName: string;
 quantity: number;
 price: number;
 subtotal: number;
 }>;
 total: number;
 status: string;
 createdAt: Date;
 updatedAt: Date;
}

export class GetOrderHandler {
 constructor(private readonly readDb: ReadDatabase) {}

 async handle(query: GetOrderQuery): Promise<OrderView | null> {
 // Query directly from denormalized read model
 return this.readDb.orders.findOne({ id: query.orderId });
 }
}
```

```typescript
// src/queries/handlers/GetOrdersHandler.ts
import { GetOrdersQuery } from '../queries/GetOrdersQuery';
import { ReadDatabase } from '../../infrastructure/ReadDatabase';

export interface OrderListView {
 orders: Array<{
 id: string;
 customerName: string;
 total: number;
 status: string;
 itemCount: number;
 createdAt: Date;
 }>;
 pagination: {
 total: number;
 page: number;
 limit: number;
 totalPages: number;
 };
}

export class GetOrdersHandler {
 constructor(private readonly readDb: ReadDatabase) {}

 async handle(query: GetOrdersQuery): Promise<OrderListView> {
 const filter: any = {};

 if (query.customerId) {
 filter.customerId = query.customerId;
 }
 if (query.status) {
 filter.status = query.status;
 }

 const total = await this.readDb.orders.count(filter);
 const orders = await this.readDb.orders.find(filter, {
 skip: (query.page - 1) * query.limit,
 limit: query.limit,
 sort: { createdAt: -1 }
 });

 return {
 orders: orders.map(o => ({
 id: o.id,
 customerName: o.customerName,
 total: o.total,
 status: o.status,
 itemCount: o.items.length,
 createdAt: o.createdAt
 })),
 pagination: {
 total,
 page: query.page,
 limit: query.limit,
 totalPages: Math.ceil(total / query.limit)
 }
 };
 }
}
```

### 2.7 Event Handling & Projections

```typescript
// src/events/OrderCreatedEvent.ts
export class OrderCreatedEvent {
 public readonly eventType = 'OrderCreated';
 public readonly occurredAt: Date;

 constructor(
 public readonly orderId: string,
 public readonly customerId: string,
 public readonly items: Array<{
 productId: string;
 productName: string;
 quantity: number;
 price: number;
 }>,
 public readonly total: number,
 occurredAt?: Date
 ) {
 this.occurredAt = occurredAt || new Date();
 }
}
```

```typescript
// src/read-models/OrderProjection.ts
import { OrderCreatedEvent } from '../events/OrderCreatedEvent';
import { OrderStatusUpdatedEvent } from '../events/OrderStatusUpdatedEvent';
import { ReadDatabase } from '../infrastructure/ReadDatabase';

export class OrderProjection {
 constructor(private readonly readDb: ReadDatabase) {}

 async handleOrderCreated(event: OrderCreatedEvent): Promise<void> {
 // Fetch additional data (e.g., customer name)
 const customer = await this.readDb.customers.findOne({
 id: event.customerId
 });

 // Build denormalized read model
 const orderView = {
 id: event.orderId,
 customerId: event.customerId,
 customerName: customer?.name || 'Unknown',
 items: event.items.map(item => ({
 ...item,
 subtotal: item.quantity * item.price
 })),
 total: event.total,
 status: 'pending',
 createdAt: event.occurredAt,
 updatedAt: event.occurredAt
 };

 await this.readDb.orders.insert(orderView);
 }

 async handleOrderStatusUpdated(event: OrderStatusUpdatedEvent): Promise<void> {
 await this.readDb.orders.update(
 { id: event.orderId },
 {
 status: event.status,
 updatedAt: event.occurredAt
 }
 );
 }
}
```

### 2.8 API Controller

```typescript
// src/api/OrderController.ts
import express, { Router, Request, Response } from 'express';
import { CommandBus } from '../commands/CommandBus';
import { QueryBus } from '../queries/QueryBus';
import { CreateOrderCommand } from '../commands/commands/CreateOrderCommand';
import { UpdateOrderStatusCommand } from '../commands/commands/UpdateOrderStatusCommand';
import { GetOrderQuery } from '../queries/queries/GetOrderQuery';
import { GetOrdersQuery } from '../queries/queries/GetOrdersQuery';

export function createOrderRouter(
 commandBus: CommandBus,
 queryBus: QueryBus
): Router {
 const router = express.Router();

 // Commands (Write operations)
 router.post('/', async (req: Request, res: Response) => {
 try {
 const command = new CreateOrderCommand(
 req.body.customerId,
 req.body.items
 );
 const orderId = await commandBus.dispatch(command);
 res.status(201).json({ orderId });
 } catch (error: any) {
 res.status(400).json({ error: error.message });
 }
 });

 router.patch('/:id/status', async (req: Request, res: Response) => {
 try {
 const command = new UpdateOrderStatusCommand(
 req.params.id,
 req.body.status
 );
 await commandBus.dispatch(command);
 res.status(200).json({ message: 'Status updated' });
 } catch (error: any) {
 res.status(400).json({ error: error.message });
 }
 });

 // Queries (Read operations)
 router.get('/', async (req: Request, res: Response) => {
 const query = new GetOrdersQuery(
 req.query.customerId as string,
 req.query.status as string,
 parseInt(req.query.page as string) || 1,
 parseInt(req.query.limit as string) || 10
 );
 const result = await queryBus.dispatch(query);
 res.json(result);
 });

 router.get('/:id', async (req: Request, res: Response) => {
 const query = new GetOrderQuery(req.params.id);
 const result = await queryBus.dispatch(query);

 if (!result) {
 return res.status(404).json({ error: 'Order not found' });
 }
 res.json(result);
 });

 return router;
}
```

---

## Phần 3: CQRS + Event Sourcing (30 phút)

### 3.1 Event Sourcing Overview

```
┌─────────────────────────────────────────────────────────────────┐
│ CQRS + Event Sourcing │
│ │
│ Command ── Domain ── Events ──┬── Event Store │
│ │ │
│ └── Projections ── Read DB │
│ │
│ Query ────────────────────────────────────────── Read DB │
└─────────────────────────────────────────────────────────────────┘
```

### 3.2 Benefits of Combining

- **Audit trail**: Complete history of all changes
- **Temporal queries**: Query state at any point in time
- **Event replay**: Rebuild read models from events
- **Debugging**: Understand exactly what happened

---

## Self-Assessment (30 câu)

### Cơ bản (1-10)

1. CQRS là viết tắt của gì?
2. Command là gì?
3. Query là gì?
4. Command khác Query như thế nào?
5. Write model là gì?
6. Read model là gì?
7. Command Handler làm gì?
8. Query Handler làm gì?
9. Tại sao tách Read/Write?
10. CQRS có cần Event Sourcing không?

### Trung bình (11-20)

11. Command Bus là gì?
12. Query Bus là gì?
13. Projection là gì?
14. Eventual consistency trong CQRS?
15. Synchronous vs Asynchronous projections?
16. Multiple read models?
17. CQRS với DDD?
18. Aggregate trong CQRS?
19. Domain Events trong CQRS?
20. Validation trong Commands?

### Nâng cao (21-30)

21. CQRS + Event Sourcing?
22. Khi nào KHÔNG nên dùng CQRS?
23. CQRS complexity overhead?
24. CQRS với Microservices?
25. Saga pattern với CQRS?
26. Testing CQRS systems?
27. CQRS performance patterns?
28. CQRS security considerations?
29. CQRS debugging strategies?
30. Production CQRS examples?

**Đáp án gợi ý:**
- 1: Command Query Responsibility Segregation
- 2: Request thay đổi state (write)
- 3: Request đọc data (read)
- 22: Simple CRUD, small teams, low read/write asymmetry

---

## Extend Labs (10 bài)

### EL1: Event Sourcing + CQRS
```
Mục tiêu: Full pattern
- Event store
- Event replay
- Snapshots
Độ khó: *****
```

### EL2: Multiple Projections
```
Mục tiêu: Specialized views
- Dashboard view
- Search view
- Report view
Độ khó: ****
```

### EL3: E-Commerce CQRS
```
Mục tiêu: Real-world
- Order commands
- Inventory queries
- Async processing
Độ khó: ****
```

### EL4: Saga Orchestration
```
Mục tiêu: Distributed transactions
- Saga orchestrator
- Compensation
- Timeout handling
Độ khó: *****
```

### EL5: Real-time Projections
```
Mục tiêu: Live updates
- WebSocket notifications
- SignalR/Socket.io
- Optimistic updates
Độ khó: ****
```

### EL6: GraphQL với CQRS
```
Mục tiêu: Query flexibility
- Queries → Read side
- Mutations → Commands
- Subscriptions
Độ khó: ****
```

### EL7: Performance Testing
```
Mục tiêu: Benchmark
- Write throughput
- Read latency
- Projection lag
Độ khó: ***
```

### EL8: Audit Trail
```
Mục tiêu: Compliance
- Complete history
- Point-in-time queries
- Regulatory reports
Độ khó: ****
```

### EL9: Schema Evolution
```
Mục tiêu: Event versioning
- Upcasting
- Downcasting
- Backward compatibility
Độ khó: *****
```

### EL10: Production Deployment
```
Mục tiêu: Operations
- Monitoring
- Debugging
- Disaster recovery
Độ khó: *****
```

---

## Deliverables

1. [ ] Command và Command Handlers
2. [ ] Query và Query Handlers
3. [ ] Command Bus và Query Bus
4. [ ] Event-based projection
5. [ ] Separate read/write models
6. [ ] REST API integration

---

## Tiếp theo

Chuyển đến: `lab-2.8-strangler-fig/`

---

## Phân bổ Thời gian: Lý thuyết 40', Command side 50', Query side 50', Sync 40' = 3 giờ

## Lời giải Mẫu
- Command: Write operations, validate, update state
- Query: Read operations, optimized views
- Sync: Event-driven hoặc eventual consistency

## Các Lỗi Thường Gặp
| Lỗi | Cách sửa |
|-----|----------|
| Over-engineering | Chỉ dùng CQRS khi thực sự cần |
| Sync issues | Implement eventual consistency đúng |
| Read/Write model mismatch | Clear mapping strategy |

## Chấm điểm: Command handling 30, Query optimization 30, Sync mechanism 25, Testing 15 = 100

## Tham khảo: Greg Young (creator), Microsoft Docs, CMU 15-445
