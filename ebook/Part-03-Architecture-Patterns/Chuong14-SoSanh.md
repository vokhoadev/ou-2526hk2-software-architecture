# Chương 14. So sánh và lựa chọn mẫu kiến trúc

Chương này tổng hợp bảng so sánh đa tiêu chí (B14.1, B14.2), ma trận theo ngữ cảnh, decision tree và ví dụ hybrid để hỗ trợ ra quyết định. Người đọc có thể đối chiếu pattern theo scalability, complexity, fault tolerance, real-time; áp dụng ma trận theo quy mô, loại ứng dụng và NFR; thu hẹp lựa chọn (Layered vs Client-Server vs Event-Driven…); giải thích kiến trúc hybrid (e-commerce, Netflix). **Cách đọc bảng:** các ô trong B14.1/B14.2 là nhận xét tổng quát — khi áp dụng thực tế cần gắn **con số và giả định** (tải đồng thời, latency, ngân sách vận hành), vì cùng một pattern có thể triển khai tốt hoặc tệ. Decision tree (§14.4) là gợi ý kinh nghiệm; dự án quan trọng nên kiểm chứng bằng PoC hoặc số liệu chạy thật.

## 14.1. Bảng so sánh tổng quan (B14.1)

Phần này cho bảng đối chiếu nhanh các pattern cốt lõi theo nhiều tiêu chí.

*(Trích từ nguồn §14.1 — Core Patterns)*

| Tiêu chí | Layered | Master-Slave | Client-Server | P2P | Broker | MVC | Event-Driven | Pipe-Filter |
|----------|---------|--------------|---------------|-----|--------|-----|--------------|-------------|
| Phân tán | Tập trung | Phân tán | Phân tán | Phân tán hoàn toàn | Phân tán | Tập trung | Phân tán | Depends |
| Scalability | Trung bình | Cao | Tốt | Rất cao | Cao | Trung bình | Rất cao | Cao |
| Complexity | Đơn giản | Trung bình | Trung bình | Phức tạp | Phức tạp | Đơn giản | Phức tạp | Đơn giản |
| Performance | Trung bình | Cao | Tốt | Tốt | Overhead | Tốt | Cao | Overhead |
| Security | Cao | Trung bình | Cao | Thấp | Tốt | Tốt | Tốt | Tốt |
| Fault Tolerance | Trung bình | SPOF Master | SPOF Server | Rất cao | SPOF Broker | Trung bình | Cao | Trung bình |
| Real-time | Không | Không | Limited | Limited | Có | Không | Excellent | Không |
| Async | Limited | Limited | Limited | Có | Tốt | Sync | Native | Limited |

## 14.2. Bảng so sánh Advanced Patterns (B14.2)

Phần này so sánh các mẫu tổ chức quanh domain và khả năng kiểm thử.

| Tiêu chí | Layered | Hexagonal | Clean | MVC |
|----------|---------|-----------|-------|-----|
| Testability | Trung bình | Rất tốt | Rất tốt | Tốt |
| Domain Focus | Mixed | High | High | Low |
| Tech Independence | Coupled | Independent | Independent | Limited |
| Complexity | Đơn giản | Trung bình | Phức tạp | Đơn giản |

## 14.3. Ma trận lựa chọn theo ngữ cảnh

Phần này gợi ý pattern theo quy mô, loại ứng dụng và NFR — cần điều chỉnh theo số liệu dự án.

**Theo quy mô:** Nhỏ → Layered, MVC, Pipe-Filter. Vừa → + Client-Server, Hexagonal. Lớn → Client-Server, Master-Slave, Broker, Event-Driven. Rất lớn → Master-Slave, P2P, Broker, Event-Driven.

**Theo loại ứng dụng:** Web → MVC, Layered, Client-Server. Microservices → Broker, Event-Driven, Hexagonal. File sharing → P2P, Client-Server. Real-time → Event-Driven, Client-Server (WebSocket), P2P. Data processing → Master-Slave, Pipe-Filter. Enterprise → Layered, Hexagonal, Clean.

**Theo NFR:** Performance cao → Master-Slave, P2P, Event-Driven (tránh Layered/Broker overhead). Scalability cao → P2P, Broker, Event-Driven. Security cao → Layered, Client-Server (tránh P2P). Availability cao → P2P, Event-Driven (tránh SPOF). Maintainability cao → Layered, MVC, Hexagonal, Clean. Real-time → Event-Driven. Testability cao → Hexagonal, Clean, MVC.

## 14.4. Decision Tree (tóm tắt)

- Có UI phức tạp? → Cần tách UI/logic? → Testability cao? → Hexagonal/Clean hoặc MVC/MVVM.
- Không UI phức tạp → Phân tán? → Không: business logic phức tạp? → Hexagonal/Clean hoặc Layered. Có: tập trung (có server)? → Real-time? → Event-Driven hoặc Client-Server. Phân tán hoàn toàn → P2P. Có middleware → Async? → Event-Driven hoặc Broker. Xử lý song song → Master-Slave.
- Use case đặc biệt: Microservices → Event-Driven + Hexagonal; File sharing → P2P; ETL/Compiler → Pipe-Filter; IoT/Real-time analytics → Event-Driven.

## 14.5. Kết hợp nhiều mẫu (Hybrid)

**E-commerce:** Frontend (MVC/MVVM) → API Gateway (Broker) → Microservices (Client-Server) → DB (Layered bên trong từng service; Master-Slave cho DB replication). **Netflix:** Event-Driven giữa services; từng service có thể Layered/Hexagonal; Client-Server cho client–backend.

## 14.6. Case study ngắn: Netflix, Instagram

**Netflix:** Scale lớn, real-time recommendations, nhiều event → Event-Driven; microservices với message broker; hybrid với Client-Server (streaming). **Instagram:** Ứng dụng social, scale ảnh → Client-Server, CDN, storage phân tán; có thể kết hợp Event-Driven cho feed/notifications. (Chi tiết xem Bài tập tổng hợp và nguồn §14, §15.10.)

## 14.7. Câu hỏi ôn tập

1. Theo bảng B14.1, pattern nào có Fault Tolerance cao nhất? Pattern nào có SPOF? 2. Khi nào chọn Hexagonal thay vì Clean? 3. Nêu 3 tiêu chí trong decision tree để đi tới Event-Driven. 4. Hybrid architecture là gì? Cho 1 ví dụ. 5. Ứng dụng "streaming video" nên kết hợp những pattern nào?

## 14.8. Bài tập ngắn

**BT14.1.** Cho yêu cầu: 50K user đồng thời, real-time chat, bảo mật cao. Chọn 1–2 pattern chính và giải thích ngắn. **BT14.2.** Vẽ decision tree rút gọn (5–7 nút) cho lựa chọn giữa Layered, Client-Server, Event-Driven.

---
*B14.1, B14.2. Xem thêm: Chương 2 (tiêu chí), Chương 13 (ADR).*
