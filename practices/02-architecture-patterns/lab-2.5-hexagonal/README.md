# Lab 2.5: Hexagonal Architecture (Ports & Adapters)

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 4 giờ |
| **Độ khó** | Advanced |
| **CLO** | CLO2, CLO3, CLO6 |
| **Công nghệ** | Java/TypeScript |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu Hexagonal Architecture và lý do sử dụng
2. Phân biệt Ports và Adapters
3. Triển khai ứng dụng theo Hexagonal pattern
4. Viết tests dễ dàng nhờ dependency inversion

---

## Phần 1: Lý thuyết Hexagonal Architecture (45 phút)

### 1.1 Tổng quan

**Hexagonal Architecture** (còn gọi là Ports & Adapters) do Alistair Cockburn đề xuất (2005), tập trung vào việc **tách biệt business logic** khỏi external concerns.

```
 ┌─────────────────────────────────────┐
 │ Driving Adapters │
 │ (REST API, CLI, GraphQL, Tests) │
 └───────────────┬─────────────────────┘
 │
 ▼ (Input Ports)
 ┌───────────────────────────────────────────────────┐
 │ │
 │ APPLICATION CORE │
 │ │
 │ ┌─────────────────────────────────────────┐ │
 │ │ DOMAIN MODEL │ │
 │ │ │ │
 │ │ Entities, Value Objects, Services │ │
 │ │ │ │
 │ └─────────────────────────────────────────┘ │
 │ │
 │ ┌─────────────────────────────────────────┐ │
 │ │ APPLICATION SERVICES │ │
 │ │ │ │
 │ │ Use Cases, Business Logic │ │
 │ │ │ │
 │ └─────────────────────────────────────────┘ │
 │ │
 └───────────────────────┬───────────────────────────┘
 │
 ▼ (Output Ports)
 ┌─────────────────────────────────────┐
 │ Driven Adapters │
 │ (Database, External APIs, Cache) │
 └─────────────────────────────────────┘
```

### 1.2 Key Concepts

| Concept | Description | Example |
|---------|-------------|---------|
| **Domain** | Business logic thuần, không phụ thuộc | Order, Product entities |
| **Port** | Interface định nghĩa communication | OrderRepository interface |
| **Adapter** | Implementation cụ thể của Port | PostgresOrderRepository |
| **Driving** | Bên ngoài gọi vào application | REST Controller |
| **Driven** | Application gọi ra ngoài | Database adapter |

### 1.3 Ports Types

```
┌────────────────────────────────────────────────────────────────┐
│ HEXAGON (Core) │
│ │
│ ┌─────────────────┐ ┌─────────────────┐ │
│ │ Input Ports │ │ Output Ports │ │
│ │ │ │ │ │
│ │ - OrderService │ │ - OrderRepo │ │
│ │ - ProductService│ │ - PaymentGateway│ │
│ │ - UserService │ │ - EmailService │ │
│ │ │ │ │ │
│ └────────┬────────┘ └────────┬────────┘ │
│ │ │ │
└────────────┼────────────────────────────┼───────────────────────┘
 │ │
 Implemented by Called by Application
 Application Layer Implemented by Infrastructure
 │ │
 ▼ ▼
 ┌────────────────┐ ┌────────────────┐
 │ Driving │ │ Driven │
 │ Adapters │ │ Adapters │
 │ │ │ │
 │ - REST API │ │ - PostgresRepo │
 │ - GraphQL │ │ - StripeAdapter│
 │ - CLI │ │ - SMTPAdapter │
 └────────────────┘ └────────────────┘
```

### 1.4 Dependency Rule

> Dependencies point **inward** - outer layers depend on inner layers, never the reverse.

```
Infrastructure → Application → Domain
 │ │ │
 └── depends on ──┴─ depends on┘
```

---

## Phần 2: Hands-on TypeScript Implementation (120 phút)

### 2.1 Project Structure

```
hexagonal-demo/
├── src/
│ ├── domain/ # Core business logic
│ │ ├── entities/
│ │ │ ├── Order.ts
│ │ │ └── OrderItem.ts
│ │ ├── value-objects/
│ │ │ ├── OrderId.ts
│ │ │ └── Money.ts
│ │ └── services/
│ │ └── OrderDomainService.ts
│ │
│ ├── application/ # Use cases
│ │ ├── ports/
│ │ │ ├── input/
│ │ │ │ └── OrderService.ts # Input port (interface)
│ │ │ └── output/
│ │ │ ├── OrderRepository.ts # Output port (interface)
│ │ │ └── PaymentGateway.ts
│ │ ├── services/
│ │ │ └── OrderServiceImpl.ts # Input port implementation
│ │ └── dto/
│ │ ├── CreateOrderRequest.ts
│ │ └── OrderResponse.ts
│ │
│ ├── infrastructure/ # External adapters
│ │ ├── adapters/
│ │ │ ├── driving/
│ │ │ │ ├── rest/
│ │ │ │ │ └── OrderController.ts
│ │ │ │ └── cli/
│ │ │ │ └── OrderCLI.ts
│ │ │ └── driven/
│ │ │ ├── persistence/
│ │ │ │ ├── InMemoryOrderRepository.ts
│ │ │ │ └── PostgresOrderRepository.ts
│ │ │ └── payment/
│ │ │ └── StripePaymentAdapter.ts
│ │ └── config/
│ │ └── dependencies.ts
│ │
│ └── index.ts
├── tests/
│ ├── unit/
│ └── integration/
├── package.json
└── tsconfig.json
```

### 2.2 Domain Layer

```typescript
// src/domain/value-objects/OrderId.ts
export class OrderId {
 private constructor(private readonly value: string) {
 if (!value || value.trim().length === 0) {
 throw new Error('OrderId cannot be empty');
 }
 }

 static create(): OrderId {
 return new OrderId(crypto.randomUUID());
 }

 static fromString(value: string): OrderId {
 return new OrderId(value);
 }

 toString(): string {
 return this.value;
 }

 equals(other: OrderId): boolean {
 return this.value === other.value;
 }
}
```

```typescript
// src/domain/value-objects/Money.ts
export class Money {
 private constructor(
 private readonly amount: number,
 private readonly currency: string = 'USD'
 ) {
 if (amount < 0) {
 throw new Error('Amount cannot be negative');
 }
 }

 static of(amount: number, currency: string = 'USD'): Money {
 return new Money(amount, currency);
 }

 static zero(currency: string = 'USD'): Money {
 return new Money(0, currency);
 }

 add(other: Money): Money {
 this.ensureSameCurrency(other);
 return new Money(this.amount + other.amount, this.currency);
 }

 multiply(factor: number): Money {
 return new Money(this.amount * factor, this.currency);
 }

 getAmount(): number {
 return this.amount;
 }

 getCurrency(): string {
 return this.currency;
 }

 private ensureSameCurrency(other: Money): void {
 if (this.currency !== other.currency) {
 throw new Error('Currency mismatch');
 }
 }
}
```

```typescript
// src/domain/entities/OrderItem.ts
import { Money } from '../value-objects/Money';

export class OrderItem {
 constructor(
 public readonly productId: string,
 public readonly productName: string,
 public readonly quantity: number,
 public readonly unitPrice: Money
 ) {
 if (quantity <= 0) {
 throw new Error('Quantity must be positive');
 }
 }

 getSubtotal(): Money {
 return this.unitPrice.multiply(this.quantity);
 }
}
```

```typescript
// src/domain/entities/Order.ts
import { OrderId } from '../value-objects/OrderId';
import { Money } from '../value-objects/Money';
import { OrderItem } from './OrderItem';

export enum OrderStatus {
 PENDING = 'PENDING',
 CONFIRMED = 'CONFIRMED',
 PAID = 'PAID',
 SHIPPED = 'SHIPPED',
 DELIVERED = 'DELIVERED',
 CANCELLED = 'CANCELLED'
}

export class Order {
 private items: OrderItem[] = [];
 private status: OrderStatus = OrderStatus.PENDING;
 private readonly createdAt: Date = new Date();

 constructor(
 public readonly id: OrderId,
 public readonly customerId: string
 ) {}

 addItem(item: OrderItem): void {
 if (this.status !== OrderStatus.PENDING) {
 throw new Error('Cannot modify confirmed order');
 }
 this.items.push(item);
 }

 removeItem(productId: string): void {
 if (this.status !== OrderStatus.PENDING) {
 throw new Error('Cannot modify confirmed order');
 }
 this.items = this.items.filter(i => i.productId !== productId);
 }

 getItems(): OrderItem[] {
 return [...this.items];
 }

 getTotal(): Money {
 return this.items.reduce(
 (total, item) => total.add(item.getSubtotal()),
 Money.zero()
 );
 }

 confirm(): void {
 if (this.items.length === 0) {
 throw new Error('Cannot confirm empty order');
 }
 if (this.status !== OrderStatus.PENDING) {
 throw new Error('Order already confirmed');
 }
 this.status = OrderStatus.CONFIRMED;
 }

 markAsPaid(): void {
 if (this.status !== OrderStatus.CONFIRMED) {
 throw new Error('Order must be confirmed before payment');
 }
 this.status = OrderStatus.PAID;
 }

 cancel(): void {
 if (this.status === OrderStatus.SHIPPED || this.status === OrderStatus.DELIVERED) {
 throw new Error('Cannot cancel shipped order');
 }
 this.status = OrderStatus.CANCELLED;
 }

 getStatus(): OrderStatus {
 return this.status;
 }

 getCreatedAt(): Date {
 return this.createdAt;
 }
}
```

### 2.3 Application Layer - Ports

```typescript
// src/application/ports/input/OrderService.ts (Input Port)
import { CreateOrderRequest } from '../../dto/CreateOrderRequest';
import { OrderResponse } from '../../dto/OrderResponse';

export interface OrderService {
 createOrder(request: CreateOrderRequest): Promise<OrderResponse>;
 getOrder(orderId: string): Promise<OrderResponse | null>;
 confirmOrder(orderId: string): Promise<OrderResponse>;
 cancelOrder(orderId: string): Promise<void>;
 getAllOrders(): Promise<OrderResponse[]>;
}
```

```typescript
// src/application/ports/output/OrderRepository.ts (Output Port)
import { Order } from '../../../domain/entities/Order';
import { OrderId } from '../../../domain/value-objects/OrderId';

export interface OrderRepository {
 save(order: Order): Promise<void>;
 findById(id: OrderId): Promise<Order | null>;
 findAll(): Promise<Order[]>;
 delete(id: OrderId): Promise<void>;
}
```

```typescript
// src/application/ports/output/PaymentGateway.ts (Output Port)
import { Money } from '../../../domain/value-objects/Money';

export interface PaymentResult {
 success: boolean;
 transactionId?: string;
 errorMessage?: string;
}

export interface PaymentGateway {
 processPayment(orderId: string, amount: Money): Promise<PaymentResult>;
 refund(transactionId: string): Promise<boolean>;
}
```

### 2.4 Application Layer - Use Cases

```typescript
// src/application/dto/CreateOrderRequest.ts
export interface OrderItemRequest {
 productId: string;
 productName: string;
 quantity: number;
 unitPrice: number;
}

export interface CreateOrderRequest {
 customerId: string;
 items: OrderItemRequest[];
}
```

```typescript
// src/application/dto/OrderResponse.ts
export interface OrderItemResponse {
 productId: string;
 productName: string;
 quantity: number;
 unitPrice: number;
 subtotal: number;
}

export interface OrderResponse {
 id: string;
 customerId: string;
 items: OrderItemResponse[];
 total: number;
 status: string;
 createdAt: Date;
}
```

```typescript
// src/application/services/OrderServiceImpl.ts
import { OrderService } from '../ports/input/OrderService';
import { OrderRepository } from '../ports/output/OrderRepository';
import { CreateOrderRequest } from '../dto/CreateOrderRequest';
import { OrderResponse } from '../dto/OrderResponse';
import { Order } from '../../domain/entities/Order';
import { OrderId } from '../../domain/value-objects/OrderId';
import { OrderItem } from '../../domain/entities/OrderItem';
import { Money } from '../../domain/value-objects/Money';

export class OrderServiceImpl implements OrderService {
 constructor(private readonly orderRepository: OrderRepository) {}

 async createOrder(request: CreateOrderRequest): Promise<OrderResponse> {
 const orderId = OrderId.create();
 const order = new Order(orderId, request.customerId);

 for (const item of request.items) {
 order.addItem(new OrderItem(
 item.productId,
 item.productName,
 item.quantity,
 Money.of(item.unitPrice)
 ));
 }

 await this.orderRepository.save(order);
 return this.toResponse(order);
 }

 async getOrder(orderId: string): Promise<OrderResponse | null> {
 const order = await this.orderRepository.findById(
 OrderId.fromString(orderId)
 );
 return order ? this.toResponse(order) : null;
 }

 async confirmOrder(orderId: string): Promise<OrderResponse> {
 const order = await this.orderRepository.findById(
 OrderId.fromString(orderId)
 );

 if (!order) {
 throw new Error('Order not found');
 }

 order.confirm();
 await this.orderRepository.save(order);
 return this.toResponse(order);
 }

 async cancelOrder(orderId: string): Promise<void> {
 const order = await this.orderRepository.findById(
 OrderId.fromString(orderId)
 );

 if (!order) {
 throw new Error('Order not found');
 }

 order.cancel();
 await this.orderRepository.save(order);
 }

 async getAllOrders(): Promise<OrderResponse[]> {
 const orders = await this.orderRepository.findAll();
 return orders.map(order => this.toResponse(order));
 }

 private toResponse(order: Order): OrderResponse {
 return {
 id: order.id.toString(),
 customerId: order.customerId,
 items: order.getItems().map(item => ({
 productId: item.productId,
 productName: item.productName,
 quantity: item.quantity,
 unitPrice: item.unitPrice.getAmount(),
 subtotal: item.getSubtotal().getAmount()
 })),
 total: order.getTotal().getAmount(),
 status: order.getStatus(),
 createdAt: order.getCreatedAt()
 };
 }
}
```

### 2.5 Infrastructure Layer - Driven Adapters

```typescript
// src/infrastructure/adapters/driven/persistence/InMemoryOrderRepository.ts
import { OrderRepository } from '../../../../application/ports/output/OrderRepository';
import { Order } from '../../../../domain/entities/Order';
import { OrderId } from '../../../../domain/value-objects/OrderId';

export class InMemoryOrderRepository implements OrderRepository {
 private orders: Map<string, Order> = new Map();

 async save(order: Order): Promise<void> {
 this.orders.set(order.id.toString(), order);
 }

 async findById(id: OrderId): Promise<Order | null> {
 return this.orders.get(id.toString()) || null;
 }

 async findAll(): Promise<Order[]> {
 return Array.from(this.orders.values());
 }

 async delete(id: OrderId): Promise<void> {
 this.orders.delete(id.toString());
 }
}
```

### 2.6 Infrastructure Layer - Driving Adapters

```typescript
// src/infrastructure/adapters/driving/rest/OrderController.ts
import express, { Router, Request, Response } from 'express';
import { OrderService } from '../../../../application/ports/input/OrderService';

export function createOrderRouter(orderService: OrderService): Router {
 const router = express.Router();

 router.post('/', async (req: Request, res: Response) => {
 try {
 const order = await orderService.createOrder(req.body);
 res.status(201).json(order);
 } catch (error: any) {
 res.status(400).json({ error: error.message });
 }
 });

 router.get('/', async (req: Request, res: Response) => {
 const orders = await orderService.getAllOrders();
 res.json(orders);
 });

 router.get('/:id', async (req: Request, res: Response) => {
 const order = await orderService.getOrder(req.params.id);
 if (!order) {
 return res.status(404).json({ error: 'Order not found' });
 }
 res.json(order);
 });

 router.post('/:id/confirm', async (req: Request, res: Response) => {
 try {
 const order = await orderService.confirmOrder(req.params.id);
 res.json(order);
 } catch (error: any) {
 res.status(400).json({ error: error.message });
 }
 });

 router.delete('/:id', async (req: Request, res: Response) => {
 try {
 await orderService.cancelOrder(req.params.id);
 res.status(204).send();
 } catch (error: any) {
 res.status(400).json({ error: error.message });
 }
 });

 return router;
}
```

### 2.7 Dependency Injection

```typescript
// src/infrastructure/config/dependencies.ts
import { OrderServiceImpl } from '../../application/services/OrderServiceImpl';
import { InMemoryOrderRepository } from '../adapters/driven/persistence/InMemoryOrderRepository';

export function createDependencies() {
 // Create driven adapters
 const orderRepository = new InMemoryOrderRepository();

 // Create application services (with injected dependencies)
 const orderService = new OrderServiceImpl(orderRepository);

 return {
 orderRepository,
 orderService
 };
}
```

```typescript
// src/index.ts
import express from 'express';
import { createDependencies } from './infrastructure/config/dependencies';
import { createOrderRouter } from './infrastructure/adapters/driving/rest/OrderController';

const app = express();
app.use(express.json());

// Initialize dependencies
const { orderService } = createDependencies();

// Mount routes
app.use('/api/orders', createOrderRouter(orderService));

const PORT = 3000;
app.listen(PORT, () => {
 console.log(` Hexagonal App running at http://localhost:${PORT}`);
});
```

---

## Phần 3: Testing Benefits (30 phút)

### 3.1 Easy Unit Testing with Mocks

```typescript
// tests/unit/OrderServiceImpl.test.ts
import { OrderServiceImpl } from '../../src/application/services/OrderServiceImpl';
import { OrderRepository } from '../../src/application/ports/output/OrderRepository';

describe('OrderServiceImpl', () => {
 let orderService: OrderServiceImpl;
 let mockRepository: jest.Mocked<OrderRepository>;

 beforeEach(() => {
 mockRepository = {
 save: jest.fn(),
 findById: jest.fn(),
 findAll: jest.fn(),
 delete: jest.fn()
 };
 orderService = new OrderServiceImpl(mockRepository);
 });

 it('should create an order', async () => {
 const request = {
 customerId: 'customer-1',
 items: [{
 productId: 'prod-1',
 productName: 'iPhone',
 quantity: 1,
 unitPrice: 999
 }]
 };

 const result = await orderService.createOrder(request);

 expect(result.customerId).toBe('customer-1');
 expect(result.items).toHaveLength(1);
 expect(result.total).toBe(999);
 expect(mockRepository.save).toHaveBeenCalled();
 });
});
```

---

## Self-Assessment (30 câu)

### Cơ bản (1-10)

1. Hexagonal Architecture còn gọi là gì?
2. Ai là người đề xuất Hexagonal Architecture?
3. Port là gì trong Hexagonal?
4. Adapter là gì trong Hexagonal?
5. Domain/Core chứa gì?
6. Application Services làm gì?
7. Driving adapter là gì?
8. Driven adapter là gì?
9. Infrastructure layer chứa gì?
10. Dependency direction trong Hexagonal?

### Trung bình (11-20)

11. Inbound port khác outbound port thế nào?
12. Primary port vs Secondary port?
13. Làm sao test domain logic độc lập?
14. Repository pattern trong Hexagonal?
15. Use Case là gì?
16. Value Objects vs Entities?
17. Domain Events trong Hexagonal?
18. Anti-corruption Layer là gì?
19. Làm sao handle cross-cutting concerns?
20. Multiple adapters cho cùng port?

### Nâng cao (21-30)

21. Hexagonal vs Clean Architecture?
22. Hexagonal vs Onion Architecture?
23. Hexagonal với DDD?
24. Hexagonal với Microservices?
25. Hexagonal với Event-Driven?
26. Performance overhead của Hexagonal?
27. Khi nào KHÔNG nên dùng Hexagonal?
28. Migration strategy từ Layered sang Hexagonal?
29. Package/folder structure cho Hexagonal?
30. Testing pyramid trong Hexagonal?

**Đáp án gợi ý:**
- 1: Ports & Adapters Architecture
- 2: Alistair Cockburn (2005)
- 10: Outside → Inside (dependencies point inward)
- 21: Rất giống, Clean Architecture có thêm layers rõ ràng hơn

---

## Extend Labs (10 bài)

### EL1: Multi-Database Support
```
Mục tiêu: Database agnostic
- PostgreSQL adapter
- MongoDB adapter
- Switch via config
Độ khó: ***
```

### EL2: Multiple Input Ports
```
Mục tiêu: Multiple interfaces
- REST API adapter
- GraphQL adapter
- CLI adapter
Độ khó: ****
```

### EL3: Event-Driven Hexagonal
```
Mục tiêu: Async processing
- Domain events
- Event handlers
- Event sourcing
Độ khó: ****
```

### EL4: External Service Integration
```
Mục tiêu: Third-party adapters
- Payment gateway adapter
- Email service adapter
- Mock adapters for testing
Độ khó: ***
```

### EL5: CQRS trong Hexagonal
```
Mục tiêu: Command/Query separation
- Command handlers
- Query handlers
- Separate models
Độ khó: ****
```

### EL6: Saga Pattern
```
Mục tiêu: Distributed transactions
- Saga orchestrator
- Compensation logic
- Failure handling
Độ khó: *****
```

### EL7: Contract Testing
```
Mục tiêu: Port contracts
- Consumer contracts
- Provider verification
- Pact testing
Độ khó: ****
```

### EL8: Modular Monolith
```
Mục tiêu: Module boundaries
- Multiple hexagons
- Inter-module communication
- Shared kernel
Độ khó: ****
```

### EL9: Feature Flags
```
Mục tiêu: Runtime switching
- Feature toggles
- A/B testing adapters
- Gradual rollout
Độ khó: ***
```

### EL10: Migrate Existing App
```
Mục tiêu: Real-world migration
- Identify boundaries
- Extract domain
- Strangler fig approach
Độ khó: *****
```

---

## Deliverables

1. [ ] Domain entities với value objects
2. [ ] Input và Output ports
3. [ ] Application service implementation
4. [ ] In-memory repository adapter
5. [ ] REST controller adapter
6. [ ] Unit tests với mocks

---

## Tiếp theo

Chuyển đến: `lab-2.6-clean-architecture/`

---

## Phân bổ Thời gian: Lý thuyết 40', Ports & Adapters 70', Testing 40', Review 30' = 3 giờ

## Lời giải Mẫu
- Domain: Pure business logic, no frameworks
- Ports: Interfaces định nghĩa ranh giới
- Adapters: Implementation cụ thể (REST, DB, etc.)

## Các Lỗi Thường Gặp
| Lỗi | Cách sửa |
|-----|----------|
| Framework trong domain | Tách ra adapter |
| Quá nhiều ports | Chỉ tạo port khi cần |
| Domain anemic | Business logic trong domain |

## Chấm điểm: Domain purity 30, Ports/Adapters 30, Testability 25, Clean code 15 = 100

## Tham khảo: Alistair Cockburn (original), CMU SEI, ĐH FPT SWD391
