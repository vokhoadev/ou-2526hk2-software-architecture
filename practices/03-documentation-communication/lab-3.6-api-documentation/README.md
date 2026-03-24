# Lab 3.6: API Documentation với OpenAPI/Swagger

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu trước** | Lab 3.1 (Technical Writing), kiến thức REST API cơ bản |
| **Công cụ** | Swagger Editor, Swagger UI, Docker, Node.js ≥ 18 |
| **Ngôn ngữ** | YAML, JavaScript/TypeScript |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Hiểu và áp dụng** OpenAPI Specification 3.0 để mô tả RESTful APIs một cách chuẩn hóa
2. **Thiết kế** API contracts theo phương pháp API-first design trước khi implementation
3. **Triển khai** Swagger UI bằng Docker để tạo interactive API documentation
4. **Tích hợp** code-first documentation bằng JSDoc/decorators để auto-generate OpenAPI spec từ source code
5. **Áp dụng** các best practices về authentication docs, error standards (RFC 7807), versioning và webhook documentation

---

## Phân bổ Thời gian

| Giai đoạn | Nội dung | Thời lượng |
|-----------|----------|------------|
| **Lý thuyết** | OpenAPI overview, cấu trúc spec, tools ecosystem | 30 phút |
| **Lab 1** | Viết OpenAPI 3.0 Spec (Products + Orders CRUD) | 40 phút |
| **Lab 2** | Swagger UI setup với Docker, customize giao diện | 30 phút |
| **Lab 3** | Code-first documentation (Express/NestJS) | 30 phút |
| **Lab 4** | Advanced: Auth schemes, webhooks, versioning | 30 phút |
| **Self-Assessment** | Trả lời 30 câu hỏi kiểm tra kiến thức | 10 phút |
| **Review & Discussion** | Nhận xét, Q&A, thảo luận best practices | 10 phút |
| **Tổng** | | **3 giờ** |

---

## Lý thuyết

### 1. Tại sao API Documentation quan trọng?

API documentation là **cầu nối** giữa API provider và consumer. Nếu không có documentation tốt, dù API được thiết kế hoàn hảo cũng sẽ không ai sử dụng được.

**Lợi ích chính:**

| Lợi ích | Mô tả |
|---------|--------|
| **Developer Experience** | Giảm thời gian onboarding cho developer mới từ ngày xuống giờ |
| **Giảm support tickets** | Documentation rõ ràng giảm 60-80% câu hỏi lặp lại |
| **Contract-first design** | Cho phép frontend/backend phát triển song song |
| **Automated testing** | Sinh test cases, mock servers từ spec |
| **Code generation** | Tạo client SDK, server stubs tự động |

### 2. OpenAPI Specification 3.0 — Cấu trúc

OpenAPI Specification (OAS) là chuẩn công nghiệp để mô tả RESTful APIs dưới dạng machine-readable (YAML/JSON).

**Lịch sử:**
- **Swagger 1.x** (2011): Format gốc do Wordnik phát triển
- **Swagger 2.0** (2014): Trở thành standard phổ biến
- **OpenAPI 3.0** (2017): Đổi tên thành OpenAPI, cải tiến lớn
- **OpenAPI 3.1** (2021): Tương thích JSON Schema Draft 2020-12

**Cấu trúc root-level của một OpenAPI 3.0 document:**

```yaml
openapi: 3.0.3 # Phiên bản OAS (bắt buộc)
info: # Metadata của API (bắt buộc)
 title: My API
 version: 1.0.0
 description: Mô tả API
 contact:
 name: API Team
 email: api@example.com
 license:
 name: MIT
servers: # Danh sách servers
 - url: https://api.example.com/v1
 description: Production
 - url: https://staging-api.example.com/v1
 description: Staging
paths: # Tất cả endpoints (bắt buộc)
 /resources:
 get: ...
 post: ...
components: # Reusable schemas, parameters, responses
 schemas: ...
 securitySchemes: ...
 parameters: ...
 responses: ...
security: # Global security
 - bearerAuth: []
tags: # Nhóm endpoints
 - name: Products
 description: Product management
```

### 3. Swagger Tools Ecosystem

| Tool | Mục đích | URL |
|------|----------|-----|
| **Swagger Editor** | Soạn thảo và preview spec trực tuyến | editor.swagger.io |
| **Swagger UI** | Render interactive documentation từ spec | github.com/swagger-api/swagger-ui |
| **Swagger Codegen** | Generate client SDKs và server stubs | github.com/swagger-api/swagger-codegen |
| **OpenAPI Generator** | Fork cải tiến của Codegen, hỗ trợ 50+ ngôn ngữ | openapi-generator.tech |
| **Redoc** | Beautiful static API docs, 3-panel layout | github.com/Redocly/redoc |
| **Stoplight Prism** | Mock server từ OpenAPI spec | stoplight.io/prism |
| **Spectral** | Linting tool cho OpenAPI specs | stoplight.io/spectral |

### 4. API-First Design vs Code-First

| Tiêu chí | API-First (Design-First) | Code-First |
|-----------|--------------------------|------------|
| **Quy trình** | Viết spec trước → implement sau | Viết code trước → generate spec |
| **Ưu điểm** | Frontend/backend song song, contract rõ ràng | Nhanh cho prototyping, spec luôn khớp code |
| **Nhược điểm** | Tốn thời gian design upfront | Spec phụ thuộc implementation details |
| **Phù hợp** | Large teams, microservices, public APIs | Small teams, internal APIs, rapid prototyping |
| **Tools** | Swagger Editor, Stoplight Studio | swagger-jsdoc, NestJS Swagger, SpringDoc |

**Khuyến nghị:** Với enterprise projects và public APIs, luôn dùng **API-First design**.

### 5. API Versioning Strategies

| Strategy | Ví dụ | Ưu điểm | Nhược điểm |
|----------|-------|----------|------------|
| **URL Path** | `GET /v1/products` | Đơn giản, rõ ràng, dễ cache | Phá vỡ REST purity, URL dài |
| **Header** | `X-API-Version: 2` | Clean URLs | Khó test bằng browser, ẩn |
| **Query Param** | `GET /products?v=2` | Dễ test | Có thể bị bỏ qua, cache phức tạp |
| **Content Negotiation** | `Accept: application/vnd.api.v2+json` | Chuẩn HTTP | Phức tạp, ít phổ biến |

### 6. Request/Response Schemas — Data Types

OpenAPI sử dụng JSON Schema (Draft 2020-12 cho v3.1) để mô tả data:

| Type | Format | Ví dụ |
|------|--------|-------|
| `string` | — | `"hello"` |
| `string` | `date-time` | `"2025-01-15T10:30:00Z"` |
| `string` | `email` | `"user@example.com"` |
| `string` | `uuid` | `"550e8400-e29b-41d4-a716-446655440000"` |
| `string` | `uri` | `"https://example.com"` |
| `integer` | `int32` | `42` |
| `integer` | `int64` | `9007199254740992` |
| `number` | `float` | `3.14` |
| `number` | `double` | `3.141592653589793` |
| `boolean` | — | `true` |
| `array` | — | `[1, 2, 3]` |
| `object` | — | `{"key": "value"}` |

### 7. Authentication Documentation

Các security schemes phổ biến trong OpenAPI:

- **HTTP Bearer (JWT):** Phổ biến nhất cho modern APIs
- **API Key:** Đơn giản, dùng cho server-to-server
- **OAuth 2.0:** Authorization flows (Authorization Code, Client Credentials, etc.)
- **OpenID Connect:** Identity layer trên OAuth 2.0

### 8. Error Response Standards — RFC 7807

RFC 7807 (Problem Details for HTTP APIs) định nghĩa format chuẩn cho error responses:

```json
{
 "type": "https://api.example.com/errors/out-of-stock",
 "title": "Product is out of stock",
 "status": 422,
 "detail": "Product #12345 hiện tại hết hàng, vui lòng thử lại sau.",
 "instance": "/orders/abc-123"
}
```

**Các trường chuẩn RFC 7807:**

| Trường | Bắt buộc | Mô tả |
|--------|----------|--------|
| `type` | Không (default `about:blank`) | URI xác định loại lỗi |
| `title` | Không | Tiêu đề ngắn gọn của lỗi |
| `status` | Không | HTTP status code |
| `detail` | Không | Mô tả chi tiết lỗi cho instance cụ thể |
| `instance` | Không | URI xác định occurrence cụ thể |

### 9. API Documentation Best Practices

1. **Luôn kèm examples** — Mỗi endpoint cần ít nhất 1 request/response example
2. **Document mọi error** — Liệt kê tất cả status codes có thể trả về
3. **Đặt tên nhất quán** — `camelCase` cho JSON, `kebab-case` cho URLs
4. **Mô tả ngắn gọn** — Summary ≤ 10 từ, description chi tiết hơn
5. **Version your spec** — Spec file phải được version control
6. **Sử dụng tags** — Nhóm endpoints theo domain (Products, Orders, Users)
7. **Reuse components** — Dùng `$ref` để tránh lặp schemas
8. **Deprecated đúng cách** — Đánh dấu `deprecated: true` và ghi rõ thay thế
9. **Validate spec** — Chạy linter (Spectral) trong CI/CD pipeline
10. **Changelog** — Ghi nhận mọi breaking changes giữa các versions

---

## Step-by-step Labs

### Lab 1: Viết OpenAPI 3.0 Spec — Products & Orders CRUD (40 phút)

**Mục tiêu:** Viết complete OpenAPI 3.0 specification cho E-Commerce API gồm Products và Orders.

**Bước 1:** Tạo project structure

```bash
mkdir -p api-docs && cd api-docs
touch openapi.yaml
```

**Bước 2:** Viết file `openapi.yaml` hoàn chỉnh

```yaml
openapi: 3.0.3
info:
 title: E-Commerce API
 version: 1.0.0
 description: |
 RESTful API cho hệ thống E-Commerce.
 Hỗ trợ quản lý products, orders và authentication.
 contact:
 name: API Support Team
 email: api-support@ecommerce.com
 url: https://developer.ecommerce.com
 license:
 name: MIT
 url: https://opensource.org/licenses/MIT

servers:
 - url: https://api.ecommerce.com/v1
 description: Production server
 - url: https://staging-api.ecommerce.com/v1
 description: Staging server
 - url: http://localhost:3000/v1
 description: Local development

tags:
 - name: Products
 description: Quản lý sản phẩm
 - name: Orders
 description: Quản lý đơn hàng

paths:
 # ==================== PRODUCTS ====================
 /products:
 get:
 tags: [Products]
 summary: Lấy danh sách sản phẩm
 operationId: listProducts
 parameters:
 - name: page
 in: query
 description: Số trang (bắt đầu từ 1)
 schema:
 type: integer
 minimum: 1
 default: 1
 - name: limit
 in: query
 description: Số items mỗi trang
 schema:
 type: integer
 minimum: 1
 maximum: 100
 default: 20
 - name: category
 in: query
 description: Lọc theo danh mục
 schema:
 type: string
 enum: [electronics, clothing, books, home]
 - name: minPrice
 in: query
 description: Giá tối thiểu
 schema:
 type: number
 format: double
 minimum: 0
 - name: maxPrice
 in: query
 description: Giá tối đa
 schema:
 type: number
 format: double
 - name: sort
 in: query
 description: "Sắp xếp: price_asc, price_desc, name_asc, created_desc"
 schema:
 type: string
 enum: [price_asc, price_desc, name_asc, created_desc]
 default: created_desc
 responses:
 '200':
 description: Danh sách sản phẩm
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/ProductListResponse'
 example:
 data:
 - id: "prod-001"
 name: "Laptop Dell XPS 15"
 price: 1299.99
 category: electronics
 stock: 50
 createdAt: "2025-01-15T10:30:00Z"
 pagination:
 page: 1
 limit: 20
 total: 150
 totalPages: 8
 '400':
 $ref: '#/components/responses/BadRequest'

 post:
 tags: [Products]
 summary: Tạo sản phẩm mới
 operationId: createProduct
 security:
 - bearerAuth: []
 requestBody:
 required: true
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/CreateProductRequest'
 example:
 name: "Laptop Dell XPS 15"
 description: "Laptop cao cấp cho developer"
 price: 1299.99
 category: electronics
 stock: 50
 images:
 - url: "https://cdn.example.com/xps15-front.jpg"
 alt: "Dell XPS 15 front view"
 responses:
 '201':
 description: Sản phẩm được tạo thành công
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/Product'
 '400':
 $ref: '#/components/responses/BadRequest'
 '401':
 $ref: '#/components/responses/Unauthorized'
 '403':
 $ref: '#/components/responses/Forbidden'

 /products/{productId}:
 parameters:
 - $ref: '#/components/parameters/ProductId'

 get:
 tags: [Products]
 summary: Lấy chi tiết sản phẩm
 operationId: getProduct
 responses:
 '200':
 description: Chi tiết sản phẩm
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/Product'
 '404':
 $ref: '#/components/responses/NotFound'

 put:
 tags: [Products]
 summary: Cập nhật sản phẩm
 operationId: updateProduct
 security:
 - bearerAuth: []
 requestBody:
 required: true
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/UpdateProductRequest'
 responses:
 '200':
 description: Sản phẩm đã được cập nhật
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/Product'
 '401':
 $ref: '#/components/responses/Unauthorized'
 '404':
 $ref: '#/components/responses/NotFound'

 delete:
 tags: [Products]
 summary: Xóa sản phẩm
 operationId: deleteProduct
 security:
 - bearerAuth: []
 responses:
 '204':
 description: Sản phẩm đã được xóa
 '401':
 $ref: '#/components/responses/Unauthorized'
 '404':
 $ref: '#/components/responses/NotFound'

 # ==================== ORDERS ====================
 /orders:
 get:
 tags: [Orders]
 summary: Lấy danh sách đơn hàng của user hiện tại
 operationId: listOrders
 security:
 - bearerAuth: []
 parameters:
 - name: status
 in: query
 schema:
 type: string
 enum: [pending, confirmed, shipping, delivered, cancelled]
 - name: page
 in: query
 schema:
 type: integer
 default: 1
 - name: limit
 in: query
 schema:
 type: integer
 default: 20
 responses:
 '200':
 description: Danh sách đơn hàng
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/OrderListResponse'
 '401':
 $ref: '#/components/responses/Unauthorized'

 post:
 tags: [Orders]
 summary: Tạo đơn hàng mới
 operationId: createOrder
 security:
 - bearerAuth: []
 requestBody:
 required: true
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/CreateOrderRequest'
 example:
 items:
 - productId: "prod-001"
 quantity: 2
 - productId: "prod-005"
 quantity: 1
 shippingAddress:
 street: "123 Nguyễn Huệ"
 city: "Hồ Chí Minh"
 country: "VN"
 postalCode: "70000"
 paymentMethod: credit_card
 responses:
 '201':
 description: Đơn hàng được tạo thành công
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/Order'
 '400':
 $ref: '#/components/responses/BadRequest'
 '401':
 $ref: '#/components/responses/Unauthorized'
 '422':
 description: Sản phẩm hết hàng hoặc dữ liệu không hợp lệ
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/ProblemDetail'

 /orders/{orderId}:
 parameters:
 - name: orderId
 in: path
 required: true
 description: ID đơn hàng (UUID)
 schema:
 type: string
 format: uuid

 get:
 tags: [Orders]
 summary: Lấy chi tiết đơn hàng
 operationId: getOrder
 security:
 - bearerAuth: []
 responses:
 '200':
 description: Chi tiết đơn hàng
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/Order'
 '401':
 $ref: '#/components/responses/Unauthorized'
 '404':
 $ref: '#/components/responses/NotFound'

 patch:
 tags: [Orders]
 summary: Cập nhật trạng thái đơn hàng
 operationId: updateOrderStatus
 security:
 - bearerAuth: []
 requestBody:
 required: true
 content:
 application/json:
 schema:
 type: object
 required: [status]
 properties:
 status:
 type: string
 enum: [confirmed, shipping, delivered, cancelled]
 note:
 type: string
 maxLength: 500
 responses:
 '200':
 description: Trạng thái đã được cập nhật
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/Order'
 '401':
 $ref: '#/components/responses/Unauthorized'
 '404':
 $ref: '#/components/responses/NotFound'

# ==================== COMPONENTS ====================
components:
 schemas:
 Product:
 type: object
 required: [id, name, price, category]
 properties:
 id:
 type: string
 readOnly: true
 example: "prod-001"
 name:
 type: string
 minLength: 1
 maxLength: 200
 example: "Laptop Dell XPS 15"
 description:
 type: string
 maxLength: 2000
 price:
 type: number
 format: double
 minimum: 0
 example: 1299.99
 category:
 type: string
 enum: [electronics, clothing, books, home]
 stock:
 type: integer
 minimum: 0
 default: 0
 images:
 type: array
 items:
 $ref: '#/components/schemas/ProductImage'
 createdAt:
 type: string
 format: date-time
 readOnly: true
 updatedAt:
 type: string
 format: date-time
 readOnly: true

 ProductImage:
 type: object
 properties:
 url:
 type: string
 format: uri
 alt:
 type: string

 CreateProductRequest:
 type: object
 required: [name, price, category]
 properties:
 name:
 type: string
 minLength: 1
 maxLength: 200
 description:
 type: string
 maxLength: 2000
 price:
 type: number
 format: double
 minimum: 0.01
 category:
 type: string
 enum: [electronics, clothing, books, home]
 stock:
 type: integer
 minimum: 0
 default: 0
 images:
 type: array
 items:
 $ref: '#/components/schemas/ProductImage'

 UpdateProductRequest:
 type: object
 properties:
 name:
 type: string
 minLength: 1
 maxLength: 200
 description:
 type: string
 price:
 type: number
 format: double
 minimum: 0.01
 category:
 type: string
 enum: [electronics, clothing, books, home]
 stock:
 type: integer
 minimum: 0

 Order:
 type: object
 required: [id, items, status, totalAmount]
 properties:
 id:
 type: string
 format: uuid
 readOnly: true
 items:
 type: array
 items:
 $ref: '#/components/schemas/OrderItem'
 status:
 type: string
 enum: [pending, confirmed, shipping, delivered, cancelled]
 default: pending
 totalAmount:
 type: number
 format: double
 readOnly: true
 shippingAddress:
 $ref: '#/components/schemas/Address'
 paymentMethod:
 type: string
 enum: [credit_card, bank_transfer, cod]
 createdAt:
 type: string
 format: date-time
 readOnly: true
 updatedAt:
 type: string
 format: date-time
 readOnly: true

 OrderItem:
 type: object
 required: [productId, quantity, unitPrice]
 properties:
 productId:
 type: string
 productName:
 type: string
 readOnly: true
 quantity:
 type: integer
 minimum: 1
 unitPrice:
 type: number
 format: double
 readOnly: true

 CreateOrderRequest:
 type: object
 required: [items, shippingAddress, paymentMethod]
 properties:
 items:
 type: array
 minItems: 1
 items:
 type: object
 required: [productId, quantity]
 properties:
 productId:
 type: string
 quantity:
 type: integer
 minimum: 1
 shippingAddress:
 $ref: '#/components/schemas/Address'
 paymentMethod:
 type: string
 enum: [credit_card, bank_transfer, cod]

 Address:
 type: object
 required: [street, city, country]
 properties:
 street:
 type: string
 city:
 type: string
 country:
 type: string
 minLength: 2
 maxLength: 2
 postalCode:
 type: string

 Pagination:
 type: object
 properties:
 page:
 type: integer
 limit:
 type: integer
 total:
 type: integer
 totalPages:
 type: integer

 ProductListResponse:
 type: object
 properties:
 data:
 type: array
 items:
 $ref: '#/components/schemas/Product'
 pagination:
 $ref: '#/components/schemas/Pagination'

 OrderListResponse:
 type: object
 properties:
 data:
 type: array
 items:
 $ref: '#/components/schemas/Order'
 pagination:
 $ref: '#/components/schemas/Pagination'

 ProblemDetail:
 type: object
 description: Error response theo RFC 7807
 properties:
 type:
 type: string
 format: uri
 example: "https://api.ecommerce.com/errors/validation-error"
 title:
 type: string
 example: "Validation Error"
 status:
 type: integer
 example: 400
 detail:
 type: string
 example: "Field 'email' is required"
 instance:
 type: string
 format: uri

 parameters:
 ProductId:
 name: productId
 in: path
 required: true
 description: ID sản phẩm
 schema:
 type: string

 responses:
 BadRequest:
 description: Dữ liệu không hợp lệ
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/ProblemDetail'
 example:
 type: "https://api.ecommerce.com/errors/bad-request"
 title: "Bad Request"
 status: 400
 detail: "Field 'name' is required"
 Unauthorized:
 description: Chưa xác thực
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/ProblemDetail'
 example:
 type: "https://api.ecommerce.com/errors/unauthorized"
 title: "Unauthorized"
 status: 401
 detail: "Missing or invalid Bearer token"
 Forbidden:
 description: Không có quyền truy cập
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/ProblemDetail'
 example:
 type: "https://api.ecommerce.com/errors/forbidden"
 title: "Forbidden"
 status: 403
 detail: "Admin role required"
 NotFound:
 description: Không tìm thấy resource
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/ProblemDetail'
 example:
 type: "https://api.ecommerce.com/errors/not-found"
 title: "Not Found"
 status: 404
 detail: "Resource not found"

 securitySchemes:
 bearerAuth:
 type: http
 scheme: bearer
 bearerFormat: JWT
 description: "JWT token lấy từ endpoint /auth/login"
```

**Bước 3:** Validate spec bằng Swagger Editor

- Truy cập https://editor.swagger.io
- Paste nội dung `openapi.yaml` vào editor
- Kiểm tra không có errors ở panel bên phải

---

### Lab 2: Swagger UI Setup với Docker (30 phút)

**Mục tiêu:** Deploy Swagger UI bằng Docker để host interactive API docs.

**Bước 1:** Tạo `docker-compose.yaml`

```yaml
version: '3.8'

services:
 swagger-ui:
 image: swaggerapi/swagger-ui:latest
 ports:
 - "8080:8080"
 volumes:
 - ./openapi.yaml:/usr/share/nginx/html/openapi.yaml
 environment:
 - SWAGGER_JSON=/usr/share/nginx/html/openapi.yaml
 - BASE_URL=/docs
 - DOC_EXPANSION=list
 - DEEP_LINKING=true
 - DISPLAY_REQUEST_DURATION=true
 - FILTER=true
 - SHOW_EXTENSIONS=true
 - SHOW_COMMON_EXTENSIONS=true
 - TRY_IT_OUT_ENABLED=true

 swagger-editor:
 image: swaggerapi/swagger-editor:latest
 ports:
 - "8081:8080"
 volumes:
 - ./openapi.yaml:/tmp/openapi.yaml
 environment:
 - SWAGGER_FILE=/tmp/openapi.yaml

 mock-server:
 image: stoplight/prism:latest
 ports:
 - "4010:4010"
 command: mock -h 0.0.0.0 /tmp/openapi.yaml
 volumes:
 - ./openapi.yaml:/tmp/openapi.yaml
```

**Bước 2:** Khởi chạy services

```bash
docker-compose up -d
```

**Bước 3:** Truy cập và kiểm tra

| Service | URL | Mô tả |
|---------|-----|--------|
| Swagger UI | http://localhost:8080/docs | Interactive API docs |
| Swagger Editor | http://localhost:8081 | Edit spec trực tiếp |
| Prism Mock | http://localhost:4010 | Mock server cho testing |

**Bước 4:** Test với Swagger UI Try-it-out

1. Mở http://localhost:8080/docs
2. Click vào endpoint `GET /products`
3. Nhấn nút **"Try it out"**
4. Điền parameters: `page=1`, `limit=5`, `category=electronics`
5. Nhấn **"Execute"** — nếu mock server đang chạy sẽ trả về sample data

**Bước 5:** Customize Swagger UI (tùy chọn)

Tạo file `swagger-custom.html`:

```html
<!DOCTYPE html>
<html>
<head>
 <title>E-Commerce API Documentation</title>
 <link rel="stylesheet"
 href="https://unpkg.com/swagger-ui-dist@5/swagger-ui.css" />
 <style>
 .topbar { background-color: #2c3e50 !important; }
 .swagger-ui .info .title { color: #2c3e50; }
 </style>
</head>
<body>
 <div id="swagger-ui"></div>
 <script src="https://unpkg.com/swagger-ui-dist@5/swagger-ui-bundle.js"></script>
 <script>
 SwaggerUIBundle({
 url: "/openapi.yaml",
 dom_id: '#swagger-ui',
 deepLinking: true,
 docExpansion: 'list',
 filter: true,
 tryItOutEnabled: true,
 displayRequestDuration: true,
 requestSnippetsEnabled: true,
 persistAuthorization: true
 });
 </script>
</body>
</html>
```

---

### Lab 3: Code-First Documentation — Express + swagger-jsdoc (30 phút)

**Mục tiêu:** Tự động generate OpenAPI spec từ JSDoc comments trong Express.js.

**Bước 1:** Khởi tạo project

```bash
mkdir express-api && cd express-api
npm init -y
npm install express swagger-jsdoc swagger-ui-express
```

**Bước 2:** Tạo `swagger.config.js`

```javascript
const swaggerJsdoc = require('swagger-jsdoc');

const options = {
 definition: {
 openapi: '3.0.3',
 info: {
 title: 'E-Commerce API',
 version: '1.0.0',
 description: 'Auto-generated API documentation',
 },
 servers: [
 { url: 'http://localhost:3000/v1', description: 'Development' }
 ],
 components: {
 securitySchemes: {
 bearerAuth: {
 type: 'http',
 scheme: 'bearer',
 bearerFormat: 'JWT',
 },
 },
 },
 },
 apis: ['./routes/*.js'],
};

module.exports = swaggerJsdoc(options);
```

**Bước 3:** Tạo `routes/products.js` với JSDoc annotations

```javascript
const express = require('express');
const router = express.Router();

/**
 * @openapi
 * components:
 * schemas:
 * Product:
 * type: object
 * required: [id, name, price]
 * properties:
 * id:
 * type: string
 * example: "prod-001"
 * name:
 * type: string
 * example: "Laptop Dell XPS 15"
 * price:
 * type: number
 * format: double
 * example: 1299.99
 * category:
 * type: string
 * enum: [electronics, clothing, books, home]
 * stock:
 * type: integer
 * example: 50
 */

/**
 * @openapi
 * /v1/products:
 * get:
 * tags: [Products]
 * summary: Lấy danh sách sản phẩm
 * parameters:
 * - in: query
 * name: page
 * schema:
 * type: integer
 * default: 1
 * - in: query
 * name: limit
 * schema:
 * type: integer
 * default: 20
 * - in: query
 * name: category
 * schema:
 * type: string
 * enum: [electronics, clothing, books, home]
 * responses:
 * 200:
 * description: Danh sách sản phẩm
 * content:
 * application/json:
 * schema:
 * type: object
 * properties:
 * data:
 * type: array
 * items:
 * $ref: '#/components/schemas/Product'
 */
router.get('/', (req, res) => {
 const { page = 1, limit = 20, category } = req.query;
 res.json({
 data: [
 { id: 'prod-001', name: 'Laptop Dell XPS 15', price: 1299.99, category: 'electronics', stock: 50 }
 ],
 pagination: { page: Number(page), limit: Number(limit), total: 1, totalPages: 1 }
 });
});

/**
 * @openapi
 * /v1/products:
 * post:
 * tags: [Products]
 * summary: Tạo sản phẩm mới
 * security:
 * - bearerAuth: []
 * requestBody:
 * required: true
 * content:
 * application/json:
 * schema:
 * type: object
 * required: [name, price, category]
 * properties:
 * name:
 * type: string
 * price:
 * type: number
 * category:
 * type: string
 * responses:
 * 201:
 * description: Sản phẩm đã được tạo
 * content:
 * application/json:
 * schema:
 * $ref: '#/components/schemas/Product'
 * 401:
 * description: Unauthorized
 */
router.post('/', (req, res) => {
 const product = { id: 'prod-new', ...req.body, createdAt: new Date().toISOString() };
 res.status(201).json(product);
});

module.exports = router;
```

**Bước 4:** Tạo `app.js`

```javascript
const express = require('express');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./swagger.config');

const app = express();
app.use(express.json());

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec, {
 customCss: '.swagger-ui .topbar { display: none }',
 customSiteTitle: 'E-Commerce API Docs',
}));

app.get('/api-docs.json', (req, res) => {
 res.setHeader('Content-Type', 'application/json');
 res.send(swaggerSpec);
});

app.use('/v1/products', require('./routes/products'));

app.listen(3000, () => {
 console.log('Server running on http://localhost:3000');
 console.log('API Docs: http://localhost:3000/api-docs');
});
```

**Bước 5:** Chạy và kiểm tra

```bash
node app.js
# Mở http://localhost:3000/api-docs để xem documentation
# Mở http://localhost:3000/api-docs.json để xem raw OpenAPI spec
```

---

### Lab 4: Advanced Features — Auth, Webhooks, Versioning (30 phút)

**Mục tiêu:** Thêm authentication schemes, webhook documentation, examples và API versioning vào spec.

**Bước 1:** Thêm multiple authentication schemes

Thêm vào `components.securitySchemes` trong `openapi.yaml`:

```yaml
components:
 securitySchemes:
 bearerAuth:
 type: http
 scheme: bearer
 bearerFormat: JWT
 description: |
 JWT token lấy từ POST /auth/login.
 Token có hiệu lực 24 giờ.
 Format header: `Authorization: Bearer <token>`

 apiKey:
 type: apiKey
 in: header
 name: X-API-Key
 description: |
 API Key cho server-to-server authentication.
 Liên hệ admin để được cấp key.

 oauth2:
 type: oauth2
 description: OAuth 2.0 authorization
 flows:
 authorizationCode:
 authorizationUrl: https://auth.ecommerce.com/authorize
 tokenUrl: https://auth.ecommerce.com/token
 refreshUrl: https://auth.ecommerce.com/refresh
 scopes:
 products:read: Đọc thông tin sản phẩm
 products:write: Tạo/sửa/xóa sản phẩm
 orders:read: Đọc đơn hàng
 orders:write: Tạo đơn hàng
```

**Bước 2:** Thêm Webhook documentation (OpenAPI 3.1)

```yaml
webhooks:
 orderStatusChanged:
 post:
 summary: Thông báo khi trạng thái đơn hàng thay đổi
 description: |
 Webhook được gọi khi order chuyển trạng thái.
 URL callback được đăng ký qua API Settings.
 requestBody:
 required: true
 content:
 application/json:
 schema:
 type: object
 properties:
 event:
 type: string
 example: "order.status_changed"
 timestamp:
 type: string
 format: date-time
 data:
 type: object
 properties:
 orderId:
 type: string
 format: uuid
 previousStatus:
 type: string
 enum: [pending, confirmed, shipping, delivered, cancelled]
 newStatus:
 type: string
 enum: [pending, confirmed, shipping, delivered, cancelled]
 example:
 event: "order.status_changed"
 timestamp: "2025-03-19T14:30:00Z"
 data:
 orderId: "550e8400-e29b-41d4-a716-446655440000"
 previousStatus: "confirmed"
 newStatus: "shipping"
 responses:
 '200':
 description: Webhook received successfully

 newProductAvailable:
 post:
 summary: Thông báo khi có sản phẩm mới
 requestBody:
 required: true
 content:
 application/json:
 schema:
 type: object
 properties:
 event:
 type: string
 example: "product.created"
 data:
 $ref: '#/components/schemas/Product'
 responses:
 '200':
 description: Acknowledged
```

**Bước 3:** Thêm rich examples

```yaml
components:
 examples:
 ProductExample:
 summary: Laptop example
 value:
 id: "prod-001"
 name: "Laptop Dell XPS 15"
 description: "15.6 inch, Intel i7, 16GB RAM, 512GB SSD"
 price: 1299.99
 category: electronics
 stock: 50
 images:
 - url: "https://cdn.example.com/xps15.jpg"
 alt: "Dell XPS 15"
 createdAt: "2025-01-15T10:30:00Z"

 OrderExample:
 summary: Đơn hàng mẫu
 value:
 id: "550e8400-e29b-41d4-a716-446655440000"
 items:
 - productId: "prod-001"
 productName: "Laptop Dell XPS 15"
 quantity: 1
 unitPrice: 1299.99
 status: "pending"
 totalAmount: 1299.99
 shippingAddress:
 street: "123 Nguyễn Huệ"
 city: "Hồ Chí Minh"
 country: "VN"
 postalCode: "70000"
 paymentMethod: "credit_card"
 createdAt: "2025-03-19T09:00:00Z"

 ValidationErrorExample:
 summary: Lỗi validation
 value:
 type: "https://api.ecommerce.com/errors/validation"
 title: "Validation Error"
 status: 400
 detail: "Request body has 2 validation errors"
 errors:
 - field: "name"
 message: "Name is required"
 - field: "price"
 message: "Price must be greater than 0"
```

**Bước 4:** API Versioning trong OpenAPI spec

```yaml
servers:
 - url: https://api.ecommerce.com/v1
 description: Version 1 (current)
 - url: https://api.ecommerce.com/v2
 description: Version 2 (beta)

# Đánh dấu endpoint deprecated
paths:
 /products/search:
 get:
 deprecated: true
 summary: "[DEPRECATED] Tìm kiếm sản phẩm - Sử dụng GET /products?q= thay thế"
 description: |
 **Endpoint này sẽ bị xóa vào 2025-06-01.**
 Vui lòng chuyển sang sử dụng `GET /products` với query parameter `q`.
 tags: [Products]
 parameters:
 - name: keyword
 in: query
 schema:
 type: string
 responses:
 '200':
 description: Kết quả tìm kiếm
```

---

## Self-Assessment — 30 Câu hỏi

### Câu 1-10: Kiến thức cơ bản

**Câu 1.** Phiên bản major hiện tại của OpenAPI Specification là gì?
- A) 2.0
- B) 3.0
- C) 4.0
- D) 5.0

> **Đáp án: B.** OpenAPI 3.0 (cụ thể 3.0.3 và 3.1.x) là phiên bản major hiện tại. Swagger 2.0 đã được đổi tên thành OpenAPI 3.0 khi chuyển giao cho OpenAPI Initiative.

**Câu 2.** `$ref` trong OpenAPI được sử dụng để:
- A) Tham chiếu URL bên ngoài
- B) Tham chiếu reusable components
- C) Định nghĩa required fields
- D) Đặt response format

> **Đáp án: B.** `$ref` dùng để tham chiếu đến components đã được định nghĩa trong `components` section, giúp tái sử dụng schemas, parameters, responses. Ví dụ: `$ref: '#/components/schemas/Product'`

**Câu 3.** Bearer authentication thuộc type nào trong OpenAPI?
- A) apiKey
- B) http
- C) oauth2
- D) openIdConnect

> **Đáp án: B.** Bearer token thuộc `type: http` với `scheme: bearer`. Type `apiKey` dùng cho API keys trong header/query/cookie.

**Câu 4.** Swagger 2.0 và OpenAPI 3.0 có gì khác nhau?
- A) Chỉ khác tên gọi
- B) OpenAPI 3.0 thêm `components`, `links`, multiple servers
- C) Swagger hỗ trợ nhiều ngôn ngữ hơn
- D) Không có sự khác biệt

> **Đáp án: B.** OpenAPI 3.0 cải tiến lớn: thay `definitions` bằng `components`, hỗ trợ multiple `servers` (thay vì `host` + `basePath`), thêm `links`, `callbacks`, cải thiện `requestBody`, hỗ trợ `oneOf`/`anyOf`/`allOf` tốt hơn.

**Câu 5.** Trong OpenAPI, `operationId` dùng để:
- A) Định danh duy nhất cho mỗi operation
- B) Xác định HTTP method
- C) Đặt URL path
- D) Định nghĩa response code

> **Đáp án: A.** `operationId` là unique identifier cho mỗi API operation, được dùng bởi code generators để tạo tên hàm. Ví dụ: `operationId: listProducts` → function `listProducts()`.

**Câu 6.** Có bao nhiêu loại parameter location trong OpenAPI?
- A) 2 (path, query)
- B) 3 (path, query, header)
- C) 4 (path, query, header, cookie)
- D) 5 (path, query, header, cookie, body)

> **Đáp án: C.** Có 4 loại: `path`, `query`, `header`, `cookie`. Lưu ý: request body không phải parameter mà được định nghĩa riêng qua `requestBody`.

**Câu 7.** `readOnly: true` trong schema property có ý nghĩa gì?
- A) Property không thể thay đổi sau khi tạo
- B) Property chỉ xuất hiện trong response, không yêu cầu trong request
- C) Property bắt buộc phải có
- D) Property chỉ admin mới đọc được

> **Đáp án: B.** `readOnly: true` chỉ ra rằng property chỉ có mặt trong response (GET), không cần gửi trong request body (POST/PUT). Ví dụ: `id`, `createdAt` thường là readOnly.

**Câu 8.** Format `date-time` trong OpenAPI tuân theo chuẩn nào?
- A) ISO 8601 / RFC 3339
- B) Unix timestamp
- C) DD/MM/YYYY
- D) Custom format

> **Đáp án: A.** `format: date-time` tuân theo RFC 3339 (subset của ISO 8601), ví dụ: `2025-03-19T14:30:00Z`.

**Câu 9.** Swagger UI là gì?
- A) Code editor cho OpenAPI
- B) Tool render interactive API documentation từ OpenAPI spec
- C) API testing framework
- D) Database management tool

> **Đáp án: B.** Swagger UI là open-source tool render OpenAPI spec thành interactive HTML documentation, cho phép developer thử gọi API trực tiếp qua giao diện web (Try it out).

**Câu 10.** HTTP status code nào nên dùng khi tạo resource thành công?
- A) 200 OK
- B) 201 Created
- C) 204 No Content
- D) 202 Accepted

> **Đáp án: B.** `201 Created` là status code chuẩn khi POST tạo resource thành công. `200` cho GET/PUT thành công, `204` cho DELETE thành công (no body), `202` cho async processing.

### Câu 11-20: Kiến thức trung bình

**Câu 11.** API-first design khác gì code-first?
- A) API-first viết code trước, code-first viết spec trước
- B) API-first viết spec trước implementation, code-first generate spec từ code
- C) Không có sự khác biệt
- D) API-first chỉ dùng cho GraphQL

> **Đáp án: B.** API-first (design-first) viết OpenAPI spec trước rồi mới implement. Code-first viết code với annotations/decorators rồi auto-generate spec. API-first phù hợp cho large teams và public APIs.

**Câu 12.** RFC 7807 (Problem Details) định nghĩa những trường nào?
- A) error, message
- B) type, title, status, detail, instance
- C) code, description, timestamp
- D) errorCode, errorMessage, stackTrace

> **Đáp án: B.** RFC 7807 định nghĩa 5 trường: `type` (URI xác định loại lỗi), `title` (tóm tắt ngắn), `status` (HTTP status code), `detail` (chi tiết), `instance` (URI xác định occurrence).

**Câu 13.** `allOf` trong OpenAPI dùng để:
- A) Validate tất cả schemas phải đúng (composition/inheritance)
- B) Chọn một trong các schemas
- C) Validate ít nhất một schema
- D) Phủ định schema

> **Đáp án: A.** `allOf` dùng cho schema composition — kết hợp nhiều schemas lại. Thường dùng cho inheritance: `allOf: [{ $ref: '#/components/schemas/Base' }, { properties: { extra: ... } }]`.

**Câu 14.** Cách nào là best practice cho API versioning?
- A) Không cần versioning
- B) URL path versioning (`/v1/products`) cho simplicity
- C) Luôn dùng header versioning
- D) Dùng query parameter versioning

> **Đáp án: B.** URL path versioning là phương pháp phổ biến nhất vì đơn giản, rõ ràng, dễ test bằng browser, dễ cache. Các major API providers (Google, Stripe, GitHub) đều dùng URL path versioning.

**Câu 15.** Prism (Stoplight) dùng để làm gì?
- A) Compile OpenAPI spec
- B) Tạo mock server từ OpenAPI spec
- C) Deploy API lên production
- D) Encrypt API requests

> **Đáp án: B.** Prism là mock server — đọc OpenAPI spec và tự động trả về sample responses dựa trên schema definitions và examples. Rất hữu ích cho frontend development khi backend chưa sẵn sàng.

**Câu 16.** Tag trong OpenAPI dùng để:
- A) Đánh dấu deprecated endpoints
- B) Nhóm và phân loại các operations trong documentation
- C) Xác định authentication type
- D) Định nghĩa HTTP method

> **Đáp án: B.** Tags nhóm các operations lại với nhau trong rendered documentation. Ví dụ: tag `Products` nhóm tất cả endpoints liên quan đến products. Swagger UI hiển thị operations theo tag groups.

**Câu 17.** `discriminator` trong OpenAPI dùng trong trường hợp nào?
- A) Phân biệt request và response
- B) Hỗ trợ polymorphism — xác định schema nào được sử dụng trong `oneOf`/`anyOf`
- C) Phân quyền truy cập
- D) Đánh version cho schema

> **Đáp án: B.** `discriminator` giúp xác định concrete type trong polymorphism. Ví dụ: `Payment` có thể là `CreditCardPayment` hoặc `BankTransferPayment`, `discriminator.propertyName: paymentType` cho biết field nào quyết định type.

**Câu 18.** Spectral là gì?
- A) Testing framework
- B) Linting tool cho OpenAPI specs
- C) Documentation generator
- D) Authentication library

> **Đáp án: B.** Spectral (by Stoplight) là linting tool kiểm tra OpenAPI specs theo các rules (built-in và custom). Giúp đảm bảo spec quality, naming conventions, và API design guidelines.

**Câu 19.** Khi nào nên dùng `PATCH` thay vì `PUT`?
- A) PATCH và PUT giống nhau
- B) PATCH cho partial update, PUT cho full replacement
- C) PATCH nhanh hơn PUT
- D) PATCH an toàn hơn PUT

> **Đáp án: B.** `PUT` thay thế toàn bộ resource (phải gửi đầy đủ fields), `PATCH` chỉ cập nhật các fields được gửi (partial update). `PATCH` phù hợp khi chỉ muốn update 1-2 fields mà không cần gửi lại toàn bộ object.

**Câu 20.** `nullable: true` trong OpenAPI 3.0 khác gì trong 3.1?
- A) Không có sự khác biệt
- B) 3.0 dùng `nullable: true`, 3.1 dùng `type: ['string', 'null']`
- C) 3.1 bỏ hỗ trợ nullable
- D) 3.0 không hỗ trợ nullable

> **Đáp án: B.** OpenAPI 3.0 dùng keyword `nullable: true`. OpenAPI 3.1 theo chuẩn JSON Schema nên dùng `type: ['string', 'null']` thay thế. Đây là breaking change quan trọng khi migrate.

### Câu 21-30: Kiến thức nâng cao

**Câu 21.** Callback trong OpenAPI dùng cho mục đích gì?
- A) Error handling
- B) Mô tả webhook URLs mà API sẽ gọi ngược lại client
- C) Async function calls
- D) Database callbacks

> **Đáp án: B.** `callbacks` mô tả API-initiated requests — khi API server gọi ngược lại một URL mà client đã đăng ký (webhook pattern). Ví dụ: sau khi payment hoàn thành, server gọi callback URL của merchant.

**Câu 22.** Làm thế nào để document pagination trong OpenAPI?
- A) Chỉ cần thêm `page` parameter
- B) Dùng query parameters (page, limit) kết hợp response schema có pagination metadata
- C) Dùng header để chứa pagination info
- D) OpenAPI không hỗ trợ pagination

> **Đáp án: B.** Best practice: định nghĩa query parameters (`page`, `limit`, `offset`) và response schema có `pagination` object chứa `total`, `totalPages`, `page`, `limit`. Nên tạo reusable Pagination schema trong components.

**Câu 23.** Cách xử lý breaking changes khi API versioning?
- A) Cập nhật trực tiếp, không thông báo
- B) Tạo version mới, deprecate version cũ với sunset date, cung cấp migration guide
- C) Chỉ thêm tính năng mới
- D) Xóa version cũ ngay lập tức

> **Đáp án: B.** Best practice: (1) tạo version mới, (2) đánh dấu `deprecated: true` cho version cũ, (3) thông báo sunset date (thường 6-12 tháng), (4) cung cấp migration guide chi tiết, (5) gửi deprecation warnings qua headers.

**Câu 24.** `x-` prefix trong OpenAPI dùng để làm gì?
- A) Đánh dấu experimental features
- B) Extension fields — custom metadata không thuộc OpenAPI standard
- C) External references
- D) XML configuration

> **Đáp án: B.** `x-` prefix cho phép thêm custom extension fields vào spec. Ví dụ: `x-internal: true` đánh dấu internal endpoint, `x-rate-limit: 100` ghi nhận rate limit. Các tools có thể đọc và xử lý extensions này.

**Câu 25.** Làm sao document rate limiting trong OpenAPI spec?
- A) Không thể document trong OpenAPI
- B) Dùng response headers (X-RateLimit-Limit, X-RateLimit-Remaining) và extensions
- C) Chỉ ghi trong description
- D) Dùng security scheme

> **Đáp án: B.** Document rate limiting qua: (1) response headers schema (`X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`), (2) `429 Too Many Requests` response, (3) API description/overview section. Có thể dùng `x-rateLimit` extension.

**Câu 26.** OpenAPI Generator hỗ trợ generate cho khoảng bao nhiêu ngôn ngữ/frameworks?
- A) 5-10
- B) 10-20
- C) 50+
- D) 100+

> **Đáp án: C.** OpenAPI Generator hỗ trợ 50+ ngôn ngữ/frameworks cho cả client SDKs (TypeScript, Python, Java, Go...) và server stubs (Express, Spring, Flask...).

**Câu 27.** `links` trong OpenAPI 3.0 dùng để:
- A) Tạo hyperlinks trong documentation
- B) Mô tả mối quan hệ giữa operations (HATEOAS-like)
- C) Link đến external resources
- D) Kết nối database

> **Đáp án: B.** `links` mô tả runtime relationships — ví dụ: response từ `createUser` chứa `userId` có thể dùng làm parameter cho `getUser`. Hỗ trợ HATEOAS pattern trong documentation.

**Câu 28.** Cách nào hiệu quả nhất để maintain OpenAPI spec trong team lớn?
- A) Một người viết và maintain toàn bộ
- B) Tách spec theo domain modules, dùng `$ref` external files, CI/CD validation
- C) Copy-paste spec giữa các team
- D) Không dùng spec, chỉ dùng Postman

> **Đáp án: B.** Best practice: (1) tách spec thành nhiều files theo domain, (2) dùng `$ref` để reference giữa files, (3) chạy Spectral linting trong CI/CD, (4) auto-publish docs khi merge, (5) version control spec files cùng codebase.

**Câu 29.** AsyncAPI khác gì OpenAPI?
- A) AsyncAPI nhanh hơn
- B) AsyncAPI dùng cho event-driven/async APIs (WebSocket, Kafka, MQTT), OpenAPI cho REST
- C) AsyncAPI là phiên bản mới của OpenAPI
- D) Không có sự khác biệt

> **Đáp án: B.** AsyncAPI là specification riêng cho event-driven architectures — mô tả message-based APIs (WebSocket, Kafka, RabbitMQ, MQTT). OpenAPI chỉ dành cho request/response (REST). Hai specs bổ sung cho nhau.

**Câu 30.** Theo best practice, API documentation nên được deploy ở đâu?
- A) Chỉ trên local máy developer
- B) Developer portal riêng biệt với auth, versioning, interactive examples
- C) Gửi email cho client
- D) In ra giấy

> **Đáp án: B.** Best practice: deploy API docs lên developer portal chuyên dụng (ví dụ: Redoc, Swagger UI hosted, ReadMe.io) với: authentication, multiple versions, interactive try-it-out, SDKs download, changelog, và getting started guides.

---

## Extend Labs (10 bài)

### EL1: Complete Multi-Domain API Spec

```
Mục tiêu: Viết OpenAPI spec đầy đủ với 20+ endpoints
- Products CRUD (5 endpoints)
- Users & Authentication (5 endpoints)
- Orders & Cart (6 endpoints)
- Reviews & Ratings (4 endpoints)
- Admin endpoints (5 endpoints)
Yêu cầu: Dùng tags, reusable components, examples
Độ khó: ***
Thời gian: 60 phút
```

### EL2: Client SDK Generation

```
Mục tiêu: Generate và test client SDKs
- Install OpenAPI Generator CLI
- Generate TypeScript Axios client
- Generate Python client
- Viết integration tests dùng generated SDK
Độ khó: ***
Thời gian: 45 phút
```

### EL3: API Developer Portal với Redoc

```
Mục tiêu: Deploy beautiful API docs với Redoc
- Setup Redoc standalone
- Customize theme (colors, fonts, logo)
- Deploy lên GitHub Pages / Netlify
- So sánh Redoc vs Swagger UI
Độ khó: ***
Thời gian: 30 phút
```

### EL4: Mock Server với Prism

```
Mục tiêu: Setup mock server cho frontend development
- Install và chạy Prism
- Cấu hình dynamic response examples
- Tích hợp Prism vào frontend dev workflow
- Viết test scripts gọi mock API
Độ khó: ***
Thời gian: 30 phút
```

### EL5: Contract Testing với Schemathesis

```
Mục tiêu: Automated testing từ OpenAPI spec
- Install Schemathesis
- Chạy property-based tests từ spec
- Tìm bugs bằng fuzzing
- Tích hợp vào CI/CD pipeline
Độ khó: ****
Thời gian: 45 phút
```

### EL6: API Versioning Implementation

```
Mục tiêu: Implement versioning strategy
- URL path versioning (/v1/, /v2/)
- Viết migration guide giữa versions
- Implement deprecation warnings qua headers
- Sunset header (RFC 8594)
Độ khó: ***
Thời gian: 40 phút
```

### EL7: API Linting với Spectral

```
Mục tiêu: Enforce API design standards
- Install Spectral CLI
- Cấu hình custom ruleset (.spectral.yaml)
- Viết 5 custom rules (naming, security, pagination)
- Tích hợp Spectral vào Git pre-commit hook
Độ khó: ***
Thời gian: 30 phút
```

### EL8: NestJS Swagger Integration

```
Mục tiêu: Code-first docs với NestJS decorators
- Setup @nestjs/swagger
- Dùng decorators: @ApiTags, @ApiOperation, @ApiResponse
- Generate OpenAPI spec tự động
- So sánh với swagger-jsdoc (Express)
Độ khó: ****
Thời gian: 45 phút
```

### EL9: AsyncAPI cho WebSocket/Events

```
Mục tiêu: Document event-driven APIs
- Viết AsyncAPI spec cho WebSocket notifications
- Document Kafka events
- Render docs với AsyncAPI Studio
- So sánh AsyncAPI vs OpenAPI
Độ khó: ****
Thời gian: 45 phút
```

### EL10: API Governance & Design Guide

```
Mục tiêu: Xây dựng API style guide cho team
- Viết naming conventions document
- Định nghĩa error response standards
- Tạo API review checklist
- Setup centralized API registry (Backstage/Stoplight)
Độ khó: ****
Thời gian: 45 phút
```

---

## Deliverables — Checklist

| # | Deliverable | Mô tả | Hoàn thành |
|---|------------|--------|------------|
| 1 | `openapi.yaml` | Complete E-Commerce OpenAPI 3.0 spec (Lab 1) | ☐ |
| 2 | `docker-compose.yaml` | Swagger UI + Editor + Mock server setup (Lab 2) | ☐ |
| 3 | Screenshots | Swagger UI đang hiển thị API docs + Try-it-out (Lab 2) | ☐ |
| 4 | Express project | Code-first docs với swagger-jsdoc (Lab 3) | ☐ |
| 5 | `openapi.yaml` (v2) | Spec bổ sung auth schemes, webhooks, versioning (Lab 4) | ☐ |
| 6 | Self-Assessment | Trả lời 30 câu hỏi (ghi nhận điểm) | ☐ |
| 7 | Reflection | Ghi nhận 3 điều đã học và 2 điều muốn tìm hiểu thêm | ☐ |

---

## Lỗi Thường Gặp

| # | Lỗi | Nguyên nhân | Cách sửa |
|---|------|-------------|----------|
| 1 | Spec không validate được | Sai cú pháp YAML (thụt đầu dòng dùng tab thay vì space) | Dùng 2-space indentation, kiểm tra bằng Swagger Editor |
| 2 | `$ref` không resolve | Sai đường dẫn reference (thiếu `#/`) | Đảm bảo path bắt đầu từ `#/components/schemas/...` |
| 3 | Swagger UI hiện blank | File spec không được mount đúng trong Docker | Kiểm tra volume path trong `docker-compose.yaml` |
| 4 | Try-it-out bị CORS error | Browser chặn cross-origin request đến API server | Cấu hình CORS headers trên server hoặc dùng proxy |
| 5 | Authentication không hoạt động trên Swagger UI | Chưa click "Authorize" và nhập token | Click nút Authorize, nhập `Bearer <token>`, nhấn Authorize |
| 6 | Response schema không khớp actual response | Spec viết tay không đồng bộ với code | Dùng contract testing (Schemathesis) để detect drift |
| 7 | `operationId` bị trùng | Hai endpoints có cùng `operationId` | Đảm bảo mỗi `operationId` là unique trong toàn spec |
| 8 | swagger-jsdoc không generate đủ endpoints | Sai glob pattern trong `apis` config | Kiểm tra pattern: `['./routes/*.js']` phải match đúng files |
| 9 | Enum values không hiện trên UI | Định nghĩa enum trong `type` thay vì `schema` | Đặt `enum` bên trong `schema` object: `schema: { type: string, enum: [...] }` |
| 10 | File spec quá lớn, khó maintain | Tất cả viết trong 1 file YAML | Tách thành multiple files, dùng `$ref: './schemas/product.yaml'` |

---

## Rubric — Thang điểm 100

| Tiêu chí | Mô tả chi tiết | Điểm |
|----------|----------------|------|
| **OpenAPI Spec Quality** | Spec có đầy đủ info, servers, paths, components. YAML syntax đúng, validate không lỗi. Có ít nhất 8 endpoints. | 25 |
| **Schema Design** | Schemas đầy đủ (Product, Order, Address, Pagination, ProblemDetail). Có required fields, data types đúng, format annotations (uuid, email, date-time). Dùng `$ref` để reuse. | 20 |
| **Swagger UI Setup** | Docker compose chạy được. Swagger UI hiển thị đúng spec. Try-it-out hoạt động. Có mock server (bonus). | 15 |
| **Code-First Integration** | Express app chạy được. JSDoc annotations đúng chuẩn. `/api-docs` hiển thị documentation. Spec generated khớp với code. | 15 |
| **Advanced Features** | Có ít nhất 2 security schemes. Có webhook/callback documentation. Có deprecation marking. Có rich examples cho request/response. | 15 |
| **Best Practices** | Consistent naming conventions. Error responses theo RFC 7807. Pagination pattern chuẩn. Có tags grouping. Có description cho mọi endpoint. | 10 |
| **Tổng** | | **100** |

**Thang xếp loại:**

| Điểm | Xếp loại | Mô tả |
|------|----------|--------|
| 90-100 | Xuất sắc | Hoàn thành tất cả labs, spec production-ready |
| 80-89 | Giỏi | Hoàn thành tốt, có minor issues |
| 70-79 | Khá | Hoàn thành cơ bản, thiếu một số advanced features |
| 60-69 | Trung bình | Hoàn thành Lab 1-2, thiếu nhiều phần |
| < 60 | Chưa đạt | Cần làm lại |

---

## Tài liệu Tham khảo

1. [OpenAPI Specification 3.0.3](https://spec.openapis.org/oas/v3.0.3)
2. [OpenAPI Specification 3.1.0](https://spec.openapis.org/oas/v3.1.0)
3. [Swagger Editor](https://editor.swagger.io/)
4. [Swagger UI Documentation](https://swagger.io/docs/open-source-tools/swagger-ui/)
5. [OpenAPI Generator](https://openapi-generator.tech/)
6. [Redoc](https://github.com/Redocly/redoc)
7. [RFC 7807 — Problem Details for HTTP APIs](https://datatracker.ietf.org/doc/html/rfc7807)
8. [RFC 8594 — Sunset Header](https://datatracker.ietf.org/doc/html/rfc8594)
9. [Stoplight Spectral](https://stoplight.io/open-source/spectral)
10. [Stoplight Prism](https://stoplight.io/open-source/prism)
11. [swagger-jsdoc](https://github.com/Surnet/swagger-jsdoc)
12. [NestJS OpenAPI (Swagger)](https://docs.nestjs.com/openapi/introduction)
13. [AsyncAPI Specification](https://www.asyncapi.com/)
14. [API Stylebook](http://apistylebook.com/)
