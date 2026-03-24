# Chương 13. ADR và tài liệu hóa quyết định kiến trúc

Kiến trúc là chuỗi quyết định có trade-offs. **Architecture Decision Records (ADR)** ghi lại "Tại sao chúng ta chọn phương án này" để team hiểu sau này và tránh lặp lại tranh cãi. Chương này giải thích vai trò ADR so với tài liệu thiết kế chi tiết, cấu trúc viết (Title, Status, Context, Decision, Consequences), thực hành lưu trong repo, và khía cạnh đạo đức/trách nhiệm (bảo mật, quyền riêng tư, tác động xã hội) khi ra quyết định.

## 13.1. Tại sao cần ADR

Phần này đối chiếu ADR với tài liệu thiết kế và nêu hậu quả khi không ghi lại quyết định.

- Kiến trúc không phải bản vẽ tĩnh mà là chuỗi quyết định.
- ADR trả lời: "Tại sao chúng ta chọn X mà không chọn Y?"
- Giúp thành viên mới (sau 2 năm) hiểu bối cảnh và tránh đảo ngược quyết định thiếu cơ sở.

**ADR khác gì tài liệu thiết kế chi tiết?** Tài liệu thiết kế thường mô tả *hệ thống hiện trông như thế nào* (API, class, schema). ADR ghi *tại sao lại thành ra như vậy*: đã cân nhắc phương án nào, loại phương án nào, và chấp nhận đánh đổi gì. Ví dụ: tài liệu nói “API dùng REST”; ADR giải thích “chọn REST vì đội quen thuộc, công cụ sẵn có, GraphQL bị loại vì chi phí học và vận hành ở giai đoạn 1”.

**Ví dụ tình huống — không có ADR:** Năm 2024 team chọn Redis làm cache. Năm 2026 developer mới thấy Redis và hỏi “sao không dùng Memcached cho nhẹ?” — không ai nhớ lúc đó cần pub/sub hay TTL phức tạp. Cả team lặp lại tranh luận hoặc đổi kiến trúc thiếu căn cứ. **Có ADR:** Mở file `ADR-003` thấy ngay: bối cảnh tải đọc cao, cần invalidation theo kênh; Memcached đã được xem xét và loại vì không đáp ứng kịch bản đó.

**Gợi ý khi viết Context / Consequences:** Trong *Context* nên có ít nhất: vấn đề nghiệp vụ hoặc kỹ thuật đang gặp, ràng buộc (thời gian, ngân sách, kỹ năng team). Trong *Consequences* nên có: lợi ích rõ ràng, chi phí hoặc rủi ro (vận hành, bảo mật, nợ kỹ thuật), và **phương án đã từ chối** — để sau này không “phát minh lại” cuộc họp cũ.

*Minh họa sketchnote — Kiến trúc và ADR là vòng lặp theo thời gian (workshop, câu hỏi mở, cập nhật), không “xong” sau một buổi.*

![Sketchnote — Workshop và vòng lặp kiến trúc](../assets/figures/part-01/sketchnotes/sketch-ch06-workshop-loop.svg)

## 13.2. Cấu trúc một ADR chuẩn

Phần này liệt kê năm thành phần tối thiểu của một ADR và ý nghĩa từng mục.

1. **Title:** Tiêu đề (VD: ADR-001: Sử dụng Kafka cho Message Bus).
2. **Status:** Proposed | Accepted | Deprecated | Superseded by ADR-XXX.
3. **Context:** Bối cảnh — vấn đề hiện tại, yêu cầu, ràng buộc.
4. **Decision:** Quyết định cuối cùng (mô tả rõ, có thể kèm lựa chọn thay thế đã loại).
5. **Consequences:** Hậu quả — ưu điểm, nhược điểm, rủi ro sau khi áp dụng.

## 13.3. Mẫu ADR hoàn chỉnh

### ADR-001: Sử dụng Apache Kafka làm Message Bus

**Status:** Accepted.

**Context:** Hệ thống cần giao tiếp async giữa Order, Payment, Inventory; cần replay events cho analytics và recovery; throughput ước tính 10K msg/s.

**Decision:** Chọn Apache Kafka làm message bus thay cho RabbitMQ. Topics: order.events, payment.events, inventory.events. Retention 7 ngày.

**Consequences:** Ưu: throughput cao, replay được, ecosystem (Kafka Streams). Nhược: vận hành phức tạp hơn, cần team có kinh nghiệm. Rủi ro: chi phí cluster; giảm thiểu bằng managed service (Confluent Cloud / AWS MSK) nếu ngân sách cho phép.

---

### ADR-002: Áp dụng Layered Architecture cho module Quản lý nội dung

**Status:** Accepted.

**Context:** Module CMS quy mô vừa, team quen Layered; yêu cầu bảo trì cao, không cần scale ngang ngay.

**Decision:** Áp dụng kiến trúc phân tầng 4 lớp (Presentation, Business, Data Access, Database) cho module CMS.

**Consequences:** Ưu: dễ hiểu, dễ onboard, tách biệt rõ. Nhược: nếu sau này cần tách microservice sẽ refactor. Đã xem xét Hexagonal nhưng bị loại do độ phức tạp không cần thiết cho giai đoạn 1.

---

### ADR-003: Event-Driven cho luồng real-time tracking

**Status:** Accepted.

**Context:** Cần cập nhật vị trí xe (GPS) real-time, 10K xe đồng thời; nhiều consumer (map, analytics, notification).

**Decision:** Luồng tracking dùng Event-Driven: Producer (vehicle gateway) → Kafka topic location.updates → Consumers (Map service, Analytics, Notify). Không dùng request-response cho từng subscriber.

**Consequences:** Ưu: scale consumer độc lập, giảm coupling. Nhược: eventual consistency; cần correlation ID và tracing. Đã chấp nhận trade-off vì real-time và scale quan trọng hơn strong consistency ngay lập tức.

---

## 13.4. Best practices

- Mỗi quyết định quan trọng một ADR; đánh số tuần tự.
- Giữ ngắn gọn; link tài liệu chi tiết nếu cần.
- Cập nhật Status khi quyết định thay đổi (Superseded by ADR-XXX).
- Lưu trong repo (docs/adr/) để version control và tìm kiếm.

*Minh họa sketchnote — Nên để **sơ đồ kiến trúc dạng text** (Mermaid, PlantUML, v.v.) cùng repo với code và ADR: pull request có thể review và diff sơ đồ như diff code, tránh tài liệu “trôi” so với hệ thống.*

![Sketchnote — Diagram as code](../assets/figures/part-01/sketchnotes/sketch-ch07-diagram-as-code.svg)

## 13.5. Đạo đức và trách nhiệm khi ra quyết định kiến trúc

Quyết định kiến trúc không chỉ ảnh hưởng đến hiệu năng hay chi phí mà còn đến **bảo mật**, **quyền riêng tư**, **trách nhiệm với người dùng** và **tính bền vững** (ví dụ tài nguyên, năng lượng). Khi ghi ADR, nên xem xét:

- **Bảo mật và quyền riêng tư:** Lựa chọn lưu trữ dữ liệu nhạy cảm ở đâu, mã hóa, phân quyền — có được ghi rõ trong Context/Consequences không? Quyết định có tuân thủ chuẩn (GDPR, OWASP) và chính sách của tổ chức không?
- **Trách nhiệm nghề nghiệp:** Kiến trúc sư và team có trách nhiệm lựa chọn giải pháp phù hợp với bối cảnh, tránh “over-engineering” hoặc chọn công nghệ rủi ro mà không ghi nhận. ADR giúp minh bạch lý do và hậu quả cho các bên liên quan.
- **Tác động xã hội và bền vững:** Một số quyết định (scale-out nhiều server, xử lý dữ liệu lớn) ảnh hưởng đến tài nguyên và môi trường; nên nêu trong Consequences khi có liên quan.

*Tham khảo thêm: ACM Code of Ethics and Professional Conduct; IEEE Code of Ethics.*

## 13.6. Câu hỏi ôn tập

1. ADR khác gì tài liệu thiết kế chi tiết? 2. Nêu 5 mục trong cấu trúc ADR. 3. Khi nào nên cập nhật Status thành Superseded? 4. Consequences nên ghi những gì? 5. Ai nên viết ADR (role)? 6. Tại sao nên xem xét bảo mật và quyền riêng tư khi ghi ADR? 7. Nêu một ví dụ quyết định kiến trúc có thể ảnh hưởng đến trách nhiệm nghề nghiệp hoặc tác động xã hội.

## 13.7. Bài tập ngắn

**BT13.1.** Viết ADR cho quyết định "Chọn REST thay vì GraphQL cho API công khai của sản phẩm X" (điền Context, Decision, Consequences). **BT13.2.** Cho một dự án đang dùng monolithic Layered; team muốn tách một module sang microservice. Liệt kê ít nhất 3 quyết định kiến trúc cần ghi ADR.

---
*Xem thêm: Chương 14 (so sánh pattern); Chương 4 môn học (Tài liệu kiến trúc).*
