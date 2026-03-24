# Chương 6. Tổng kết và liên kết liên chương

Năm chương trước đã đi từ nền tảng (định nghĩa, đặc điểm kiến trúc phân tán) qua công nghệ giao tiếp (middleware, web services) đến phong cách kiến trúc hiện đại (microservices). Chương này rút lại các ý chính, so sánh nhanh các lựa chọn kiến trúc, và nối kết nội dung với sách Chương 1 (Tổng quan kiến trúc phần mềm) và sách Chương 3 (Các mẫu kiến trúc phần mềm).

---

## 6.1. Tóm tắt các ý chính

**Bảng 6.1.** Tóm tắt nội dung từng chương.

| Chương | Chủ đề | Ý chính |
|--------|--------|---------|
| 1 | Giới thiệu | Vị trí trong môn học; mục tiêu; cách dùng sách; tải nhận thức và phân biệt bằng chứng định lượng vs lời kể. |
| 2 | Tổng quan phân tán | Năm góc nhìn định nghĩa; bốn đặc điểm; CAP và PACELC; linearizability vs eventual; Lamport / thứ tự sự kiện; tám ngộ nhận Deutsch và ánh xạ kỹ thuật giảm rủi ro. |
| 3 | Middleware | Trừu tượng hóa và giới hạn; backpressure; 2PC/Saga sâu hơn; Kafka partition/consumer group/exactly-once thực tế; mesh control/data plane. |
| 4 | Web Services | REST + Richardson; idempotency; GraphQL N+1; gRPC deadline/metadata. |
| 5 | Microservices | Distributed monolith; strangler; schema/API contract; bảy nguyên lý; patterns và thách thức vận hành. |

---

## 6.2. Bảng so sánh nhanh các mô hình giao tiếp

**Bảng 6.2.** So sánh các cơ chế giao tiếp chính trong hệ thống phân tán.

| Cơ chế | Kiểu | Hiệu năng | Coupling | Phù hợp |
|--------|------|-----------|---------|---------|
| REST (HTTP/JSON) | Đồng bộ | Trung bình | Trung bình | API công khai, CRUD đơn giản |
| gRPC (Protobuf/HTTP2) | Đồng bộ | Cao | Trung bình | Nội bộ microservices |
| SOAP (XML/HTTP) | Đồng bộ | Thấp | Cao | Enterprise, tài chính |
| Message Queue (RabbitMQ) | Bất đồng bộ | Trung bình | Thấp | Tác vụ nền, decoupling |
| Event Streaming (Kafka) | Bất đồng bộ | Cao | Thấp | Event sourcing, log aggregation |
| GraphQL | Đồng bộ | Trung bình | Trung bình | Mobile, dashboard tổng hợp |

---

## 6.2a. Checklist tư duy khi thiết kế một luồng phân tán

Trước khi chốt sơ đồ, có thể tự hỏi theo trình tự sau (rút gọn từ thực hành phân tích kịch bản chất lượng và tư duy *Hard Parts* [6], [7]):

1. **Stakeholder** và **SLO** của luồng (độ trễ, tỷ lệ lỗi, RPO/RTO nếu có) là gì?
2. Luồng **đồng bộ** hay **bất đồng bộ**? Chuỗi gọi mấy hop — đã có **timeout**, **bulkhead**, **circuit breaker** chưa?
3. **Nguồn sự thật** dữ liệu ở đâu? Nếu nhiều store, mức nhất quán chấp nhận được (đọc mới nhất, read-your-writes, eventual) đã đặt tên chưa?
4. Khi partition hoặc downstream chậm, hành vi mong muốn: **từ chối**, **degraded**, hay **queue** — đã có **idempotency** cho retry chưa [3], [15]?
5. **Quan sát:** trace id, log correlation, metric theo bước — tránh postmortem chỉ kết luận “do mạng” [5].
6. Thay đổi có cần **ADR** và cập nhật **C4** (sách Chương 1; Chương 4 môn học) không?

---

## 6.3. Liên kết với sách Chương 1

Sách Chương 1 (Tổng quan kiến trúc phần mềm) cung cấp nền tảng lý thuyết mà cuốn sách này xây dựng lên:

- **Khái niệm kiến trúc** (cấu trúc, quyết định, NFR) → Chương 2 sách này áp dụng vào bối cảnh phân tán: availability, scalability, consistency trở thành **NFR trọng tâm** khi các thành phần nằm trên nhiều máy.
- **Khung nhìn kiến trúc** (4+1, C4) → Sơ đồ C4 đặc biệt hữu ích để biểu diễn kiến trúc phân tán: Context diagram cho thấy hệ thống tương tác với bên ngoài, Container diagram cho thấy các service và data store, Component diagram cho thấy nội bộ từng service.
- **Chi phí thay đổi** → Đổi từ monolithic sang microservices là **quyết định kiến trúc đắt đỏ**; cần ADR ghi lại lý do.

---

## 6.4. Liên kết với sách Chương 3

Sách Chương 3 (Các mẫu kiến trúc phần mềm) đi sâu vào từng mẫu kiến trúc cụ thể. Bảng 6.3 ánh xạ nội dung Chương 2 sang các chương tương ứng trong sách Chương 3.

**Bảng 6.3.** Ánh xạ nội dung sách Chương 2 → sách Chương 3.

| Nội dung sách Chương 2 | Chương tương ứng sách Chương 3 | Mối liên hệ |
|------------------------|-------------------------------|-------------|
| Giao tiếp Client-Server | Chương 5 (Client-Server) | Mô hình phân tán cơ bản nhất |
| Peer-to-Peer | Chương 6 (P2P) | Kiến trúc phân tán không có node trung tâm |
| Middleware, Broker | Chương 7 (Broker) | Broker pattern = middleware giao tiếp |
| Event-driven communication | Chương 9 (EDA) | Mô hình bất đồng bộ nâng cao |
| Microservices | Chương 12 (Microservices Patterns) | Saga, Sidecar, Circuit Breaker chi tiết |
| MVC qua mạng | Chương 8 (MVC) | MVC áp dụng trong web phân tán |

---

## 6.5. Lộ trình học tiếp

Sau khi nắm vững kiến trúc phân tán, người đọc có thể mở rộng theo ba hướng:

1. **Đi sâu vào mẫu kiến trúc** → sách Chương 3: học từng pattern (Layered, Client-Server, P2P, Broker, MVC, EDA, Pipe-and-Filter, Hexagonal, Clean, Microservices Patterns) với case study và code mẫu.
2. **Tài liệu hóa kiến trúc** → Chương 4 môn học: ADR, C4 diagram, UML — áp dụng trực tiếp lên kiến trúc phân tán đã học.
3. **Thực hành vận hành** → tự triển khai hệ thống phân tán đơn giản: Docker Compose với 2–3 service giao tiếp qua REST + RabbitMQ; Kubernetes cho orchestration; Prometheus + Grafana cho monitoring.

---

## 6.6. Câu hỏi ôn tập tổng hợp

1. Một tổ chức đang vận hành hệ thống monolithic phục vụ 10.000 người dùng, muốn mở rộng lên 1 triệu. Phân tích: (a) những giới hạn nào của monolithic sẽ bộc lộ? (b) đề xuất chiến lược chuyển sang phân tán (big-bang hay strangler fig?).
2. Vẽ sơ đồ kiến trúc phân tán cho hệ thống quản lý thư viện (tra cứu sách, mượn/trả, thông báo). Chỉ rõ: service, database, giao thức giao tiếp (đồng bộ hay bất đồng bộ), middleware.
3. So sánh hai hệ thống: (a) hệ thống giao dịch ngân hàng cần strong consistency; (b) mạng xã hội ưu tiên availability. Mỗi hệ thống nên chọn CP hay AP? Giải thích bằng định lý CAP.
4. Giải thích tại sao Netflix dùng cả REST (API công khai), gRPC (nội bộ) và Kafka (event streaming) thay vì chọn một giao thức duy nhất.

---

*Bảng 6.1–6.3 | §6.2a | Xem thêm: Phần I (Tổng quan KTPM), Phần III (Các mẫu kiến trúc phần mềm).*
