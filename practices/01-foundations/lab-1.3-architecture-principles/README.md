# Lab 1.3: Các Nguyên tắc Kiến trúc Phần mềm (Architecture Principles)

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | ** Beginner |
| **Yêu cầu trước** | Hoàn thành Lab 1.1, 1.2 |
| **Công cụ** | IDE (VSCode), draw.io |

## Mục tiêu Học tập

Sau khi hoàn thành lab này, bạn có thể:

1. **Liệt kê** các nguyên tắc kiến trúc phổ biến nhất
2. **Giải thích** lý do và lợi ích của mỗi nguyên tắc
3. **Áp dụng** các nguyên tắc vào thiết kế thực tế
4. **Đánh giá** kiến trúc dựa trên bộ nguyên tắc chuẩn

---

## Phân bổ Thời gian Chi tiết

| Phần | Hoạt động | Thời gian | Ghi chú |
|------|-----------|-----------|---------|
| **Phần 1** | Các nguyên tắc cốt lõi | 40 phút | Đọc + thảo luận |
| | - SOLID Principles | 15 phút | |
| | - DRY, KISS, YAGNI | 10 phút | |
| | - Coupling & Cohesion | 10 phút | |
| | - Design for Failure | 5 phút | |
| **Phần 2** | Nguyên tắc kiến trúc hiện đại | 20 phút | Đọc |
| **Phần 3** | Bài tập Thực hành | 100 phút | 4 bài tập |
| | - Bài 1: Nhận diện vi phạm | 20 phút | |
| | - Bài 2: Thiết kế lại | 40 phút | |
| | - Bài 3: Xung đột nguyên tắc | 20 phút | |
| | - Bài 4: Review kiến trúc | 20 phút | |
| **Phần 4** | Tự đánh giá | 20 phút | 30 câu hỏi |
| **Tổng** | | **3 giờ** | |

---

## Phần 1: Các Nguyên tắc Cốt lõi

### 1.1 SOLID Principles - Nền tảng thiết kế tốt

SOLID là 5 nguyên tắc cơ bản cho thiết kế phần mềm, áp dụng từ cấp class đến cấp service:

| Chữ cái | Nguyên tắc | Ý nghĩa thực tế | Ví dụ vi phạm |
|---------|------------|-----------------|---------------|
| **S** | Single Responsibility | Mỗi module/service chỉ làm MỘT việc | OrderService vừa xử lý đơn hàng vừa gửi email |
| **O** | Open/Closed | Mở để mở rộng, đóng để sửa đổi | Phải sửa code cũ mỗi khi thêm tính năng mới |
| **L** | Liskov Substitution | Có thể thay thế bằng subclass mà không lỗi | SquareClass kế thừa RectangleClass nhưng hành vi khác |
| **I** | Interface Segregation | API nhỏ gọn, không ép dùng method không cần | Interface có 20 methods, service chỉ cần 2 |
| **D** | Dependency Inversion | Phụ thuộc vào abstraction, không phải implementation | Service gọi trực tiếp MySQL, không qua interface |

**Ví dụ minh họa Single Responsibility:**

```
[Khong] SAI: OrderService làm quá nhiều việc
┌─────────────────────────────────┐
│ OrderService │
│ - validateOrder() │
│ - calculateTax() │
│ - processPayment() │
│ - updateInventory() │
│ - sendEmail() │
│ - generateReport() │
└─────────────────────────────────┘

[OK] ĐÚNG: Mỗi service một trách nhiệm
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│OrderService │ │PaymentSvc │ │EmailService │
│- validate() │ │- process() │ │- send() │
│- create() │ │- refund() │ │- template() │
└─────────────┘ └─────────────┘ └─────────────┘
```

### 1.2 Separation of Concerns - Tách biệt mối quan tâm

Chia hệ thống thành các lớp (layers), mỗi lớp phụ trách một khía cạnh riêng:

```
┌─────────────────────────────────────────┐
│ Presentation Layer │ → Giao diện người dùng
│ (UI, API Controllers) │
├─────────────────────────────────────────┤
│ Business Layer │ → Logic nghiệp vụ
│ (Services, Rules) │
├─────────────────────────────────────────┤
│ Data Layer │ → Truy cập dữ liệu
│ (Repositories, DAOs) │
├─────────────────────────────────────────┤
│ Infrastructure │ → Logging, Caching, etc.
└─────────────────────────────────────────┘
```

**Lợi ích:**
- Dễ test (mock từng layer)
- Dễ thay đổi (thay DB không ảnh hưởng UI)
- Team có thể làm song song

### 1.3 DRY, KISS, YAGNI - Bộ ba vàng

| Nguyên tắc | Viết tắt của | Ý nghĩa | Ví dụ |
|------------|--------------|---------|-------|
| **DRY** | Don't Repeat Yourself | Không viết code trùng lặp | Tạo shared library cho validation |
| **KISS** | Keep It Simple, Stupid | Giữ mọi thứ đơn giản | Dùng if-else thay vì pattern phức tạp khi không cần |
| **YAGNI** | You Aren't Gonna Need It | Không làm trước những gì chưa cần | Không xây multi-tenant khi mới có 1 khách hàng |

**DRY trong thực tế:**

```
[Khong] SAI: Logic trùng lặp ở nhiều nơi
Service A: validateEmail(email) { regex... }
Service B: validateEmail(email) { regex... } ← Copy code
Service C: validateEmail(email) { regex... } ← Copy code

[OK] ĐÚNG: Tập trung vào một nơi
┌───────────────────┐
│ ValidationLib │
│ validateEmail() │
└─────────┬─────────┘
 │
 ┌─────┼─────┐
 ▼ ▼ ▼
 A B C (Tất cả dùng chung)
```

### 1.4 Loose Coupling, High Cohesion - Liên kết lỏng, Gắn kết chặt

| Khái niệm | Giải thích | Mục tiêu |
|-----------|------------|----------|
| **Loose Coupling** | Các module ít phụ thuộc vào nhau | Module A thay đổi → Module B không bị ảnh hưởng |
| **High Cohesion** | Các thành phần trong 1 module liên quan chặt chẽ | Mọi thứ trong OrderModule đều về đơn hàng |

```
LOOSE COUPLING: HIGH COHESION:
┌───────┐ ┌───────┐ ┌─────────────────┐
│ A │─ ─ ─│ B │ │ Order Module │
└───────┘ └───────┘ │ ┌───┐ ┌───┐ │
 (qua interface, │ │create│validate│
 không gọi trực tiếp) │ └───┘ └───┘ │
 │ ┌───────────┐ │
 │ │ calculate │ │
 │ └───────────┘ │
 └─────────────────┘
 (Mọi thứ về Order ở cùng chỗ)
```

### 1.5 Design for Failure - Thiết kế cho trường hợp lỗi

> [Goi y] **Tư duy quan trọng:** "Mọi thứ SẼ hỏng. Vấn đề là KHI NÀO, không phải NẾU."

```
Request đến hệ thống:

┌─────────────────────────────────────────────┐
│ ┌─────────┐ ┌─────────────────────────┐ │
│ │ Request │───│ Circuit Breaker │ │
│ └─────────┘ │ (Ngắt mạch khi lỗi liên │ │
│ │ tục để bảo vệ hệ thống) │ │
│ │ ┌─────────┐ │ │
│ │ │ Retry │ (Thử lại │ │
│ │ │ Logic │ 3 lần) │ │
│ │ └────┬────┘ │ │
│ │ ▼ │ │
│ │ ┌─────────┐ │ │
│ │ │Fallback │ (Phương án │ │
│ │ │ │ dự phòng) │ │
│ │ └─────────┘ │ │
│ └─────────────────────────┘ │
└─────────────────────────────────────────────┘
```

**Các kỹ thuật:**
- **Retry**: Thử lại khi lỗi tạm thời
- **Timeout**: Không chờ vô hạn
- **Circuit Breaker**: Ngắt kết nối khi service chết
- **Fallback**: Có phương án dự phòng
- **Bulkhead**: Cách ly lỗi, không lan sang module khác

### 1.6 Defense in Depth - Bảo mật nhiều lớp

Không tin tưởng hoàn toàn vào bất kỳ lớp bảo vệ nào, xây dựng nhiều lớp:

```
┌─────────────────────────────────────────────────┐
│ Lớp 1: Firewall mạng (chặn IP lạ) │
│ ┌─────────────────────────────────────────────┐│
│ │ Lớp 2: WAF (chặn SQL injection, XSS) ││
│ │ ┌─────────────────────────────────────────┐││
│ │ │ Lớp 3: API Gateway (xác thực, rate │││
│ │ │ limit) │││
│ │ │ ┌─────────────────────────────────────┐│││
│ │ │ │ Lớp 4: Application (validate ││││
│ │ │ │ input, authorize) ││││
│ │ │ │ ┌─────────────────────────────────┐││││
│ │ │ │ │ Lớp 5: Database (mã hóa, │││││
│ │ │ │ │ row-level security) │││││
│ │ │ │ └─────────────────────────────────┘││││
│ │ │ └─────────────────────────────────────┘│││
│ │ └─────────────────────────────────────────┘││
│ └─────────────────────────────────────────────┘│
└─────────────────────────────────────────────────┘
```

### 1.7 Principle of Least Privilege - Quyền tối thiểu

Mỗi user/service chỉ có đúng quyền cần thiết, không hơn:

```
Ví dụ phân quyền:

Admin ─────────── Full Access (tạo, xóa, cấu hình)
Developer ─────── Read + Deploy (staging only)
Operator ──────── Read + Restart services
Viewer ────────── Read Only (xem logs, metrics)

[Khong] SAI: OrderService có quyền truy cập toàn bộ database
[OK] ĐÚNG: OrderService chỉ đọc/ghi table orders
```

---

## Phần 2: Nguyên tắc Kiến trúc Hiện đại

### 2.1 API-First Design

Thiết kế API contract **trước**, rồi mới code:

```
Quy trình:
1. Viết OpenAPI/Swagger spec ─┐
2. Review với team frontend │── TRƯỚC khi code
3. Thống nhất contract ─┘
4. Implement backend
5. Generate documentation tự động
```

```yaml
# Ví dụ OpenAPI Specification
openapi: 3.0.0
info:
 title: Order API
 version: 1.0.0
paths:
 /orders:
 post:
 summary: Tạo đơn hàng mới
 requestBody:
 content:
 application/json:
 schema:
 $ref: '#/components/schemas/CreateOrderRequest'
 responses:
 '201':
 description: Đơn hàng được tạo thành công
```

### 2.2 Event-Driven Architecture

Thay vì gọi trực tiếp giữa các service, sử dụng events:

```
Synchronous (đồng bộ - coupling cao):
OrderService ────── PaymentService ────── InventoryService
 (chờ) (chờ)

Event-Driven (bất đồng bộ - coupling thấp):
OrderService ── [Event: OrderCreated] ── PaymentService
 ── InventoryService
 ── NotificationService
 (Không cần chờ, mỗi service xử lý độc lập)
```

### 2.3 Stateless Services

Service không lưu trạng thái trong memory, lưu ra external store:

```
[Khong] Stateful (có trạng thái trong service):
┌─────────────────┐
│ Service │ ← User session trong RAM
│ ┌───────────┐ │ ← Nếu restart = mất hết
│ │ Session │ │
│ │ Data │ │
│ └───────────┘ │
└─────────────────┘

[OK] Stateless (không có trạng thái):
┌─────────────────┐
│ Service │ ← Không lưu gì trong RAM
│ (stateless) │ ← Có thể restart, scale thoải mái
└────────┬────────┘
 │
 ▼
┌─────────────────┐
│ Redis/Database │ ← Session lưu ở đây
│ (External) │
└─────────────────┘
```

**Lợi ích Stateless:**
- Scale dễ dàng (thêm instance không lo đồng bộ state)
- Restart không mất dữ liệu
- Load balancer có thể gửi request đến bất kỳ instance nào

### 2.4 Immutability - Không thay đổi dữ liệu đã có

```
[Khong] Mutable (thay đổi trực tiếp):
user.status = "active" ← Mất lịch sử

[OK] Immutable (tạo bản mới):
newUser = {...user, status: "active"} ← Giữ bản cũ

Áp dụng với:
- Log entries → Chỉ append, không sửa/xóa
- Events → Append-only log
- Audit trail → Không bao giờ xóa
```

---

## Phần 3: Bài tập Thực hành

### Bài tập 1: Nhận diện Vi phạm Nguyên tắc (20 phút)

Xác định nguyên tắc nào bị vi phạm trong mỗi tình huống:

**Tình huống A:**
```python
class OrderService:
 def create_order(self, order_data):
 self.validate_order(order_data) # Validate
 self.calculate_tax(order_data) # Tính thuế
 self.process_payment(order_data) # Thanh toán
 self.update_inventory(order_data) # Cập nhật kho
 self.send_confirmation_email() # Gửi email
 self.update_analytics() # Analytics
 self.generate_invoice() # Hóa đơn
```

**Vi phạm nguyên tắc:** __________________
**Lý do:** __________________

**Tình huống B:**
```
API Gateway cấp quyền truy cập FULL DATABASE cho tất cả services
```

**Vi phạm nguyên tắc:** __________________
**Lý do:** __________________

**Tình huống C:**
```
Service A gọi Service B (đồng bộ)
Service B gọi Service C (đồng bộ)
Service C gọi Service A (đồng bộ) ← Vòng tròn!
```

**Vi phạm nguyên tắc:** __________________
**Lý do:** __________________

**Tình huống D:**
```python
# Trong 5 services khác nhau, đều có code này:
def validate_email(email):
 pattern = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
 return re.match(pattern, email) is not None
```

**Vi phạm nguyên tắc:** __________________
**Lý do:** __________________

---

### Bài tập 2: Thiết kế lại theo Đúng Nguyên tắc (40 phút)

Thiết kế lại các tình huống ở Bài tập 1 để tuân thủ nguyên tắc.

**Template cho mỗi tình huống:**

```
Thiết kế ban đầu: [mô tả ngắn]
Nguyên tắc bị vi phạm: [tên nguyên tắc]
Thiết kế mới: [mô tả]
Sơ đồ minh họa: [vẽ đơn giản]
Lợi ích sau khi sửa: [liệt kê]
```

---

### Bài tập 3: Xung đột giữa các Nguyên tắc (20 phút)

Đôi khi các nguyên tắc mâu thuẫn với nhau. Phân tích và đề xuất cách giải quyết:

| Xung đột | Tình huống cụ thể | Bạn sẽ ưu tiên nguyên tắc nào? | Lý do |
|----------|-------------------|-------------------------------|-------|
| **DRY vs Loose Coupling** | Shared library tạo coupling giữa services | | |
| **KISS vs Extensibility** | Thiết kế đơn giản nhưng khó mở rộng sau này | | |
| **Performance vs Immutability** | Copy object tốn memory và CPU | | |
| **Security vs Usability** | MFA phức tạp làm khó người dùng | | |

---

### Bài tập 4: Review Kiến trúc (20 phút)

Review kiến trúc sau và liệt kê các vi phạm:

```
┌─────────────────────────────────────────────────────────┐
│ Hệ thống E-Commerce │
│ │
│ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ │
│ │ Web UI │ │ Admin UI │ │ Mobile App │ │
│ └──────┬──────┘ └──────┬──────┘ └──────┬──────┘ │
│ │ │ │ │
│ └────────────────┬─────────────────┘ │
│ ▼ │
│ ┌─────────────────────┐ │
│ │ Monolith API │ │
│ │ ┌───────────────┐ │ │
│ │ │Tất cả logic │ │ ← ??? │
│ │ │trong 1 class │ │ │
│ │ │50,000 dòng │ │ │
│ │ └───────────────┘ │ │
│ └──────────┬──────────┘ │
│ │ │
│ ┌──────────▼──────────┐ │
│ │ Database duy nhất │ │
│ │ (không mã hóa) │ ← ??? │
│ │ (admin:admin123) │ ← ??? │
│ └─────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

**Yêu cầu:**
1. Liệt kê TẤT CẢ nguyên tắc bị vi phạm
2. Đánh giá mức độ nghiêm trọng (Critical/High/Medium/Low)
3. Đề xuất cách khắc phục
4. Vẽ sơ đồ kiến trúc cải tiến

---

## Lời giải Mẫu (Sample Solutions)

### Đáp án Bài tập 1

| Tình huống | Nguyên tắc vi phạm | Giải thích |
|------------|-------------------|------------|
| A | **Single Responsibility** | OrderService làm 7 việc khác nhau |
| B | **Least Privilege** | Tất cả service có quyền như nhau, quá nguy hiểm |
| C | **Loose Coupling** | Circular dependency, services phụ thuộc lẫn nhau |
| D | **DRY** | Code validate email trùng lặp 5 nơi |

### Đáp án Bài tập 2

**Sửa Tình huống A:**

```
Thiết kế mới: Tách thành nhiều services độc lập

┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│OrderService │────│PaymentService────│InventoryService
│-validate │ │-process │ │-update │
│-create │ │-refund │ │-check │
└─────────────┘ └─────────────┘ └─────────────┘
 │
 ▼
┌─────────────┐ ┌─────────────┐
│EmailService │ │AnalyticsSvc │
│-send │ │-track │
└─────────────┘ └─────────────┘

Lợi ích:
- Mỗi service có thể scale riêng
- Dễ test từng service
- Team khác nhau có thể làm song song
```

### Đáp án Bài tập 3

| Xung đột | Ưu tiên | Lý do |
|----------|---------|-------|
| DRY vs Coupling | **Loose Coupling** | Tốt hơn là duplicate một ít code hơn là tạo coupling chặt |
| KISS vs Extensibility | **Tùy ngữ cảnh** | Startup = KISS; Enterprise = Extensibility |
| Performance vs Immutability | **Immutability** | Trừ khi có bottleneck thực sự |
| Security vs Usability | **Security** | Nhưng cần tìm UX tốt nhất trong giới hạn bảo mật |

### Đáp án Bài tập 4

| Vi phạm | Mức độ | Mô tả |
|---------|--------|-------|
| Single Responsibility | **High** | 50,000 dòng trong 1 class |
| Separation of Concerns | **High** | Không có layers rõ ràng |
| Defense in Depth | **Critical** | Database không mã hóa |
| Least Privilege | **Critical** | Password yếu: admin123 |
| DRY | **Medium** | Có thể có code trùng lặp trong monolith |

---

## Các Lỗi Thường Gặp

### Lỗi khi Áp dụng Nguyên tắc

| # | Lỗi | [Khong] Biểu hiện | [OK] Cách tránh |
|---|-----|-------------|---------------|
| 1 | **Over-engineering** | Áp dụng quá nhiều patterns phức tạp | Bắt đầu đơn giản, refactor khi cần |
| 2 | **Dogmatic** | "Phải tuyệt đối tuân thủ DRY" | Nguyên tắc là hướng dẫn, không phải luật |
| 3 | **Wrong abstraction** | Tạo abstraction quá sớm | Chờ thấy pattern rõ ràng rồi hãy abstract |
| 4 | **Cargo cult** | Copy architecture Netflix mà không hiểu | Hiểu context của mình trước |
| 5 | **All or nothing** | "Hoặc microservices hoặc thất bại" | Có thể bắt đầu từ modular monolith |

### Anti-patterns phổ biến

```
[Khong] God Class (Class thần thánh):
- Một class làm mọi thứ
- 10,000+ dòng code
- Không ai dám sửa

[Khong] Spaghetti Code:
- Dependencies chằng chịt
- Không biết module nào gọi module nào

[Khong] Copy-Paste Programming:
- Code giống nhau khắp nơi
- Sửa 1 bug phải sửa 10 chỗ

[Khong] Golden Hammer:
- "Mọi vấn đề đều giải bằng microservices"
- Dùng tool quen thay vì tool phù hợp
```

---

## Tiêu chí Chấm điểm (Grading Rubric)

### Tổng quan

| Bài tập | Điểm tối đa | Trọng số |
|---------|-------------|----------|
| Bài 1: Nhận diện vi phạm | 20 điểm | 20% |
| Bài 2: Thiết kế lại | 40 điểm | 40% |
| Bài 3: Xung đột nguyên tắc | 20 điểm | 20% |
| Bài 4: Review kiến trúc | 20 điểm | 20% |
| **Tổng** | **100 điểm** | **100%** |

### Rubric Chi tiết

**Bài 1 (20 điểm):** 5 điểm mỗi tình huống
- Xác định đúng nguyên tắc: 3 điểm
- Giải thích hợp lý: 2 điểm

**Bài 2 (40 điểm):** 10 điểm mỗi thiết kế lại
- Thiết kế mới hợp lý: 5 điểm
- Có sơ đồ minh họa: 3 điểm
- Liệt kê lợi ích: 2 điểm

**Bài 3 (20 điểm):** 5 điểm mỗi xung đột
- Chọn nguyên tắc ưu tiên: 2 điểm
- Lý do thuyết phục: 3 điểm

**Bài 4 (20 điểm):**
- Liệt kê đầy đủ vi phạm: 8 điểm
- Đánh giá mức độ hợp lý: 4 điểm
- Đề xuất khắc phục: 4 điểm
- Sơ đồ cải tiến: 4 điểm

---

## Checklist Review Kiến trúc

| Nhóm | Nguyên tắc | x |
|------|------------|---|
| **Modularity** | Single Responsibility | |
| | Separation of Concerns | |
| | Loose Coupling | |
| | High Cohesion | |
| **Simplicity** | KISS | |
| | YAGNI | |
| | DRY | |
| **Resilience** | Design for Failure | |
| | Graceful Degradation | |
| | Fault Isolation | |
| **Security** | Defense in Depth | |
| | Least Privilege | |
| | Secure by Default | |
| **Scalability** | Stateless Services | |
| | Horizontal Scaling | |
| | Caching Strategy | |

---

## Tự đánh giá (30 câu)

### Mức cơ bản (Câu 1-10)

1. SOLID viết tắt của những nguyên tắc nào?
2. Single Responsibility Principle nói gì?
3. DRY là gì? Vì sao quan trọng?
4. KISS nghĩa là gì trong thiết kế phần mềm?
5. YAGNI giúp tránh vấn đề gì?
6. Loose Coupling là gì? Lợi ích?
7. High Cohesion là gì? Lợi ích?
8. Defense in Depth áp dụng thế nào trong bảo mật?
9. Principle of Least Privilege nghĩa là gì?
10. Separation of Concerns giúp ích gì cho việc bảo trì?

### Mức trung bình (Câu 11-20)

11. Open/Closed Principle áp dụng thế nào với microservices?
12. Liskov Substitution Principle vi phạm khi nào?
13. Interface Segregation giải quyết vấn đề gì?
14. Dependency Inversion là gì? Cho ví dụ?
15. Stateless service khác stateful thế nào?
16. API-First design có những bước nào?
17. Event-Driven Architecture giải quyết vấn đề gì?
18. Immutability giúp ích gì trong distributed systems?
19. Circuit Breaker pattern implement nguyên tắc nào?
20. Làm sao đảm bảo team tuân thủ nguyên tắc?

### Mức nâng cao (Câu 21-30)

21. Khi nào nên vi phạm DRY để giữ Loose Coupling?
22. 12-Factor App có những nguyên tắc nào?
23. Zero Trust Architecture là gì?
24. Làm sao balance giữa KISS và Extensibility?
25. Conway's Law ảnh hưởng architecture thế nào?
26. Fail Fast principle áp dụng khi nào?
27. Bulkhead pattern implement nguyên tắc nào?
28. Làm sao enforce nguyên tắc trong CI/CD?
29. Technical Debt liên quan gì đến vi phạm nguyên tắc?
30. Làm sao modernize legacy system theo nguyên tắc mới?

**Gợi ý đáp án:**
- **Câu 1**: Single responsibility, Open/closed, Liskov substitution, Interface segregation, Dependency inversion
- **Câu 12**: Khi subclass thay đổi hành vi của parent class theo cách không mong đợi
- **Câu 22**: Codebase, Dependencies, Config, Backing services, Build/Release/Run, Processes, Port binding, Concurrency, Disposability, Dev/prod parity, Logs, Admin processes

---

## Bài tập Mở rộng (10 bài)

### EL1: Áp dụng SOLID vào Code thực tế
```
Đề bài: Refactor code vi phạm SOLID
- Cho sẵn code 500 dòng vi phạm nhiều nguyên tắc
- Tách thành nhiều class/module
- Viết unit tests
Độ khó: ***
```

### EL2: Thiết kế Microservices theo Nguyên tắc
```
Đề bài: Chia monolith thành microservices
- Service boundaries dựa trên SRP
- API contracts (API-First)
- Event-driven communication
Độ khó: ****
```

### EL3: Security Principles trong Thực tế
```
Đề bài: Audit bảo mật cho web app
- Áp dụng Defense in Depth
- Implement Least Privilege
- Zero Trust checklist
Độ khó: ****
```

### EL4: 12-Factor App
```
Đề bài: Chuẩn hóa ứng dụng theo 12-Factor
- Check từng factor
- Remediation plan
- Containerization
Độ khó: ***
```

### EL5: Resilience Patterns
```
Đề bài: Implement các pattern chịu lỗi
- Circuit Breaker
- Retry with backoff
- Bulkhead
Độ khó: ****
```

### EL6: Architecture Review Process
```
Đề bài: Tạo quy trình review kiến trúc
- Checklist dựa trên nguyên tắc
- Scoring system
- Remediation tracking
Độ khó: ***
```

### EL7: Xung đột Nguyên tắc
```
Đề bài: Case study về trade-offs
- 5 tình huống xung đột thực tế
- Decision framework
- Documentation (ADR)
Độ khó: ***
```

### EL8: Team Standards
```
Đề bài: Xây dựng bộ tiêu chuẩn cho team
- Coding standards
- Architecture principles
- Review process
Độ khó: ***
```

### EL9: Legacy Modernization
```
Đề bài: Lên kế hoạch hiện đại hóa hệ thống cũ
- Assessment hiện trạng
- Áp dụng nguyên tắc dần dần
- Strangler Fig pattern
Độ khó: ****
```

### EL10: Tài liệu hóa Nguyên tắc
```
Đề bài: Viết tài liệu nguyên tắc cho team
- ADRs cho mỗi nguyên tắc
- Ví dụ tốt/xấu
- Anti-patterns
Độ khó: ***
```

---

## Bài nộp

| # | Sản phẩm | Bài tập | Hình thức |
|---|----------|---------|-----------|
| 1 | Bảng phân tích vi phạm | Bài 1 | File Word/PDF |
| 2 | Sơ đồ thiết kế mới | Bài 2 | File draw.io/PDF |
| 3 | Bảng phân tích xung đột | Bài 3 | File Word/PDF |
| 4 | Báo cáo review kiến trúc | Bài 4 | File Word/PDF |

---

## Tài liệu Tham khảo

1. **Robert C. Martin** - "Clean Architecture" (2017)
2. **Martin Fowler** - "Patterns of Enterprise Application Architecture" (2002)
3. **Sam Newman** - "Building Microservices" (2021, 2nd ed.)
4. [Microsoft Architecture Guide](https://docs.microsoft.com/en-us/azure/architecture/)
5. [12-Factor App](https://12factor.net/)

---

## Nguồn Tham khảo Học thuật

### Đại học Quốc tế

| Trường | Khóa học | Nội dung |
|--------|----------|----------|
| **MIT** | 6.170 Software Studio | Design principles, SOLID |
| **CMU** | 17-214 Principles of Software Construction | OOP principles |
| **Stanford** | CS 107 Computer Organization | Systems principles |
| **Georgia Tech** | CS 6310 Software Architecture | SOLID in architecture |
| **U of Washington** | CSE 403 Software Engineering | Design patterns |

### (VN) Đại học Việt Nam

| Trường | Môn học | Nội dung |
|--------|---------|----------|
| **ĐH Bách Khoa TP.HCM** | CO3017 - Phương pháp phát triển PM | SOLID principles |
| **ĐH Bách Khoa Hà Nội** | IT3180 - Công nghệ phần mềm | Design principles |
| **ĐH FPT** | SWP391 - Software Development | Applied principles |
| **VNU-UET** | INT2208 - Công nghệ phần mềm | Software design |

### Papers quan trọng

| Paper | Tác giả | Đóng góp |
|-------|---------|----------|
| "Design Principles Behind Smalltalk" | Dan Ingalls (1981) | OOP origins |
| "On the Criteria for Decomposing Systems" | David Parnas (1972) | Modularity |
| "SOLID Principles" | Robert C. Martin (2000) | SOLID framework |

---

## Tiếp theo

Chuyển đến: `lab-1.4-architecture-views/`