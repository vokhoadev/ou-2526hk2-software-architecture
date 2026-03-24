# Chương 15. Tổng kết và lộ trình học tiếp

Chương này tóm tắt mười mẫu kiến trúc cốt lõi và mẫu bổ trợ microservices, các **key takeaways** (context matters, bắt đầu đơn giản, trade-offs, separation of concerns, SPOF, hybrid), bảng tra cứu **B15.1** (pattern → use case → công nghệ), liên hệ với các chương còn lại của môn học và gợi ý lộ trình tự học (Microservices, DDD, CQRS, Serverless).

## 15.1. Tóm tắt kiến thức

Phần này gom ý nhớ ngắn và khái niệm then chốt đã xuất hiện xuyên suốt sách.

**Một cách nhớ:** Mỗi pattern là một **lựa chọn có đánh đổi** — ví dụ đơn giản triển khai thường đổi lấy giới hạn khi scale; scale tốt thường đổi lấy phức tạp vận hành. Không có mẫu “thắng mọi trường hợp”; luôn hỏi: *bài toán cụ thể là gì*, *ưu tiên hiệu năng / bảo mật / bảo trì / chi phí là gì*.

**10 mẫu kiến trúc:** Layered, Master-Slave, Client-Server, P2P, Broker, MVC (core); Event-Driven, Pipe-and-Filter, Hexagonal, Clean (modern/advanced). **Khái niệm quan trọng:** Architecture vs Design Pattern; Separation of Concerns; SPOF; Location Transparency; Event Sourcing; CQRS; Eventual Consistency; Dependency Inversion; Ports and Adapters; DDD. **Kỹ năng:** Phân tích, so sánh, lựa chọn mẫu; thiết kế và vẽ sơ đồ; kết hợp patterns; áp dụng best practices và ADR.

## 15.2. Key takeaways

1. Không có silver bullet — context matters.
2. Start simple (Layered, MVC), evolve khi cần.
3. Hiểu rõ functional và non-functional requirements.
4. Mỗi lựa chọn đều có trade-offs.
5. Separation of Concerns là nguyên tắc vàng.
6. Luôn xét SPOF và scalability.
7. Security và maintainability by design.
8. Modern patterns (Event-Driven, Hexagonal) quan trọng trong thực tế.
9. Hybrid architecture phổ biến ở hệ thống lớn.

## 15.3. Bảng tóm tắt: Pattern → Use case chính → Công nghệ điển hình (B15.1)

| Pattern | Use case chính | Công nghệ điển hình |
|---------|----------------|----------------------|
| Layered | Web/ERP, CRUD, bảo trì cao | Spring, Django, .NET |
| Master-Slave | DB replication, MapReduce, load balancing | MySQL Replication, Hadoop |
| Client-Server | Web, API, quản lý tập trung | REST, Nginx, Spring Boot |
| P2P | File sharing, blockchain, CDN P2P | BitTorrent, IPFS, Bitcoin |
| Broker | Microservices, async, discovery | RabbitMQ, Kafka, Kong, Consul |
| MVC | Web/Mobile UI, tách UI–logic | Rails, Django, Spring MVC, React |
| Event-Driven | Real-time, microservices, IoT | Kafka, RabbitMQ, Kinesis |
| Pipe-and-Filter | ETL, compiler, stream processing | Unix pipes, Kafka Streams, Flink |
| Hexagonal | Domain phức tạp, testability | Ports/Adapters, DDD |
| Clean | Enterprise, long-term | Uncle Bob layers, DDD |

## 15.4. Liên kết với các chương môn học

- **Chương 1:** Khái niệm kiến trúc → áp dụng vào từng pattern; views.
- **Chương 2:** Kiến trúc phân tán → Client-Server, P2P, Broker, Event-Driven; CAP, eventual consistency.
- **Chương 4:** Tài liệu kiến trúc → document patterns; ADR; diagram chuẩn.

## 15.5. Roadmap tiếp theo

- **Chương 4 (môn học):** ADR, UML, documentation best practices.
- **Tự học nâng cao:** Microservices patterns nâng cao; Serverless; DDD sâu; Reactive; CQRS + Event Sourcing.

## 15.6. Tài liệu đọc thêm (nhóm theo chủ đề)

**Core patterns:** POSA (Buschmann et al.); Fundamentals of Software Architecture (Richards & Ford). **Event-Driven & Data:** Building Event-Driven Microservices (Bellemare); Designing Data-Intensive Applications (Kleppmann). **Hexagonal/Clean/DDD:** Get Your Hands Dirty on Clean Architecture (Hombergs); Implementing Domain-Driven Design (Vernon); Domain-Driven Design (Evans). **Microservices:** Building Microservices (Newman). **Websites:** Martin Fowler; Microsoft/AWS Architecture Center; patterns.dev; Enterprise Integration Patterns; Alistair Cockburn; Uncle Bob (Clean Architecture).

---
*B15.1. Chương tiếp theo (môn học): Chương 4 — Viết tài liệu kiến trúc phần mềm.*
