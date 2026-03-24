# Bài tập tổng hợp

## Phần II — Kiến trúc phân tán


Các bài tập dưới đây tổng hợp kiến thức xuyên suốt sáu chương. Mức độ khó: ★ (cơ bản), ★★ (trung bình), ★★★ (nâng cao). Thời lượng ước lượng cho mỗi bài.

---

## BT1. Phân tích kiến trúc phân tán ★ (30 phút)

Cho hệ thống quản lý đặt vé xem phim trực tuyến. Yêu cầu:
1. Xác định tối thiểu bốn thành phần cần phân tán (ví dụ: User Service, Movie Service…).
2. Vẽ sơ đồ kiến trúc tổng quan (C4 Level 2 — Container diagram).
3. Chỉ rõ giao thức giao tiếp giữa các thành phần (đồng bộ hay bất đồng bộ, REST hay message queue).
4. Nhận diện ít nhất một SPOF tiềm ẩn và đề xuất cách loại bỏ.

---

## BT2. CAP Theorem trong thực tế ★★ (45 phút)

Cho hai hệ thống:
- **Hệ thống A:** Ứng dụng chuyển tiền ngân hàng (yêu cầu số dư luôn chính xác, không chấp nhận sai lệch).
- **Hệ thống B:** Mạng xã hội hiển thị số lượt like (chấp nhận con số chậm vài giây so với thực tế).

Yêu cầu:
1. Với mỗi hệ thống, phân tích nên chọn CP hay AP. Giải thích lý do.
2. Đề xuất database phù hợp cho mỗi hệ thống (ví dụ: PostgreSQL, Cassandra, DynamoDB…).
3. Nếu hệ thống A cần mở rộng lên nhiều region, làm thế nào để vẫn giữ strong consistency? Nêu đánh đổi.

---

## BT3. Lựa chọn middleware ★★ (45 phút)

Một công ty thương mại điện tử đang thiết kế hệ thống mới với các yêu cầu:
- Xử lý đơn hàng: tạo đơn → thanh toán → cập nhật kho → gửi email xác nhận.
- API công khai cho ứng dụng mobile.
- Giao tiếp nội bộ giữa 8 microservice.
- Xử lý 10.000 đơn hàng/phút vào giờ cao điểm.

Yêu cầu:
1. Chọn middleware cho từng nhu cầu (API Gateway, message broker, RPC framework). Giải thích lý do.
2. Cho luồng "tạo đơn → thanh toán → kho → email", chọn 2PC hay Saga? Vì sao?
3. Vẽ sơ đồ kiến trúc tổng quan thể hiện các middleware đã chọn.

---

## BT4. Thiết kế RESTful API ★ (30 phút)

Thiết kế RESTful API cho hệ thống quản lý sinh viên với các chức năng: xem danh sách sinh viên, xem chi tiết một sinh viên, thêm sinh viên, cập nhật thông tin, xóa sinh viên, xem danh sách môn học của một sinh viên.

Yêu cầu:
1. Liệt kê tất cả endpoint (URL, HTTP method).
2. Cho ví dụ request/response JSON cho endpoint tạo sinh viên mới.
3. Xử lý lỗi: liệt kê mã HTTP phù hợp cho các tình huống (thành công, không tìm thấy, dữ liệu không hợp lệ, lỗi server).
4. Đề xuất chiến lược phân trang cho endpoint danh sách.

---

## BT5. So sánh web services ★★ (45 phút)

Cho ba tình huống:
- **A:** API cho ứng dụng mobile cần hiển thị dashboard tổng hợp (user info + orders + notifications trong một màn hình).
- **B:** Giao tiếp nội bộ giữa 20 microservice với yêu cầu latency < 10ms.
- **C:** Tích hợp với hệ thống ngân hàng yêu cầu WS-Security và WS-Transaction.

Yêu cầu:
1. Chọn loại web service phù hợp cho mỗi tình huống (SOAP, REST, GraphQL, gRPC). Giải thích.
2. Nếu cả ba tình huống thuộc cùng một hệ thống, vẽ sơ đồ kiến trúc thể hiện cách kết hợp ba loại.

---

## BT6. Microservices vs. Monolith ★★★ (60 phút)

Một startup EdTech (5 developers) đang xây dựng nền tảng học trực tuyến với các module: quản lý khóa học, quản lý học viên, thanh toán, video streaming, quiz/exam, notification.

Yêu cầu:
1. Phân tích: nên bắt đầu với monolith hay microservices? Lý luận dựa trên quy mô đội, giai đoạn sản phẩm và nguyên tắc YAGNI.
2. Nếu sau 2 năm, đội tăng lên 30 người và có 500.000 học viên, lập kế hoạch chuyển sang microservices: (a) xác định bounded context, (b) thứ tự tách service, (c) chiến lược migration (big-bang hay strangler fig).
3. Xác định ba thách thức lớn nhất khi migration và đề xuất giải pháp.

---

## BT7. Tám ngộ nhận Deutsch ★★ (30 phút)

Một developer viết đoạn code gọi REST API từ Service A sang Service B mà không có retry, không có timeout, không xử lý lỗi mạng.

Yêu cầu:
1. Chỉ ra developer đã vi phạm những ngộ nhận nào trong tám ngộ nhận Deutsch.
2. Viết pseudocode minh họa cách sửa: thêm timeout, retry với exponential backoff, circuit breaker.
3. Giải thích tại sao idempotency quan trọng khi có retry.

---

## BT8. Case study tổng hợp ★★★ (90 phút)

Thiết kế kiến trúc phân tán cho hệ thống giao đồ ăn (tương tự GrabFood/ShopeeFood):
- Người dùng đặt đơn → chọn nhà hàng → thanh toán → phân công tài xế → theo dõi đơn hàng real-time → đánh giá sau khi nhận.
- Yêu cầu: 100.000 đơn/ngày, latency < 2s cho đặt đơn, real-time tracking.

Yêu cầu:
1. Xác định các microservice cần thiết (ít nhất 6 service).
2. Vẽ sơ đồ kiến trúc (C4 Level 2) với middleware, database, giao thức.
3. Cho luồng "đặt đơn → thanh toán → phân công tài xế", thiết kế Saga (liệt kê các bước và compensating transaction).
4. Chọn giao thức cho: (a) client ↔ API Gateway, (b) service nội bộ, (c) real-time tracking.
5. Đề xuất chiến lược monitoring và distributed tracing.

---

*Đáp án gợi ý: xem `99-DapAn.md`.*

---

## Phần III — Các mẫu kiến trúc


Các bài tập dưới đây gom từ Chương 14–15 và bài giảng gốc, đánh số thống nhất BT1–BTn. Mỗi bài có **độ khó** (★☆☆ dễ, ★★☆ trung bình, ★★★ khó) và **thời lượng ước lượng** để người đọc chủ động sắp xếp.

---

## BT1. Phân tích và so sánh — ★★☆ — 30 phút

Chọn 2 mẫu kiến trúc và so sánh về: Cấu trúc; Ưu/nhược điểm; Use cases phù hợp; Ví dụ ứng dụng thực tế.

**Gợi ý cặp:** Layered vs MVC; Client-Server vs P2P; Master-Slave vs Broker; Event-Driven vs Broker; Hexagonal vs Layered.

---

## BT2. Nhận biết mẫu kiến trúc — ★☆☆ — 20 phút

Với mỗi hệ thống sau, xác định mẫu kiến trúc chính:

1. Facebook (Frontend)
2. BitTorrent
3. MySQL Replication
4. Netflix
5. Ruby on Rails web app
6. Hadoop MapReduce
7. RabbitMQ
8. WhatsApp
9. Uber ride matching
10. Apache Kafka
11. Unix pipes: `cat | grep | sort`
12. Modern banking backend

---

## BT3. Lựa chọn mẫu kiến trúc — ★★☆ — 45 phút

Cho một dự án cụ thể (giảng viên đưa hoặc tự chọn), thực hiện: (1) Phân tích yêu cầu chức năng và phi chức năng; (2) Lựa chọn 1–2 mẫu kiến trúc và giải thích; (3) Vẽ sơ đồ kiến trúc; (4) Nêu trade-offs.

---

## BT4. Scenario 1 — Hệ thống quản lý kho (cửa hàng nhỏ) — ★☆☆ — 25 phút

- 5 nhân viên; CRUD đơn giản; Budget hạn chế; Deploy nhanh.
**Yêu cầu:** Chọn mẫu kiến trúc; vẽ sơ đồ; liệt kê components chính.

---

## BT5. Scenario 2 — Streaming video (kiểu YouTube) — ★★☆ — 40 phút

- Hàng triệu users; adaptive quality; low latency; high availability.
**Yêu cầu:** Chọn mẫu (có thể hybrid); giải thích trade-offs; chỉ ra bottleneck tiềm năng.

---

## BT6. Scenario 3 — Real-time tracking (logistics) — ★★☆ — 45 phút

- GPS mỗi 5s; thông báo khách hàng; dashboard real-time; 10K xe; high availability.
**Yêu cầu:** Chọn mẫu (gợi ý Event-Driven); thiết kế event flow; liệt kê event types; cách xử lý eventual consistency.

---

## BT7. Scenario 4 — ETL pipeline (data warehouse) — ★★☆ — 45 phút

- Extract từ DB, APIs, files; Transform (clean, validate, enrich); Load vào warehouse; 10GB/ngày; retry và error handling.
**Yêu cầu:** Chọn mẫu (gợi ý Pipe-and-Filter); thiết kế filters/pipes; chiến lược xử lý lỗi; tối ưu hiệu năng.

---

## BT8. Scenario 5 — Banking backend — ★★★ — 50 phút

- Business rules phức tạp; testability cao; nhiều giao diện (Web, Mobile, ATM, Branch); bảo mật và compliance; bảo trì dài hạn (10+ năm).
**Yêu cầu:** Chọn mẫu (gợi ý Hexagonal/Clean); xác định Ports và Adapters; phân biệt Domain vs Infrastructure; chiến lược test.

---

## BT9. Thiết kế chi tiết — Đặt vé xem phim trực tuyến — ★★★ — 90 phút

**Chức năng:** User (đăng ký, đăng nhập); Movies (danh sách, chi tiết); Booking (suất chiếu, ghế, thanh toán); Admin (phim, rạp, suất chiếu). **NFR:** 10K concurrent users; 99.9% uptime; booking < 2s; thanh toán an toàn.
**Deliverables:** Sơ đồ kiến trúc; giải thích lựa chọn mẫu; components và trách nhiệm; data flow; deployment strategy.

---

## BT10. Refactoring — Từ Monolith sang Microservices — ★★★ — 60 phút

**Hiện trạng:** Monolithic Layered; 100K LOC; 20 developers; deploy 2h; single instance; bug ảnh hưởng toàn bộ.
**Yêu cầu:** Phân tích vấn đề; đề xuất kiến trúc mới (Microservices?); chiến lược migration; phân tích trade-offs.

---

## BT11. Case study — Instagram Architecture Evolution — ★★☆ — 35 phút

**Phase 1 (2010):** Monolithic (Layered + MVC), Django, PostgreSQL.
**Phase 2 (2012):** Scaled monolith, load balancer, Master-Slave DB.
**Phase 3 (2014+):** Microservices, message queues (Broker), Cassandra, Redis.
**Câu hỏi:** Tại sao evolve? Trade-offs từng phase? Bài học?

---

## BT12. Case study — Netflix Microservices — ★★☆ — 40 phút

**Thành phần:** Frontend (React, MVC/MVVM); API Gateway (Zuul, Broker); 700+ microservices (Client-Server); Kafka (Broker); EVCache.
**Câu hỏi:** Vẽ sơ đồ kiến trúc; chỉ ra patterns; thách thức và giải pháp; áp dụng cho dự án nhỏ hơn?

---

## BT13. Project — Bài tập lớn cuối kỳ — ★★★ — (nhiều tuần)

Áp dụng Chương 3 vào bài tập lớn: (1) Phân tích yêu cầu; (2) Lựa chọn kiến trúc và biện minh; (3) Thiết kế chi tiết (sơ đồ, component, deployment); (4) Tài liệu (ADR, trade-offs, kế hoạch tiến hóa); (5) Triển khai và test.

---
*Đáp án gợi ý: xem file 99-DapAn.md.*
