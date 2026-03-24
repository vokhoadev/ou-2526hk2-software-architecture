# Lab 2.8: Strangler Fig Pattern

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Advanced |
| **CLO** | CLO2, CLO3, CLO6 |
| **Công nghệ** | Kong/Nginx, Docker |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu Strangler Fig Pattern và use cases
2. Thiết kế migration strategy từ monolith
3. Triển khai routing với API Gateway
4. Thực hiện incremental migration

---

## Phần 1: Strangler Fig Pattern Theory (45 phút)

### 1.1 Pattern Origin

**Strangler Fig** (cây Đa bóp nghẹt) là loại cây nhiệt đới bắt đầu như cây ký sinh, dần dần bao bọc và thay thế cây chủ.

```
Phase 1: Seed Phase 2: Growth Phase 3: Replace

 │ ┌─┴─┐ ┌──┴──┐
 │ ╱ ╲ ╱ ╲

 (Old) (Old+New) (All New)
```

### 1.2 Application to Software

**Strangler Fig Pattern** cho phép migrate từ legacy system sang new system một cách incremental.

```
┌─────────────────────────────────────────────────────────────────┐
│ BEFORE │
│ │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ MONOLITH │ │
│ │ │ │
│ │ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────────┐ │ │
│ │ │ Users │ │ Products│ │ Orders │ │ Payments │ │ │
│ │ └─────────┘ └─────────┘ └─────────┘ └─────────────┘ │ │
│ └──────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ DURING │
│ │
│ ┌─────────────────┐ │
│ │ API Gateway │ │
│ │ (Strangler) │ │
│ └────────┬────────┘ │
│ │ │
│ ┌────────────────┼────────────────┐ │
│ ▼ ▼ ▼ │
│ ┌─────────────────┐ ┌─────────┐ ┌─────────────────┐ │
│ │ New Service │ │MONOLITH │ │ New Service │ │
│ │ (Products) │ │(Users, │ │ (Payments) │ │
│ │ │ │Orders) │ │ │ │
│ └─────────────────┘ └─────────┘ └─────────────────┘ │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ AFTER │
│ │
│ ┌─────────────────┐ │
│ │ API Gateway │ │
│ └────────┬────────┘ │
│ │ │
│ ┌──────────┬───────────┼───────────┬──────────┐ │
│ ▼ ▼ ▼ ▼ ▼ │
│ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ │
│ │ Users │ │Products │ │ Orders │ │Payments │ │Inventory│ │
│ │ Service │ │ Service │ │ Service │ │ Service │ │ Service │ │
│ └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### 1.3 Key Strategies

| Strategy | Description | When to Use |
|----------|-------------|-------------|
| **Asset Capture** | Extract và replace từng module | Clear module boundaries |
| **Event Interception** | Intercept events, route to new | Event-driven system |
| **API Gateway** | Route requests dynamically | REST/HTTP systems |
| **Database Seam** | Separate data access | Shared database |

### 1.4 Benefits & Challenges

**Benefits:**
- Zero downtime migration
- Gradual risk reduction
- Rollback capability
- Team learning curve

**Challenges:**
- Increased complexity during migration
- Data synchronization
- Transaction boundaries
- Testing complexity

---

## Phần 2: Hands-on với Kong API Gateway (90 phút)

### 2.1 Scenario Setup

Migrating a monolith e-commerce app to microservices:
1. **Legacy Monolith**: Node.js app với Users, Products, Orders
2. **New Service**: Extract Products to separate service
3. **Strangler**: Kong routes traffic

### 2.2 Docker Compose Setup

```yaml
# docker-compose.yml
version: '3.8'

services:
 # Kong API Gateway (Strangler)
 kong:
 image: kong:3.4
 environment:
 KONG_DATABASE: "off"
 KONG_DECLARATIVE_CONFIG: /kong/kong.yml
 KONG_PROXY_ACCESS_LOG: /dev/stdout
 KONG_ADMIN_ACCESS_LOG: /dev/stdout
 KONG_PROXY_ERROR_LOG: /dev/stderr
 KONG_ADMIN_ERROR_LOG: /dev/stderr
 KONG_ADMIN_LISTEN: 0.0.0.0:8001
 volumes:
 - ./kong/kong.yml:/kong/kong.yml
 ports:
 - "8000:8000" # Proxy
 - "8001:8001" # Admin API
 depends_on:
 - monolith
 - products-service

 # Legacy Monolith
 monolith:
 build: ./monolith
 ports:
 - "3001:3000"
 environment:
 - PORT=3000

 # New Products Service
 products-service:
 build: ./products-service
 ports:
 - "3002:3000"
 environment:
 - PORT=3000
```

### 2.3 Kong Configuration

```yaml
# kong/kong.yml
_format_version: "3.0"
_transform: true

services:
 # Route Products to New Service
 - name: products-service
 url: http://products-service:3000
 routes:
 - name: products-route
 paths:
 - /api/products
 strip_path: false

 # Route everything else to Monolith
 - name: monolith-service
 url: http://monolith:3000
 routes:
 - name: users-route
 paths:
 - /api/users
 strip_path: false
 - name: orders-route
 paths:
 - /api/orders
 strip_path: false
 - name: legacy-fallback
 paths:
 - /api
 strip_path: false
```

### 2.4 Legacy Monolith

```javascript
// monolith/app.js
const express = require('express');
const app = express();
app.use(express.json());

// In-memory data
const users = [
 { id: 1, name: 'John', email: 'john@example.com' },
 { id: 2, name: 'Jane', email: 'jane@example.com' }
];

const products = [
 { id: 1, name: 'iPhone', price: 999, stock: 100 },
 { id: 2, name: 'MacBook', price: 1999, stock: 50 }
];

const orders = [
 { id: 1, userId: 1, productId: 1, quantity: 1, status: 'pending' }
];

// Users endpoints (will stay in monolith)
app.get('/api/users', (req, res) => {
 console.log('[MONOLITH] GET /api/users');
 res.json(users);
});

app.get('/api/users/:id', (req, res) => {
 console.log(`[MONOLITH] GET /api/users/${req.params.id}`);
 const user = users.find(u => u.id === parseInt(req.params.id));
 if (!user) return res.status(404).json({ error: 'User not found' });
 res.json(user);
});

// Products endpoints (will be migrated)
app.get('/api/products', (req, res) => {
 console.log('[MONOLITH] GET /api/products');
 res.json(products);
});

app.get('/api/products/:id', (req, res) => {
 console.log(`[MONOLITH] GET /api/products/${req.params.id}`);
 const product = products.find(p => p.id === parseInt(req.params.id));
 if (!product) return res.status(404).json({ error: 'Product not found' });
 res.json(product);
});

// Orders endpoints
app.get('/api/orders', (req, res) => {
 console.log('[MONOLITH] GET /api/orders');
 res.json(orders);
});

app.post('/api/orders', (req, res) => {
 console.log('[MONOLITH] POST /api/orders');
 const order = {
 id: orders.length + 1,
 ...req.body,
 status: 'pending'
 };
 orders.push(order);
 res.status(201).json(order);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
 console.log(`[MONOLITH] Running on port ${PORT}`);
});
```

```dockerfile
# monolith/Dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
```

### 2.5 New Products Service

```javascript
// products-service/app.js
const express = require('express');
const app = express();
app.use(express.json());

// Products data (could be from separate database)
const products = [
 { id: 1, name: 'iPhone 15', price: 999, stock: 100, category: 'phones' },
 { id: 2, name: 'MacBook Pro', price: 1999, stock: 50, category: 'laptops' },
 { id: 3, name: 'AirPods Pro', price: 249, stock: 200, category: 'audio' }
];

let nextId = 4;

// Enhanced Products API
app.get('/api/products', (req, res) => {
 console.log('[PRODUCTS-SERVICE] GET /api/products');

 let result = [...products];

 // Filtering
 if (req.query.category) {
 result = result.filter(p => p.category === req.query.category);
 }

 // Search
 if (req.query.search) {
 const search = req.query.search.toLowerCase();
 result = result.filter(p => p.name.toLowerCase().includes(search));
 }

 // Sorting
 if (req.query.sort) {
 const [field, order] = req.query.sort.split(':');
 result.sort((a, b) => {
 if (order === 'desc') return b[field] - a[field];
 return a[field] - b[field];
 });
 }

 res.json({
 data: result,
 total: result.length,
 service: 'products-service',
 version: '2.0'
 });
});

app.get('/api/products/:id', (req, res) => {
 console.log(`[PRODUCTS-SERVICE] GET /api/products/${req.params.id}`);
 const product = products.find(p => p.id === parseInt(req.params.id));

 if (!product) {
 return res.status(404).json({
 error: 'Product not found',
 service: 'products-service'
 });
 }

 res.json({
 data: product,
 service: 'products-service'
 });
});

app.post('/api/products', (req, res) => {
 console.log('[PRODUCTS-SERVICE] POST /api/products');
 const product = {
 id: nextId++,
 ...req.body
 };
 products.push(product);
 res.status(201).json({
 data: product,
 service: 'products-service'
 });
});

app.put('/api/products/:id', (req, res) => {
 const id = parseInt(req.params.id);
 const index = products.findIndex(p => p.id === id);

 if (index === -1) {
 return res.status(404).json({ error: 'Product not found' });
 }

 products[index] = { ...products[index], ...req.body, id };
 res.json({ data: products[index], service: 'products-service' });
});

app.delete('/api/products/:id', (req, res) => {
 const id = parseInt(req.params.id);
 const index = products.findIndex(p => p.id === id);

 if (index === -1) {
 return res.status(404).json({ error: 'Product not found' });
 }

 products.splice(index, 1);
 res.status(204).send();
});

// Health check
app.get('/health', (req, res) => {
 res.json({ status: 'healthy', service: 'products-service' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
 console.log(`[PRODUCTS-SERVICE] Running on port ${PORT}`);
});
```

### 2.6 Running & Testing

```bash
# Start all services
docker-compose up -d

# Test Products (routed to new service)
curl http://localhost:8000/api/products
# Response includes "service": "products-service"

# Test Users (routed to monolith)
curl http://localhost:8000/api/users
# Response from monolith

# Test Orders (routed to monolith)
curl http://localhost:8000/api/orders
```

---

## Phần 3: Migration Strategy (30 phút)

### 3.1 Step-by-Step Migration

1. **Identify Seams**: Find module boundaries in monolith
2. **Build New Service**: Implement với improved design
3. **Setup Strangler**: Configure routing
4. **Gradual Traffic Shift**: Route % traffic to new
5. **Data Migration**: Sync or migrate data
6. **Full Cutover**: 100% traffic to new
7. **Decommission Legacy**: Remove old code

### 3.2 Data Synchronization Strategies

| Strategy | Pros | Cons |
|----------|------|------|
| **Shared DB** | Simple | Tight coupling |
| **Data Sync** | Independence | Complexity |
| **Event-driven** | Real-time | Infrastructure |
| **API calls** | Decoupled | Latency |

### 3.3 Canary Deployment with Kong

```yaml
# Kong configuration for canary (10% to new, 90% to old)
services:
 - name: products-new
 url: http://products-service:3000

 - name: products-old
 url: http://monolith:3000

upstreams:
 - name: products-upstream
 targets:
 - target: products-service:3000
 weight: 10
 - target: monolith:3000
 weight: 90
```

---

## Self-Assessment (30 câu)

### Cơ bản (1-10)

1. Strangler Fig Pattern là gì?
2. Tại sao gọi là "Strangler Fig"?
3. Strangler Fig giải quyết vấn đề gì?
4. API Gateway trong Strangler Fig?
5. Routing trong migration?
6. Incremental migration là gì?
7. Feature by feature migration?
8. Data synchronization strategies?
9. Khi nào migration hoàn tất?
10. Legacy system lifecycle?

### Trung bình (11-20)

11. Anti-corruption layer là gì?
12. Facade pattern trong Strangler Fig?
13. Event interception?
14. Asset capture?
15. Parallel running?
16. Feature toggles trong migration?
17. Rollback strategies?
18. Monitoring during migration?
19. Team organization?
20. Risk management?

### Nâng cao (21-30)

21. Strangler Fig vs Big Bang migration?
22. Data migration strategies?
23. Database splitting?
24. Event sourcing trong migration?
25. Strangler Fig với microservices?
26. Multi-year migration planning?
27. Legacy decommissioning?
28. Stakeholder communication?
29. Success metrics?
30. Real-world case studies?

**Đáp án gợi ý:**
- 1: Pattern migrate legacy system gradually
- 2: Strangler fig tree gradually envelops host tree
- 21: Strangler Fig lower risk, incremental; Big Bang higher risk, faster

---

## Extend Labs (10 bài)

### EL1: Complete Migration
```
Mục tiêu: End-to-end
- Monolith to 3 services
- Data migration
- Traffic switching
Độ khó: *****
```

### EL2: API Gateway Routing
```
Mục tiêu: Traffic management
- Kong/NGINX setup
- A/B routing
- Gradual rollout
Độ khó: ***
```

### EL3: Database Splitting
```
Mục tiêu: Data migration
- Identify boundaries
- Sync strategies
- Cut-over plan
Độ khó: *****
```

### EL4: Feature Flags
```
Mục tiêu: Controlled rollout
- Feature flag system
- Gradual percentage
- Kill switch
Độ khó: ***
```

### EL5: Anti-corruption Layer
```
Mục tiêu: Clean integration
- Translation layer
- Adapter pattern
- Event transformation
Độ khó: ****
```

### EL6: Parallel Running
```
Mục tiêu: Verification
- Shadow traffic
- Comparison logic
- Discrepancy alerts
Độ khó: ****
```

### EL7: Event Interception
```
Mục tiêu: Async migration
- Event capture
- Event replay
- Dual write
Độ khó: *****
```

### EL8: Monitoring Dashboard
```
Mục tiêu: Migration tracking
- Traffic split
- Error rates
- Performance comparison
Độ khó: ***
```

### EL9: Rollback Strategy
```
Mục tiêu: Safety net
- Rollback plan
- Quick switch
- Data sync
Độ khó: ****
```

### EL10: Legacy Decommission
```
Mục tiêu: Final phase
- Dependency check
- Sunset plan
- Cleanup
Độ khó: ****
```

---

## Deliverables

1. [ ] Docker Compose với Kong, Monolith, New Service
2. [ ] Kong routing configuration
3. [ ] Legacy Monolith application
4. [ ] New Products microservice
5. [ ] Migration test scenarios

---

## Tài liệu Tham khảo

1. Martin Fowler - Strangler Fig Application: https://martinfowler.com/bliki/StranglerFigApplication.html
2. Kong Documentation: https://docs.konghq.com/
3. Sam Newman - Building Microservices (Chapter 5)

---

## Tiếp theo

Hoàn thành Level 2! Chuyển đến: `03-documentation-communication/`

---

## Phân bổ Thời gian: Lý thuyết 30', Planning 40', Implementation 70', Review 40' = 3 giờ

## Lời giải Mẫu
- Identify: Chọn module để migrate trước
- Strangle: Route traffic dần sang hệ thống mới
- Remove: Xóa legacy khi hoàn tất

## Các Lỗi Thường Gặp
| Lỗi | Cách sửa |
|-----|----------|
| Big bang approach | Migrate từng phần nhỏ |
| No rollback plan | Luôn có plan B |
| Feature parity | Test kỹ trước khi switch |

## Chấm điểm: Migration strategy 30, Routing implementation 30, Rollback plan 20, Testing 20 = 100

## Tham khảo: Martin Fowler, ThoughtWorks, Microsoft Azure Patterns
