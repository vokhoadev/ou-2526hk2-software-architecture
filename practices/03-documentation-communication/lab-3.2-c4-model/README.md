# Lab 3.2: C4 Model for Software Architecture

## 1. Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu trước** | Lab 3.1 (Documentation Fundamentals) |
| **CLO** | CLO4 |
| **Công cụ** | Structurizr DSL, C4-PlantUML, PlantUML |
| **Kết quả đầu ra** | 4 C4 diagrams hoàn chỉnh cho hệ thống E-Commerce |

C4 Model là phương pháp trực quan hóa kiến trúc phần mềm được phát triển bởi **Simon Brown**. Thay vì cố gắng thể hiện mọi thứ trên một diagram duy nhất, C4 sử dụng **4 mức trừu tượng** (zoom levels) — giống như Google Maps cho phép bạn zoom từ bản đồ thế giới xuống đến từng con đường. Lab này hướng dẫn bạn áp dụng C4 Model bằng Structurizr DSL và PlantUML cho hệ thống E-Commerce thực tế.

---

## 2. Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Giải thích** C4 Model, 4 levels of abstraction và triết lý thiết kế của Simon Brown
2. **Vẽ** System Context Diagram xác định ranh giới hệ thống, actors và external systems
3. **Phân tách** hệ thống thành Container Diagram thể hiện các deployment units (web app, API, database, message queue)
4. **Chi tiết hóa** một container thành Component Diagram với các thành phần nội bộ và quan hệ giữa chúng
5. **Sử dụng** Structurizr DSL và C4-PlantUML để tạo diagrams dạng "diagram as code" có thể version control

---

## 3. Phân bổ Thời gian

| Giai đoạn | Nội dung | Thời lượng |
|-----------|----------|------------|
| **Lý thuyết** | C4 Model overview, 4 levels, notation, tooling | 30 phút |
| **Lab 1** | System Context Diagram (Structurizr DSL + PlantUML) | 30 phút |
| **Lab 2** | Container Diagram (break system into containers) | 35 phút |
| **Lab 3** | Component Diagram (zoom into API container) | 30 phút |
| **Lab 4** | Deployment Diagram (map to infrastructure) | 25 phút |
| **Review** | Self-assessment, peer review, Q&A | 20 phút |
| **Mở rộng** | Extend Labs, bài tập nâng cao | 10 phút |
| **Tổng** | | **3 giờ** |

---

## 4. Lý thuyết

### 4.1 C4 Model là gì?

**C4 Model** được tạo bởi **Simon Brown** (tác giả cuốn *"Software Architecture for Developers"*). C4 là viết tắt của **Context, Containers, Components, Code** — 4 mức zoom để mô tả kiến trúc phần mềm.

Triết lý cốt lõi:
- **Maps, not art** — diagram phải truyền tải thông tin, không phải tác phẩm nghệ thuật
- **Different levels for different audiences** — mỗi level phục vụ một nhóm đối tượng khác nhau
- **Abstractions first** — xác định các khái niệm trừu tượng trước khi vẽ diagram
- **Notation second** — notation chỉ là cách thể hiện, quan trọng là nội dung

```
Zoom Level:

Level 1: System Context ← "Big picture" — toàn cảnh hệ thống
 └── Level 2: Container ← "High-level technology" — ứng dụng, database, queue
 └── Level 3: Component ← "Internal structure" — thành phần bên trong
 └── Level 4: Code ← "Implementation" — class, interface (optional)
```

### 4.2 Bốn mức trừu tượng (4 Levels)

#### Level 1 — System Context Diagram

| Thuộc tính | Mô tả |
|------------|--------|
| **Mục đích** | Cho thấy hệ thống trong bối cảnh tổng thể |
| **Đối tượng** | Tất cả mọi người (business, technical, management) |
| **Hiển thị** | Hệ thống chính, users/actors, external systems |
| **Không hiển thị** | Chi tiết công nghệ bên trong |
| **Tương tự** | Nhìn bản đồ ở mức quốc gia |

**Khi nào dùng**: Luôn luôn — đây là diagram bắt buộc đầu tiên cho mọi hệ thống.

#### Level 2 — Container Diagram

| Thuộc tính | Mô tả |
|------------|--------|
| **Mục đích** | Cho thấy các "deployment units" trong hệ thống |
| **Đối tượng** | Technical people (developers, architects, DevOps) |
| **Hiển thị** | Web apps, APIs, databases, message queues, file systems |
| **Không hiển thị** | Nội bộ của từng container |
| **Tương tự** | Nhìn bản đồ ở mức thành phố |

> **Lưu ý**: "Container" trong C4 ≠ Docker container. Container ở đây là một **deployment/runtime unit** — bất cứ thứ gì chạy riêng biệt và cần tồn tại để hệ thống hoạt động.

**Khi nào dùng**: Khi team cần hiểu high-level technology decisions và cách hệ thống được phân tách.

#### Level 3 — Component Diagram

| Thuộc tính | Mô tả |
|------------|--------|
| **Mục đích** | Cho thấy cấu trúc bên trong một container |
| **Đối tượng** | Developers làm việc trực tiếp trên container đó |
| **Hiển thị** | Components/modules/services bên trong container |
| **Không hiển thị** | Implementation details (classes, methods) |
| **Tương tự** | Nhìn bản đồ ở mức quận/phường |

**Khi nào dùng**: Khi cần thiết kế hoặc giải thích cấu trúc bên trong của một container cụ thể.

#### Level 4 — Code Diagram (Optional)

| Thuộc tính | Mô tả |
|------------|--------|
| **Mục đích** | Cho thấy implementation ở mức code |
| **Đối tượng** | Developers |
| **Hiển thị** | Classes, interfaces, enums, relationships |
| **Tương tự** | UML Class Diagram |

**Khi nào dùng**: Hiếm khi cần vẽ thủ công — nên auto-generate từ code. Chỉ dùng cho core domain hoặc complex algorithms.

### 4.3 Diagram Notation

C4 Model sử dụng notation đơn giản với các element types:

| Element | Hình dạng | Mô tả |
|---------|-----------|--------|
| **Person** | Hình người (stick figure) | User hoặc actor tương tác với hệ thống |
| **Software System** | Hộp chữ nhật (viền đậm) | Hệ thống phần mềm cấp cao nhất |
| **Container** | Hộp chữ nhật (có technology tag) | Ứng dụng, database, queue, v.v. |
| **Component** | Hộp chữ nhật (có technology tag) | Module/service bên trong container |
| **Relationship** | Mũi tên có nhãn | Kết nối giữa các elements (label mô tả mục đích + technology) |
| **System Boundary** | Hộp viền nét đứt | Ranh giới hệ thống (dùng ở Level 2, 3) |

Quy tắc cho Relationships:
- Mỗi mũi tên cần có **description** (làm gì?) và ideally có **technology** (dùng gì?)
- Ví dụ: `"Sends order events" / "AMQP"` thay vì chỉ `"Uses"`

### 4.4 Công cụ (Tooling)

#### Structurizr DSL

**Structurizr** là công cụ chính thức do chính Simon Brown phát triển, sử dụng DSL (Domain Specific Language) để mô tả architecture model.

```bash
# Chạy Structurizr Lite bằng Docker
docker run -it --rm -p 8080:8080 \
 -v $(pwd):/usr/local/structurizr \
 structurizr/lite

# Export diagrams sang PlantUML
docker run --rm -v $(pwd):/usr/local/structurizr \
 structurizr/cli export \
 -workspace workspace.dsl \
 -format plantuml
```

#### C4-PlantUML

Library mở rộng PlantUML hỗ trợ vẽ C4 diagrams:

```
Repository: https://github.com/plantuml-stdlib/C4-PlantUML
Macros chính:
 - Person(), Person_Ext()
 - System(), System_Ext(), System_Boundary()
 - Container(), ContainerDb(), ContainerQueue()
 - Component()
 - Rel(), Rel_Back(), Rel_Neighbor()
```

#### c4builder

CLI tool giúp tạo website tĩnh từ C4 diagrams:

```bash
npm install -g c4builder
c4builder init
c4builder
```

### 4.5 Supplementary Diagrams

Ngoài 4 core diagrams, C4 Model còn hỗ trợ:

| Diagram | Mục đích | Khi nào dùng |
|---------|----------|--------------|
| **System Landscape** | Toàn cảnh nhiều hệ thống trong enterprise | Khi cần overview toàn bộ hệ sinh thái |
| **Deployment** | Mapping containers lên infrastructure (servers, cloud, k8s) | Khi cần mô tả production/staging environment |
| **Dynamic** | Sequence/collaboration giữa elements cho một use case cụ thể | Khi cần giải thích flow cho một scenario |

---

## 5. Step-by-step Labs

> **Scenario xuyên suốt**: Hệ thống **E-Commerce Platform** cho phép khách hàng duyệt sản phẩm, đặt hàng, thanh toán online. Admin quản lý sản phẩm, đơn hàng và báo cáo.

### Lab 1: System Context Diagram (30 phút)

**Mục tiêu**: Vẽ Level 1 — xác định hệ thống E-Commerce trong bối cảnh tổng thể.

**Yêu cầu**:
- Xác định các actors (ai sử dụng hệ thống?)
- Xác định external systems (hệ thống nào tương tác?)
- Vẽ relationships giữa tất cả elements

#### Bước 1: Xác định elements

| Element | Type | Mô tả |
|---------|------|--------|
| Customer | Person | Khách hàng mua sắm online |
| Admin | Person | Quản trị viên hệ thống |
| E-Commerce Platform | Software System | Hệ thống chính |
| Payment Gateway | External System | Xử lý thanh toán (Stripe) |
| Shipping Provider | External System | Vận chuyển đơn hàng (GHN, GHTK) |
| Email Service | External System | Gửi email thông báo (SendGrid) |
| Identity Provider | External System | Xác thực SSO (Google, Facebook) |

#### Bước 2: Viết Structurizr DSL

```dsl
workspace "E-Commerce Platform" "System Context for an e-commerce platform" {

 model {
 customer = person "Customer" "Khách hàng duyệt sản phẩm và đặt hàng online"
 admin = person "Admin" "Quản trị viên quản lý sản phẩm, đơn hàng, báo cáo"

 ecommerce = softwareSystem "E-Commerce Platform" "Nền tảng thương mại điện tử cho phép mua bán sản phẩm online" {
 tags "Internal"
 }

 paymentGateway = softwareSystem "Payment Gateway" "Xử lý thanh toán qua Stripe, VNPay" {
 tags "External"
 }
 shippingProvider = softwareSystem "Shipping Provider" "Dịch vụ vận chuyển GHN, GHTK" {
 tags "External"
 }
 emailService = softwareSystem "Email Service" "Gửi email transactional qua SendGrid" {
 tags "External"
 }
 identityProvider = softwareSystem "Identity Provider" "Xác thực SSO qua Google, Facebook" {
 tags "External"
 }

 # Relationships
 customer -> ecommerce "Duyệt sản phẩm, đặt hàng, theo dõi đơn hàng" "HTTPS"
 admin -> ecommerce "Quản lý sản phẩm, xử lý đơn hàng, xem báo cáo" "HTTPS"
 ecommerce -> paymentGateway "Xử lý thanh toán" "HTTPS/REST API"
 ecommerce -> shippingProvider "Tạo đơn vận chuyển, tracking" "HTTPS/REST API"
 ecommerce -> emailService "Gửi email xác nhận đơn hàng, khuyến mãi" "SMTP/API"
 ecommerce -> identityProvider "Xác thực người dùng SSO" "OAuth 2.0 / OIDC"
 }

 views {
 systemContext ecommerce "SystemContext" "System Context diagram cho E-Commerce Platform" {
 include *
 autoLayout
 }

 styles {
 element "Person" {
 shape Person
 background #08427B
 color #ffffff
 }
 element "Internal" {
 background #1168BD
 color #ffffff
 }
 element "External" {
 background #999999
 color #ffffff
 }
 }
 }
}
```

#### Bước 3: Viết PlantUML tương đương

```plantuml
@startuml C4_Context
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Context.puml

LAYOUT_WITH_LEGEND()

title System Context Diagram — E-Commerce Platform

Person(customer, "Customer", "Khách hàng duyệt sản phẩm và đặt hàng online")
Person(admin, "Admin", "Quản trị viên quản lý sản phẩm, đơn hàng")

System(ecommerce, "E-Commerce Platform", "Nền tảng thương mại điện tử cho phép mua bán sản phẩm online")

System_Ext(payment, "Payment Gateway", "Xử lý thanh toán (Stripe, VNPay)")
System_Ext(shipping, "Shipping Provider", "Dịch vụ vận chuyển (GHN, GHTK)")
System_Ext(email, "Email Service", "Gửi email transactional (SendGrid)")
System_Ext(idp, "Identity Provider", "Xác thực SSO (Google, Facebook)")

Rel(customer, ecommerce, "Duyệt sản phẩm, đặt hàng", "HTTPS")
Rel(admin, ecommerce, "Quản lý sản phẩm, đơn hàng", "HTTPS")
Rel(ecommerce, payment, "Xử lý thanh toán", "REST API")
Rel(ecommerce, shipping, "Tạo đơn vận chuyển", "REST API")
Rel(ecommerce, email, "Gửi email xác nhận", "SMTP")
Rel(ecommerce, idp, "Xác thực SSO", "OAuth 2.0")

@enduml
```

#### Checklist Lab 1

- [ ] Xác định đúng tất cả actors (ít nhất 2)
- [ ] Xác định đúng tất cả external systems (ít nhất 3)
- [ ] Mỗi relationship có description và technology
- [ ] Diagram có title và legend
- [ ] File DSL chạy được trên Structurizr Lite

---

### Lab 2: Container Diagram (35 phút)

**Mục tiêu**: Zoom vào E-Commerce Platform — phân tách thành các containers (deployment units).

**Yêu cầu**:
- Break hệ thống thành các containers: Web App, Mobile BFF, API Gateway, services, databases, queue
- Xác định technology cho mỗi container
- Vẽ relationships giữa containers và với external systems

#### Bước 1: Xác định containers

| Container | Technology | Mô tả |
|-----------|-----------|--------|
| Web Application | React, TypeScript | SPA cho khách hàng và admin |
| Mobile BFF | Node.js, Express | Backend-for-Frontend cho mobile app |
| API Gateway | Kong / Nginx | Routing, rate limiting, authentication |
| Catalog Service | Node.js, Express | Quản lý sản phẩm, danh mục, tìm kiếm |
| Order Service | Java, Spring Boot | Xử lý đặt hàng, quản lý đơn hàng |
| Payment Service | Go | Tích hợp thanh toán, quản lý giao dịch |
| Notification Service | Python, FastAPI | Gửi email, SMS, push notification |
| Catalog Database | PostgreSQL | Lưu trữ sản phẩm, categories |
| Order Database | PostgreSQL | Lưu trữ đơn hàng, customers |
| Message Queue | RabbitMQ | Async messaging giữa services |
| Cache | Redis | Caching sản phẩm, sessions |
| Search Engine | Elasticsearch | Full-text search sản phẩm |

#### Bước 2: Viết Structurizr DSL

```dsl
workspace "E-Commerce Platform" "Container Diagram" {

 model {
 customer = person "Customer" "Khách hàng mua sắm online"
 admin = person "Admin" "Quản trị viên hệ thống"

 ecommerce = softwareSystem "E-Commerce Platform" "Nền tảng TMĐT" {
 webApp = container "Web Application" "Giao diện người dùng cho khách hàng và admin" "React, TypeScript" "WebBrowser"
 mobileBff = container "Mobile BFF" "Backend-for-Frontend phục vụ mobile app" "Node.js, Express"
 apiGateway = container "API Gateway" "Routing, rate limiting, auth" "Kong"

 catalogService = container "Catalog Service" "Quản lý sản phẩm, danh mục, tìm kiếm" "Node.js, Express"
 orderService = container "Order Service" "Xử lý đặt hàng, quản lý đơn hàng" "Java, Spring Boot"
 paymentService = container "Payment Service" "Tích hợp thanh toán, quản lý giao dịch" "Go"
 notificationService = container "Notification Service" "Gửi email, SMS, push notification" "Python, FastAPI"

 catalogDb = container "Catalog Database" "Lưu trữ sản phẩm, categories, inventory" "PostgreSQL" "Database"
 orderDb = container "Order Database" "Lưu trữ đơn hàng, customers, payments" "PostgreSQL" "Database"
 messageQueue = container "Message Queue" "Async messaging giữa services" "RabbitMQ" "Queue"
 cache = container "Cache" "Caching sản phẩm hot, user sessions" "Redis" "Database"
 searchEngine = container "Search Engine" "Full-text search sản phẩm" "Elasticsearch" "Database"
 }

 paymentGateway = softwareSystem "Payment Gateway" "Stripe, VNPay" { tags "External" }
 shippingProvider = softwareSystem "Shipping Provider" "GHN, GHTK" { tags "External" }
 emailService = softwareSystem "Email Service" "SendGrid" { tags "External" }

 # Person -> Container
 customer -> webApp "Duyệt sản phẩm, đặt hàng" "HTTPS"
 admin -> webApp "Quản lý sản phẩm, đơn hàng" "HTTPS"

 # Web -> API Gateway
 webApp -> apiGateway "API calls" "HTTPS/JSON"
 mobileBff -> apiGateway "API calls" "HTTPS/JSON"

 # API Gateway -> Services
 apiGateway -> catalogService "Route catalog requests" "HTTP/JSON"
 apiGateway -> orderService "Route order requests" "HTTP/JSON"

 # Service -> Service (via queue)
 orderService -> messageQueue "Publish OrderCreated event" "AMQP"
 paymentService -> messageQueue "Subscribe OrderCreated, Publish PaymentCompleted" "AMQP"
 notificationService -> messageQueue "Subscribe PaymentCompleted" "AMQP"

 # Service -> Database
 catalogService -> catalogDb "Reads/Writes products" "JDBC"
 catalogService -> cache "Cache product data" "Redis Protocol"
 catalogService -> searchEngine "Index & search products" "HTTP/REST"
 orderService -> orderDb "Reads/Writes orders" "JDBC"

 # Service -> External
 paymentService -> paymentGateway "Process payments" "HTTPS/REST"
 orderService -> shippingProvider "Create shipping orders" "HTTPS/REST"
 notificationService -> emailService "Send transactional emails" "SMTP/API"
 }

 views {
 container ecommerce "Containers" "Container diagram cho E-Commerce Platform" {
 include *
 autoLayout
 }

 styles {
 element "WebBrowser" {
 shape WebBrowser
 }
 element "Database" {
 shape Cylinder
 }
 element "Queue" {
 shape Pipe
 }
 element "External" {
 background #999999
 color #ffffff
 }
 }
 }
}
```

#### Bước 3: Viết PlantUML tương đương

```plantuml
@startuml C4_Container
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

LAYOUT_WITH_LEGEND()

title Container Diagram — E-Commerce Platform

Person(customer, "Customer", "Khách hàng")
Person(admin, "Admin", "Quản trị viên")

System_Boundary(ecommerce, "E-Commerce Platform") {
 Container(webApp, "Web Application", "React, TypeScript", "SPA cho khách hàng và admin")
 Container(mobileBff, "Mobile BFF", "Node.js, Express", "Backend-for-Frontend cho mobile")
 Container(apiGateway, "API Gateway", "Kong", "Routing, rate limiting, auth")

 Container(catalogSvc, "Catalog Service", "Node.js", "Quản lý sản phẩm, danh mục")
 Container(orderSvc, "Order Service", "Java Spring Boot", "Xử lý đặt hàng")
 Container(paymentSvc, "Payment Service", "Go", "Tích hợp thanh toán")
 Container(notifSvc, "Notification Service", "Python FastAPI", "Gửi email, SMS, push")

 ContainerDb(catalogDb, "Catalog DB", "PostgreSQL", "Sản phẩm, categories")
 ContainerDb(orderDb, "Order DB", "PostgreSQL", "Đơn hàng, customers")
 ContainerQueue(queue, "Message Queue", "RabbitMQ", "Async messaging")
 ContainerDb(cache, "Cache", "Redis", "Caching layer")
 ContainerDb(search, "Search Engine", "Elasticsearch", "Full-text search")
}

System_Ext(stripe, "Payment Gateway", "Stripe, VNPay")
System_Ext(shipping, "Shipping Provider", "GHN, GHTK")
System_Ext(email, "Email Service", "SendGrid")

Rel(customer, webApp, "Duyệt SP, đặt hàng", "HTTPS")
Rel(admin, webApp, "Quản lý SP, đơn hàng", "HTTPS")
Rel(webApp, apiGateway, "API calls", "HTTPS/JSON")
Rel(mobileBff, apiGateway, "API calls", "HTTPS/JSON")

Rel(apiGateway, catalogSvc, "Route", "HTTP/JSON")
Rel(apiGateway, orderSvc, "Route", "HTTP/JSON")

Rel(catalogSvc, catalogDb, "Reads/Writes", "JDBC")
Rel(catalogSvc, cache, "Cache", "Redis Protocol")
Rel(catalogSvc, search, "Index & Search", "REST")
Rel(orderSvc, orderDb, "Reads/Writes", "JDBC")
Rel(orderSvc, queue, "Publish events", "AMQP")
Rel(paymentSvc, queue, "Subscribe events", "AMQP")
Rel(notifSvc, queue, "Subscribe events", "AMQP")

Rel(paymentSvc, stripe, "Process payments", "REST")
Rel(orderSvc, shipping, "Create shipments", "REST")
Rel(notifSvc, email, "Send emails", "SMTP")

@enduml
```

#### Checklist Lab 2

- [ ] Xác định ít nhất 6 containers với technology choices
- [ ] Phân biệt rõ ràng giữa web app, service, database, queue
- [ ] Mỗi relationship có description + technology/protocol
- [ ] External systems được hiển thị bên ngoài System Boundary
- [ ] File DSL hoặc PlantUML render được diagram

---

### Lab 3: Component Diagram (30 phút)

**Mục tiêu**: Zoom vào **Order Service** container — thể hiện cấu trúc bên trong.

**Yêu cầu**:
- Xác định các components trong Order Service
- Vẽ relationships giữa components và với containers bên ngoài
- Thể hiện technology/framework cho mỗi component

#### Bước 1: Xác định components

| Component | Technology | Responsibility |
|-----------|-----------|----------------|
| Order Controller | Spring MVC RestController | Nhận HTTP requests, trả responses |
| Order Service | Spring Service | Business logic xử lý đơn hàng |
| Order Validator | Java Bean Validation | Validate dữ liệu đơn hàng |
| Pricing Calculator | Java | Tính giá, áp dụng voucher, tính phí shipping |
| Order Repository | Spring Data JPA | CRUD operations cho Order entity |
| Inventory Client | Spring WebClient | Gọi Catalog Service để check tồn kho |
| Event Publisher | Spring AMQP | Publish domain events lên RabbitMQ |
| Order Mapper | MapStruct | Chuyển đổi giữa Entity DTO Domain |

#### Bước 2: Viết Structurizr DSL

```dsl
workspace "E-Commerce Platform" "Component Diagram — Order Service" {

 model {
 ecommerce = softwareSystem "E-Commerce Platform" {
 apiGateway = container "API Gateway" "Kong"

 orderService = container "Order Service" "Java, Spring Boot" {
 orderController = component "Order Controller" "Nhận HTTP requests từ API Gateway, trả JSON responses" "Spring MVC RestController"
 orderSvc = component "Order Service" "Business logic: tạo đơn, cập nhật trạng thái, hủy đơn" "Spring Service"
 orderValidator = component "Order Validator" "Validate dữ liệu đơn hàng: items, address, payment method" "Bean Validation"
 pricingCalculator = component "Pricing Calculator" "Tính tổng giá, áp dụng voucher, phí vận chuyển" "Java"
 orderRepository = component "Order Repository" "CRUD operations cho Order, OrderItem entities" "Spring Data JPA"
 inventoryClient = component "Inventory Client" "Gọi Catalog Service kiểm tra tồn kho" "Spring WebClient"
 eventPublisher = component "Event Publisher" "Publish OrderCreated, OrderCancelled events" "Spring AMQP"
 orderMapper = component "Order Mapper" "Chuyển đổi Entity DTO Domain Object" "MapStruct"
 }

 catalogService = container "Catalog Service" "Node.js"
 orderDb = container "Order Database" "PostgreSQL" "" "Database"
 messageQueue = container "Message Queue" "RabbitMQ" "" "Queue"
 }

 # API Gateway -> Controller
 apiGateway -> orderController "Routes order requests" "HTTP/JSON"

 # Controller -> Service
 orderController -> orderSvc "Delegates business logic"
 orderController -> orderMapper "Maps DTO Domain"

 # Service -> Components
 orderSvc -> orderValidator "Validates order data"
 orderSvc -> pricingCalculator "Calculates pricing"
 orderSvc -> orderRepository "Persists orders"
 orderSvc -> inventoryClient "Checks inventory"
 orderSvc -> eventPublisher "Publishes domain events"

 # Components -> External Containers
 orderRepository -> orderDb "Reads/Writes" "JDBC/JPA"
 inventoryClient -> catalogService "GET /api/inventory/{sku}" "HTTP/JSON"
 eventPublisher -> messageQueue "Publish events" "AMQP"
 }

 views {
 component orderService "OrderServiceComponents" "Component diagram cho Order Service" {
 include *
 autoLayout
 }
 }
}
```

#### Bước 3: Viết PlantUML tương đương

```plantuml
@startuml C4_Component
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Component.puml

LAYOUT_WITH_LEGEND()

title Component Diagram — Order Service

Container(apiGateway, "API Gateway", "Kong", "Routing requests")

Container_Boundary(orderService, "Order Service [Java, Spring Boot]") {
 Component(controller, "Order Controller", "Spring MVC", "Nhận HTTP requests, trả JSON responses")
 Component(service, "Order Service", "Spring Service", "Business logic: tạo đơn, cập nhật trạng thái")
 Component(validator, "Order Validator", "Bean Validation", "Validate dữ liệu đơn hàng")
 Component(pricing, "Pricing Calculator", "Java", "Tính giá, voucher, phí ship")
 Component(repository, "Order Repository", "Spring Data JPA", "CRUD cho Order entities")
 Component(inventoryClient, "Inventory Client", "WebClient", "Gọi Catalog Service check tồn kho")
 Component(publisher, "Event Publisher", "Spring AMQP", "Publish domain events")
 Component(mapper, "Order Mapper", "MapStruct", "Entity DTO Domain")
}

ContainerDb(db, "Order Database", "PostgreSQL", "Đơn hàng, customers")
ContainerQueue(queue, "Message Queue", "RabbitMQ", "Async messaging")
Container(catalogSvc, "Catalog Service", "Node.js", "Quản lý sản phẩm")

Rel(apiGateway, controller, "Routes requests", "HTTP/JSON")
Rel(controller, service, "Delegates")
Rel(controller, mapper, "Maps DTO")
Rel(service, validator, "Validates")
Rel(service, pricing, "Calculates price")
Rel(service, repository, "Persists")
Rel(service, inventoryClient, "Checks stock")
Rel(service, publisher, "Publishes events")
Rel(repository, db, "Reads/Writes", "JDBC")
Rel(inventoryClient, catalogSvc, "GET /inventory/{sku}", "HTTP")
Rel(publisher, queue, "Publish", "AMQP")

@enduml
```

#### Checklist Lab 3

- [ ] Xác định ít nhất 5 components trong Order Service
- [ ] Mỗi component có tên, description, technology rõ ràng
- [ ] Relationships thể hiện hướng phụ thuộc đúng (dependency direction)
- [ ] Connections ra containers bên ngoài (DB, Queue, other services) được hiển thị
- [ ] Diagram không quá phức tạp (< 15 elements)

---

### Lab 4: Deployment Diagram (25 phút)

**Mục tiêu**: Map containers lên infrastructure — cho thấy hệ thống được deploy ở đâu và như thế nào.

**Yêu cầu**:
- Định nghĩa deployment nodes (cloud, servers, containers)
- Map mỗi container vào node tương ứng
- Thể hiện network topology giữa các nodes

#### Bước 1: Thiết kế infrastructure

```
Production Environment:
├── AWS Cloud
│ ├── CloudFront (CDN)
│ │ └── Web Application (React — S3 Static Hosting)
│ ├── ECS Cluster (Fargate)
│ │ ├── API Gateway (Kong)
│ │ ├── Catalog Service (Node.js)
│ │ ├── Order Service (Java Spring Boot)
│ │ ├── Payment Service (Go)
│ │ └── Notification Service (Python)
│ ├── RDS
│ │ ├── Catalog DB (PostgreSQL)
│ │ └── Order DB (PostgreSQL)
│ ├── ElastiCache (Redis)
│ ├── Amazon MQ (RabbitMQ)
│ └── OpenSearch (Elasticsearch)
└── External
 ├── Stripe
 ├── SendGrid
 └── GHN API
```

#### Bước 2: Viết Structurizr DSL

```dsl
workspace "E-Commerce Platform" "Deployment Diagram" {

 model {
 ecommerce = softwareSystem "E-Commerce Platform" {
 webApp = container "Web Application" "React" "" "WebBrowser"
 apiGateway = container "API Gateway" "Kong"
 catalogService = container "Catalog Service" "Node.js"
 orderService = container "Order Service" "Java Spring Boot"
 paymentService = container "Payment Service" "Go"
 notificationService = container "Notification Service" "Python"
 catalogDb = container "Catalog DB" "PostgreSQL" "" "Database"
 orderDb = container "Order DB" "PostgreSQL" "" "Database"
 cache = container "Cache" "Redis" "" "Database"
 messageQueue = container "Message Queue" "RabbitMQ" "" "Queue"
 searchEngine = container "Search Engine" "Elasticsearch" "" "Database"
 }

 production = deploymentEnvironment "Production" {
 deploymentNode "AWS Cloud" "Amazon Web Services" "us-east-1" {
 deploymentNode "CloudFront" "CDN" "AWS CloudFront" {
 deploymentNode "S3 Bucket" "Static Hosting" "AWS S3" {
 containerInstance webApp
 }
 }

 deploymentNode "ECS Cluster" "Container Orchestration" "AWS Fargate" {
 deploymentNode "API Gateway Task" "1 instance" "Fargate Task" {
 containerInstance apiGateway
 }
 deploymentNode "Catalog Task" "2 instances" "Fargate Task" {
 containerInstance catalogService
 }
 deploymentNode "Order Task" "2 instances" "Fargate Task" {
 containerInstance orderService
 }
 deploymentNode "Payment Task" "2 instances" "Fargate Task" {
 containerInstance paymentService
 }
 deploymentNode "Notification Task" "1 instance" "Fargate Task" {
 containerInstance notificationService
 }
 }

 deploymentNode "Amazon RDS" "Managed Database" "Multi-AZ" {
 deploymentNode "Catalog DB Instance" "db.r5.large" "PostgreSQL 15" {
 containerInstance catalogDb
 }
 deploymentNode "Order DB Instance" "db.r5.large" "PostgreSQL 15" {
 containerInstance orderDb
 }
 }

 deploymentNode "ElastiCache" "Managed Cache" "Redis 7" {
 containerInstance cache
 }

 deploymentNode "Amazon MQ" "Managed Message Broker" "RabbitMQ" {
 containerInstance messageQueue
 }

 deploymentNode "OpenSearch" "Managed Search" "OpenSearch 2.x" {
 containerInstance searchEngine
 }
 }
 }
 }

 views {
 deployment ecommerce "Production" "DeploymentDiagram" "Deployment diagram cho Production environment" {
 include *
 autoLayout
 }
 }
}
```

#### Bước 3: Viết PlantUML tương đương

```plantuml
@startuml C4_Deployment
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Deployment.puml

LAYOUT_WITH_LEGEND()

title Deployment Diagram — E-Commerce Platform (Production)

Deployment_Node(aws, "AWS Cloud", "us-east-1") {
 Deployment_Node(cdn, "CloudFront", "CDN") {
 Deployment_Node(s3, "S3 Bucket", "Static Hosting") {
 Container(webApp, "Web Application", "React", "SPA")
 }
 }

 Deployment_Node(ecs, "ECS Cluster", "AWS Fargate") {
 Deployment_Node(apiTask, "API Gateway Task", "1 instance") {
 Container(apiGw, "API Gateway", "Kong", "Routing")
 }
 Deployment_Node(catTask, "Catalog Task", "2 instances") {
 Container(catSvc, "Catalog Service", "Node.js", "Products")
 }
 Deployment_Node(ordTask, "Order Task", "2 instances") {
 Container(ordSvc, "Order Service", "Spring Boot", "Orders")
 }
 Deployment_Node(payTask, "Payment Task", "2 instances") {
 Container(paySvc, "Payment Service", "Go", "Payments")
 }
 Deployment_Node(notifTask, "Notification Task", "1 instance") {
 Container(notifSvc, "Notification Svc", "Python", "Notifications")
 }
 }

 Deployment_Node(rds, "Amazon RDS", "Multi-AZ") {
 ContainerDb(catDb, "Catalog DB", "PostgreSQL 15", "Products, categories")
 ContainerDb(ordDb, "Order DB", "PostgreSQL 15", "Orders, payments")
 }

 Deployment_Node(elasticache, "ElastiCache", "Redis 7") {
 ContainerDb(redis, "Cache", "Redis", "Sessions, products cache")
 }

 Deployment_Node(mq, "Amazon MQ", "RabbitMQ") {
 ContainerQueue(queue, "Message Queue", "RabbitMQ", "Async events")
 }

 Deployment_Node(opensearch, "OpenSearch", "2.x") {
 ContainerDb(search, "Search Engine", "OpenSearch", "Product search")
 }
}

Rel(webApp, apiGw, "API calls", "HTTPS")
Rel(apiGw, catSvc, "Route", "HTTP")
Rel(apiGw, ordSvc, "Route", "HTTP")
Rel(catSvc, catDb, "R/W", "JDBC")
Rel(catSvc, redis, "Cache", "Redis")
Rel(catSvc, search, "Search", "REST")
Rel(ordSvc, ordDb, "R/W", "JDBC")
Rel(ordSvc, queue, "Publish", "AMQP")
Rel(paySvc, queue, "Subscribe", "AMQP")
Rel(notifSvc, queue, "Subscribe", "AMQP")

@enduml
```

#### Checklist Lab 4

- [ ] Tất cả containers được map vào deployment nodes
- [ ] Deployment nodes thể hiện rõ cloud provider, service type
- [ ] Có thông tin về instances/replicas cho scalable services
- [ ] Network relationships giữa containers vẫn được hiển thị
- [ ] Diagram phân biệt rõ managed services vs custom code

---

## 6. Self-Assessment (30 câu hỏi)

### Band 1 — Cơ bản (Câu 1–10)

**Câu 1**: C4 Model là gì? Ai tạo ra?

> **Đáp án**: C4 Model là phương pháp trực quan hóa kiến trúc phần mềm ở 4 mức trừu tượng (Context, Containers, Components, Code). Được tạo bởi **Simon Brown**, tác giả cuốn *"Software Architecture for Developers"*. Triết lý chính: "maps, not art" — diagram để truyền tải thông tin, không phải nghệ thuật.

**Câu 2**: C4 viết tắt của gì? Liệt kê 4 levels.

> **Đáp án**: C4 = **Context, Containers, Components, Code**. (1) System Context — toàn cảnh hệ thống, (2) Container — các deployment units, (3) Component — cấu trúc bên trong container, (4) Code — mức class/interface (optional).

**Câu 3**: System Context Diagram hiển thị những gì?

> **Đáp án**: System Context Diagram (Level 1) hiển thị: hệ thống phần mềm chính ở trung tâm, các **users/actors** tương tác với hệ thống, và các **external systems** (hệ thống bên ngoài) có quan hệ. Không hiển thị chi tiết công nghệ bên trong hệ thống.

**Câu 4**: Container Diagram hiển thị những gì?

> **Đáp án**: Container Diagram (Level 2) zoom vào bên trong hệ thống, hiển thị các **deployment units** (containers): web applications, APIs, databases, message queues, file systems. Mỗi container có tên, technology, và description. Relationships cho thấy cách containers giao tiếp với nhau.

**Câu 5**: Component Diagram hiển thị những gì?

> **Đáp án**: Component Diagram (Level 3) zoom vào bên trong một **container cụ thể**, hiển thị các **components/modules/services** bên trong. Ví dụ: controllers, services, repositories, publishers. Mỗi component có tên, responsibility, technology.

**Câu 6**: Code Diagram (Level 4) hiển thị gì? Khi nào nên dùng?

> **Đáp án**: Code Diagram hiển thị chi tiết ở mức implementation: classes, interfaces, enums, relationships (tương tự UML Class Diagram). **Hiếm khi nên vẽ thủ công** — nên auto-generate từ IDE/tooling. Chỉ vẽ khi cần giải thích core domain logic hoặc complex algorithms.

**Câu 7**: "Container" trong C4 khác "Docker container" thế nào?

> **Đáp án**: Trong C4, "Container" là một **deployment/runtime unit** — bất cứ thứ gì cần chạy riêng biệt để hệ thống hoạt động (web app, API server, database, message queue). Docker container là một công nghệ cụ thể để đóng gói/deploy ứng dụng. Một C4 container **có thể** chạy trong Docker container, nhưng không bắt buộc.

**Câu 8**: Person element dùng để biểu diễn gì?

> **Đáp án**: Person element biểu diễn **user hoặc actor** — con người tương tác với hệ thống phần mềm. Ví dụ: Customer, Admin, Operator. Person có tên và description ngắn giải thích vai trò. Trong diagram, thường vẽ dạng hình người (stick figure).

**Câu 9**: Relationship trong C4 gồm những thông tin gì?

> **Đáp án**: Relationship (mũi tên) kết nối hai elements và nên chứa: (1) **Description** — mô tả mục đích (ví dụ: "Gửi email xác nhận đơn hàng"), (2) **Technology** — protocol/technology sử dụng (ví dụ: "HTTPS/REST", "AMQP", "JDBC"). Mũi tên thể hiện hướng phụ thuộc hoặc hướng data flow.

**Câu 10**: Tại sao C4 Model sử dụng nhiều levels thay vì một diagram duy nhất?

> **Đáp án**: Vì mỗi audience cần mức chi tiết khác nhau: (1) Business stakeholders cần Level 1 (big picture), (2) Technical architects cần Level 2 (technology choices), (3) Developers cần Level 3 (internal structure). Một diagram duy nhất sẽ quá phức tạp hoặc quá đơn giản cho tất cả đối tượng. C4 giống Google Maps — zoom in/out tùy nhu cầu.

### Band 2 — Trung bình (Câu 11–20)

**Câu 11**: Level nào phù hợp nhất cho business stakeholders?

> **Đáp án**: **Level 1 — System Context Diagram** là phù hợp nhất vì nó cho thấy big picture: hệ thống làm gì, ai sử dụng, và tương tác với hệ thống bên ngoài nào. Không cần kiến thức kỹ thuật để hiểu. Level 2 (Container) cũng hữu ích cho business stakeholders có kiến thức kỹ thuật cơ bản.

**Câu 12**: Level nào phù hợp nhất cho developers?

> **Đáp án**: **Level 2 (Container)** và **Level 3 (Component)** phù hợp nhất. Level 2 giúp developers hiểu tổng thể các services và databases. Level 3 giúp hiểu cấu trúc bên trong container mà họ đang làm việc. Level 4 (Code) thường không cần vì developers đã đọc code trực tiếp.

**Câu 13**: Khi nào KHÔNG nên vẽ Code Diagram (Level 4)?

> **Đáp án**: Không nên vẽ Level 4 khi: (1) Code thay đổi thường xuyên → diagram sẽ nhanh outdated, (2) Đã có UML auto-generated từ IDE, (3) Codebase đơn giản, developers đọc code trực tiếp nhanh hơn. **Nên dùng** khi: complex domain model, thuật toán phức tạp, hoặc onboarding team mới vào core module.

**Câu 14**: Supplementary diagrams trong C4 bao gồm những gì?

> **Đáp án**: (1) **System Landscape Diagram** — toàn cảnh nhiều hệ thống trong enterprise, (2) **Deployment Diagram** — map containers lên infrastructure (servers, cloud, Kubernetes), (3) **Dynamic Diagram** — thể hiện sequence/collaboration cho một use case cụ thể (tương tự sequence diagram nhưng dùng C4 elements).

**Câu 15**: Dynamic Diagram dùng khi nào? Khác gì sequence diagram?

> **Đáp án**: Dynamic Diagram dùng khi cần mô tả **runtime behavior** cho một use case cụ thể (ví dụ: "flow đặt hàng", "flow thanh toán"). Khác UML Sequence Diagram ở chỗ: dùng cùng notation elements của C4 (Person, Container, Component) thay vì objects, và đánh số thứ tự các interactions. Đơn giản hơn sequence diagram.

**Câu 16**: Deployment Diagram trong C4 thể hiện gì?

> **Đáp án**: Deployment Diagram map các containers lên **deployment nodes** — thể hiện hệ thống chạy ở đâu: cloud provider nào (AWS, Azure), service type nào (ECS, RDS, ElastiCache), bao nhiêu instances, network topology. Giúp DevOps/Ops team hiểu infrastructure và giúp developers hiểu production environment.

**Câu 17**: Structurizr là gì? Có những phiên bản nào?

> **Đáp án**: Structurizr là công cụ tạo C4 diagrams do Simon Brown phát triển. Các phiên bản: (1) **Structurizr Lite** — free, chạy local bằng Docker, (2) **Structurizr Cloud** — SaaS hosted, (3) **Structurizr On-Premises** — self-hosted. Tất cả sử dụng **Structurizr DSL** — domain-specific language để mô tả architecture model dạng text.

**Câu 18**: C4-PlantUML là gì? Cách sử dụng?

> **Đáp án**: C4-PlantUML là thư viện mở rộng cho PlantUML, cung cấp macros để vẽ C4 diagrams: `Person()`, `System()`, `Container()`, `Component()`, `Rel()`, v.v. Cách dùng: thêm `!include` URL của thư viện vào đầu file `.puml`, sau đó sử dụng các macros. Ưu điểm: free, open-source, tích hợp dễ với CI/CD.

**Câu 19**: Làm sao version control C4 diagrams hiệu quả?

> **Đáp án**: Sử dụng **"Diagram as Code"** approach: (1) Viết diagrams bằng Structurizr DSL hoặc PlantUML (text files), (2) Commit vào Git cùng source code, (3) Review changes qua pull requests (diff text files dễ hơn diff images), (4) CI/CD pipeline auto-generate images từ DSL/PlantUML, (5) Publish lên wiki/documentation site tự động.

**Câu 20**: So sánh C4 Model vs UML — ưu nhược điểm?

> **Đáp án**: **C4**: ưu — đơn giản, dễ học, focus abstraction levels, phù hợp nhiều audiences, "just enough" detail; nhược — không có chuẩn chính thức (informal), ít diagram types. **UML**: ưu — chuẩn quốc tế (ISO/IEC 19505), 14 diagram types phong phú, tool support mạnh; nhược — phức tạp, learning curve cao, nhiều team không dùng đầy đủ. C4 phù hợp cho architectural overview, UML phù hợp cho detailed design.

### Band 3 — Nâng cao (Câu 21–30)

**Câu 21**: "Diagram as Code" approach là gì? Ưu điểm so với drag-and-drop?

> **Đáp án**: "Diagram as Code" là viết diagrams dưới dạng text (DSL) thay vì kéo thả trên GUI. Ưu điểm: (1) **Version control** — diff, merge, review qua Git, (2) **Automation** — CI/CD tự động generate images, (3) **Consistency** — cùng model sinh nhiều views, (4) **Reproducible** — build lại diagram bất cứ lúc nào, (5) **DRY** — define model một lần, tạo nhiều diagrams. Nhược: learning curve ban đầu, khó fine-tune layout.

**Câu 22**: Áp dụng C4 cho microservices architecture như thế nào?

> **Đáp án**: (1) **Level 1**: mỗi microservice system hoặc bounded context là một Software System, (2) **Level 2**: mỗi microservice là một Container, kèm databases riêng (database-per-service), message broker (Kafka/RabbitMQ) là shared container, (3) **Level 3**: zoom vào một microservice cụ thể, hiển thị internal components, (4) Dùng **System Landscape Diagram** để overview toàn bộ microservices ecosystem. Chú ý: vẽ communication patterns (sync REST vs async events).

**Câu 23**: Áp dụng C4 cho event-driven architecture như thế nào?

> **Đáp án**: (1) Message broker (Kafka, RabbitMQ) là một Container ở Level 2, (2) Sử dụng **Dynamic Diagrams** để thể hiện event flows: service A publish event → broker → service B subscribe, (3) Relationship labels ghi rõ event names: "Publish OrderCreated event" / "AMQP", (4) Có thể dùng nhiều Dynamic Diagrams cho các scenarios khác nhau (happy path, error handling, compensation/saga).

**Câu 24**: Làm sao giữ C4 diagrams luôn up-to-date?

> **Đáp án**: (1) **Diagram as Code** — DSL files nằm cùng repo với source code, (2) **CI/CD pipeline** — auto-generate diagrams khi merge PR, (3) **Architecture fitness functions** — automated tests kiểm tra diagram khớp với code, (4) **Review process** — thêm "update C4 diagrams" vào Definition of Done, (5) **Living documentation** — tools như Structurizr có thể extract model từ code annotations.

**Câu 25**: Tích hợp C4 vào CI/CD pipeline như thế nào?

> **Đáp án**: Pipeline stages: (1) **Lint** — validate DSL syntax (`structurizr-cli validate`), (2) **Generate** — export sang PlantUML/SVG/PNG (`structurizr-cli export`), (3) **Publish** — deploy images lên documentation site (Confluence, GitHub Pages, wiki), (4) **Notify** — gửi notification khi diagrams thay đổi. Ví dụ GitHub Actions:
> ```yaml
> - name: Generate C4 diagrams
> run: |
> docker run --rm -v $PWD:/usr/local/structurizr \
> structurizr/cli export -w workspace.dsl -f plantuml
> ```

**Câu 26**: C4 đóng vai trò gì trong system documentation?

> **Đáp án**: C4 là **backbone** của system documentation: (1) Level 1 nằm trong **architecture overview** section, (2) Level 2 nằm trong **technical architecture** section, (3) Level 3 nằm trong **developer guide** cho từng service, (4) Deployment diagram nằm trong **operations/runbook**. C4 bổ sung cho (không thay thế) các tài liệu khác: ADRs, API specs, runbooks, onboarding guides.

**Câu 27**: C4 kết hợp với ADRs (Architecture Decision Records) như thế nào?

> **Đáp án**: (1) ADRs ghi lại **why** — tại sao chọn technology/approach, (2) C4 thể hiện **what** — kết quả của decisions đó trên diagrams. Ví dụ: ADR-005 quyết định dùng RabbitMQ cho async messaging → Container Diagram hiển thị RabbitMQ container. Liên kết: mỗi ADR tham chiếu đến diagram bị ảnh hưởng, mỗi container/component có thể link đến ADR liên quan.

**Câu 28**: Khi nào cần vẽ nhiều diagrams cho cùng một level?

> **Đáp án**: (1) **Level 2**: khi hệ thống có quá nhiều containers (>15) — chia theo domain/bounded context, (2) **Level 3**: vẽ Component Diagram riêng cho **từng container** quan trọng (không phải tất cả), (3) **Dynamic Diagram**: vẽ riêng cho từng use case/scenario, (4) **Deployment**: vẽ riêng cho từng environment (dev, staging, production). Rule of thumb: nếu diagram có > 20 elements, nên tách.

**Câu 29**: Best practices khi vẽ C4 diagrams?

> **Đáp án**: (1) **Mỗi diagram có title rõ ràng** và legend, (2) **Relationships có cả description và technology**, (3) **Consistent naming** — cùng tên cho cùng element across levels, (4) **External systems luôn ở ngoài boundary**, (5) **Không trộn levels** — không vẽ components lẫn containers trên cùng diagram, (6) **Keep it simple** — < 20 elements per diagram, (7) **Start from Level 1** — luôn vẽ Context trước, (8) **Review với team** — diagram phải được mọi người hiểu.

**Câu 30**: C4 anti-patterns — những lỗi thường gặp?

> **Đáp án**: (1) **"Big ball of mud" diagram** — quá nhiều elements không tổ chức, (2) **Missing relationships** — vẽ boxes nhưng không nối, (3) **Vague labels** — relationship chỉ ghi "Uses" thay vì mô tả cụ thể, (4) **Trộn abstraction levels** — vẽ cả containers lẫn classes trên cùng diagram, (5) **Outdated diagrams** — vẽ xong rồi không bao giờ cập nhật, (6) **Too many levels** — cố vẽ Level 4 cho tất cả mọi thứ, (7) **No audience** — không xác định ai sẽ đọc diagram.

---

## 7. Extend Labs (10 bài tập mở rộng)

### EL1: System Landscape Diagram cho Enterprise

```
Mục tiêu: Vẽ System Landscape cho một enterprise có 5+ hệ thống
- ERP System, CRM System, E-Commerce, HR System, BI Platform
- Thể hiện data flows giữa các systems
- Xác định integration points
Yêu cầu: Structurizr DSL, ít nhất 5 systems, 8 relationships
Độ khó: **
```

### EL2: Microservices E-Commerce mở rộng

```
Mục tiêu: Mở rộng Container Diagram thêm các services
- User Service, Cart Service, Review Service, Recommendation Service
- Service mesh (Istio), API Gateway pattern
- CQRS cho Order Service (command DB + query DB)
Yêu cầu: 15+ containers, event-driven communication
Độ khó: ****
```

### EL3: Dynamic Diagram — Order Flow

```
Mục tiêu: Vẽ Dynamic Diagram cho flow "Customer đặt hàng"
- Bước 1: Customer submit order trên Web App
- Bước 2: API Gateway route đến Order Service
- Bước 3: Order Service validate và check inventory
- Bước 4: Order Service publish OrderCreated event
- Bước 5: Payment Service process payment
- Bước 6: Notification Service gửi email xác nhận
Yêu cầu: Numbered steps, both happy path và error handling
Độ khó: ***
```

### EL4: Multi-environment Deployment

```
Mục tiêu: Vẽ Deployment Diagrams cho 3 environments
- Development: Docker Compose trên local
- Staging: Kubernetes cluster (EKS) với scaled-down resources
- Production: Full AWS deployment với HA, multi-AZ
Yêu cầu: 3 separate diagrams, highlight differences
Độ khó: ***
```

### EL5: Diagram as Code Pipeline

```
Mục tiêu: Tạo GitHub Actions pipeline tự động
- Validate Structurizr DSL syntax
- Export sang PNG/SVG
- Publish lên GitHub Pages
- Comment PR với updated diagrams
Yêu cầu: Working .github/workflows/c4-diagrams.yml
Độ khó: ****
```

### EL6: Living Documentation từ Code

```
Mục tiêu: Auto-generate C4 diagrams từ source code
- Sử dụng annotations (@Component, @Service, @Repository) để extract model
- Parse Spring Boot project structure → Component Diagram
- Sync với Structurizr workspace
Yêu cầu: Script hoặc tool tạo DSL từ Java/Spring code
Độ khó: *****
```

### EL7: Security Overlay trên C4

```
Mục tiêu: Thêm security perspective lên C4 diagrams
- Trust boundaries (internal network, DMZ, external)
- Data classification labels (Public, Internal, Confidential)
- Authentication/authorization flows
- Kết hợp STRIDE threat model với C4 containers
Yêu cầu: Annotated Container Diagram + threat analysis table
Độ khó: ****
```

### EL8: Migration Planning — As-Is vs To-Be

```
Mục tiêu: Dùng C4 cho migration planning
- As-Is: Monolithic application (1 container, 1 database)
- To-Be: Microservices architecture (nhiều containers)
- Phase 1, 2, 3: Tách từng service dần dần
Yêu cầu: 4 diagrams (As-Is + 3 phases), migration notes
Độ khó: ****
```

### EL9: C4 cho Mobile Application

```
Mục tiêu: Vẽ C4 cho hệ thống mobile-first
- Mobile App (React Native) + Web App (React)
- Backend-for-Frontend (BFF) pattern cho mỗi client
- Push notification service, offline sync
Yêu cầu: Container Diagram thể hiện BFF pattern rõ ràng
Độ khó: ***
```

### EL10: Stakeholder Presentation Package

```
Mục tiêu: Tạo bộ tài liệu trình bày cho stakeholders
- Slide 1: System Landscape (CTO/CEO audience)
- Slide 2: System Context (Business audience)
- Slide 3: Container Diagram (Technical Lead audience)
- Slide 4: Component Diagram (Developer audience)
- Slide 5: Deployment Diagram (DevOps audience)
Yêu cầu: 5 diagrams, mỗi diagram có notes cho presenter
Độ khó: ***
```

---

## 8. Deliverables (Checklist nộp bài)

| # | Deliverable | Mô tả | Hoàn thành |
|---|-------------|--------|------------|
| 1 | System Context Diagram | Structurizr DSL + PlantUML cho E-Commerce Platform | [ ] |
| 2 | Container Diagram | Phân tách ≥ 8 containers với technology choices | [ ] |
| 3 | Component Diagram | Zoom vào Order Service, ≥ 5 components | [ ] |
| 4 | Deployment Diagram | Map containers lên AWS infrastructure | [ ] |
| 5 | Structurizr workspace file | File `workspace.dsl` hoàn chỉnh, chạy được trên Structurizr Lite | [ ] |
| 6 | Self-assessment | Trả lời ít nhất 20/30 câu hỏi | [ ] |
| 7 | Extend Lab | Hoàn thành ít nhất 1 Extend Lab | [ ] |

---

## 9. Lỗi Thường Gặp

| # | Lỗi | Mô tả | Cách sửa |
|---|------|--------|----------|
| 1 | Trộn abstraction levels | Vẽ cả containers lẫn classes trên cùng diagram | Mỗi diagram chỉ thuộc 1 level. Tách thành nhiều diagrams |
| 2 | Relationship không có description | Mũi tên chỉ nối nhưng không giải thích purpose | Thêm description ("Gửi email xác nhận") và technology ("SMTP") |
| 3 | Quá nhiều elements trên 1 diagram | Diagram > 20 elements, khó đọc | Tách theo domain/bounded context hoặc zoom vào level tiếp theo |
| 4 | Container ≠ Docker container | Nhầm lẫn khái niệm C4 Container với Docker | C4 Container = deployment unit (app, DB, queue). Docker chỉ là 1 cách deploy |
| 5 | Thiếu external systems | Context Diagram chỉ có hệ thống chính, thiếu dependencies | Liệt kê tất cả systems bên ngoài mà hệ thống tương tác |
| 6 | Diagram không có title/legend | Người đọc không biết đang xem diagram gì | Luôn thêm title rõ ràng, legend giải thích notation |
| 7 | Outdated diagrams | Vẽ xong rồi không cập nhật khi code thay đổi | Dùng Diagram as Code, tích hợp CI/CD, thêm vào DoD |
| 8 | Inconsistent naming | Cùng 1 container nhưng tên khác nhau ở Level 2 và Level 3 | Đặt tên nhất quán across all levels, dùng Structurizr (shared model) |
| 9 | Vẽ Level 4 cho mọi thứ | Tốn thời gian vẽ Code diagram rồi outdated ngay | Chỉ vẽ Level 4 cho core domain, hoặc auto-generate từ IDE |
| 10 | Không xác định audience | Vẽ diagram không biết ai sẽ đọc, level chi tiết không phù hợp | Xác định audience trước khi vẽ: business → L1, technical → L2/L3, ops → Deployment |

---

## 10. Rubric Chấm điểm (100 điểm)

| Tiêu chí | Điểm tối đa | Mô tả chi tiết |
|----------|-------------|-----------------|
| **System Context Diagram** | 20 | Đúng actors (5đ), đúng external systems (5đ), relationships có description + technology (5đ), có title + legend (5đ) |
| **Container Diagram** | 25 | Phân tách hợp lý ≥ 6 containers (8đ), technology choices phù hợp (5đ), relationships đúng protocol (5đ), phân biệt container types (DB, Queue, App) (4đ), System Boundary rõ ràng (3đ) |
| **Component Diagram** | 20 | Xác định ≥ 5 components (5đ), responsibility rõ ràng (5đ), dependency direction đúng (5đ), connections ra containers bên ngoài (5đ) |
| **Deployment Diagram** | 15 | Map đúng tất cả containers (5đ), deployment nodes có technology info (4đ), instances/scaling info (3đ), network topology hợp lý (3đ) |
| **Structurizr DSL** | 10 | File DSL valid syntax (4đ), chạy được trên Structurizr Lite (3đ), styles/themes phù hợp (3đ) |
| **Chất lượng tổng thể** | 10 | Consistent naming (3đ), không trộn levels (3đ), aesthetic và readability (2đ), đầy đủ deliverables (2đ) |
| **Tổng** | **100** | |

Thang điểm:

| Điểm | Xếp loại | Mô tả |
|------|----------|--------|
| 90–100 | Xuất sắc | Diagrams chính xác, đầy đủ, professional quality |
| 80–89 | Giỏi | Diagrams tốt, minor issues về naming hoặc relationships |
| 70–79 | Khá | Diagrams cơ bản đúng nhưng thiếu chi tiết hoặc có lỗi nhỏ |
| 60–69 | Trung bình | Có diagrams nhưng thiếu nhiều elements hoặc relationships |
| < 60 | Chưa đạt | Thiếu diagrams, sai concepts, hoặc không nộp đủ deliverables |

---

## Tài liệu Tham khảo

1. **C4 Model Official**: https://c4model.com/
2. **Structurizr**: https://structurizr.com/
3. **Structurizr DSL Reference**: https://docs.structurizr.com/dsl/language
4. **C4-PlantUML**: https://github.com/plantuml-stdlib/C4-PlantUML
5. **Simon Brown — "Software Architecture for Developers"**: https://leanpub.com/software-architecture-for-developers
6. **c4builder**: https://github.com/adrianvlupu/C4-Builder
7. **Mermaid C4 support**: https://mermaid.js.org/syntax/c4.html

---

## Tiếp theo

Chuyển đến: `lab-3.3-adr/` — Architecture Decision Records (ADRs)
