# Lab 2.4: Event-Driven Architecture

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 4 giờ |
| **Độ khó** | Intermediate |
| **CLO** | CLO2, CLO3 |
| **Công nghệ** | Apache Kafka, RabbitMQ, Docker |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu kiến trúc Event-Driven
2. Phân biệt Event-Driven vs Request-Driven
3. Triển khai hệ thống với RabbitMQ
4. Triển khai hệ thống với Apache Kafka

---

## Phần 1: Lý thuyết (45 phút)

### 1.1 Event-Driven Architecture (EDA)

EDA là kiến trúc trong đó các components giao tiếp thông qua events thay vì direct calls.

```
┌─────────────┐ Event ┌─────────────┐ Event ┌─────────────┐
│ Producer │──────────│ Broker │──────────│ Consumer │
│ │ │ │ │ │
│ OrderService│ OrderPlaced (Kafka) │ OrderPlaced │InventoryService│
└─────────────┘ └─────────────┘ └─────────────┘
 │
 │ Event
 ▼
 ┌─────────────┐
 │ Consumer │
 │ │
 │NotificationService│
 └─────────────┘
```

### 1.2 Core Concepts

| Concept | Mô tả |
|---------|-------|
| **Event** | Fact that happened (immutable) |
| **Producer** | Component tạo events |
| **Consumer** | Component xử lý events |
| **Broker** | Middleware quản lý events |
| **Topic/Queue** | Channel chứa events |

### 1.3 Event Types

1. **Domain Events**: Business facts (OrderPlaced, PaymentCompleted)
2. **Integration Events**: Cross-service communication
3. **Notification Events**: Inform about state changes

### 1.4 Patterns

| Pattern | Mô tả | Use Case |
|---------|-------|----------|
| **Pub/Sub** | Many consumers receive same event | Notifications |
| **Point-to-Point** | One consumer per event | Task processing |
| **Event Sourcing** | Store events as source of truth | Audit, replay |
| **CQRS** | Separate read/write models | Complex queries |

### 1.5 Ưu nhược điểm

**Ưu điểm:**
- Loose coupling
- Scalability
- Real-time processing
- Fault tolerance

**Nhược điểm:**
- Complexity
- Debugging difficulty
- Eventual consistency
- Event ordering challenges

---

## Phần 2: Hands-on RabbitMQ (60 phút)

### Setup RabbitMQ

```bash
# Docker Compose
cat << 'EOF' > docker-compose-rabbitmq.yml
version: '3.8'
services:
 rabbitmq:
 image: rabbitmq:3-management
 ports:
 - "5672:5672"
 - "15672:15672"
 environment:
 - RABBITMQ_DEFAULT_USER=admin
 - RABBITMQ_DEFAULT_PASS=admin
EOF

docker-compose -f docker-compose-rabbitmq.yml up -d
```

Truy cập Management UI: http://localhost:15672 (admin/admin)

### Project Structure

```
event-driven-demo/
├── order-service/
│ ├── package.json
│ └── src/
│ ├── index.js
│ └── publisher.js
├── inventory-service/
│ ├── package.json
│ └── src/
│ ├── index.js
│ └── consumer.js
└── notification-service/
 ├── package.json
 └── src/
 └── consumer.js
```

### Bài tập 2.1: Order Service (Publisher)

```javascript
// order-service/src/publisher.js
const amqp = require('amqplib');

class OrderPublisher {
 constructor() {
 this.connection = null;
 this.channel = null;
 }

 async connect() {
 this.connection = await amqp.connect('amqp://admin:admin@localhost');
 this.channel = await this.connection.createChannel();

 // Declare exchange
 await this.channel.assertExchange('orders', 'fanout', { durable: true });
 console.log('Connected to RabbitMQ');
 }

 async publishOrderPlaced(order) {
 const event = {
 type: 'ORDER_PLACED',
 data: order,
 timestamp: new Date().toISOString()
 };

 this.channel.publish(
 'orders',
 '',
 Buffer.from(JSON.stringify(event)),
 { persistent: true }
 );

 console.log('Published ORDER_PLACED event:', order.id);
 }

 async close() {
 await this.channel.close();
 await this.connection.close();
 }
}

module.exports = OrderPublisher;
```

```javascript
// order-service/src/index.js
const express = require('express');
const OrderPublisher = require('./publisher');

const app = express();
app.use(express.json());

const publisher = new OrderPublisher();

app.post('/orders', async (req, res) => {
 const order = {
 id: Date.now().toString(),
 customerId: req.body.customerId,
 items: req.body.items,
 total: req.body.total,
 status: 'PLACED'
 };

 // Save to database (simulated)
 console.log('Order saved:', order.id);

 // Publish event
 await publisher.publishOrderPlaced(order);

 res.status(201).json(order);
});

async function start() {
 await publisher.connect();
 app.listen(3001, () => {
 console.log('Order Service running on port 3001');
 });
}

start();
```

### Bài tập 2.2: Inventory Service (Consumer)

```javascript
// inventory-service/src/consumer.js
const amqp = require('amqplib');

class InventoryConsumer {
 async start() {
 const connection = await amqp.connect('amqp://admin:admin@localhost');
 const channel = await connection.createChannel();

 // Declare exchange and queue
 await channel.assertExchange('orders', 'fanout', { durable: true });
 const queue = await channel.assertQueue('inventory-queue', { durable: true });
 await channel.bindQueue(queue.queue, 'orders', '');

 console.log('Inventory Service waiting for events...');

 channel.consume(queue.queue, (msg) => {
 const event = JSON.parse(msg.content.toString());

 if (event.type === 'ORDER_PLACED') {
 this.handleOrderPlaced(event.data);
 }

 channel.ack(msg);
 });
 }

 handleOrderPlaced(order) {
 console.log('Updating inventory for order:', order.id);

 // Deduct inventory (simulated)
 order.items.forEach(item => {
 console.log(` - Deducting ${item.quantity} of product ${item.productId}`);
 });
 }
}

const consumer = new InventoryConsumer();
consumer.start();
```

---

## Phần 3: Hands-on Apache Kafka (60 phút)

### Setup Kafka

```bash
cat << 'EOF' > docker-compose-kafka.yml
version: '3.8'
services:
 zookeeper:
 image: confluentinc/cp-zookeeper:7.5.0
 environment:
 ZOOKEEPER_CLIENT_PORT: 2181

 kafka:
 image: confluentinc/cp-kafka:7.5.0
 depends_on:
 - zookeeper
 ports:
 - "9092:9092"
 environment:
 KAFKA_BROKER_ID: 1
 KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
 KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:9092
 KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
EOF

docker-compose -f docker-compose-kafka.yml up -d
```

### Kafka với Node.js

```javascript
// kafka-producer.js
const { Kafka } = require('kafkajs');

const kafka = new Kafka({
 clientId: 'order-service',
 brokers: ['localhost:9092']
});

const producer = kafka.producer();

async function publishEvent(topic, event) {
 await producer.connect();

 await producer.send({
 topic,
 messages: [
 {
 key: event.data.id,
 value: JSON.stringify(event),
 headers: {
 'event-type': event.type
 }
 }
 ]
 });

 console.log('Event published to Kafka');
 await producer.disconnect();
}

// Usage
publishEvent('orders', {
 type: 'ORDER_PLACED',
 data: { id: '123', items: [] },
 timestamp: new Date().toISOString()
});
```

```javascript
// kafka-consumer.js
const { Kafka } = require('kafkajs');

const kafka = new Kafka({
 clientId: 'inventory-service',
 brokers: ['localhost:9092']
});

const consumer = kafka.consumer({ groupId: 'inventory-group' });

async function startConsumer() {
 await consumer.connect();
 await consumer.subscribe({ topic: 'orders', fromBeginning: true });

 await consumer.run({
 eachMessage: async ({ topic, partition, message }) => {
 const event = JSON.parse(message.value.toString());
 console.log('Received event:', event.type);

 // Process event
 if (event.type === 'ORDER_PLACED') {
 console.log('Processing order:', event.data.id);
 }
 }
 });
}

startConsumer();
```

---

## Phần 4: Bài tập Tổng hợp (45 phút)

### Bài tập: Order Processing System

Xây dựng hệ thống xử lý đơn hàng với:

1. **Order Service**: Tạo orders, publish events
2. **Payment Service**: Xử lý thanh toán
3. **Inventory Service**: Cập nhật kho
4. **Notification Service**: Gửi email/SMS

**Event Flow:**
```
OrderPlaced → PaymentProcessed → InventoryUpdated → NotificationSent
```

**Requirements:**
- Sử dụng RabbitMQ hoặc Kafka
- Handle failed events (retry, dead letter queue)
- Log all events

---

## Self-Assessment (30 câu)

### Cơ bản (1-10)

1. Event-Driven Architecture là gì?
2. Event là gì?
3. Event Producer là gì?
4. Event Consumer là gì?
5. Event Broker là gì?
6. Pub/Sub pattern là gì?
7. Event Queue là gì?
8. Event Topic là gì?
9. Fire-and-forget là gì?
10. Event acknowledgment là gì?

### Trung bình (11-20)

11. Event-Driven vs Request-Driven?
12. Eventual consistency là gì?
13. Dead Letter Queue dùng để làm gì?
14. Event ordering đảm bảo thế nào?
15. Kafka vs RabbitMQ khác nhau thế nào?
16. Event sourcing là gì?
17. CQRS với Event-Driven?
18. Event schema evolution?
19. Event replay là gì?
20. Idempotent consumers?

### Nâng cao (21-30)

21. Event choreography vs orchestration?
22. Saga pattern với events?
23. Event streaming vs Event queuing?
24. Event-driven microservices?
25. Event storm workshop?
26. Domain events vs Integration events?
27. Event schema registry?
28. Event-driven testing?
29. Event-driven debugging?
30. Production event-driven patterns?

**Đáp án gợi ý:**
- 1: Architecture sử dụng events để communicate
- 11: Event-driven async/decoupled, Request-driven sync/coupled
- 15: Kafka log-based streaming, RabbitMQ queue-based messaging

---

## Extend Labs (10 bài)

### EL1: Event Sourcing System
```
Mục tiêu: Full event sourcing
- Event store
- Aggregates
- Projections
Độ khó: *****
```

### EL2: Order Processing Pipeline
```
Mục tiêu: Complete pipeline
- Order → Payment → Shipping
- Error handling
- Retry logic
Độ khó: ****
```

### EL3: Real-time Notifications
```
Mục tiêu: Live updates
- Event to WebSocket
- Mobile push
- Email notifications
Độ khó: ***
```

### EL4: Event Storm Workshop
```
Mục tiêu: Domain discovery
- Domain events
- Aggregates
- Bounded contexts
Độ khó: ***
```

### EL5: CDC with Debezium
```
Mục tiêu: Change Data Capture
- Database → Events
- Outbox pattern
- Reliable delivery
Độ khó: ****
```

### EL6: Stream Processing
```
Mục tiêu: Real-time analytics
- Kafka Streams
- Windowed aggregations
- Real-time dashboard
Độ khó: *****
```

### EL7: Schema Evolution
```
Mục tiêu: Event versioning
- Schema registry
- Backward/Forward compat
- Migration strategies
Độ khó: ****
```

### EL8: Dead Letter Handling
```
Mục tiêu: Error handling
- DLQ setup
- Retry strategies
- Manual intervention
Độ khó: ***
```

### EL9: Event Monitoring
```
Mục tiêu: Observability
- Event flow visualization
- Lag monitoring
- Alerting
Độ khó: ***
```

### EL10: Multi-region Events
```
Mục tiêu: Global distribution
- Cross-region replication
- Event ordering
- Conflict resolution
Độ khó: *****
```

---

## Deliverables

1. [ ] RabbitMQ setup với Docker
2. [ ] Order Publisher service
3. [ ] Inventory Consumer service
4. [ ] Kafka-based alternative
5. [ ] Complete order processing system

---

## Tài liệu Tham khảo

1. Richards, M. (2020). *Fundamentals of Software Architecture*. Chapter 14: Event-Driven Architecture.
2. RabbitMQ Documentation: https://www.rabbitmq.com/documentation.html
3. Apache Kafka Documentation: https://kafka.apache.org/documentation/

---

## Tiếp theo

Chuyển đến: `lab-2.5-hexagonal/`

---

## Phân bổ Thời gian: Lý thuyết 40', Kafka setup 60', Implementation 50', Testing 30' = 3 giờ

## Lời giải Mẫu
- Event Producer: Publish OrderCreated event
- Event Consumer: Subscribe và xử lý async
- Event Store: Kafka topic với retention

## Các Lỗi Thường Gặp
| Lỗi | Cách sửa |
|-----|----------|
| Lost events | Implement idempotency |
| Event ordering | Partition key strategy |
| No dead letter queue | Implement DLQ pattern |

## Chấm điểm: Event design 30, Async handling 25, Error recovery 25, Testing 20 = 100

## Tham khảo: CMU 15-440, MIT 6.824, ĐH Bách Khoa Hà Nội IT4995
