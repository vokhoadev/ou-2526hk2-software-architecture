# Đáp án / gợi ý — hợp nhất

## Phần II


Các đáp án dưới đây mang tính **gợi ý**; nhiều bài tập có nhiều cách tiếp cận đúng. Người đọc nên so sánh đáp án của mình với gợi ý, hiểu lý do, và bổ sung nếu cần.

---

## BT1. Phân tích kiến trúc phân tán

**1. Bốn thành phần phân tán:**
- **User Service:** quản lý tài khoản, đăng nhập.
- **Movie Service:** danh sách phim, suất chiếu, rạp.
- **Booking Service:** đặt vé, chọn ghế, xác nhận.
- **Payment Service:** xử lý thanh toán (tích hợp cổng thanh toán bên ngoài).
- *(Bổ sung)* **Notification Service:** gửi email/SMS xác nhận.

**2. Sơ đồ:** Client → API Gateway → {User Service, Movie Service, Booking Service}. Booking Service → Payment Service (đồng bộ REST). Booking Service → Notification Service (bất đồng bộ qua RabbitMQ).

**3. Giao thức:** Client ↔ Gateway: REST/HTTPS. Gateway ↔ Service: REST hoặc gRPC. Booking → Notification: message queue (bất đồng bộ — không cần chờ email gửi xong mới trả response cho user).

**4. SPOF:** API Gateway nếu chỉ có một instance → giải pháp: chạy nhiều instance sau Load Balancer. Database nếu dùng single instance → giải pháp: replication (primary-replica).

---

## BT2. CAP Theorem trong thực tế

**1. Hệ thống A (chuyển tiền):** Chọn **CP** — consistency bắt buộc (số dư phải chính xác); chấp nhận từ chối request khi partition xảy ra (trả lỗi thay vì trả số dư sai). **Hệ thống B (lượt like):** Chọn **AP** — availability ưu tiên (luôn hiển thị dù con số chưa cập nhật); chấp nhận eventual consistency.

**2. Database:** A → PostgreSQL (strong consistency, ACID). B → Cassandra hoặc DynamoDB (AP, eventual consistency, scale tốt).

**3. Mở rộng A lên nhiều region:** Dùng Google Spanner (globally consistent) hoặc CockroachDB — đánh đổi: latency tăng đáng kể vì mỗi write cần đồng thuận (*consensus*) xuyên region; chi phí hạ tầng cao.

---

## BT3. Lựa chọn middleware

**1. Middleware:**
- API công khai: **Kong** hoặc **AWS API Gateway** (REST, rate limiting, auth).
- Giao tiếp nội bộ: **gRPC** (hiệu năng cao, type-safe).
- Xử lý đơn hàng bất đồng bộ: **RabbitMQ** (message queue cho luồng đơn hàng → kho → email).

**2. 2PC hay Saga?** Chọn **Saga** vì: (a) microservices — mỗi service có DB riêng, 2PC cần coordinator tập trung; (b) 10.000 đơn/phút — 2PC quá chậm (nhiều round-trip); (c) Saga cho phép compensating transaction (hủy đơn nếu thanh toán thất bại).

**3. Sơ đồ:** Client → Kong (API Gateway) → Order Service →(gRPC)→ Payment Service; Order Service →(RabbitMQ event)→ Inventory Service, Notification Service.

---

## BT4. Thiết kế RESTful API

**1. Endpoints:**

| Method | URL | Mô tả |
|--------|-----|-------|
| GET | /api/v1/students | Danh sách sinh viên |
| GET | /api/v1/students/:id | Chi tiết một sinh viên |
| POST | /api/v1/students | Tạo sinh viên mới |
| PUT | /api/v1/students/:id | Cập nhật toàn bộ |
| PATCH | /api/v1/students/:id | Cập nhật một phần |
| DELETE | /api/v1/students/:id | Xóa sinh viên |
| GET | /api/v1/students/:id/courses | Danh sách môn học |

**2. Ví dụ tạo sinh viên:**

Request: `POST /api/v1/students`
```json
{
  "name": "Nguyen Van A",
  "email": "a@student.edu.vn",
  "major": "CNTT"
}
```

Response: `201 Created`
```json
{
  "id": 456,
  "name": "Nguyen Van A",
  "email": "a@student.edu.vn",
  "major": "CNTT",
  "createdAt": "2025-03-23T10:00:00Z"
}
```

**3. Mã HTTP:** 200 (thành công GET/PUT/PATCH), 201 (tạo thành công), 204 (xóa thành công), 400 (dữ liệu không hợp lệ), 404 (không tìm thấy), 409 (trùng lặp, ví dụ email đã tồn tại), 500 (lỗi server).

**4. Phân trang:** Query parameter `?page=1&size=20`. Response kèm metadata: `{ "data": [...], "page": 1, "size": 20, "total": 150 }`.

---

## BT5. So sánh web services

**1. Lựa chọn:**
- A (dashboard mobile): **GraphQL** — client query chính xác data cần, một request lấy user + orders + notifications, tiết kiệm bandwidth.
- B (nội bộ 20 service, < 10ms): **gRPC** — nhị phân, HTTP/2, hiệu năng cao nhất.
- C (ngân hàng, WS-Security): **SOAP** — hỗ trợ WS-Security, WS-Transaction chuẩn.

**2. Sơ đồ kết hợp:** Mobile App →(GraphQL)→ BFF Service →(gRPC)→ 20 Microservices. Banking Partner →(SOAP)→ Integration Service →(gRPC)→ Payment Service.

---

## BT6. Microservices vs. Monolith

**1. Bắt đầu monolith:** Với 5 developers, microservices quá overhead (vận hành, monitoring, CI/CD cho mỗi service). Monolith cho phép tập trung vào nghiệp vụ, nhanh ra MVP, dễ debug. Áp dụng YAGNI: chỉ chuyển phân tán khi có nhu cầu thực sự.

**2. Kế hoạch migration (sau 2 năm):**
- Bounded context: User, Course, Payment, Video, Quiz, Notification.
- Thứ tự tách: (1) Notification (ít coupling, bất đồng bộ); (2) Payment (ranh giới rõ, tích hợp bên ngoài); (3) Video Streaming (yêu cầu scale riêng); (4) Course + Quiz (sau cùng vì coupling cao).
- Chiến lược: **Strangler Fig** — tách dần từng module thành service, proxy request từ monolith sang service mới, dần loại bỏ code cũ.

**3. Ba thách thức:** (a) Data migration — tách database; giải pháp: dual write + migration script. (b) Distributed transaction — thanh toán + tạo khóa học; giải pháp: Saga. (c) Testing — integration test phức tạp; giải pháp: contract testing (Pact).

---

## BT7. Tám ngộ nhận Deutsch

**1. Vi phạm:** Ngộ nhận 1 (mạng đáng tin cậy — không xử lý lỗi mạng), Ngộ nhận 2 (latency bằng không — không có timeout), và ngộ nhận 7 (chi phí truyền tải bằng không — không tối ưu dữ liệu).

**2. Pseudocode:**
```
function callServiceB(request):
    maxRetries = 3
    for attempt in 1..maxRetries:
        try:
            response = httpCall(serviceB, request, timeout=2s)
            return response
        catch TimeoutError, NetworkError:
            if attempt == maxRetries:
                if circuitBreaker.isOpen():
                    return fallbackResponse()
                circuitBreaker.recordFailure()
                raise ServiceUnavailable
            wait(2^attempt * 100ms)  // exponential backoff
```

**3. Idempotency quan trọng khi retry:** nếu request "trừ 100đ" được gửi hai lần (lần 1 thành công nhưng client không nhận response), mà không có idempotency key, tiền bị trừ 200đ. Với idempotency key, server nhận diện request trùng và trả lại kết quả cũ.

---

## BT8. Case study giao đồ ăn

**1. Microservices:** User Service, Restaurant Service, Menu Service, Order Service, Payment Service, Driver Service, Tracking Service, Notification Service, Rating Service.

**2. Sơ đồ:** Client → API Gateway (Kong) → {User, Restaurant, Order}. Order →(gRPC)→ Payment. Order →(Kafka event)→ Driver, Notification. Tracking → WebSocket → Client.

**3. Saga "đặt đơn → thanh toán → phân công":**
- Step 1: Order Service tạo đơn (status: PENDING). Compensate: hủy đơn.
- Step 2: Payment Service trừ tiền. Compensate: hoàn tiền.
- Step 3: Driver Service phân công tài xế. Compensate: giải phóng tài xế, hoàn tiền.

**4. Giao thức:** (a) Client ↔ Gateway: REST/HTTPS. (b) Nội bộ: gRPC (đồng bộ) + Kafka (bất đồng bộ). (c) Real-time tracking: **WebSocket** (client ↔ Tracking Service).

**5. Monitoring:** Prometheus + Grafana (metrics), ELK Stack (centralized logging), Jaeger (distributed tracing với correlation ID xuyên suốt luồng đặt đơn).

---

*Nguồn đối chiếu: ../../baigiang/BaiGiang_Chuong2_KienTrucPhanTan.md, ../../drafts/PhanTichSau_Chuong2_KienTrucPhanTan.md.*

---

## Phần III


Đáp án gợi ý cho các bài tập tổng hợp và bài tập trong chương. Chỉ mang tính tham khảo; người làm bài có thể có lập luận khác hợp lý.

---

## Đáp án bài tập trong chương

### BT3.1. Sơ đồ kiến trúc phân tầng — Đặt vé xe buýt

**Presentation:** Web UI (React/Vue) — form tìm tuyến, chọn chuyến, chọn ghế, thanh toán.
**Business Logic:** RouteService (tìm tuyến, lịch chạy), BookingService (tạo vé, kiểm tra ghế trống, tính giá), PaymentService (xử lý thanh toán).
**Data Access:** RouteRepository, BookingRepository, PaymentRepository (ORM, CRUD).
**Database:** PostgreSQL.

### BT3.2. Tại sao Layered không phù hợp latency < 10ms

Layered monolithic mỗi request đi qua 4 lớp (Presentation → Business → Data Access → DB và ngược lại), mỗi bước chuyển lớp tốn overhead serialize/deserialize, gọi qua interface. Với hàng triệu request/s, bottleneck ở single process. Hướng thay thế: tách service (microservices) scale ngang; cache tại edge (Redis, CDN); CQRS tách đọc/ghi tối ưu riêng.

### BT3.3. `returnBook` — pseudocode Business

**Gợi ý:** `BorrowRecord record = borrowRepository.findById(id)`; nếu không tồn tại hoặc đã trả → ném lỗi nghiệp vụ. Lấy `dueDate`, `returnDate = today`; nếu `returnDate > dueDate` thì `lateFee = policy.calculate(dueDate, returnDate)` (toàn bộ trong Business). `record.setReturnedAt(...); record.setLateFee(lateFee); book.setAvailable(true);` gọi `borrowRepository.save`, `bookRepository.save` trong cùng transaction nếu có. Presentation chỉ gọi `returnBook(id)` và hiển thị kết quả trả về.

### BT3.4. Presentation khi chỉ có REST API

**Gợi ý:** Thêm hàng: **Presentation** = lớp **controller / API adapter** — map HTTP (status code, JSON request/response), validate format, auth middleware; **không** chứa SQL hay rule “có được trả sách không”. Có thể gọi là “inbound adapter” trong tư duy Hexagonal (Chương 11) nhưng vẫn đóng vai trò “lớp trên cùng” của kiến trúc phân tầng trong backend.

### BT4.1. Sơ đồ Master-Slave — Render video

**Master:** VideoRenderMaster — nhận video, chia thành segments theo thời gian (0-10s, 10-20s, ...), gửi segment cho Workers, tổng hợp file output.
**Slave:** RenderWorker 1, 2, ..., N — nhận segment, render (encode, effects), trả file segment đã render.
**Luồng:** Client upload video → Master chia → Workers render song song → Master merge segments → output video.

### BT4.2. Tránh SPOF cho Master

Giải pháp: (a) **Master standby** — Master chính + Master dự phòng (hot standby); khi chính chết, standby tiếp quản (leader election, ví dụ dùng ZooKeeper). (b) **Persistent task queue** — dùng message queue bền vững (Kafka/RabbitMQ); nếu Master restart, đọc lại task từ queue. Trade-off: phức tạp hơn, cần consensus protocol hoặc queue HA.

### BT5.1. Kiến trúc 3-tier — Đặt phòng khách sạn

**Client:** Web browser (React) — tìm phòng, chọn ngày, form đặt phòng.
**Application Server:** Spring Boot — RoomService (tìm phòng trống), BookingService (tạo booking, check-in/check-out), PaymentService.
**Database Server:** PostgreSQL — rooms, bookings, customers, payments.
**Luồng đặt phòng:** User tìm phòng → Client GET /rooms?date=... → App Server query DB → trả danh sách → User chọn → Client POST /bookings → App Server validate (phòng còn trống?), tạo booking, charge card → DB insert → response success.

### BT5.2. Chat real-time cần bổ sung gì

Request-response thuần (HTTP) không phù hợp vì server không thể chủ động push message cho client (phải client poll liên tục → tốn tài nguyên). Cần: **WebSocket** (kết nối hai chiều, server push message khi có tin nhắn mới); hoặc **Event-Driven** (message broker giữa các user); hoặc kết hợp P2P (WebRTC) cho video call.

### BT6.1. Sơ đồ Hybrid P2P — Chia sẻ tài liệu

**Index Server:** Lưu danh sách tài liệu và peer nào có tài liệu nào. Peer đăng ký file khi có.
**Peer:** Người dùng A, B, C (hoặc máy chủ đồng đẳng). Mỗi peer lưu file cục bộ.
**Luồng:** A muốn tài liệu "BaiGiang.pdf" → hỏi Index Server → Server trả: B có file → A kết nối trực tiếp B → B gửi file cho A.

### BT6.2. So sánh P2P vs Client-Server — Streaming video

| Tiêu chí | P2P | Client-Server |
|----------|-----|---------------|
| Bandwidth | Phân tán, tận dụng upload peer | Tập trung tại server, cần CDN |
| Chi phí server | Thấp (peer đóng góp) | Cao (server, CDN) |
| Kiểm soát chất lượng | Khó (phụ thuộc peer) | Dễ (server kiểm soát bitrate, DRM) |
| Bảo mật | Khó bảo vệ bản quyền | Dễ áp DRM, auth |

### BT7.1. Hệ thống đặt hàng qua Broker

**Luồng thành công:** Client → API Gateway → Order Service tạo đơn → publish OrderCreated → Payment Service charge → publish PaymentSucceeded → Email confirm.
**Luồng fail:** ... → Payment Service charge → publish PaymentFailed → Order Service cập nhật Cancelled.

### BT7.2. Chọn Broker cho order → email + kho + analytics

Chọn **Kafka** vì: (1) Có 3 consumer cần nhận cùng event (fan-out/pub-sub — Kafka native); (2) Analytics có thể cần replay event cũ (Kafka retention); (3) Thứ tự event theo order_id quan trọng (Kafka partition by key). RabbitMQ phù hợp hơn nếu chỉ cần task queue one-shot, routing phức tạp.

### BT8.1. Sơ đồ MVC — Sửa thông tin user

**View:** Form hiển thị name, email hiện tại + input fields + nút Submit.
**Controller:** Nhận POST /users/:id — validate input → gọi Model.updateUser(id, name, email).
**Model:** Validate (email unique? format?), update DB.
**Khi thành công:** Controller redirect → View danh sách + flash "Cập nhật thành công".
**Khi lỗi:** Controller render lại form + flash "Email đã tồn tại".

### BT8.2. MVC — Filter đơn hàng theo trạng thái

**Model:** Order (id, customer, status, total). Method: `Order.findByStatus(status)` trả danh sách.
**View:** Dropdown filter (Pending/Paid/Shipped) + bảng đơn hàng.
**Controller:** Nhận GET /orders?status=Paid → gọi `Order.findByStatus("Paid")` → truyền danh sách cho View → View render bảng.

### BT9.1. Luồng event — Đơn đã thanh toán

**Producer:** Payment Service publish `PaymentSucceeded { order_id, amount, timestamp }`.
**Event Bus:** Kafka topic `payment.events`.
**Consumers:** (1) Email Service → gửi email xác nhận; (2) Inventory Service → xác nhận xuất kho; (3) Analytics Service → ghi doanh thu.

### BT9.2. Chọn Kafka vs RabbitMQ

(a) **Task queue ảnh (one-shot):** Chọn **RabbitMQ** — hỗ trợ work queue (mỗi message chỉ 1 worker nhận), acknowledgement, retry.
(b) **Event stream replay analytics:** Chọn **Kafka** — lưu event bền vững (retention), consumer có thể đọc lại từ offset cũ (replay).

### BT10.1. Pipeline CSV đơn hàng

**Filters:** (1) ReadCSVFilter — đọc file CSV. (2) ValidateColumnsFilter — kiểm tra cột order_id, customer, amount tồn tại. (3) NormalizeDateFilter — chuyển DD/MM/YYYY → YYYY-MM-DD. (4) AmountFilter — lọc amount > 100000. (5) WriteJSONFilter — ghi kết quả ra file JSON.

### BT10.2. Compiler dùng Pipe-and-Filter

Compiler tự nhiên xử lý tuần tự: Source code → Lexer (token stream) → Parser (AST) → Semantic Analyzer (annotated AST) → Optimizer (optimized AST) → Code Generator (machine code). Mỗi phase là filter độc lập, output phase này là input phase sau. Có thể thay đổi Optimizer mà không sửa Parser.

### BT11.1. Hexagonal — Đăng ký user

**Inbound Port:** `RegisterUserPort { registerUser(name, email, password) }`.
**Outbound Ports:** `UserRepository { save(user), findByEmail(email) }`, `EmailService { sendWelcome(user) }`.
**Primary Adapter:** REST API Controller — nhận POST /register → gọi RegisterUserPort.
**Secondary Adapters:** PostgresUserRepository, SMTPEmailService.
**Luồng:** REST → RegisterUserUseCase → validate (email unique? password strong?) → UserRepository.save() → EmailService.sendWelcome() → response success.

### BT11.2. Interface + InMemory Adapter

```python
from abc import ABC, abstractmethod
from typing import Optional, List

class OrderRepository(ABC):
 @abstractmethod
 def save(self, order) -> None: pass
 @abstractmethod
 def find_by_id(self, order_id: str) -> Optional[dict]: pass
 @abstractmethod
 def find_by_customer_id(self, customer_id: str) -> List[dict]: pass

class InMemoryOrderRepository(OrderRepository):
 def __init__(self):
 self.store = {}
 def save(self, order) -> None:
 self.store[order['id']] = order
 def find_by_id(self, order_id: str):
 return self.store.get(order_id)
 def find_by_customer_id(self, customer_id: str):
 return [o for o in self.store.values() if o['customer_id'] == customer_id]
```

### BT12.1. Saga Orchestration — Đặt phòng

**Bước 1:** RoomService.reserveRoom(roomId, dates) → thành công.
**Bước 2:** PaymentService.chargeCard(cardInfo, amount) → **FAIL**.
**Compensate:** RoomService.releaseRoom(roomId, dates).
**Kết quả:** Trả lỗi cho client "Thanh toán thất bại, phòng đã được giải phóng".

### BT12.2. Cấu hình Circuit Breaker cho Payment

Gợi ý: failure_threshold = 5 (5 lỗi liên tiếp → Open); recovery_timeout = 30s (chờ 30s trước khi thử lại); sliding_window = count-based (10 requests gần nhất). Lý do: 1/3 request timeout → threshold không quá nhạy (tránh mở mạch quá sớm) nhưng đủ nhanh phát hiện Payment sự cố kéo dài. 30s đủ để Payment phục hồi từ overload tạm thời.

---

## Đáp án bài tập tổng hợp

### BT1. Phân tích và so sánh — Gợi ý

**Ví dụ cặp Layered vs MVC:**

| Tiêu chí | Layered | MVC |
|----------|---------|-----|
| Cấu trúc | 4 lớp ngang (Presentation → Business → Data → DB) | 3 thành phần (Model, View, Controller) |
| Phạm vi | Toàn hệ thống | Chủ yếu UI/Presentation |
| Ưu điểm | Tách biệt rõ lớp, dễ bảo trì | Separation of concerns UI, testable |
| Nhược điểm | Overhead nhiều lớp | Tight coupling View-Controller |
| Use case | Web app, ERP, enterprise | Web UI, SPA, mobile |
| Ví dụ | Spring Boot 3-layer app | Rails, Django, React |

MVC thường nằm **trong** lớp Presentation của Layered hoặc kết hợp: Layered tổ chức toàn bộ hệ thống, MVC tổ chức phần giao diện.

### BT2. Nhận biết mẫu kiến trúc

| STT | Hệ thống | Mẫu kiến trúc chính |
|-----|----------|----------------------|
| 1 | Facebook (Frontend) | MVC (React component model) |
| 2 | BitTorrent | P2P (Hybrid — tracker + peers) |
| 3 | MySQL Replication | Master-Slave |
| 4 | Netflix | Hybrid (Event-Driven + Microservices + Client-Server) |
| 5 | Ruby on Rails web app | MVC + Layered |
| 6 | Hadoop MapReduce | Master-Slave (JobTracker + TaskTrackers) |
| 7 | RabbitMQ | Broker (Message Queue) |
| 8 | WhatsApp | Event-Driven + Client-Server |
| 9 | Uber ride matching | Event-Driven + Hexagonal |
| 10 | Apache Kafka | Event-Driven (Event Streaming / Broker) |
| 11 | Unix pipes: cat \| grep \| sort | Pipe-and-Filter |
| 12 | Modern banking backend | Hexagonal / Clean Architecture |

### BT3. Lựa chọn mẫu kiến trúc — Gợi ý quy trình

(1) Phân tích yêu cầu: liệt kê functional (CRUD, real-time, batch) và non-functional (scalability, security, latency). (2) Dùng decision tree Chương 14: phân tán? real-time? UI phức tạp? (3) Chọn 1–2 pattern, giải thích dựa trên tiêu chí ưu tiên. (4) Vẽ sơ đồ component/deployment. (5) Nêu trade-offs: ưu điểm gì được, đánh đổi gì (complexity, cost, consistency).

### BT4. Scenario 1 — Hệ thống quản lý kho (cửa hàng nhỏ)

**Gợi ý pattern:** Layered hoặc MVC.
**Lý do:** Quy mô nhỏ (5 nhân viên), CRUD đơn giản, budget hạn chế → cần đơn giản, triển khai nhanh.
**Sơ đồ:** Web UI → REST API (Flask/Django) → Business Logic → SQLite/PostgreSQL.
**Components:** Presentation (Web); Application (API + services: ProductService, InventoryService); Data Access (Repository); Database.

### BT5. Scenario 2 — Streaming video

**Gợi ý pattern:** Hybrid — Client-Server + Master-Slave (DB/cache replication) + CDN.
**Có thể kết hợp:** P2P CDN (WebTorrent) giảm tải origin; Event-Driven (analytics, notifications).
**Trade-offs:** Phức tạp và chi phí cao nhưng cần thiết cho hàng triệu users. Bottleneck: bandwidth origin → giảm bằng CDN, edge cache.

### BT6. Scenario 3 — Real-time tracking

**Gợi ý pattern:** Event-Driven.
**Event flow:** GPS devices → Event Bus (Kafka topic `location.updates`) → Consumers: Real-time Dashboard, Customer Notifications, Analytics, ETA Calculator.
**Event types:** LocationUpdated, DeliveryStatusChanged, ETAUpdated, GeofenceEntered.
**Eventual consistency:** Chấp nhận delay vài giây cho dashboard/notification; dùng correlation ID (delivery_id) và idempotent consumer.

### BT7. Scenario 4 — ETL pipeline

**Gợi ý pattern:** Pipe-and-Filter.
**Filters:** Extract (DB connector, API reader, file reader) → Validate (schema check, null check) → Clean (dedup, trim, normalize) → Transform (calculate, enrich, join) → Load (warehouse insert).
**Error handling:** Dead Letter Queue cho bản ghi lỗi; retry với backoff; checkpoint (lưu offset) để resume sau restart.
**Performance:** Batch size phù hợp (10K records/batch); parallel filters nếu có thể; tối ưu I/O.

### BT8. Scenario 5 — Banking backend

**Gợi ý pattern:** Hexagonal hoặc Clean Architecture.
**Outbound Ports:** AccountRepository, TransactionRepository, AuditLog, PaymentGateway.
**Adapters:** PostgresAccountRepository, BankPaymentGateway, FileAuditLog; InMemory variants cho test.
**Inbound Ports:** REST API (Web/Mobile), ATM Adapter, Branch Adapter.
**Domain:** Account entity (balance, rules), Transaction entity, Money value object.
**Testing:** Unit test domain + use case với mock adapters (milliseconds); integration test adapter + real DB.

### BT9. Thiết kế chi tiết — Đặt vé xem phim

**Pattern:** Client-Server (web/mobile client → backend) + Layered/Hexagonal (backend internal) + Event-Driven (booking confirmation → email, analytics).
**Components:** UserService, MovieService, ShowtimeService, BookingService, PaymentService, NotificationService.
**Data flow:** User browse movies → select showtime → select seats → pay → confirm.
**Deployment:** Kubernetes, 2+ replicas BookingService, Redis cache for seat availability, PostgreSQL, Kafka for notifications.

### BT10. Refactoring — Monolith sang Microservices

**Vấn đề monolith:** Deploy 2h (toàn bộ 100K LOC), bug ảnh hưởng toàn bộ, 20 dev conflict, single instance bottleneck.
**Đề xuất:** Xác định bounded contexts (DDD) → tách service theo domain (User, Order, Payment, Inventory). Mỗi service có DB riêng. Giao tiếp qua Event-Driven (Kafka) hoặc REST.
**Migration:** Strangler Fig pattern — tách từng module dần, không refactor big-bang. Bắt đầu với module ít coupling nhất.
**Trade-offs:** Phức tạp vận hành tăng (monitoring, tracing, deployment pipeline cho mỗi service); eventual consistency; cần invest CI/CD, observability.

### BT11. Case study — Instagram

**Tại sao evolve:** Tăng trưởng user nhanh → monolith không scale; cần deploy độc lập; cần fault isolation.
**Phase 1 (monolith):** Đơn giản, nhanh ship. Trade-off: scale hạn chế, deploy chậm khi code lớn.
**Phase 2 (scaled monolith):** Load balancer + Master-Slave DB. Cải thiện read nhưng vẫn monolith → deploy vẫn ảnh hưởng toàn bộ.
**Phase 3 (microservices):** Tách service, message queue, Cassandra. Linh hoạt, scale từng phần. Trade-off: phức tạp vận hành, eventual consistency.
**Bài học:** Start simple, evolve khi có nhu cầu rõ ràng; invest observability sớm.

### BT12. Case study — Netflix

**Patterns:** MVC/MVVM (frontend React); Broker (Zuul API Gateway, Kafka); Client-Server (microservices); Event-Driven (Kafka event streaming); Hexagonal (trong từng service).
**Challenges:** Distributed tracing (giải: Zipkin/Jaeger), eventual consistency (giải: event sourcing, idempotent), deployment 700+ services (giải: Spinnaker CI/CD).
**Áp dụng dự án nhỏ:** Dùng subset: 1 API Gateway + 3-5 services + 1 message broker. Không cần 700+ services; scale dần theo nhu cầu.

### BT13. Project — Bài tập lớn cuối kỳ — Hướng dẫn

(1) **Phân tích yêu cầu:** Liệt kê functional requirements (use cases), non-functional requirements (performance, security, scalability). (2) **Lựa chọn kiến trúc:** Dùng decision tree Ch14; viết ADR (Ch13) cho mỗi quyết định quan trọng. (3) **Thiết kế chi tiết:** Vẽ sơ đồ C4 (Context, Container, Component); liệt kê component và trách nhiệm; mô tả data flow chính. (4) **Tài liệu:** 2-3 ADR; bảng trade-offs; kế hoạch tiến hóa (từ MVP → production). (5) **Triển khai:** Code prototype cho 1-2 luồng chính; viết test cho domain/use case.

---
*Đáp án mang tính gợi ý. Người đọc nên tự lập luận và có thể đề xuất phương án khác nếu hợp lý.*
