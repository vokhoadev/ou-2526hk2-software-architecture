# Tự luận (20 bài) — Phần III

Nguồn: `sach-Chuong3/99-TuLuan-20Bai.md`.


**(Từ cơ bản đến chuyên sâu, ưu tiên tình huống thực tế)**

**Phạm vi kiến thức:** Layered, Master-Slave, Client-Server, P2P, Broker, MVC, Event-Driven, Pipe-and-Filter, Hexagonal/Clean Architecture, Saga, Sidecar, Circuit Breaker, ADR.

**Hướng dẫn sử dụng:**
- Phần A (Bài 1–5): Kiểm tra hiểu biết nền tảng — phù hợp kiểm tra giữa kỳ hoặc bài tập cá nhân.
- Phần B (Bài 6–10): Phân tích và so sánh — phù hợp seminar nhóm hoặc kiểm tra cuối chương.
- Phần C (Bài 11–15): Thiết kế hệ thống — phù hợp bài tập nhóm hoặc project.
- Phần D (Bài 16–20): Tình huống thực tế chuyên sâu — phù hợp bài thi cuối kỳ hoặc đồ án.

---

## Phần A — Cơ bản (Bài 1–5)

---

### Bài 1. Kiến trúc phân tầng và nguyên tắc thiết kế — ★☆☆ — 25 phút

**Đề bài:** Một công ty phần mềm nhỏ đang phát triển ứng dụng quản lý nhân sự nội bộ (chấm công, tính lương, quản lý hồ sơ). Team gồm 3 developer, triển khai trên một server duy nhất, phục vụ khoảng 200 nhân viên. Trưởng nhóm quyết định sử dụng kiến trúc phân tầng (Layered Architecture).

**Yêu cầu:**
1. Trình bày khái niệm kiến trúc phân tầng. Vẽ sơ đồ kiến trúc 4 lớp cho hệ thống trên, ghi rõ tên và trách nhiệm từng lớp.
2. Giải thích nguyên tắc **dependency rule** (lớp trên chỉ gọi lớp dưới) và cho ví dụ vi phạm nguyên tắc này trong hệ thống quản lý nhân sự.
3. Nêu 2 anti-pattern phổ biến trong kiến trúc phân tầng (sinkhole anti-pattern, skip-layer) và cách phòng tránh cho hệ thống này.
4. Mô tả luồng xử lý cụ thể: "Nhân viên xem bảng lương tháng 3" — request đi qua từng lớp như thế nào?

---

### Bài 2. Mô hình Client-Server và giao thức giao tiếp — ★☆☆ — 25 phút

**Đề bài:** Một trường đại học triển khai hệ thống đăng ký học phần trực tuyến. Người dùng truy cập qua trình duyệt web, server xử lý nghiệp vụ và lưu trữ dữ liệu. Hệ thống phục vụ 15.000 tài khoản đăng ký, trong đó đợt cao điểm đăng ký có khoảng 3.000 người truy cập đồng thời.

**Yêu cầu:**
1. Vẽ sơ đồ kiến trúc Client-Server cho hệ thống trên. Chỉ rõ vai trò của client, server, database và giao thức giao tiếp (HTTP/HTTPS, REST).
2. Giải thích khái niệm SPOF (Single Point of Failure) trong mô hình này. Hệ thống đăng ký học phần có bao nhiêu điểm SPOF? Đề xuất cách giảm thiểu.
3. Phân biệt mô hình **2-tier** và **3-tier** Client-Server. Hệ thống đăng ký học phần nên dùng mô hình nào? Giải thích.
4. Nêu 2 ưu điểm và 2 nhược điểm của Client-Server cho bài toán này so với nếu dùng kiến trúc P2P.

---

### Bài 3. Mẫu MVC và các biến thể — ★☆☆ — 30 phút

**Đề bài:** Một startup phát triển ứng dụng quản lý công việc (task management) dạng Trello. Ứng dụng có giao diện web và dự kiến phát triển thêm mobile app. Giao diện cần cập nhật real-time khi thành viên trong nhóm thay đổi trạng thái task.

**Yêu cầu:**
1. Trình bày mẫu MVC: định nghĩa, vai trò của Model, View, Controller. Vẽ sơ đồ MVC cho module "Quản lý Board" của ứng dụng.
2. Giải thích sự khác nhau giữa MVC, MVP và MVVM. Với ứng dụng task management này, biến thể nào phù hợp nhất cho phiên bản web? Cho mobile app (React Native/Flutter)?
3. Mô tả luồng xử lý: "Thành viên A kéo thả task từ cột 'Đang làm' sang 'Hoàn thành'" — các thành phần MVC tương tác ra sao?
4. Khi giao diện cần cập nhật real-time (thành viên B thấy thay đổi của A ngay lập tức), MVC thuần túy có đáp ứng được không? Cần bổ sung cơ chế gì?

---

### Bài 4. Master-Slave và xử lý song song — ★☆☆ — 25 phút

**Đề bài:** Một công ty thương mại điện tử cần tạo báo cáo tổng hợp doanh thu cuối ngày. Dữ liệu gồm 5 triệu đơn hàng phân bố trên 10 bảng cơ sở dữ liệu khác nhau (theo vùng miền). Việc tính toán trên một máy mất khoảng 4 giờ, vượt quá yêu cầu hoàn thành trước 6:00 sáng hôm sau.

**Yêu cầu:**
1. Trình bày mẫu kiến trúc Master-Slave: khái niệm, thành phần chính (Master, Slave), cơ chế hoạt động.
2. Thiết kế giải pháp Master-Slave cho bài toán trên: Master phân chia dữ liệu như thế nào (theo vùng? theo khoảng thời gian?)? Mỗi Slave xử lý gì? Master tổng hợp kết quả ra sao?
3. Nêu 2 ưu điểm chính của Master-Slave trong bài toán này (hiệu năng, khả năng scale).
4. Nếu một Slave bị lỗi giữa chừng, hệ thống xử lý như thế nào? Đề xuất cơ chế fault tolerance.

---

### Bài 5. Pipe-and-Filter trong xử lý dữ liệu — ★☆☆ — 25 phút

**Đề bài:** Một hệ thống giám sát an ninh mạng cần xử lý log từ firewall: nhận log thô → phân tích cú pháp (parse) → lọc các event đáng ngờ (filter) → làm giàu thông tin (enrich thêm GeoIP, threat intelligence) → lưu vào SIEM. Mỗi ngày hệ thống nhận khoảng 50 triệu dòng log.

**Yêu cầu:**
1. Trình bày mẫu Pipe-and-Filter: khái niệm, thành phần (Filter, Pipe), nguyên tắc hoạt động.
2. Vẽ sơ đồ pipeline cho hệ thống trên. Đặt tên cho từng filter, mô tả input/output của mỗi filter.
3. Nêu 2 ưu điểm của Pipe-and-Filter cho bài toán xử lý log (tái sử dụng filter, dễ thêm bước mới).
4. Nếu filter "Enrich" bị chậm (do gọi API GeoIP bên ngoài), toàn bộ pipeline bị ảnh hưởng ra sao? Đề xuất giải pháp (buffering, async, parallel instances).

---

## Phần B — Phân tích và so sánh (Bài 6–10)

---

### Bài 6. So sánh Layered vs Hexagonal/Clean Architecture — ★★☆ — 35 phút

**Đề bài:** Công ty X có hai dự án: (A) Ứng dụng quản lý kho nội bộ — logic nghiệp vụ đơn giản (nhập/xuất/kiểm kê), team 2 người, deadline gấp 2 tháng. (B) Nền tảng fintech cho vay ngang hàng (peer-to-peer lending) — logic nghiệp vụ phức tạp (đánh giá tín dụng, quản lý hợp đồng vay, tuân thủ pháp luật), cần tích hợp nhiều hệ thống bên ngoài (ngân hàng, CIC, eKYC), team 8 người, phát triển dài hạn.

**Yêu cầu:**
1. Lập bảng so sánh Layered Architecture và Hexagonal Architecture theo ít nhất 5 tiêu chí: cấu trúc, dependency rule, testability, độc lập công nghệ, độ phức tạp triển khai, phù hợp quy mô.
2. Với dự án (A), nên chọn kiến trúc nào? Giải thích cụ thể dựa trên bảng so sánh.
3. Với dự án (B), nên chọn kiến trúc nào? Giải thích tại sao Hexagonal/Clean giúp quản lý logic nghiệp vụ phức tạp và tích hợp bên ngoài tốt hơn.
4. Vẽ sơ đồ Hexagonal cho module "Đánh giá tín dụng" của dự án (B): chỉ rõ Core Domain, Inbound Ports (REST API, Internal Service Call), Outbound Ports (CIC Adapter, DB Repository, Notification Adapter).

---

### Bài 7. Broker vs Event-Driven: khi nào dùng gì? — ★★☆ — 35 phút

**Đề bài:** Hệ thống quản lý logistics vận chuyển hàng hóa cho một công ty chuyển phát. Các module chính: Quản lý đơn hàng (Order), Điều phối tài xế (Dispatch), Theo dõi vị trí (Tracking), Thông báo khách hàng (Notification), Tính cước (Billing). Đơn hàng có thể lên tới 10.000 đơn/ngày. Cần cập nhật vị trí tài xế liên tục (mỗi 30 giây) và thông báo khách hàng khi trạng thái đơn thay đổi.

**Yêu cầu:**
1. Giải thích sự khác nhau cốt lõi giữa Broker pattern (trung gian điều phối, có thể đồng bộ) và Event-Driven Architecture (giao tiếp qua sự kiện, bất đồng bộ).
2. Với tương tác "Tạo đơn hàng mới → kiểm tra cước → xác nhận" — nên dùng Broker (sync) hay Event-Driven (async)? Giải thích.
3. Với tương tác "Tài xế cập nhật vị trí → Tracking lưu trữ → Notification gửi cho khách" — nên dùng Broker hay Event-Driven? Giải thích.
4. Lập bảng so sánh Broker vs Event-Driven theo 4 tiêu chí: coupling, latency, throughput, error handling. Đề xuất kiến trúc hybrid cho hệ thống logistics này.

---

### Bài 8. P2P vs Client-Server cho ứng dụng chia sẻ — ★★☆ — 30 phút

**Đề bài:** Một tổ chức phi lợi nhuận muốn xây dựng nền tảng chia sẻ tài liệu giáo dục mở (open educational resources) cho giáo viên ở vùng sâu vùng xa. Đặc thù: kết nối internet không ổn định, băng thông thấp, không có ngân sách cho server mạnh, cần khoảng 500 giáo viên chia sẻ tài liệu (PDF, video ngắn) với nhau.

**Yêu cầu:**
1. Phân tích ưu/nhược điểm của Client-Server cho bối cảnh này (chi phí server, SPOF, phụ thuộc internet ổn định).
2. Phân tích ưu/nhược điểm của P2P cho bối cảnh này (tận dụng máy cá nhân, hoạt động khi mất kết nối internet trung tâm, vấn đề NAT/firewall, bảo mật).
3. Giải thích sự khác nhau giữa P2P thuần túy (pure), P2P có Super Peer, và P2P hybrid. Mô hình nào phù hợp nhất cho bài toán này?
4. Vẽ sơ đồ kiến trúc cho phương án được chọn. Mô tả cơ chế discovery (tìm peer) và cơ chế đồng bộ tài liệu khi kết nối lại internet.

---

### Bài 9. Phân biệt Architecture Pattern và Design Pattern — ★★☆ — 30 phút

**Đề bài:** Trong buổi review thiết kế, một junior developer nói: "Em dùng mẫu Observer nên hệ thống của mình là Event-Driven Architecture rồi." Một developer khác nói: "MVC là một design pattern, không phải architecture pattern." Trưởng nhóm muốn làm rõ các khái niệm này cho team.

**Yêu cầu:**
1. Trình bày rõ ràng sự khác nhau giữa Architecture Pattern và Design Pattern theo 4 tiêu chí: phạm vi, mức độ ảnh hưởng, người quyết định, ví dụ minh họa.
2. Phân tích nhận định của junior developer: "Dùng Observer = Event-Driven Architecture" — đúng hay sai? Giải thích rõ ràng sự khác biệt giữa Observer pattern (design) và Event-Driven Architecture.
3. Phân tích nhận định: "MVC là design pattern" — đúng hay sai? MVC nằm ở mức nào? Có thể vừa là architecture pattern vừa là design pattern không?
4. Cho ví dụ một hệ thống cụ thể (ví dụ ứng dụng e-commerce) trong đó architecture pattern (Layered) và design pattern (Repository, Factory, Observer) cùng tồn tại và bổ sung cho nhau. Chỉ rõ mỗi pattern nằm ở đâu.

---

### Bài 10. Tiêu chí lựa chọn mẫu kiến trúc — ★★☆ — 35 phút

**Đề bài:** Công ty Y nhận được 3 dự án mới và cần chọn mẫu kiến trúc phù hợp cho từng dự án:
- **Dự án 1:** Ứng dụng blog cá nhân — 1 developer, vài trăm người đọc, không cần scale, cần ra nhanh trong 2 tuần.
- **Dự án 2:** Hệ thống giám sát IoT cho nhà máy — 10.000 sensor gửi dữ liệu mỗi 5 giây, cần xử lý real-time, phát hiện bất thường, lưu trữ lịch sử.
- **Dự án 3:** Nền tảng marketplace (chợ trực tuyến) — mua bán giữa người dùng, thanh toán trực tuyến, đánh giá, chat, 100.000 người dùng hoạt động hàng tháng.

**Yêu cầu:**
1. Liệt kê và giải thích 5 tiêu chí lựa chọn mẫu kiến trúc: yêu cầu chức năng, yêu cầu phi chức năng, độ phức tạp, kinh nghiệm team, chi phí/thời gian.
2. Áp dụng quy trình 5 bước lựa chọn (Phân tích → Ưu tiên → Đánh giá → Chọn → Tài liệu hóa) cho **Dự án 2**. Trình bày từng bước.
3. Lập bảng: mỗi dự án (1, 2, 3) chọn mẫu kiến trúc gì, với lý do ngắn gọn dựa trên tiêu chí ưu tiên.
4. Với Dự án 3, nếu sau 1 năm lượng người dùng tăng gấp 10 lần, kiến trúc ban đầu cần thay đổi gì? Đề xuất lộ trình evolution.

---

## Phần C — Thiết kế hệ thống (Bài 11–15)

---

### Bài 11. Thiết kế hệ thống thương mại điện tử — ★★★ — 50 phút

**Đề bài:** Thiết kế kiến trúc cho sàn thương mại điện tử "VietShop" với các tính năng: quản lý sản phẩm, giỏ hàng, đặt hàng, thanh toán (VNPay, MoMo), quản lý kho, giao hàng, đánh giá sản phẩm, tìm kiếm. Hệ thống phục vụ 500.000 người dùng hoạt động/tháng. Đợt flash sale có thể lên tới 50.000 request/phút. Team 15 developer chia thành 4 squad.

**Yêu cầu:**
1. Chia hệ thống thành các module/service chính. Với mỗi module, đề xuất mẫu kiến trúc phù hợp (Layered, Hexagonal, Event-Driven...) và giải thích lý do.
2. Vẽ sơ đồ kiến trúc tổng thể, thể hiện rõ: các service, cách giao tiếp (sync/async), API Gateway, message broker, database strategy (shared DB vs DB per service).
3. Thiết kế luồng "Đặt hàng trong đợt flash sale": từ người dùng nhấn "Mua ngay" → kiểm tra tồn kho → giữ chỗ → thanh toán → xác nhận → gửi email. Chỉ rõ đâu dùng sync, đâu dùng async, cơ chế xử lý khi thanh toán thất bại.
4. Nêu 3 thách thức chính (race condition kho, payment consistency, search performance) và giải pháp kiến trúc tương ứng.

---

### Bài 12. Thiết kế hệ thống ngân hàng số — ★★★ — 50 phút

**Đề bài:** Thiết kế kiến trúc cho ứng dụng ngân hàng số "DigiBank" với các tính năng: đăng nhập (OTP, biometric), xem số dư, chuyển khoản nội bộ và liên ngân hàng (Napas), thanh toán hóa đơn, lịch sử giao dịch, thông báo real-time. Yêu cầu: tính nhất quán dữ liệu cao (strong consistency cho giao dịch tài chính), bảo mật nghiêm ngặt, uptime 99.99%, tuân thủ quy định NHNN.

**Yêu cầu:**
1. Phân tích yêu cầu phi chức năng đặc thù của hệ thống ngân hàng: consistency, availability, security, auditability. Các yêu cầu này ảnh hưởng đến lựa chọn kiến trúc như thế nào?
2. Đề xuất kiến trúc tổng thể: tại sao không thể dùng eventual consistency cho chuyển khoản? Mẫu kiến trúc nào đảm bảo strong consistency? Vẽ sơ đồ.
3. Thiết kế luồng "Chuyển khoản liên ngân hàng": từ nhập thông tin → xác thực OTP → gọi Napas → ghi nhận giao dịch → thông báo. Chỉ rõ cơ chế đảm bảo tính nhất quán (2PC, Saga, hay cơ chế khác?).
4. Giải thích vì sao cần Circuit Breaker khi gọi Napas/đối tác bên ngoài. Vẽ sơ đồ trạng thái Circuit Breaker (Closed → Open → Half-Open) và mô tả hành vi ở mỗi trạng thái.

---

### Bài 13. Thiết kế hệ thống theo dõi IoT — ★★★ — 45 phút

**Đề bài:** Thiết kế kiến trúc cho hệ thống theo dõi đội xe giao hàng "TrackFleet": 2.000 xe, mỗi xe gửi vị trí GPS + trạng thái (tốc độ, nhiên liệu, nhiệt độ khoang lạnh) mỗi 10 giây qua mạng 4G. Dispatcher xem dashboard real-time. Hệ thống cần: lưu lịch sử 1 năm, phát hiện bất thường (xe đi lệch tuyến, quá tốc độ), gửi cảnh báo tức thì.

**Yêu cầu:**
1. Tính toán throughput: bao nhiêu message/giây từ 2.000 xe? Kích thước ước tính mỗi message? Tổng dữ liệu/ngày?
2. Đề xuất kiến trúc kết hợp: dùng mẫu nào để thu nhận dữ liệu (Client-Server qua MQTT?), xử lý luồng (Pipe-and-Filter hoặc Event-Driven?), lưu trữ (time-series DB?), hiển thị dashboard (MVC?). Vẽ sơ đồ tổng thể.
3. Thiết kế pipeline phát hiện bất thường: GPS data → Parse → Validate → Compare with route → Detect anomaly → Alert. Mô tả từng filter.
4. Khi số xe tăng lên 20.000 (10x), kiến trúc cần thay đổi gì? Đề xuất cách scale (horizontal scaling, partitioning, sharding).

---

### Bài 14. Thiết kế hệ thống video streaming — ★★★ — 50 phút

**Đề bài:** Thiết kế kiến trúc cho nền tảng video giáo dục "EduStream": người tạo khóa học upload bài giảng video, người xem theo khóa học, hệ thống chuyển đổi (transcode) video sang nhiều chất lượng (360p, 720p, 1080p), hỗ trợ adaptive bitrate streaming, theo dõi tiến độ học. 50.000 người xem đồng thời quy mô thiết kế, 5.000 video, 500 video mới/tháng.

**Yêu cầu:**
1. Chia hệ thống thành các thành phần chính: Upload Service, Transcode Pipeline, Content Delivery, Playback Service, Progress Tracking, Course Management. Đề xuất mẫu kiến trúc cho từng thành phần.
2. Thiết kế Transcode Pipeline theo Pipe-and-Filter: video gốc → Extract metadata → Validate format → Transcode (360p, 720p, 1080p song song) → Generate thumbnails → Upload CDN. Giải thích vì sao Pipe-and-Filter phù hợp ở đây.
3. Thiết kế cơ chế: khi giảng viên upload video xong, hệ thống tự động trigger transcode pipeline (dùng Event-Driven). Vẽ luồng từ upload → event "VideoUploaded" → transcode → event "TranscodeCompleted" → update catalog.
4. Phân tích trade-off giữa transcode đồng bộ (người dùng chờ) vs bất đồng bộ (xử lý nền). Tại sao bất đồng bộ là lựa chọn tốt hơn cho hệ thống giáo dục?

---

### Bài 15. Thiết kế mạng xã hội nội bộ doanh nghiệp — ★★★ — 45 phút

**Đề bài:** Thiết kế kiến trúc cho mạng xã hội nội bộ "CorpConnect" của tập đoàn 10.000 nhân viên: đăng bài viết (text, ảnh), bình luận, like, nhóm thảo luận, chat 1-1 và nhóm, thông báo real-time, tìm kiếm nhân viên/bài viết. Hệ thống chạy on-premise (không dùng cloud công cộng do chính sách bảo mật).

**Yêu cầu:**
1. Chia hệ thống thành các module: Feed (dòng tin), Messaging (chat), Notification, Search, User Profile, Media Storage. Đề xuất mẫu kiến trúc cho từng module.
2. Thiết kế module Feed: khi user A đăng bài → bài xuất hiện trên dòng tin của followers (fan-out). Dùng kiến trúc nào (Event-Driven để fan-out bất đồng bộ? Pipe-and-Filter để xử lý nội dung?)? Vẽ sơ đồ.
3. Thiết kế module Messaging (chat): dùng Client-Server với WebSocket? Hay P2P cho chat 1-1? So sánh và lựa chọn. Vẽ sơ đồ kiến trúc cho module chat.
4. Giải thích cách Broker pattern có thể đóng vai trò trung tâm kết nối các module (Feed, Messaging, Notification) trong hệ thống. Vẽ sơ đồ tổng thể có Broker.

---

## Phần D — Tình huống thực tế chuyên sâu (Bài 16–20)

---

### Bài 16. Chuyển đổi Monolith sang Microservices — ★★★ — 60 phút

**Đề bài:** Công ty Z có hệ thống ERP monolithic đã vận hành 8 năm, phát triển bằng Java/Spring, codebase 500.000 dòng code, một database PostgreSQL chung. Hệ thống gồm: Quản lý nhân sự (HR), Kế toán (Accounting), Quản lý kho (Inventory), Bán hàng (Sales), CRM. Vấn đề hiện tại: deploy mất 2 giờ, một bug ở module Sales làm sập toàn bộ, team 20 người thường xuyên conflict code, không thể scale riêng module Bán hàng khi mùa cao điểm.

**Yêu cầu:**
1. Phân tích các vấn đề của kiến trúc monolithic hiện tại theo 4 khía cạnh: deployment, fault isolation, team autonomy, scalability. Tại sao monolithic không còn phù hợp?
2. Đề xuất lộ trình chuyển đổi theo từng giai đoạn (Strangler Fig Pattern):
 - Giai đoạn 1: Tách module nào trước? Tại sao?
 - Giai đoạn 2: Xử lý vấn đề shared database — tách DB hay dùng database view?
 - Giai đoạn 3: Thiết kế giao tiếp giữa service mới và monolith còn lại (sync API vs event).
3. Với service "Sales" được tách ra đầu tiên, thiết kế kiến trúc nội bộ (Hexagonal/Clean). Vẽ sơ đồ gồm: Core Domain, Inbound Ports (REST API, gRPC), Outbound Ports (Sales DB, Legacy Monolith Adapter, Message Queue).
4. Nêu 3 rủi ro lớn nhất khi chuyển đổi (data consistency, distributed debugging, operational complexity) và biện pháp giảm thiểu cho từng rủi ro.

---

### Bài 17. Thiết kế hệ thống streaming giống Netflix — ★★★ — 60 phút

**Đề bài:** Thiết kế kiến trúc cho nền tảng xem phim trực tuyến "VietFlix" phục vụ 2 triệu người dùng. Tính năng: đăng ký/đăng nhập, duyệt phim (catalog), xem phim (streaming), gợi ý phim (recommendation), lịch sử xem, thanh toán subscription, hỗ trợ nhiều thiết bị (web, mobile, smart TV). Yêu cầu phi chức năng: latency xem phim < 2 giây, availability 99.9%, hỗ trợ 100.000 người xem đồng thời, content delivery toàn quốc.

**Yêu cầu:**
1. Chia hệ thống thành các service chính và xác định mẫu kiến trúc cho từng service. Lập bảng: Service | Mẫu kiến trúc | Lý do | Giao tiếp (sync/async).
2. Thiết kế kiến trúc tổng thể: vẽ sơ đồ gồm API Gateway, các service, message broker, CDN, cache layer, database layer. Giải thích vì sao cần tách riêng service Recommendation (tính toán nặng, ML model) khỏi service Catalog (read-heavy, cần cache).
3. Thiết kế luồng "Người dùng nhấn Play": Client → API Gateway → Auth check → Playback Service → CDN URL → Stream. Giải thích vai trò của CDN, adaptive bitrate, và cách xử lý khi một CDN node lỗi (Circuit Breaker + fallback).
4. Giải thích vì sao hệ thống này cần kết hợp nhiều mẫu (Client-Server cho API, Event-Driven cho analytics/recommendation, Pipe-and-Filter cho transcode, Broker cho inter-service communication). Nêu 2 anti-pattern cần tránh (Distributed Monolith, Architecture Astronaut).

---

### Bài 18. Xử lý giao dịch phân tán với Saga Pattern — ★★★ — 50 phút

**Đề bài:** Hệ thống đặt vé máy bay trực tuyến "FlyBook" có các service: Flight Search, Booking, Payment, Seat Assignment, Notification. Quy trình đặt vé: tìm chuyến → chọn ghế → thanh toán → xác nhận → gửi vé điện tử. Mỗi bước do một service khác nhau xử lý. Vấn đề: nếu thanh toán thành công nhưng seat assignment thất bại (ghế đã bị người khác đặt), cần rollback thanh toán. Không thể dùng distributed transaction (2PC) vì các service dùng database khác nhau.

**Yêu cầu:**
1. Giải thích vì sao 2PC (Two-Phase Commit) không phù hợp cho microservices (performance, availability, tight coupling). Trình bày Saga Pattern là gì và 2 kiểu triển khai: Choreography vs Orchestration.
2. Thiết kế Saga cho luồng đặt vé theo kiểu **Orchestration** (có Saga Orchestrator điều phối):
 - Vẽ sơ đồ các bước: CreateBooking → ReserveSeat → ProcessPayment → ConfirmBooking → SendNotification.
 - Với mỗi bước, chỉ rõ compensating action (hành động bù) khi bước đó hoặc bước sau thất bại.
3. Thiết kế Saga cho cùng luồng theo kiểu **Choreography** (các service tự phối hợp qua event):
 - Vẽ sơ đồ event flow: BookingCreated → SeatReserved → PaymentProcessed → BookingConfirmed.
 - Mô tả khi PaymentProcessed nhưng SeatAssignment fail → event SeatReservationFailed → Payment compensate.
4. So sánh Choreography vs Orchestration cho bài toán đặt vé: tiêu chí coupling, complexity, traceability, error handling. Đề xuất lựa chọn và giải thích.

---

### Bài 19. Architecture Decision Record cho dự án thực — ★★★ — 45 phút

**Đề bài:** Bạn là kiến trúc sư phần mềm của dự án "HealthCare" — hệ thống quản lý bệnh viện (đặt lịch khám, hồ sơ bệnh nhân, kê đơn thuốc, thanh toán BHYT). Team 12 người, dự kiến phát triển 18 tháng. Trong buổi họp kiến trúc, team có 3 quyết định lớn cần thảo luận:
- Quyết định 1: Kiến trúc tổng thể — Modular Monolith (Layered bên trong từng module) vs Microservices (service nhỏ, giao tiếp qua API/event).
- Quyết định 2: Giao tiếp giữa các module/service — REST (sync) vs Message Queue (async) vs kết hợp.
- Quyết định 3: Kiến trúc bên trong mỗi module/service — Layered vs Hexagonal.

**Yêu cầu:**
1. Giải thích ADR (Architecture Decision Record) là gì, tại sao cần ADR, và cấu trúc chuẩn của một ADR (Title, Status, Context, Decision, Consequences).
2. Viết ADR đầy đủ cho **Quyết định 1** (Modular Monolith vs Microservices). Phân tích bối cảnh (quy mô team, deadline, yêu cầu phi chức năng ngành y tế), các phương án, quyết định cuối cùng và hệ quả (tích cực + tiêu cực).
3. Viết ADR cho **Quyết định 2** (giao tiếp sync vs async vs kết hợp). Nêu rõ tương tác nào cần sync (ví dụ xem hồ sơ bệnh nhân), tương tác nào cần async (ví dụ gửi kết quả xét nghiệm).
4. Giải thích tại sao ADR quan trọng trong dự án dài hạn: khi thành viên mới gia nhập, khi cần thay đổi kiến trúc, khi audit/review. Nêu 2 sai lầm phổ biến khi viết ADR và cách tránh.

---

### Bài 20. Kết hợp nhiều mẫu cho hệ thống phức tạp — ★★★ — 60 phút

**Đề bài:** Thiết kế kiến trúc cho nền tảng gọi xe "GoRide" (tương tự Grab/Gojek) với các tính năng: đặt xe (bike, car), matching tài xế, định giá động (surge pricing), thanh toán (ví điện tử, thẻ), theo dõi real-time trên bản đồ, đánh giá tài xế/khách, promotion/voucher. Quy mô: 1 triệu chuyến/ngày, 200.000 tài xế trực tuyến, phục vụ 10 thành phố.

**Yêu cầu:**
1. Chia hệ thống thành ít nhất 8 service/module chính. Lập bảng chi tiết: Service | Mẫu kiến trúc bên trong | Giao tiếp với service khác | Cơ sở dữ liệu | Lý do lựa chọn.
2. Vẽ sơ đồ kiến trúc tổng thể thể hiện:
 - API Gateway (Broker pattern) cho client requests.
 - Event Bus/Message Broker cho giao tiếp async giữa services.
 - Luồng real-time: vị trí tài xế → Location Service → Matching Engine → Rider App (dùng mẫu nào?).
 - Pipeline xử lý: ride data → analytics pipeline (Pipe-and-Filter) → pricing model → surge pricing.
3. Thiết kế chi tiết luồng "Khách đặt xe": Request → Pricing Service (tính giá) → Matching Service (tìm tài xế gần nhất) → Driver App (nhận/từ chối) → Ride Started → Tracking → Ride Completed → Payment → Rating. Chỉ rõ từng bước dùng sync hay async, mẫu nào, và cơ chế xử lý khi tài xế từ chối (retry matching).
4. Áp dụng các mẫu bổ trợ microservices:
 - **Sidecar**: dùng ở đâu trong hệ thống? (logging, monitoring, service mesh). Vẽ minh họa.
 - **Circuit Breaker**: dùng cho tương tác nào? (gọi Payment Gateway bên ngoài). Mô tả cấu hình (threshold, timeout, reset).
 - **Saga**: dùng cho luồng nào? (Payment fail sau khi ride completed). Thiết kế compensating actions.
5. Nêu 3 trade-off lớn nhất trong thiết kế này (consistency vs availability, latency vs accuracy cho matching, cost vs reliability) và cách bạn cân bằng.

---

## Gợi ý đáp án

---

### Gợi ý Bài 1 — Kiến trúc phân tầng

**Sơ đồ 4 lớp:**
- **Presentation Layer**: Giao diện web (form chấm công, bảng lương, quản lý hồ sơ). Trách nhiệm: hiển thị dữ liệu, nhận input từ người dùng.
- **Business Logic Layer**: Xử lý nghiệp vụ — tính lương (lương cơ bản + phụ cấp – khấu trừ), kiểm tra quy tắc chấm công (đi muộn, vắng), validate dữ liệu hồ sơ.
- **Persistence/Data Access Layer**: Truy vấn DB — các repository/DAO cho Employee, Attendance, Payroll.
- **Database Layer**: PostgreSQL/MySQL lưu dữ liệu.

**Dependency rule:** Presentation → Business Logic → Persistence → Database. Vi phạm: nếu Presentation gọi thẳng Persistence để query dữ liệu bỏ qua Business Logic → mất kiểm soát nghiệp vụ, khó bảo trì.

**Anti-patterns:**
- *Sinkhole*: Request đi qua Business Logic nhưng không xử lý gì, chỉ forward xuống Persistence (ví dụ lấy danh sách phòng ban). Cách tránh: chấp nhận nếu < 20% use case, nếu nhiều hơn thì xem xét cho phép skip có kiểm soát.
- *Skip-layer*: Presentation gọi thẳng Database. Cách tránh: enforce dependency rule bằng module boundaries.

**Luồng "Xem bảng lương tháng 3":** User → Presentation (form lọc tháng 3) → Controller/Business Logic (validate quyền xem, gọi PayrollService.getByMonth(3)) → Persistence (PayrollRepository.findByEmployeeAndMonth) → Database (SELECT query) → trả kết quả ngược lên → hiển thị.

---

### Gợi ý Bài 2 — Client-Server

**Sơ đồ:** Browser (Client) HTTPS/REST Application Server (Spring Boot/Node.js) JDBC/ORM Database (PostgreSQL). Có thể thêm Load Balancer trước Application Server.

**SPOF:** 2 điểm — Application Server (1 instance → sập = mất toàn bộ) và Database (1 instance → mất dữ liệu). Giảm thiểu: Load Balancer + 2+ Application Server instances; Database replication (primary-replica).

**2-tier vs 3-tier:**
- 2-tier: Client giao tiếp trực tiếp với Database (ít dùng trong web hiện đại).
- 3-tier: Client → Application Server → Database. Hệ thống đăng ký học phần nên dùng 3-tier: tách biệt logic nghiệp vụ (kiểm tra tiên quyết, giới hạn tín chỉ) ở Application Server.

**So sánh với P2P:** Client-Server phù hợp hơn vì: quản lý tập trung (dữ liệu đăng ký cần nhất quán), bảo mật (xác thực tập trung), dễ kiểm soát. P2P không phù hợp vì: khó đảm bảo consistency đăng ký (hai người đăng ký cùng lớp cùng lúc), khó kiểm soát quyền truy cập.

---

### Gợi ý Bài 3 — MVC

**Sơ đồ MVC cho "Quản lý Board":**
- **Model**: Board (id, title, columns), Column (id, name, position), Task (id, title, description, status, assignee).
- **View**: Board view hiển thị các column và task dạng Kanban.
- **Controller**: BoardController xử lý CRUD board, TaskController xử lý kéo thả, thêm/sửa/xóa task.

**MVC vs MVP vs MVVM:**
- MVC: View biết Model, Controller điều phối. Phù hợp server-side rendering.
- MVP: Presenter thay Controller, View passive. Phù hợp Android truyền thống.
- MVVM: ViewModel binding 2 chiều với View. Phù hợp React (với hooks/state), Flutter, Vue.js.
- Web: MVVM (React + state management). Mobile: MVVM (Flutter/React Native).

**Luồng kéo thả task:** User kéo task → View dispatch event "moveTask(taskId, fromColumn, toColumn)" → Controller nhận event → gọi Model.moveTask() → Model cập nhật trạng thái → notify View → View re-render.

**Real-time:** MVC thuần túy không đủ — cần WebSocket hoặc Server-Sent Events. Khi thành viên A thay đổi, server broadcast qua WebSocket đến tất cả client đang mở cùng board. Bổ sung event bus phía server hoặc dùng thư viện real-time (Socket.io, Pusher).

---

### Gợi ý Bài 4 — Master-Slave

**Thành phần:**
- **Master**: Nhận yêu cầu tạo báo cáo, phân chia dữ liệu thành 10 phần (theo vùng miền — mỗi bảng DB tương ứng 1 vùng), giao cho Slave, thu thập kết quả, tổng hợp báo cáo cuối.
- **Slave**: Nhận phần dữ liệu, tính tổng doanh thu/số đơn/giá trị trung bình cho vùng được giao, trả kết quả về Master.

**Phân chia:** Theo vùng miền (10 bảng → 10 Slave, mỗi Slave xử lý 500.000 đơn). Thời gian giảm từ 4 giờ xuống ~25–30 phút (giả sử overhead phân phối + tổng hợp nhỏ).

**Ưu điểm:** (1) Hiệu năng tăng gần tuyến tính theo số Slave. (2) Dễ scale — thêm Slave khi dữ liệu tăng.

**Fault tolerance:** Khi Slave lỗi, Master phát hiện (timeout/heartbeat) → giao lại task cho Slave khác hoặc Slave dự phòng. Cơ chế: idempotent task (có thể retry an toàn), checkpoint (Slave lưu tiến trình, khi restart tiếp tục từ checkpoint).

---

### Gợi ý Bài 5 — Pipe-and-Filter

**Sơ đồ pipeline:**
```
Log thô → [Parse Filter] → Structured log → [Suspicious Filter] → Filtered events
→ [Enrich Filter] → Enriched events → [Store Filter] → SIEM
```

**Từng filter:**
- **Parse Filter**: Input: raw text log. Output: structured JSON (timestamp, source IP, dest IP, port, action). Dùng regex/parser cho format log cụ thể.
- **Suspicious Filter**: Input: structured log. Output: chỉ các event match rule (port scan, brute force, unusual traffic). Loại bỏ ~90% traffic bình thường.
- **Enrich Filter**: Input: suspicious event. Output: event + GeoIP location, threat intelligence score, hostname resolution.
- **Store Filter**: Input: enriched event. Output: ghi vào SIEM (Elasticsearch/Splunk).

**Ưu điểm:** (1) Dễ thêm filter mới (ví dụ thêm filter ML anomaly detection giữa Enrich và Store). (2) Mỗi filter có thể test độc lập, reuse cho pipeline khác.

**Bottleneck Enrich Filter:** Nếu Enrich chậm → backpressure, các filter trước bị block. Giải pháp: (1) Buffering: đặt queue (Kafka) giữa Suspicious và Enrich → Suspicious ghi nhanh vào queue, Enrich đọc theo tốc độ riêng. (2) Parallel instances: chạy nhiều Enrich Filter song song. (3) Async + cache: cache kết quả GeoIP, gọi API bất đồng bộ.

---

### Gợi ý Bài 6 — Layered vs Hexagonal

**Bảng so sánh:**

| Tiêu chí | Layered | Hexagonal |
|----------|---------|-----------|
| Cấu trúc | Các lớp xếp chồng (Presentation → Business → Data) | Core domain ở trung tâm, ports/adapters bao quanh |
| Dependency | Lớp trên phụ thuộc lớp dưới | Mọi thứ phụ thuộc vào Core (dependency inversion) |
| Testability | Test cần mock DB layer | Core test được hoàn toàn không cần infrastructure |
| Độc lập công nghệ | Thay DB phải sửa nhiều chỗ | Thay DB chỉ sửa adapter, core không đổi |
| Độ phức tạp | Thấp, dễ hiểu, dễ bắt đầu | Cao hơn, cần hiểu port/adapter, nhiều interface |
| Phù hợp quy mô | Nhỏ-trung bình | Trung bình-lớn, logic phức tạp |

**Dự án A (Quản lý kho):** Layered — logic đơn giản (CRUD), team nhỏ (2 người), deadline gấp → cần kiến trúc đơn giản, nhanh chóng. Hexagonal quá phức tạp cho scope này.

**Dự án B (Fintech P2P Lending):** Hexagonal — logic nghiệp vụ phức tạp (đánh giá tín dụng có nhiều rule, thay đổi thường xuyên theo quy định), cần tích hợp nhiều hệ thống ngoài (CIC, eKYC, ngân hàng) → adapter giúp thay đổi đối tác mà không ảnh hưởng core, testability cao cho logic tài chính quan trọng.

**Sơ đồ Hexagonal "Đánh giá tín dụng":** Core (CreditAssessmentUseCase, CreditScore entity, AssessmentRules). Inbound Ports: REST API Adapter (từ web), Internal Service Call Port (từ Loan Service). Outbound Ports: CIC Adapter (gọi API Trung tâm Thông tin Tín dụng), CustomerRepository (DB), NotificationPort (gửi kết quả). Mũi tên dependency: tất cả adapter → hướng vào Core.

---

### Gợi ý Bài 7 — Broker vs Event-Driven

**Khác biệt cốt lõi:**
- Broker: thành phần trung gian điều phối, client gửi request → broker route đến service phù hợp → trả response. Có thể đồng bộ (request-response). Broker biết cả sender và receiver.
- Event-Driven: producer phát event, consumer subscribe. Bất đồng bộ. Producer không biết ai xử lý. Loose coupling cao hơn.

**"Tạo đơn hàng":** Broker (sync) — vì cần response ngay (đơn hàng đã được tạo thành công, cước phí là X). Luồng: Client → API Gateway → Order Service → Billing Service (tính cước) → response. Người dùng cần biết kết quả ngay.

**"Cập nhật vị trí tài xế":** Event-Driven (async) — vì volume cao (30s/lần x 200 tài xế), không cần response. Driver App publish "LocationUpdated" event → Tracking consume & lưu → Notification consume & gửi push khi cần. Decoupling giúp thêm consumer mới (ví dụ Analytics) mà không sửa Driver App.

**Bảng so sánh:**

| Tiêu chí | Broker (sync) | Event-Driven (async) |
|----------|---------------|----------------------|
| Coupling | Trung bình (broker biết cả 2 bên) | Thấp (producer không biết consumer) |
| Latency | Thấp (response ngay) | Cao hơn (eventual) |
| Throughput | Bị giới hạn bởi slowest service | Cao (buffer bằng queue) |
| Error handling | Dễ (lỗi trả ngay cho client) | Phức tạp (dead letter queue, retry) |

**Hybrid:** Tạo đơn + tính cước = sync qua API Gateway. Cập nhật vị trí + thông báo khách = async qua event bus (Kafka/RabbitMQ).

---

### Gợi ý Bài 8 — P2P vs Client-Server

**Client-Server cho bối cảnh này:** Nhược điểm nổi bật — cần server mạnh (tốn chi phí mà tổ chức phi lợi nhuận không có), phụ thuộc internet ổn định (vùng sâu vùng xa không đảm bảo), SPOF. Ưu điểm: quản lý tập trung, dễ kiểm soát nội dung, bảo mật.

**P2P cho bối cảnh này:** Ưu điểm — tận dụng máy cá nhân (không cần server đắt), hoạt động trong mạng LAN khi mất internet, dữ liệu phân tán → không SPOF. Nhược điểm: NAT/firewall phức tạp, khó kiểm soát nội dung, bảo mật yếu hơn, peer offline → mất tài liệu.

**Mô hình phù hợp:** P2P hybrid với Super Peer — mỗi trường/cụm trường có 1 Super Peer (máy ổn định nhất) làm index/discovery. Khi có internet → sync với Super Peer trung tâm. Khi mất internet → vẫn chia sẻ trong cụm LAN qua Super Peer cục bộ.

**Sơ đồ:** Vẽ các peer (máy giáo viên) kết nối với Super Peer cục bộ (trường), các Super Peer kết nối với nhau khi có internet. Cơ chế discovery: Super Peer duy trì danh sách tài liệu + peer nào có. Đồng bộ khi kết nối lại: vector clock hoặc timestamp-based sync.

---

### Gợi ý Bài 9 — Architecture Pattern vs Design Pattern

**Bảng so sánh:**

| Tiêu chí | Architecture Pattern | Design Pattern |
|----------|---------------------|----------------|
| Phạm vi | Toàn hệ thống / subsystem | Module / class / component |
| Ảnh hưởng | Cấu trúc tổng thể, deployment | Cấu trúc code cục bộ |
| Người quyết định | Architect / Tech Lead | Developer |
| Ví dụ | Layered, Event-Driven, Microservices | Singleton, Observer, Factory |

**Observer ≠ Event-Driven Architecture:** Sai. Observer là design pattern — một object (subject) notify danh sách observer trong cùng process, cùng codebase. Event-Driven Architecture là architecture pattern — producer publish event qua message broker (Kafka, RabbitMQ), consumer là service khác, chạy trên process/máy khác, asynchronous. Quy mô khác hẳn.

**MVC — Architecture hay Design?** MVC có thể ở cả hai mức tùy bối cảnh. Khi MVC quyết định cấu trúc tổng thể ứng dụng (Rails, Django) → architecture pattern. Khi MVC chỉ áp dụng cho một component nhỏ trong hệ thống lớn → gần design pattern hơn. Trong ngữ cảnh môn học, MVC được xếp vào architecture pattern.

**Ví dụ e-commerce cùng tồn tại:** Kiến trúc Layered (4 lớp). Trong Presentation Layer: Observer pattern (UI update khi giỏ hàng thay đổi). Trong Business Logic Layer: Strategy pattern (chọn phương thức tính phí ship), Factory pattern (tạo Payment object theo loại thanh toán). Trong Data Access Layer: Repository pattern (abstract DB access). Architecture pattern = khung tổng thể, Design pattern = chi tiết bên trong từng lớp.

---

### Gợi ý Bài 10 — Tiêu chí lựa chọn

**5 tiêu chí:** (1) Yêu cầu chức năng (loại app, tính năng chính). (2) Yêu cầu phi chức năng (performance, scalability, availability, security). (3) Độ phức tạp hệ thống (số module, tương tác, dữ liệu). (4) Kinh nghiệm team (quen thuộc với pattern, DevOps maturity). (5) Chi phí & thời gian (ngân sách, time-to-market).

**Quy trình 5 bước cho Dự án 2 (IoT nhà máy):**
1. Phân tích yêu cầu: 10.000 sensor x 1 message/5s = 2.000 msg/s. Cần real-time processing, anomaly detection, lưu trữ lịch sử.
2. Ưu tiên: throughput cao, latency thấp (real-time), scalability (thêm sensor).
3. Đánh giá: Layered — không phù hợp (không xử lý được streaming). Client-Server — phù hợp cho thu nhận. Event-Driven — phù hợp cho xử lý luồng. Pipe-and-Filter — phù hợp cho pipeline phân tích.
4. Chọn: Client-Server (sensor → server qua MQTT) + Event-Driven (event streaming qua Kafka) + Pipe-and-Filter (pipeline phân tích).
5. Tài liệu: ghi ADR lý do chọn kết hợp 3 mẫu, trade-off chấp nhận (complexity tăng nhưng đáp ứng yêu cầu).

**Bảng lựa chọn:**

| Dự án | Mẫu đề xuất | Lý do chính |
|-------|------------|-------------|
| 1 (Blog) | Layered + MVC (monolithic) | Đơn giản, 1 dev, nhanh, không cần scale |
| 2 (IoT) | Client-Server + Event-Driven + Pipe-and-Filter | Throughput cao, streaming, pipeline phân tích |
| 3 (Marketplace) | Client-Server + Broker + Event-Driven | Nhiều module, cần scale, async notification |

**Dự án 3 tăng 10x:** Chuyển từ modular monolith → microservices cho module hot (Search, Order). Thêm cache layer (Redis). Tách database per service. Thêm CDN cho static content. Event-Driven cho inter-service communication. Lộ trình: 3 tháng thêm cache + CDN → 6 tháng tách Search service → 12 tháng tách Order + Payment service.

---

### Gợi ý Bài 11 — E-commerce VietShop

**Các module và mẫu:**

| Module | Mẫu | Lý do |
|--------|-----|-------|
| Product Catalog | Layered + Cache | Read-heavy, logic đơn giản |
| Shopping Cart | Client-Server (session/Redis) | Stateful per user, cần nhanh |
| Order Service | Hexagonal | Logic phức tạp (validate, pricing, promo) |
| Payment | Hexagonal + Circuit Breaker | Tích hợp bên ngoài (VNPay, MoMo) |
| Inventory | Event-Driven | Cập nhật kho async sau đặt hàng |
| Search | Separated service (Elasticsearch) | Full-text search, index riêng |
| Notification | Event-Driven | Async, không cần response |
| Delivery | Event-Driven + Saga | Phối hợp nhiều bên, cần compensate |

**Sơ đồ tổng thể:** Client → API Gateway (Broker) → [Order, Payment, Inventory, Catalog, Search] services. Message Broker (Kafka/RabbitMQ) kết nối Order → Inventory, Order → Notification. Mỗi service có DB riêng (DB per service).

**Luồng flash sale:** User → API Gateway → Order Service (sync: validate + tạo đơn) → Inventory Service (sync: giữ chỗ — dùng distributed lock/Redis) → Payment Service (sync: gọi VNPay — Circuit Breaker) → nếu thành công: publish OrderConfirmed event (async) → Notification consume → gửi email. Nếu payment fail: Inventory Service compensate (giải phóng giữ chỗ) — Saga pattern.

**3 thách thức:** (1) Race condition kho flash sale: distributed lock (Redis SETNX) hoặc optimistic locking. (2) Payment consistency: Saga pattern, idempotency key. (3) Search performance: Elasticsearch index riêng, sync từ Product DB qua event (ProductUpdated → reindex).

---

### Gợi ý Bài 12 — Ngân hàng số DigiBank

**Yêu cầu phi chức năng đặc thù:**
- Consistency: giao dịch tài chính phải strong consistency (số dư không được âm, chuyển khoản phải atomic).
- Availability: 99.99% uptime (downtime < 53 phút/năm).
- Security: mã hóa end-to-end, xác thực đa yếu tố, audit log mọi thao tác.
- Auditability: lưu trữ mọi giao dịch, không xóa, truy vết được.

**Kiến trúc:** Không thể dùng eventual consistency cho chuyển khoản vì: người A chuyển 10 triệu cho B, nếu eventual → có lúc A đã trừ nhưng B chưa nhận → khách hàng hoang mang, vi phạm quy định. Cần strong consistency → transaction đồng bộ cho core banking. Kiến trúc: Core Banking Service (Layered/Hexagonal, single DB với ACID transaction). Các service phụ trợ (Notification, History) dùng Event-Driven (eventual OK cho notification).

**Luồng chuyển khoản liên ngân hàng:** Nhập thông tin → OTP verify (sync, Auth Service) → Core Banking ghi debit (transaction) → gọi Napas API (sync, Circuit Breaker bảo vệ) → Napas confirm → Core Banking ghi hoàn tất → publish TransferCompleted event → Notification consume → SMS/push. Nếu Napas fail: Core Banking rollback debit. Dùng Saga (2 bước: debit local → credit via Napas) với compensate = rollback debit.

**Circuit Breaker khi gọi Napas:**
- **Closed** (bình thường): request đi qua, đếm lỗi. Nếu lỗi < threshold → vẫn Closed.
- **Open** (ngắt): lỗi vượt threshold (ví dụ 5 lỗi liên tiếp hoặc 50% fail trong 30s) → ngắt, trả lỗi ngay cho client ("Hệ thống Napas đang bảo trì"), không gọi Napas.
- **Half-Open** (thử lại): sau timeout (ví dụ 60s) → cho 1 request thử → nếu thành công → Closed, nếu thất bại → Open tiếp.

---

### Gợi ý Bài 13 — IoT TrackFleet

**Throughput:** 2.000 xe x 1 msg/10s = 200 msg/s. Mỗi message ~200 bytes (GPS lat/lng, speed, fuel, temp, timestamp, vehicle_id). Tổng/ngày: 200 x 86.400 x 200 bytes ≈ 3.5 GB/ngày. Lưu 1 năm ≈ 1.3 TB.

**Kiến trúc kết hợp:**
- Thu nhận: Client-Server (xe → server qua MQTT/HTTP). Protocol: MQTT phù hợp cho IoT (lightweight, persistent connection).
- Xử lý luồng: Event-Driven (Kafka nhận message từ MQTT broker, consumer groups xử lý).
- Pipeline phân tích: Pipe-and-Filter (Parse → Validate → Route Compare → Anomaly Detect → Alert).
- Lưu trữ: Time-series DB (InfluxDB/TimescaleDB) cho location data. PostgreSQL cho metadata (xe, tài xế, tuyến).
- Dashboard: MVC (web app) + WebSocket cho real-time map update.

**Pipeline phát hiện bất thường:**
- Parse: raw bytes → structured (vehicle_id, lat, lng, speed, fuel, temp, timestamp).
- Validate: kiểm tra GPS hợp lệ (lat -90~90, lng -180~180), loại bỏ noise.
- Route Compare: so sánh vị trí hiện tại với tuyến đường planned (geofencing).
- Anomaly Detect: speed > limit? fuel drop đột ngột (rò rỉ)? temp khoang lạnh > ngưỡng? deviation > 500m từ tuyến?
- Alert: gửi push notification cho dispatcher, log vào hệ thống cảnh báo.

**Scale 10x (20.000 xe → 2.000 msg/s):** Horizontal scale MQTT broker (cluster). Kafka partitioning by vehicle_id. Nhiều consumer instances cho pipeline. Sharding time-series DB theo thời gian (monthly partition). Có thể thêm Master-Slave: Master phân task theo vùng, Slave xử lý anomaly detection cho từng vùng.

---

### Gợi ý Bài 14 — Video streaming EduStream

**Các thành phần và mẫu:**

| Thành phần | Mẫu | Lý do |
|------------|-----|-------|
| Upload Service | Client-Server | Upload đơn giản, chunked upload |
| Transcode Pipeline | Pipe-and-Filter | Xử lý tuần tự nhiều bước, dễ thêm bước |
| Content Delivery | Client-Server + CDN | Phân phối nội dung tĩnh, edge caching |
| Playback Service | Client-Server + MVC | Serve HLS/DASH manifest, track progress |
| Progress Tracking | Event-Driven | Async ghi tiến độ, không block playback |
| Course Management | Layered/MVC | CRUD đơn giản |

**Transcode Pipeline:** Video gốc → [Extract Metadata] (codec, resolution, duration) → [Validate] (format hỗ trợ? size limit?) → [Transcode 360p], [Transcode 720p], [Transcode 1080p] (3 filter song song, Master-Slave cho bước này) → [Generate Thumbnails] (trích frame đại diện) → [Upload CDN] (đẩy lên CDN edge nodes). Pipe-and-Filter phù hợp: mỗi bước độc lập, dễ thêm chất lượng mới (4K), dễ thay codec.

**Event-Driven trigger:** Upload Service publish "VideoUploaded" event (videoId, originalUrl, courseId) → Transcode Pipeline consume → xử lý → publish "TranscodeCompleted" event (videoId, urls: {360p, 720p, 1080p}, thumbnailUrl) → Course Catalog Service consume → cập nhật video trong catalog → video sẵn sàng xem.

**Sync vs Async transcode:** Sync: user upload → chờ transcode (có thể 10–30 phút cho video 1 giờ) → UX rất tệ, timeout risk. Async: user upload → nhận thông báo "Video đang được xử lý" → notification khi hoàn tất → UX tốt hơn nhiều. Hệ thống giáo dục không cần video có ngay lập tức (giảng viên upload trước buổi học vài giờ/ngày), nên async là lựa chọn rõ ràng.

---

### Gợi ý Bài 15 — Mạng xã hội CorpConnect

**Các module và mẫu:**

| Module | Mẫu đề xuất | Lý do |
|--------|------------|-------|
| Feed | Event-Driven (fan-out) | Bài viết mới → push async đến followers |
| Messaging | Client-Server + WebSocket | Chat cần persistent connection, real-time |
| Notification | Event-Driven | Subscribe nhiều nguồn (feed, chat, mention) |
| Search | Separated service + Elasticsearch | Full-text search nhân viên, bài viết |
| User Profile | Layered/MVC | CRUD đơn giản |
| Media Storage | Pipe-and-Filter | Upload → resize → compress → store |

**Feed fan-out:** User A đăng bài → Feed Service nhận → publish "PostCreated" event → Fan-out Service consume: lấy danh sách followers của A (giả sử 500 người) → ghi post vào timeline cache (Redis sorted set) của mỗi follower → khi follower mở app, đọc từ cache. Pipe-and-Filter cho content processing: text → filter bad words → extract mentions → extract hashtags → enrich (add author info) → store.

**Messaging:** Client-Server + WebSocket phù hợp hơn P2P vì: on-premise → server có sẵn, cần lưu lịch sử chat (compliance), cần kiểm soát (admin có thể moderate). P2P không phù hợp vì: khó lưu lịch sử tập trung, khó moderate, NAT trong mạng nội bộ ít vấn đề nhưng quản lý phức tạp hơn. Sơ đồ: Client WebSocket Chat Server (Redis Pub/Sub cho multi-instance) Message DB (MongoDB/PostgreSQL).

**Broker trung tâm:** Message Broker (RabbitMQ) kết nối: Feed Service publish PostCreated → Notification Service consume (push notification) + Search Service consume (index bài mới). Chat Service publish MessageSent → Notification Service consume (badge count). Broker giúp các module độc lập, thêm module mới (ví dụ Analytics) chỉ cần subscribe thêm.

---

### Gợi ý Bài 16 — Monolith sang Microservices

**Vấn đề monolithic:**
- Deployment: 500K LOC → build + test + deploy mất 2 giờ, mỗi thay đổi nhỏ cũng deploy toàn bộ.
- Fault isolation: bug ở Sales (memory leak) → sập toàn bộ HR, Accounting, CRM.
- Team autonomy: 20 người cùng 1 repo → merge conflict, mỗi thay đổi phải coordinate.
- Scalability: mùa cao điểm Sales cần scale nhưng không thể scale riêng Sales → phải scale toàn bộ (tốn tài nguyên).

**Lộ trình Strangler Fig:**
- **Giai đoạn 1 (3–6 tháng):** Tách Sales trước — vì: thay đổi nhiều nhất, cần scale riêng, bounded context rõ ràng (đơn hàng, sản phẩm, khách hàng). Dùng API Gateway proxy: request Sales mới → Sales Service, request khác → Monolith.
- **Giai đoạn 2 (6–12 tháng):** Tách database Sales. Bước đầu dùng database view/synonym để Sales Service đọc từ DB cũ. Sau đó migrate data sang Sales DB riêng, dùng event để sync khi cần (ví dụ ProductPriceChanged).
- **Giai đoạn 3 (12–18 tháng):** Giao tiếp: Sales cần gọi Inventory (check tồn kho) → sync REST. Sales → CRM (cập nhật lịch sử mua) → async event (SaleCompleted). Tiếp tục tách Inventory nếu cần.

**Sơ đồ Hexagonal cho Sales Service:** Core: OrderUseCase, PricingUseCase, Order entity, Product entity. Inbound: REST API Adapter (từ API Gateway), gRPC Adapter (từ internal service). Outbound: SalesDBRepository, LegacyMonolithAdapter (gọi REST đến monolith cũ cho CRM data), MessageQueuePublisher (publish events). Dependency: tất cả adapter → Core.

**3 rủi ro:** (1) Data consistency: dữ liệu phân tán → eventual consistency, cần Saga cho cross-service transaction. Giảm thiểu: thiết kế bounded context rõ, chấp nhận eventual cho non-critical. (2) Distributed debugging: lỗi trải qua nhiều service. Giảm thiểu: centralized logging (ELK), distributed tracing (Jaeger), correlation ID. (3) Operational complexity: nhiều service → nhiều deployment, monitoring, networking. Giảm thiểu: CI/CD pipeline, container orchestration (Kubernetes), Sidecar pattern cho cross-cutting concerns.

---

### Gợi ý Bài 17 — Netflix-like VietFlix

**Các service và mẫu:**

| Service | Mẫu | Giao tiếp | Lý do |
|---------|-----|-----------|-------|
| User/Auth | Layered | Sync (REST) | CRUD + auth, đơn giản |
| Catalog | Layered + Cache (Redis) | Sync (REST) | Read-heavy, cần cache |
| Recommendation | Event-Driven + Pipe-and-Filter | Async (consume viewing events) | ML processing nặng, batch/stream |
| Playback | Client-Server | Sync (REST → CDN URL) | Latency thấp, response nhanh |
| Subscription/Payment | Hexagonal + Circuit Breaker | Sync (REST) + Async (webhook) | Tích hợp payment gateway |
| Transcode | Pipe-and-Filter | Async (event trigger) | Pipeline xử lý video |
| Analytics | Event-Driven + Pipe-and-Filter | Async (consume events) | Volume lớn, không cần real-time |
| Notification | Event-Driven | Async | Push/email, fire-and-forget |

**Tách Recommendation khỏi Catalog:** Recommendation tính toán nặng (ML model, collaborative filtering, dữ liệu viewing history lớn) → nếu chung với Catalog → ảnh hưởng performance đọc catalog. Catalog là read-heavy (hàng triệu request duyệt phim) → cần cache tối ưu, response nhanh. Tách ra: Recommendation consume ViewingHistory events → tính offline → lưu result → Catalog query result khi cần.

**Luồng Play:** Client → API Gateway → Auth Service (validate token) → Playback Service (lookup video metadata, chọn CDN node gần nhất, generate signed URL) → Client nhận URL → Client stream từ CDN (HLS/DASH, adaptive bitrate tự chọn chất lượng theo bandwidth). CDN node lỗi: Circuit Breaker detect failure → fallback sang CDN node khác hoặc origin server.

**Kết hợp nhiều mẫu:** Client-Server cho tất cả API (fundamental). Event-Driven cho analytics + recommendation (decouple, async). Pipe-and-Filter cho transcode + analytics pipeline (sequential processing). Broker (API Gateway) cho routing, auth, rate limiting. Anti-pattern tránh: (1) Distributed Monolith — service phụ thuộc chặt, deploy phải cùng lúc. (2) Architecture Astronaut — over-engineer cho tính năng chưa cần (ví dụ dùng event sourcing cho catalog đơn giản).

---

### Gợi ý Bài 18 — Saga Pattern

**Vì sao 2PC không phù hợp microservices:** (1) Performance: 2PC lock resource suốt quá trình → latency cao, throughput thấp. (2) Availability: coordinator fail → tất cả participant bị block. (3) Tight coupling: tất cả service phải hỗ trợ XA transaction, cùng transaction manager → phá vỡ nguyên tắc independent deployment. Saga: chuỗi local transaction, mỗi service commit riêng, nếu thất bại → chạy compensating action ngược lại.

**Saga Orchestration cho đặt vé:**
```
Orchestrator:
1. CreateBooking (Booking Service) → success →
2. ReserveSeat (Seat Service) → success →
3. ProcessPayment (Payment Service) → success →
4. ConfirmBooking (Booking Service) → success →
5. SendNotification (Notification Service)

Compensating actions:
- Nếu step 3 fail: CancelSeatReservation (Seat) → CancelBooking (Booking)
- Nếu step 2 fail: CancelBooking (Booking)
- Nếu step 4 fail: RefundPayment (Payment) → CancelSeatReservation (Seat) → CancelBooking (Booking)
```
Orchestrator điều phối tập trung, biết trạng thái toàn bộ saga.

**Saga Choreography:**
```
Booking Service: CreateBooking → publish BookingCreated
Seat Service: consume BookingCreated → ReserveSeat → publish SeatReserved
Payment Service: consume SeatReserved → ProcessPayment → publish PaymentProcessed
Booking Service: consume PaymentProcessed → ConfirmBooking → publish BookingConfirmed
Notification Service: consume BookingConfirmed → SendTicket

Compensation flow:
Payment fail → publish PaymentFailed
Seat Service: consume PaymentFailed → CancelReservation → publish SeatReservationCancelled
Booking Service: consume SeatReservationCancelled → CancelBooking
```
Không có điều phối trung tâm, mỗi service tự biết cần làm gì khi nhận event.

**So sánh:**

| Tiêu chí | Choreography | Orchestration |
|----------|-------------|---------------|
| Coupling | Thấp (mỗi service độc lập) | Trung bình (phụ thuộc orchestrator) |
| Complexity | Tăng theo số service (event flow khó theo dõi) | Tập trung (logic rõ ràng trong orchestrator) |
| Traceability | Khó debug (event phân tán) | Dễ (orchestrator có state machine) |
| Error handling | Phức tạp (mỗi service tự xử lý) | Dễ hơn (orchestrator quyết định compensate) |

**Đề xuất:** Orchestration cho đặt vé — vì luồng có nhiều bước, cần rollback rõ ràng, business-critical (tiền bạc). Orchestrator dễ debug, dễ thêm bước, dễ theo dõi trạng thái. Choreography phù hợp hơn cho luồng đơn giản (ví dụ 2–3 bước, không cần compensate phức tạp).

---

### Gợi ý Bài 19 — ADR cho HealthCare

**ADR là gì:** Architecture Decision Record — tài liệu ghi lại quyết định kiến trúc quan trọng: bối cảnh, lý do, phương án đã xem xét, quyết định cuối, hệ quả. Cần ADR vì: quyết định kiến trúc khó đảo ngược, cần ghi lại lý do để team mới hiểu, để review khi thay đổi yêu cầu.

**ADR Quyết định 1:**
```
# ADR-001: Kiến trúc tổng thể — Modular Monolith

## Status: Accepted

## Context:
- Team 12 người, 18 tháng phát triển.
- Hệ thống bệnh viện: đặt lịch, hồ sơ bệnh nhân, kê đơn, thanh toán BHYT.
- Cần strong consistency cho hồ sơ y tế (quy định Bộ Y tế).
- Team chưa có kinh nghiệm vận hành microservices (Kubernetes, distributed tracing).
- Cần deliver MVP trong 6 tháng đầu.

## Decision:
Chọn Modular Monolith — mỗi module (Appointment, Patient, Prescription, Billing)
là package riêng, giao tiếp qua internal API, deploy chung.

## Consequences:
Tích cực: deploy đơn giản, consistency dễ đảm bảo (shared DB, local transaction),
team quen thuộc, time-to-market nhanh.
Tiêu cực: không scale riêng module, deploy toàn bộ khi thay đổi 1 module.
Nếu sau 18 tháng cần scale → có thể tách module thành service (đã có boundary rõ).

## Alternatives:
- Microservices: quá phức tạp cho team hiện tại, chưa cần scale riêng.
- Pure Layered (không modular): khó tách sau này, coupling cao giữa modules.
```

**ADR Quyết định 2:**
```
# ADR-002: Giao tiếp giữa modules — Sync (internal call) + Async cho notification

## Status: Accepted

## Context:
Modular Monolith nên giao tiếp qua internal method call (nhanh, đơn giản).
Tuy nhiên: gửi kết quả xét nghiệm cho bệnh nhân (email/SMS) không cần đồng bộ,
nên dùng async để không block.

## Decision:
- Sync: xem hồ sơ bệnh nhân, đặt lịch, kê đơn (cần response ngay, consistency).
- Async (message queue nội bộ): gửi notification (email kết quả, SMS nhắc lịch),
 tạo báo cáo BHYT định kỳ.

## Consequences:
Tích cực: giữ đơn giản cho đa số tương tác. Async giúp notification không làm chậm.
Tiêu cực: cần setup message queue (RabbitMQ) cho async, thêm operational complexity nhẹ.
```

**Tầm quan trọng ADR:** Thành viên mới đọc ADR hiểu tại sao chọn Modular Monolith thay vì Microservices — không phải vì team "lười" mà vì cân nhắc kỹ. Khi cần thay đổi kiến trúc, đọc ADR hiểu context ban đầu → quyết định thay đổi có cơ sở. Khi audit: ADR chứng minh quyết định có lý do kỹ thuật.

**2 sai lầm phổ biến:** (1) Viết ADR quá chi tiết hoặc quá chung chung — cần vừa đủ context để người đọc hiểu mà không phải đọc 10 trang. (2) Không cập nhật ADR khi quyết định thay đổi — ADR cũ vẫn nằm đó với status "Accepted" nhưng thực tế đã thay đổi → gây nhầm lẫn. Cách tránh: đánh status "Superseded by ADR-XXX" khi thay đổi.

---

### Gợi ý Bài 20 — GoRide (hệ thống gọi xe)

**8 service chính:**

| Service | Mẫu bên trong | Giao tiếp | Database | Lý do |
|---------|---------------|-----------|----------|-------|
| User Service | Layered | Sync (REST) | PostgreSQL | CRUD user/driver, đơn giản |
| Ride Service | Hexagonal | Sync + Async | PostgreSQL | Logic phức tạp (state machine ride) |
| Matching Service | Event-Driven | Async (consume location) + Sync (response) | Redis (in-memory) | Real-time, tính toán nhanh |
| Location Service | Event-Driven | Async (consume GPS) | Redis + TimescaleDB | High throughput GPS data |
| Pricing Service | Hexagonal | Sync (REST) | PostgreSQL + Redis (cache) | Logic phức tạp (surge, promo) |
| Payment Service | Hexagonal + Circuit Breaker | Sync + Async | PostgreSQL | Tích hợp payment gateway |
| Notification Service | Event-Driven | Async | MongoDB | Push/SMS, fire-and-forget |
| Analytics/Reporting | Pipe-and-Filter | Async (consume events) | ClickHouse/BigQuery | Pipeline xử lý dữ liệu lớn |

**Sơ đồ tổng thể:** Client Apps (Rider, Driver) → API Gateway (Broker pattern, xử lý auth, routing, rate limiting) → Services. Event Bus (Kafka) kết nối: Location Service publish LocationUpdated → Matching Service consume. Ride Service publish RideCompleted → Payment, Analytics consume. Real-time: Driver App → MQTT/WebSocket → Location Service → Redis (latest position) → Matching Service. Analytics Pipeline: ride events → [Parse] → [Enrich] → [Aggregate] → [Store] → Pricing model input.

**Luồng đặt xe:**
1. Rider request ride (sync) → API Gateway → Ride Service: tạo RideRequest (pending).
2. Ride Service → Pricing Service (sync REST): tính giá (base + surge + promo).
3. Ride Service → Matching Service (sync): tìm tài xế gần nhất (query Redis location data, thuật toán GeoHash).
4. Matching Service → Driver App (async push): gửi offer.
5. Driver accept/reject (async): nếu reject → Matching retry tài xế tiếp theo (timeout 15s, retry tối đa 3 lần).
6. Driver accept → Ride Service update status "Matched" → publish RideMatched event → Notification consume → push cho Rider.
7. Ride started → Location Service tracking (async, mỗi 5s).
8. Ride completed → Ride Service publish RideCompleted → Payment consume (async, charge) → Rating Service consume.

**Mẫu bổ trợ:**
- **Sidecar:** Mỗi service pod có sidecar container cho: logging (Fluentd sidecar thu log → ELK), service mesh (Envoy sidecar xử lý TLS, load balancing, retry). Vẽ: [Ride Service Container] + [Envoy Sidecar] trong cùng pod, Envoy xử lý network traffic.
- **Circuit Breaker:** Payment Service → Payment Gateway (VNPay/Momo): threshold 5 lỗi trong 30s → Open (trả lỗi "Thanh toán tạm thời không khả dụng") → 60s sau Half-Open (thử 1 request) → thành công → Closed. Config: failureThreshold=5, timeout=60s, successThreshold=2.
- **Saga:** RideCompleted → Payment charge fail (insufficient balance): compensating = mark ride as "Payment Pending" → retry sau 1h → nếu vẫn fail → Notification cho rider "Thanh toán thất bại, vui lòng nạp tiền" → suspend account sau 3 ngày.

**3 trade-off lớn:**
1. **Consistency vs Availability** (matching): Driver location có thể outdated 5s → matching tài xế đã offline. Chấp nhận eventual consistency + timeout mechanism (driver không phản hồi → retry).
2. **Latency vs Accuracy** (pricing): Surge pricing cần dữ liệu demand/supply real-time → tính chính xác cần thời gian. Cân bằng: cache surge multiplier mỗi 30s thay vì tính mỗi request.
3. **Cost vs Reliability** (infrastructure): Multi-region deployment tốn gấp 2–3x chi phí. Cân bằng: active-passive per city, active-active cho core services (matching, payment).

---

*Hết.*
