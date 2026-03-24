# Lab 2.3: Client-Server RESTful Architecture

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **CLO** | CLO2, CLO3 |
| **Công nghệ** | Express.js/FastAPI, REST APIs |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu kiến trúc Client-Server
2. Thiết kế RESTful APIs theo chuẩn
3. Implement CRUD APIs hoàn chỉnh
4. Handle errors và validation đúng cách
5. Document API với OpenAPI/Swagger

---

## Phần 1: Client-Server Architecture (30 phút)

### 1.1 Kiến trúc Client-Server

```
┌─────────────────┐ ┌─────────────────┐
│ CLIENT │ Request │ SERVER │
│ │ ───────────────── │ │
│ - Web Browser │ │ - API Server │
│ - Mobile App │ ───────────────── │ - Database │
│ - Desktop App │ Response │ - Business │
│ │ │ Logic │
└─────────────────┘ └─────────────────┘
```

### 1.2 REST Principles

| Principle | Description |
|-----------|-------------|
| **Stateless** | Server không lưu client state |
| **Client-Server** | Phân tách concerns |
| **Cacheable** | Response có thể cache |
| **Uniform Interface** | Standard operations (GET, POST, PUT, DELETE) |
| **Layered System** | Có thể có intermediaries (proxy, gateway) |

### 1.3 RESTful Resource Design

```
# Resource naming conventions
GET /users # List all users
POST /users # Create user
GET /users/{id} # Get single user
PUT /users/{id} # Update user
DELETE /users/{id} # Delete user

# Nested resources
GET /users/{id}/orders # Get user's orders
POST /users/{id}/orders # Create order for user

# Filtering, sorting, pagination
GET /products?category=electronics&sort=price&page=1&limit=10
```

### 1.4 HTTP Status Codes

| Code | Category | Common Uses |
|------|----------|-------------|
| **2xx** | Success | |
| 200 | OK | Successful GET, PUT |
| 201 | Created | Successful POST |
| 204 | No Content | Successful DELETE |
| **4xx** | Client Error | |
| 400 | Bad Request | Validation error |
| 401 | Unauthorized | Missing auth |
| 403 | Forbidden | No permission |
| 404 | Not Found | Resource not exist |
| 409 | Conflict | Duplicate resource |
| 422 | Unprocessable | Semantic error |
| **5xx** | Server Error | |
| 500 | Internal Error | Server bug |
| 503 | Service Unavailable | Maintenance |

---

## Phần 2: Hands-on Express.js REST API (90 phút)

### 2.1 Project Setup

```bash
# Create project
mkdir rest-api-demo && cd rest-api-demo
npm init -y

# Install dependencies
npm install express cors helmet morgan express-validator uuid

# Dev dependencies
npm install -D nodemon

# Create structure
mkdir -p {routes,controllers,models,middleware,utils}
touch app.js
```

**package.json scripts:**
```json
{
 "scripts": {
 "start": "node app.js",
 "dev": "nodemon app.js"
 }
}
```

### 2.2 Project Structure

```
rest-api-demo/
├── app.js
├── package.json
├── routes/
│ ├── index.js
│ └── userRoutes.js
├── controllers/
│ └── userController.js
├── models/
│ └── User.js
├── middleware/
│ ├── errorHandler.js
│ └── validator.js
└── utils/
 └── ApiError.js
```

### 2.3 Custom Error Class

```javascript
// utils/ApiError.js
class ApiError extends Error {
 constructor(statusCode, message, errors = []) {
 super(message);
 this.statusCode = statusCode;
 this.errors = errors;
 this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
 this.isOperational = true;

 Error.captureStackTrace(this, this.constructor);
 }
}

module.exports = ApiError;
```

### 2.4 Error Handler Middleware

```javascript
// middleware/errorHandler.js
const errorHandler = (err, req, res, next) => {
 err.statusCode = err.statusCode || 500;
 err.status = err.status || 'error';

 // Development: detailed error
 if (process.env.NODE_ENV === 'development') {
 res.status(err.statusCode).json({
 status: err.status,
 message: err.message,
 errors: err.errors,
 stack: err.stack
 });
 }
 // Production: minimal error
 else {
 if (err.isOperational) {
 res.status(err.statusCode).json({
 status: err.status,
 message: err.message,
 errors: err.errors
 });
 } else {
 console.error('ERROR:', err);
 res.status(500).json({
 status: 'error',
 message: 'Something went wrong!'
 });
 }
 }
};

module.exports = errorHandler;
```

### 2.5 User Model

```javascript
// models/User.js
const { v4: uuidv4 } = require('uuid');

class User {
 static users = [
 {
 id: '1',
 name: 'John Doe',
 email: 'john@example.com',
 role: 'admin',
 createdAt: new Date('2024-01-01'),
 updatedAt: new Date('2024-01-01')
 },
 {
 id: '2',
 name: 'Jane Smith',
 email: 'jane@example.com',
 role: 'user',
 createdAt: new Date('2024-01-02'),
 updatedAt: new Date('2024-01-02')
 }
 ];

 static findAll(filters = {}) {
 let result = [...this.users];

 // Filter by role
 if (filters.role) {
 result = result.filter(u => u.role === filters.role);
 }

 // Search by name
 if (filters.search) {
 const search = filters.search.toLowerCase();
 result = result.filter(u =>
 u.name.toLowerCase().includes(search) ||
 u.email.toLowerCase().includes(search)
 );
 }

 // Pagination
 const page = parseInt(filters.page) || 1;
 const limit = parseInt(filters.limit) || 10;
 const startIndex = (page - 1) * limit;
 const endIndex = page * limit;

 const paginated = result.slice(startIndex, endIndex);

 return {
 data: paginated,
 pagination: {
 total: result.length,
 page,
 limit,
 totalPages: Math.ceil(result.length / limit)
 }
 };
 }

 static findById(id) {
 return this.users.find(u => u.id === id);
 }

 static findByEmail(email) {
 return this.users.find(u => u.email === email);
 }

 static create(data) {
 const user = {
 id: uuidv4(),
 name: data.name,
 email: data.email,
 role: data.role || 'user',
 createdAt: new Date(),
 updatedAt: new Date()
 };
 this.users.push(user);
 return user;
 }

 static update(id, data) {
 const index = this.users.findIndex(u => u.id === id);
 if (index === -1) return null;

 this.users[index] = {
 ...this.users[index],
 ...data,
 id: this.users[index].id, // prevent id change
 updatedAt: new Date()
 };
 return this.users[index];
 }

 static delete(id) {
 const index = this.users.findIndex(u => u.id === id);
 if (index === -1) return false;
 this.users.splice(index, 1);
 return true;
 }
}

module.exports = User;
```

### 2.6 Validation Middleware

```javascript
// middleware/validator.js
const { body, validationResult } = require('express-validator');
const ApiError = require('../utils/ApiError');

const handleValidationErrors = (req, res, next) => {
 const errors = validationResult(req);
 if (!errors.isEmpty()) {
 const errorMessages = errors.array().map(err => ({
 field: err.path,
 message: err.msg
 }));
 throw new ApiError(400, 'Validation failed', errorMessages);
 }
 next();
};

const userValidation = {
 create: [
 body('name')
 .trim()
 .notEmpty().withMessage('Name is required')
 .isLength({ min: 2, max: 50 }).withMessage('Name must be 2-50 characters'),
 body('email')
 .trim()
 .notEmpty().withMessage('Email is required')
 .isEmail().withMessage('Invalid email format')
 .normalizeEmail(),
 body('role')
 .optional()
 .isIn(['admin', 'user']).withMessage('Role must be admin or user'),
 handleValidationErrors
 ],

 update: [
 body('name')
 .optional()
 .trim()
 .isLength({ min: 2, max: 50 }).withMessage('Name must be 2-50 characters'),
 body('email')
 .optional()
 .trim()
 .isEmail().withMessage('Invalid email format')
 .normalizeEmail(),
 body('role')
 .optional()
 .isIn(['admin', 'user']).withMessage('Role must be admin or user'),
 handleValidationErrors
 ]
};

module.exports = { userValidation };
```

### 2.7 User Controller

```javascript
// controllers/userController.js
const User = require('../models/User');
const ApiError = require('../utils/ApiError');

const userController = {
 // GET /api/users
 getAll: (req, res) => {
 const { role, search, page, limit } = req.query;
 const result = User.findAll({ role, search, page, limit });

 res.status(200).json({
 status: 'success',
 ...result
 });
 },

 // GET /api/users/:id
 getById: (req, res, next) => {
 const user = User.findById(req.params.id);

 if (!user) {
 return next(new ApiError(404, 'User not found'));
 }

 res.status(200).json({
 status: 'success',
 data: user
 });
 },

 // POST /api/users
 create: (req, res, next) => {
 // Check duplicate email
 const existingUser = User.findByEmail(req.body.email);
 if (existingUser) {
 return next(new ApiError(409, 'Email already exists'));
 }

 const user = User.create(req.body);

 res.status(201).json({
 status: 'success',
 message: 'User created successfully',
 data: user
 });
 },

 // PUT /api/users/:id
 update: (req, res, next) => {
 // Check if user exists
 const existingUser = User.findById(req.params.id);
 if (!existingUser) {
 return next(new ApiError(404, 'User not found'));
 }

 // Check duplicate email (if changing)
 if (req.body.email && req.body.email !== existingUser.email) {
 const emailExists = User.findByEmail(req.body.email);
 if (emailExists) {
 return next(new ApiError(409, 'Email already exists'));
 }
 }

 const user = User.update(req.params.id, req.body);

 res.status(200).json({
 status: 'success',
 message: 'User updated successfully',
 data: user
 });
 },

 // DELETE /api/users/:id
 delete: (req, res, next) => {
 const result = User.delete(req.params.id);

 if (!result) {
 return next(new ApiError(404, 'User not found'));
 }

 res.status(204).send();
 }
};

module.exports = userController;
```

### 2.8 Routes

```javascript
// routes/userRoutes.js
const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { userValidation } = require('../middleware/validator');

router
 .route('/')
 .get(userController.getAll)
 .post(userValidation.create, userController.create);

router
 .route('/:id')
 .get(userController.getById)
 .put(userValidation.update, userController.update)
 .delete(userController.delete);

module.exports = router;
```

```javascript
// routes/index.js
const express = require('express');
const router = express.Router();
const userRoutes = require('./userRoutes');

router.use('/users', userRoutes);

// Health check
router.get('/health', (req, res) => {
 res.json({ status: 'ok', timestamp: new Date() });
});

module.exports = router;
```

### 2.9 Main Application

```javascript
// app.js
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const routes = require('./routes');
const errorHandler = require('./middleware/errorHandler');
const ApiError = require('./utils/ApiError');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet()); // Security headers
app.use(cors()); // CORS
app.use(morgan('dev')); // Logging
app.use(express.json()); // JSON body parser
app.use(express.urlencoded({ extended: true }));

// API Routes
app.use('/api', routes);

// API Documentation (simple)
app.get('/', (req, res) => {
 res.json({
 name: 'REST API Demo',
 version: '1.0.0',
 endpoints: {
 health: 'GET /api/health',
 users: {
 list: 'GET /api/users',
 create: 'POST /api/users',
 get: 'GET /api/users/:id',
 update: 'PUT /api/users/:id',
 delete: 'DELETE /api/users/:id'
 }
 }
 });
});

// 404 Handler
app.use((req, res, next) => {
 next(new ApiError(404, `Cannot ${req.method} ${req.originalUrl}`));
});

// Error Handler
app.use(errorHandler);

// Start Server
app.listen(PORT, () => {
 console.log(` REST API running at http://localhost:${PORT}`);
 console.log(` API docs at http://localhost:${PORT}`);
});
```

---

## Phần 3: Testing API với cURL/HTTPie (30 phút)

### 3.1 Test với cURL

```bash
# Get all users
curl http://localhost:3000/api/users

# Get all users (formatted)
curl http://localhost:3000/api/users | jq

# Get single user
curl http://localhost:3000/api/users/1

# Create user
curl -X POST http://localhost:3000/api/users \
 -H "Content-Type: application/json" \
 -d '{"name":"Alice Johnson","email":"alice@example.com","role":"user"}'

# Update user
curl -X PUT http://localhost:3000/api/users/1 \
 -H "Content-Type: application/json" \
 -d '{"name":"John Updated"}'

# Delete user
curl -X DELETE http://localhost:3000/api/users/1

# Filter by role
curl "http://localhost:3000/api/users?role=admin"

# Pagination
curl "http://localhost:3000/api/users?page=1&limit=5"

# Search
curl "http://localhost:3000/api/users?search=john"
```

### 3.2 Test với HTTPie

```bash
# Get all users
http GET localhost:3000/api/users

# Create user
http POST localhost:3000/api/users name="Bob" email="bob@example.com"

# Update user
http PUT localhost:3000/api/users/1 name="Bob Updated"

# Delete user
http DELETE localhost:3000/api/users/1
```

---

## Phần 4: Bài tập Mở rộng (30 phút)

### Bài tập 4.1: Add Products API

Tạo CRUD API cho Products với:
- id, name, price, category, stock
- Validation
- Filtering by category, price range
- Sorting

### Bài tập 4.2: Add Authentication

Thêm JWT authentication:
- POST /api/auth/register
- POST /api/auth/login
- Protected routes

### Bài tập 4.3: OpenAPI Documentation

Tạo OpenAPI spec và integrate Swagger UI.

---

## Self-Assessment

### Quiz

1. REST là viết tắt của:
 - a) Remote State Transfer
 - b) Representational State Transfer
 - c) Request State Transfer
 - d) Response State Transfer

2. HTTP status code nào cho "Resource created"?
 - a) 200
 - b) 201
 - c) 204
 - d) 202

3. Stateless nghĩa là:
 - a) Server không lưu client state
 - b) Client không có state
 - c) Không có database
 - d) Không cần authentication

4. Route nào đúng cho "Get orders of user 5"?
 - a) GET /orders/user/5
 - b) GET /users/5/orders
 - c) GET /user-orders/5
 - d) GET /orders?userId=5

5. HTTP method nào để update một phần resource?
 - a) PUT
 - b) PATCH
 - c) POST
 - d) UPDATE

**Đáp án**: 1-b, 2-b, 3-a, 4-b, 5-b

### Câu 6-30 (Trung bình → Nâng cao)

6. REST API là gì?
7. Stateless là gì?
8. Resource trong REST?
9. HTTP verbs cho CRUD?
10. Status codes categories?
11. Request vs Response?
12. Headers trong HTTP?
13. Query parameters vs Path parameters?
14. Request body format?
15. Content-Type header?
16. Authentication methods (API Key, OAuth, JWT)?
17. Rate limiting là gì?
18. Pagination strategies?
19. Filtering và sorting?
20. Versioning API (URI, Header, Query)?
21. HATEOAS là gì?
22. GraphQL vs REST?
23. gRPC vs REST?
24. WebSocket vs REST?
25. API Gateway pattern?
26. BFF (Backend for Frontend)?
27. API security best practices?
28. OpenAPI/Swagger?
29. API testing strategies?
30. API monitoring và logging?

**Đáp án gợi ý:**
- 6: Representational State Transfer architectural style
- 16: API Key simple, OAuth cho 3rd party, JWT stateless auth
- 22: GraphQL flexible queries, REST fixed endpoints

---

## Extend Labs (10 bài)

### EL1: Complete REST API
```
Mục tiêu: Production-ready API
- CRUD cho 5 resources
- Relationships
- Error handling
Độ khó: ***
```

### EL2: Authentication & Authorization
```
Mục tiêu: Secure API
- JWT authentication
- Role-based access
- Refresh tokens
Độ khó: ***
```

### EL3: API Documentation
```
Mục tiêu: OpenAPI/Swagger
- Auto-generate docs
- Try-it-out feature
- Versioning
Độ khó: **
```

### EL4: GraphQL API
```
Mục tiêu: Alternative to REST
- Schema design
- Queries & Mutations
- Subscriptions
Độ khó: ****
```

### EL5: gRPC Service
```
Mục tiêu: High-performance RPC
- Protocol Buffers
- Streaming
- Code generation
Độ khó: ****
```

### EL6: Real-time với WebSocket
```
Mục tiêu: Bidirectional communication
- WebSocket server
- Event handling
- Connection management
Độ khó: ***
```

### EL7: API Gateway
```
Mục tiêu: API management
- Rate limiting
- Authentication
- Request routing
Độ khó: ****
```

### EL8: BFF Pattern
```
Mục tiêu: Client-specific APIs
- Web BFF
- Mobile BFF
- Aggregation
Độ khó: ****
```

### EL9: API Testing
```
Mục tiêu: Quality assurance
- Unit tests
- Integration tests
- Contract tests
Độ khó: ***
```

### EL10: API Performance
```
Mục tiêu: Optimization
- Caching
- Compression
- Connection pooling
Độ khó: ****
```

---

## Deliverables

1. [ ] REST API với CRUD operations
2. [ ] Proper error handling
3. [ ] Input validation
4. [ ] API testing với cURL/Postman
5. [ ] README với API documentation

---

## Tài liệu Tham khảo

1. REST API Design Best Practices: https://restfulapi.net/
2. HTTP Status Codes: https://httpstatuses.com/
3. Express.js Guide: https://expressjs.com/en/guide/routing.html

---

## Tiếp theo

Chuyển đến: `lab-2.4-event-driven/`

---

## Phân bổ Thời gian: Lý thuyết 30', Hands-on 90', Testing 30', Mở rộng 30' = 3 giờ

## Lời giải Mẫu
- Client: React/Angular gọi REST API
- Server: Spring Boot/Node.js xử lý request
- Protocol: HTTP/HTTPS, WebSocket cho realtime

## Các Lỗi Thường Gặp
| Lỗi | Cách sửa |
|-----|----------|
| Tight coupling client-server | Dùng API versioning |
| No error handling | Implement error codes |
| Security bypass | Auth ở mọi endpoint |

## Chấm điểm: API design 30, Error handling 25, Security 25, Code quality 20 = 100

## Tham khảo: MIT 6.033, Stanford CS 144, ĐH Bách Khoa CO3001
