# Trắc nghiệm (110 câu) — Phần III

Nguồn: `sach-Chuong3/99-TracNghiem-110Cau.md`.


(Từ cơ bản đến chuyên sâu, ưu tiên tình huống thực tế)

---

## Phần A — Kiến thức cơ bản (Câu 1–30)

**Câu 1.** Mẫu kiến trúc phần mềm (Architecture Pattern) là gì?
A. Một đoạn code mẫu có thể copy vào dự án
B. Một giải pháp tái sử dụng cho vấn đề phổ biến trong kiến trúc phần mềm
C. Một framework lập trình cụ thể
D. Một công cụ vẽ sơ đồ UML

**Câu 2.** Ai là người đầu tiên đưa ra ý tưởng "pattern" mà sau đó cộng đồng phần mềm tiếp nhận?
A. Martin Fowler
B. Gang of Four (GoF)
C. Christopher Alexander
D. Robert C. Martin

**Câu 3.** Kiến trúc phân tầng (Layered Architecture) thường gồm bao nhiêu lớp cơ bản?
A. 2 lớp
B. 3 lớp
C. 4 lớp
D. 5 lớp

**Câu 4.** Trong kiến trúc phân tầng, lớp nào chịu trách nhiệm xử lý logic nghiệp vụ?
A. Presentation Layer
B. Business Logic Layer
C. Data Access Layer
D. Database Layer

**Câu 5.** Nguyên tắc nào yêu cầu lớp trên chỉ giao tiếp với lớp ngay bên dưới, không "nhảy cóc"?
A. Separation of Concerns
B. Abstraction
C. Closed Layer
D. Open/Closed Principle

**Câu 6.** Trong kiến trúc Master-Slave, thành phần nào là SPOF (Single Point of Failure)?
A. Slave
B. Master
C. Client
D. Database

**Câu 7.** Kiến trúc Client-Server thuộc nhóm kiến trúc nào?
A. Tập trung (monolithic)
B. Phân tán (distributed)
C. Data-flow
D. Object-Oriented

**Câu 8.** Trong mô hình Client-Server, bên nào khởi tạo kết nối?
A. Server
B. Client
C. Cả hai đều có thể
D. Load Balancer

**Câu 9.** Đặc điểm nào KHÔNG phải của kiến trúc P2P?
A. Phi tập trung (decentralization)
B. Đối xứng vai trò (symmetry)
C. Có server trung tâm bắt buộc
D. Tự tổ chức (self-organizing)

**Câu 10.** Trong kiến trúc Broker, thành phần Broker đảm nhiệm vai trò chính nào?
A. Lưu trữ dữ liệu vĩnh viễn
B. Điều phối giao tiếp giữa các component phân tán
C. Xử lý logic nghiệp vụ
D. Hiển thị giao diện người dùng

**Câu 11.** MVC là viết tắt của cụm từ nào?
A. Model-View-Controller
B. Module-View-Component
C. Model-Validate-Create
D. Manager-View-Connector

**Câu 12.** Trong MVC, thành phần nào chịu trách nhiệm quản lý dữ liệu và logic nghiệp vụ?
A. View
B. Controller
C. Model
D. Router

**Câu 13.** Kiến trúc Event-Driven giao tiếp chủ yếu theo kiểu nào?
A. Đồng bộ (synchronous), request-response
B. Bất đồng bộ (asynchronous), qua events
C. Giao tiếp trực tiếp giữa hai component
D. Gọi hàm trong cùng process

**Câu 14.** Pipe-and-Filter là mẫu kiến trúc phù hợp nhất cho bài toán nào?
A. Xử lý dữ liệu qua nhiều bước biến đổi tuần tự
B. Giao diện người dùng phức tạp
C. Chat real-time
D. Chia sẻ file ngang hàng

**Câu 15.** Design Pattern khác Architecture Pattern ở điểm nào?
A. Design Pattern áp dụng cho toàn bộ hệ thống
B. Design Pattern áp dụng ở mức component/module, Architecture Pattern áp dụng cho toàn bộ hệ thống
C. Không có sự khác biệt
D. Architecture Pattern do developer quyết định, Design Pattern do kiến trúc sư quyết định

**Câu 16.** Singleton, Observer, Factory thuộc loại pattern nào?
A. Architecture Pattern
B. Design Pattern
C. Infrastructure Pattern
D. Deployment Pattern

**Câu 17.** SPOF (Single Point of Failure) nghĩa là gì?
A. Một điểm trong hệ thống mà nếu nó hỏng, toàn bộ hệ thống dừng hoạt động
B. Một phương pháp kiểm thử phần mềm
C. Một loại design pattern
D. Một kỹ thuật cân bằng tải

**Câu 18.** Trong kiến trúc phân tầng, Dependency Rule quy định chiều phụ thuộc như thế nào?
A. Lớp dưới phụ thuộc vào lớp trên
B. Các lớp phụ thuộc lẫn nhau
C. Lớp trên phụ thuộc vào lớp dưới, không ngược lại
D. Không có quy tắc phụ thuộc

**Câu 19.** Hexagonal Architecture còn có tên gọi nào khác?
A. Clean Architecture
B. Ports and Adapters
C. Onion Architecture
D. Microservices Architecture

**Câu 20.** Circuit Breaker Pattern có ba trạng thái chính. Trạng thái nào cho phép request đi qua bình thường?
A. Open
B. Half-Open
C. Closed
D. Locked

**Câu 21.** Saga Pattern giải quyết vấn đề gì trong microservices?
A. Cân bằng tải
B. Giao dịch phân tán (distributed transaction) giữa nhiều service
C. Logging tập trung
D. Service discovery

**Câu 22.** Sidecar Pattern tách các chức năng nào ra khỏi ứng dụng chính?
A. Business logic
B. Cross-cutting concerns (logging, monitoring, security, proxy)
C. Database operations
D. User interface rendering

**Câu 23.** ADR (Architecture Decision Record) gồm những mục chính nào?
A. Code, Test, Deploy, Monitor
B. Title, Status, Context, Decision, Consequences
C. Input, Process, Output, Feedback
D. Plan, Do, Check, Act

**Câu 24.** Eventual Consistency có nghĩa là gì?
A. Dữ liệu luôn nhất quán tức thì tại mọi thời điểm
B. Dữ liệu sẽ nhất quán sau một khoảng thời gian, không đảm bảo tức thì
C. Dữ liệu không bao giờ nhất quán
D. Chỉ có một bản sao dữ liệu duy nhất

**Câu 25.** Trong kiến trúc P2P, Hybrid P2P khác Pure P2P ở điểm nào?
A. Hybrid P2P không cho phép peer giao tiếp trực tiếp
B. Hybrid P2P có một server nhẹ hỗ trợ peer discovery và indexing
C. Pure P2P nhanh hơn Hybrid P2P
D. Hybrid P2P không có peer nào cả

**Câu 26.** Trong Broker, tính chất Location Transparency có nghĩa là gì?
A. Client biết chính xác IP và port của mọi service
B. Client không cần biết vị trí (IP, port) của service, chỉ cần biết tên dịch vụ
C. Service không cần đăng ký với Broker
D. Broker không lưu thông tin service

**Câu 27.** Mẫu kiến trúc nào sau đây thuộc nhóm kiến trúc tập trung (monolithic)?
A. Client-Server
B. P2P
C. Layered
D. Broker

**Câu 28.** Master trong kiến trúc Master-Slave thực hiện bước nào cuối cùng sau khi Slave hoàn thành?
A. Task Distribution
B. Parallel Processing
C. Result Aggregation
D. Service Registration

**Câu 29.** Event Sourcing lưu trữ dữ liệu theo cách nào?
A. Lưu trạng thái hiện tại (current state) trong một bảng duy nhất
B. Lưu chuỗi sự kiện (events) làm nguồn chân lý, tái tạo state bằng replay
C. Lưu snapshot định kỳ, xóa event cũ
D. Không lưu gì cả, tính toán mỗi lần cần

**Câu 30.** Clean Architecture do ai đề xuất?
A. Alistair Cockburn
B. Martin Fowler
C. Robert C. Martin (Uncle Bob)
D. Eric Evans

---

## Phần B — Hiểu và phân tích (Câu 31–60)

**Câu 31.** Ưu điểm nổi bật nhất của kiến trúc phân tầng là gì?
A. Hiệu năng cực cao
B. Tách biệt trách nhiệm rõ ràng, dễ bảo trì
C. Khả năng mở rộng ngang (horizontal scaling) vượt trội
D. Hỗ trợ real-time tốt nhất

**Câu 32.** Nhược điểm chính của kiến trúc phân tầng là gì?
A. Quá phức tạp để hiểu
B. Không thể test được
C. Performance overhead do request phải đi qua tất cả các lớp, khó scale ngang
D. Không thể sử dụng với database

**Câu 33.** Tại sao Broker có thể trở thành SPOF?
A. Vì Broker lưu trữ tất cả dữ liệu nghiệp vụ
B. Vì mọi giao tiếp đi qua Broker — nếu Broker hỏng, giao tiếp dừng
C. Vì Broker xử lý logic nghiệp vụ
D. Vì Broker không hỗ trợ clustering

**Câu 34.** Giải pháp nào giúp giảm thiểu SPOF của Broker?
A. Tăng RAM cho Broker
B. Thiết kế HA (High Availability) — chạy cluster nhiều node, failover tự động
C. Giảm số lượng service
D. Sử dụng static IP cho tất cả service

**Câu 35.** So sánh P2P và Client-Server: khi thêm nhiều người dùng, hệ thống nào có lợi thế hơn về bandwidth?
A. Client-Server — vì server mạnh hơn
B. P2P — vì mỗi peer mới đóng góp thêm tài nguyên (bandwidth, storage)
C. Cả hai giống nhau
D. Không thể so sánh

**Câu 36.** Tại sao P2P không phù hợp cho hệ thống cần SLA (Service Level Agreement) chặt chẽ?
A. Vì P2P quá nhanh
B. Vì P2P không đảm bảo uptime, thời gian phản hồi và chất lượng dịch vụ — phụ thuộc vào peer đang online
C. Vì P2P quá đắt
D. Vì P2P chỉ hoạt động trên LAN

**Câu 37.** Trong Event-Driven Architecture, Producer có cần biết Consumer là ai không?
A. Có, phải biết tất cả Consumer
B. Không, Producer chỉ publish event vào Event Bus, không biết ai nhận
C. Có, phải gửi trực tiếp cho từng Consumer
D. Tùy thuộc vào ngôn ngữ lập trình

**Câu 38.** CQRS (Command Query Responsibility Segregation) tách biệt điều gì?
A. Frontend và Backend
B. Đọc (Query) và Ghi (Command) thành hai model/service riêng biệt
C. Client và Server
D. Testing và Production

**Câu 39.** Compensating Transaction trong Saga Pattern là gì?
A. Giao dịch tự động commit
B. Giao dịch bù để hoàn tác các bước đã thực hiện khi một bước thất bại
C. Giao dịch song song
D. Giao dịch backup dữ liệu

**Câu 40.** Trong Circuit Breaker, khi trạng thái chuyển từ Closed sang Open, điều gì xảy ra?
A. Request tiếp tục được gửi bình thường
B. Request bị ngắt ngay, trả lỗi cho client mà không gọi service downstream
C. Hệ thống tự động restart
D. Service downstream tự sửa lỗi

**Câu 41.** Sidecar container trong Kubernetes chia sẻ gì với app container?
A. Không chia sẻ gì
B. Network namespace (cùng IP, localhost) và có thể chia sẻ volume
C. Chỉ chia sẻ CPU
D. Chỉ chia sẻ RAM

**Câu 42.** Trong Hexagonal Architecture, Inbound Port (Driving Port) có vai trò gì?
A. Định nghĩa cách Core gọi ra bên ngoài
B. Định nghĩa cách bên ngoài gọi vào Core
C. Lưu trữ dữ liệu
D. Kết nối database

**Câu 43.** Outbound Port (Driven Port) trong Hexagonal Architecture dùng để làm gì?
A. Nhận request từ client
B. Hiển thị giao diện
C. Định nghĩa interface để Core gọi ra bên ngoài (DB, email, API)
D. Tạo log file

**Câu 44.** Clean Architecture có quy tắc Dependency Rule. Quy tắc này nói gì?
A. Vòng ngoài phụ thuộc vào vòng trong, vòng trong không biết gì về vòng ngoài
B. Vòng trong phụ thuộc vào vòng ngoài
C. Tất cả các vòng phụ thuộc lẫn nhau
D. Không có quy tắc phụ thuộc

**Câu 45.** Khi nào KHÔNG nên dùng kiến trúc Broker?
A. Khi hệ thống có hàng trăm service cần decouple
B. Khi yêu cầu latency rất thấp (microsecond) hoặc hệ thống rất nhỏ, đơn giản
C. Khi cần location transparency
D. Khi cần load balancing

**Câu 46.** DHT (Distributed Hash Table) trong P2P giải quyết vấn đề gì?
A. Mã hóa dữ liệu
B. Tìm kiếm tài nguyên hiệu quả trong O(log N) bước thay vì flooding
C. Tăng tốc download
D. Xác thực người dùng

**Câu 47.** Trong kiến trúc Master-Slave, khi một Slave bị lỗi, Master sẽ làm gì?
A. Dừng toàn bộ hệ thống
B. Gán lại subtask cho Slave khác (retry) hoặc đánh dấu kết quả thiếu
C. Xóa dữ liệu của Slave đó
D. Tự động tạo Slave mới

**Câu 48.** Tại sao debugging trong hệ thống Event-Driven khó hơn request-response?
A. Vì code ít hơn
B. Vì luồng xử lý phân tán qua nhiều consumer, bất đồng bộ — cần correlation ID và distributed tracing
C. Vì không có log
D. Vì chỉ có một component

**Câu 49.** So sánh RabbitMQ và Apache Kafka: Kafka phù hợp hơn cho use case nào?
A. Task queue đơn giản với routing phức tạp
B. Event streaming với throughput cao, cần replay event và lưu bền vững
C. Gửi email đơn lẻ
D. Chat đơn giản giữa hai người

**Câu 50.** Trong ADR, mục "Consequences" nên ghi những gì?
A. Chỉ ghi ưu điểm
B. Ưu điểm, nhược điểm và rủi ro sau khi áp dụng quyết định
C. Chỉ ghi code
D. Chỉ ghi ngày tháng

**Câu 51.** Tại sao Hexagonal Architecture giúp tăng testability so với Layered?
A. Vì Hexagonal có ít code hơn
B. Vì domain không phụ thuộc vào infrastructure — có thể dùng adapter giả (InMemory) để test mà không cần DB thật
C. Vì Hexagonal không cần test
D. Vì Layered không thể test được

**Câu 52.** Kiến trúc nào sau đây có Fault Tolerance cao nhất theo bảng so sánh?
A. Layered
B. Client-Server
C. P2P
D. MVC

**Câu 53.** Pipe-and-Filter Architecture có đặc điểm nào?
A. Dữ liệu chảy qua chuỗi các bộ lọc (filter), mỗi filter thực hiện một phép biến đổi
B. Mọi component giao tiếp qua event bus
C. Có server trung tâm điều phối
D. Các node ngang hàng trao đổi trực tiếp

**Câu 54.** Coupling (độ ràng buộc) cao giữa các component gây ra vấn đề gì?
A. Tăng hiệu năng
B. Thay đổi một component có thể ảnh hưởng nhiều component khác, khó bảo trì và mở rộng
C. Giảm chi phí phát triển
D. Tăng bảo mật

**Câu 55.** Trong Saga Pattern, Choreography khác Orchestration ở điểm nào?
A. Choreography có một orchestrator trung tâm điều phối
B. Choreography không có orchestrator — các service tự phản ứng qua event; Orchestration có một coordinator trung tâm
C. Orchestration không cần message broker
D. Không có sự khác biệt

**Câu 56.** Scalability theo chiều ngang (horizontal scaling) có nghĩa là gì?
A. Nâng cấp CPU, RAM trên cùng một máy
B. Thêm nhiều máy/instance để chia sẻ tải
C. Tăng dung lượng ổ cứng
D. Giảm số lượng người dùng

**Câu 57.** Scalability theo chiều dọc (vertical scaling) có nghĩa là gì?
A. Thêm nhiều máy mới
B. Nâng cấp phần cứng (CPU, RAM, SSD) trên cùng một máy
C. Thêm tính năng phần mềm
D. Chia nhỏ database

**Câu 58.** Trong MVC, View có được truy cập trực tiếp vào Database không?
A. Có, View truy cập Database bất cứ lúc nào
B. Không, View chỉ hiển thị dữ liệu nhận từ Controller/Model
C. Có, nhưng chỉ khi cần đọc
D. Tùy framework

**Câu 59.** API Gateway trong kiến trúc microservices đóng vai trò gì?
A. Lưu trữ tất cả dữ liệu
B. Entry point duy nhất — auth, rate limiting, routing request tới các backend service
C. Chạy logic nghiệp vụ cho tất cả service
D. Thay thế database

**Câu 60.** Tại sao cần Distributed Tracing (Jaeger, Zipkin) trong hệ thống microservices?
A. Để gửi email thông báo
B. Để truy vết request xuyên suốt nhiều service, giúp debug và tìm bottleneck
C. Để thay thế log
D. Để tạo giao diện người dùng

---

## Phần C — Ứng dụng và so sánh (Câu 61–90)

**Câu 61.** Bạn đang thiết kế ứng dụng web CRUD đơn giản cho một phòng ban nhỏ (5 người dùng), team quen với Spring MVC. Mẫu kiến trúc nào phù hợp nhất?
A. Event-Driven với Kafka
B. P2P
C. Layered hoặc MVC
D. Microservices với Service Mesh

**Câu 62.** Hệ thống cần xử lý ảnh vệ tinh cỡ lớn: nhận ảnh → cắt thành nhiều mảnh → xử lý song song → ghép lại. Mẫu nào phù hợp?
A. MVC
B. Master-Slave
C. P2P
D. Layered

**Câu 63.** Ứng dụng cần chia sẻ file lớn giữa hàng nghìn người dùng, không muốn đầu tư server trung tâm mạnh. Nên dùng mẫu nào?
A. Layered
B. Master-Slave
C. P2P (kiểu BitTorrent)
D. Clean Architecture

**Câu 64.** Hệ thống e-commerce có Order Service, Payment Service, Inventory Service cần giao tiếp bất đồng bộ. Mẫu nào phù hợp?
A. Layered
B. Event-Driven với Message Broker
C. Pure P2P
D. Pipe-and-Filter

**Câu 65.** Dữ liệu log từ nhiều server cần đi qua các bước: thu thập → lọc → chuyển đổi định dạng → lưu trữ. Mẫu nào mô tả đúng nhất luồng này?
A. Client-Server
B. MVC
C. Pipe-and-Filter
D. P2P

**Câu 66.** Hệ thống có domain nghiệp vụ phức tạp (bảo hiểm, ngân hàng), cần domain không phụ thuộc vào database hay framework. Mẫu nào tốt nhất?
A. Layered truyền thống
B. Hexagonal hoặc Clean Architecture
C. Pipe-and-Filter
D. Master-Slave

**Câu 67.** Khi Payment Service trong microservices liên tục timeout, mẫu nào giúp tránh cascading failure?
A. Saga
B. Sidecar
C. Circuit Breaker
D. Pipe-and-Filter

**Câu 68.** Quy trình đặt tour du lịch: đặt khách sạn → đặt vé máy bay → thanh toán. Nếu thanh toán thất bại, cần hủy vé và phòng. Mẫu nào mô tả quy trình này?
A. Circuit Breaker
B. Saga (với compensating transactions)
C. Sidecar
D. MVC

**Câu 69.** Bạn muốn logging, monitoring, mTLS cho mọi service mà không sửa code nghiệp vụ. Mẫu nào phù hợp?
A. Saga
B. Circuit Breaker
C. Sidecar (ví dụ Envoy proxy trong Service Mesh)
D. Layered

**Câu 70.** So sánh Layered và Hexagonal Architecture: điểm khác biệt cốt lõi là gì?
A. Layered có nhiều lớp hơn
B. Hexagonal đặt domain ở trung tâm, không phụ thuộc infrastructure; Layered có domain phụ thuộc vào Data Access
C. Layered hiệu năng cao hơn
D. Hexagonal không thể dùng với Java

**Câu 71.** Trong Clean Architecture, vòng nào nằm ở trung tâm (innermost)?
A. Frameworks & Drivers
B. Interface Adapters
C. Use Cases
D. Entities (Domain)

**Câu 72.** Hệ thống cần cập nhật bảng xếp hạng real-time khi có giao dịch mới. Mẫu kiến trúc nào phù hợp nhất?
A. Layered
B. Event-Driven
C. Master-Slave
D. Pipe-and-Filter

**Câu 73.** Bạn ghi lại quyết định "Chọn Kafka thay vì RabbitMQ cho message bus" kèm lý do và hậu quả. Tài liệu này gọi là gì?
A. User Story
B. Architecture Decision Record (ADR)
C. Sprint Backlog
D. Test Plan

**Câu 74.** MySQL Replication (1 Master ghi, nhiều Slave đọc) là ứng dụng của mẫu kiến trúc nào?
A. P2P
B. Master-Slave
C. Broker
D. Event-Driven

**Câu 75.** Hadoop MapReduce: JobTracker chia job cho nhiều TaskTracker xử lý song song. Đây là ứng dụng của mẫu nào?
A. Client-Server
B. MVC
C. Master-Slave
D. P2P

**Câu 76.** BitTorrent dùng cơ chế gì để khuyến khích peer đóng góp và hạn chế free-riding?
A. Auction (đấu giá)
B. Tit-for-tat (ưu tiên upload cho peer cũng đang upload)
C. Pay-per-download
D. First-come-first-served

**Câu 77.** Khi nào nên cập nhật Status của ADR thành "Superseded"?
A. Khi quyết định vẫn đang áp dụng
B. Khi có một ADR mới thay thế quyết định cũ
C. Khi bắt đầu dự án
D. Khi team không đồng ý

**Câu 78.** Trong Pipe-and-Filter, nếu một Filter xử lý chậm, điều gì xảy ra?
A. Các Filter khác tự động bỏ qua Filter chậm
B. Toàn bộ pipeline bị chậm theo — bottleneck tại Filter chậm nhất
C. Hệ thống tự động scale Filter đó
D. Không ảnh hưởng gì

**Câu 79.** Hệ thống chat real-time giữa 2 người qua trình duyệt, không cần server trung gian cho media. Công nghệ nào phù hợp?
A. FTP
B. WebRTC (P2P)
C. SMTP
D. SOAP

**Câu 80.** Trong Event-Driven, Event Notification khác Event-Carried State Transfer ở điểm nào?
A. Event Notification mang toàn bộ dữ liệu; Event-Carried State Transfer chỉ mang ID
B. Event Notification chỉ thông báo kèm ID tối thiểu; Event-Carried State Transfer mang toàn bộ dữ liệu cần thiết
C. Không có sự khác biệt
D. Event-Carried State Transfer không dùng message broker

**Câu 81.** Khi cần replay event để audit trail hoặc recovery, kiến trúc nào phù hợp?
A. Layered truyền thống chỉ lưu current state
B. Event Sourcing — lưu chuỗi event làm source of truth, có thể replay
C. MVC
D. Master-Slave

**Câu 82.** CQRS thường kết hợp với mẫu nào để tối ưu read và write?
A. Layered Architecture
B. Event Sourcing
C. MVC
D. Pipe-and-Filter

**Câu 83.** Istio Service Mesh sử dụng mẫu nào để inject proxy vào mỗi pod?
A. Saga
B. Circuit Breaker
C. Sidecar (Envoy proxy)
D. Master-Slave

**Câu 84.** So sánh Choreography Saga và Orchestration Saga: trường hợp nào nên dùng Orchestration?
A. Khi chỉ có 2 service đơn giản
B. Khi có nhiều service với luồng nghiệp vụ phức tạp, cần kiểm soát tập trung và dễ theo dõi
C. Khi không cần compensating transaction
D. Khi không có message broker

**Câu 85.** Ứng dụng blockchain (Bitcoin) sử dụng mẫu kiến trúc nào?
A. Client-Server
B. Master-Slave
C. P2P (pure)
D. Layered

**Câu 86.** Ứng dụng compiler: source code → Lexer → Parser → Semantic Analyzer → Code Generator. Mẫu kiến trúc nào mô tả đúng nhất?
A. MVC
B. Pipe-and-Filter
C. Event-Driven
D. Broker

**Câu 87.** Hệ thống cần hỗ trợ nhiều loại database (PostgreSQL, MongoDB, InMemory cho test) mà không sửa domain. Điều này phù hợp với mẫu nào?
A. Layered truyền thống
B. Hexagonal — thay Secondary Adapter mà không đụng domain
C. Master-Slave
D. P2P

**Câu 88.** Khi nào KHÔNG nên dùng P2P?
A. Khi cần chia sẻ file lớn giữa nhiều người
B. Khi cần kiểm soát tập trung, SLA chặt, bảo mật dữ liệu nhạy cảm
C. Khi cần phi tập trung
D. Khi cần tiết kiệm chi phí server

**Câu 89.** Trong quy trình 5 bước lựa chọn mẫu kiến trúc (Chương 2), bước cuối cùng là gì?
A. Phân tích yêu cầu
B. Xác định tiêu chí ưu tiên
C. Đánh giá các mẫu
D. Tài liệu hóa quyết định (ADR)

**Câu 90.** Event-Driven Architecture có nhược điểm nào so với request-response truyền thống?
A. Không thể scale
B. Dữ liệu có thể chưa nhất quán ngay lập tức (eventual consistency), debugging phức tạp hơn
C. Không hỗ trợ async
D. Chỉ hoạt động trên một máy

---

## Phần D — Tình huống thực tế và chuyên sâu (Câu 91–110)

**Câu 91.** Bạn đang xây dựng hệ thống e-commerce với 10 triệu người dùng. Hệ thống gồm: Order, Payment, Inventory, Notification, Analytics. Cần async, decouple, real-time notification. Kiến trúc tổng thể nên kết hợp những mẫu nào?
A. Chỉ Layered cho toàn bộ hệ thống
B. Client-Server (API Gateway) + Event-Driven (Kafka) + từng service theo Hexagonal + Circuit Breaker cho fault tolerance
C. Chỉ P2P
D. Chỉ MVC

**Câu 92.** Netflix có hàng trăm microservices. Khi một service gọi service khác mà service đích bị chậm, Netflix dùng mẫu nào để tránh toàn bộ hệ thống bị sập (cascading failure)?
A. Layered Architecture
B. Circuit Breaker (Hystrix / Resilience4j)
C. P2P
D. Pipe-and-Filter

**Câu 93.** Uber cần cập nhật vị trí xe real-time cho hàng triệu tài xế và hành khách. Producer (vehicle gateway) gửi GPS → Kafka → Consumers (Map, Analytics, ETA). Đây là ứng dụng kết hợp của mẫu nào?
A. Layered + MVC
B. Event-Driven + Client-Server (API) + Master-Slave (xử lý song song)
C. P2P thuần túy
D. Pipe-and-Filter

**Câu 94.** Bạn đang chuyển đổi (migrate) hệ thống monolith sang microservices. Một nghiệp vụ "đặt hàng" trước đây dùng database transaction duy nhất, giờ trải qua 3 service riêng biệt (Order, Inventory, Payment), mỗi service có DB riêng. Bạn cần đảm bảo tính nhất quán. Mẫu nào giải quyết vấn đề này?
A. Dùng một database duy nhất cho cả 3 service
B. Saga Pattern (choreography hoặc orchestration) với compensating transactions
C. Circuit Breaker
D. Sidecar

**Câu 95.** Hệ thống ngân hàng cần lưu lại mọi thay đổi số dư tài khoản để audit. Thay vì chỉ lưu số dư hiện tại, hệ thống lưu chuỗi sự kiện: "Nạp 1M", "Rút 500K", "Chuyển 200K". Đây là ứng dụng của mẫu nào?
A. CQRS
B. Event Sourcing
C. Circuit Breaker
D. Master-Slave

**Câu 96.** Hệ thống thương mại điện tử cần tối ưu: nghiệp vụ ghi (đặt hàng, cập nhật) phức tạp, còn nghiệp vụ đọc (xem sản phẩm, tra cứu) cần nhanh. Bạn tách thành Write Model (command) và Read Model (query) riêng biệt. Đây là mẫu gì?
A. Event Sourcing
B. CQRS (Command Query Responsibility Segregation)
C. Saga
D. MVC

**Câu 97.** Công ty bạn có 50 microservices. Mỗi service cần logging, tracing, mTLS. Team không muốn thêm library vào từng service. Giải pháp kiến trúc nào phù hợp?
A. Thêm library logging vào mỗi service
B. Dùng Service Mesh (Istio) với Sidecar Pattern — Envoy proxy tự động xử lý
C. Viết một monolith mới
D. Dùng P2P giữa các service

**Câu 98.** Bạn thiết kế hệ thống IoT: 100.000 cảm biến gửi dữ liệu nhiệt độ mỗi giây. Dữ liệu cần xử lý real-time (cảnh báo khi quá ngưỡng) và lưu trữ cho analytics. Kết hợp mẫu nào?
A. Layered + MVC
B. Event-Driven (sensor → Kafka/MQTT → Consumer cảnh báo + Consumer lưu trữ)
C. P2P giữa các cảm biến
D. Chỉ Client-Server đồng bộ

**Câu 99.** Hệ thống video streaming kiểu Netflix: client xem video từ CDN, recommendations engine xử lý real-time, billing service tách biệt. Đây là ví dụ của kiến trúc nào?
A. Pure Layered
B. Hybrid — Client-Server (streaming), Event-Driven (recommendations, billing), từng service có thể Layered/Hexagonal bên trong
C. Pure P2P
D. Pipe-and-Filter

**Câu 100.** Team bạn tranh luận giữa Hexagonal và Clean Architecture cho domain nghiệp vụ phức tạp. Hexagonal nhấn mạnh Ports/Adapters, Clean nhấn mạnh vòng tròn 4 lớp (Entities, Use Cases, Adapters, Frameworks). Khi nào chọn Clean thay vì Hexagonal?
A. Khi domain rất đơn giản
B. Khi cần phân tách rõ ràng hơn giữa Entities và Use Cases, áp dụng Dependency Rule nghiêm ngặt theo 4 vòng tròn
C. Khi không cần test
D. Khi muốn phụ thuộc vào framework

**Câu 101.** Bạn phải thiết kế ADR cho quyết định "Dùng Kafka thay vì RabbitMQ". Mục Context nên ghi gì?
A. Code implementation chi tiết
B. Bối cảnh: hệ thống cần async giữa nhiều service, throughput ước tính 10K msg/s, cần replay events cho analytics
C. Chỉ ghi tên team
D. Chỉ ghi ngày quyết định

**Câu 102.** Hệ thống bán vé concert online: 500.000 người cùng truy cập trong 10 phút đầu mở bán. Yêu cầu: không bán trùng vé, response time < 2 giây. Bạn cần kết hợp những yếu tố kiến trúc nào?
A. Chỉ một server Layered duy nhất
B. Client-Server (load balanced) + Event-Driven (queue đặt vé async) + Circuit Breaker (bảo vệ khi quá tải) + CQRS (tách đọc/ghi)
C. P2P giữa các người mua
D. Chỉ MVC framework

**Câu 103.** Hệ thống giao hàng kiểu Grab: tài xế cập nhật vị trí liên tục, hệ thống cần matching tài xế–khách hàng real-time, thông báo cho cả hai bên. Tại sao Event-Driven phù hợp hơn request-response cho luồng này?
A. Vì Event-Driven chậm hơn
B. Vì Event-Driven cho phép xử lý async, real-time, nhiều consumer (map, ETA, notification) nhận cùng event mà producer không cần biết
C. Vì Event-Driven đơn giản hơn Layered
D. Vì Event-Driven không cần server

**Câu 104.** Hệ thống CI/CD pipeline: Code commit → Build → Test → Security Scan → Deploy. Mỗi bước nhận output của bước trước làm input. Mẫu nào mô tả đúng nhất?
A. MVC
B. Pipe-and-Filter
C. P2P
D. Saga

**Câu 105.** Bạn thiết kế hệ thống y tế lưu hồ sơ bệnh nhân. Dữ liệu cực kỳ nhạy cảm, cần kiểm soát truy cập chặt, audit trail mọi thay đổi. Kết hợp mẫu nào?
A. P2P (phi tập trung, dễ truy cập)
B. Hexagonal/Clean (domain bảo vệ business rules) + Event Sourcing (audit trail) + Client-Server (kiểm soát truy cập)
C. Chỉ Pipe-and-Filter
D. Chỉ Master-Slave

**Câu 106.** Hệ thống social media cần: News Feed cập nhật real-time, hàng triệu post mỗi ngày, nhiều service đọc feed. Bạn dùng Kafka để publish event "NewPost" cho các consumer (Feed Builder, Notification, Analytics). Consumer nào chậm sẽ ảnh hưởng consumer khác không?
A. Có, tất cả consumer phải chờ nhau
B. Không, mỗi consumer xử lý độc lập — consumer chậm không ảnh hưởng consumer khác (nhờ consumer group độc lập)
C. Chỉ khi dùng RabbitMQ
D. Không thể xác định

**Câu 107.** Bạn đang migrate monolith thành microservices. Giai đoạn đầu, một số module vẫn chạy trong monolith, một số đã tách thành service riêng. Kết nối qua API Gateway. Đây gọi là kiến trúc gì?
A. Pure Microservices
B. Strangler Fig Pattern / Hybrid Architecture
C. Pure Monolith
D. P2P

**Câu 108.** Hệ thống xử lý thanh toán: Payment Service → Fraud Detection → Bank API → Confirmation. Nếu Bank API chậm (timeout 30s), hàng nghìn request chờ, hệ thống nghẽn. Circuit Breaker chuyển sang trạng thái gì?
A. Closed — tiếp tục gửi request
B. Open — ngắt mạch, trả lỗi ngay cho client, không gọi Bank API
C. Half-Open — gửi tất cả request thử lại
D. Restart hệ thống

**Câu 109.** Trong DDD (Domain-Driven Design), Aggregate là gì và nó liên quan đến Hexagonal Architecture như thế nào?
A. Aggregate là một bảng database
B. Aggregate là tập hợp các entity liên quan được xử lý như một đơn vị nhất quán; trong Hexagonal, Aggregate nằm trong Domain layer ở Core
C. Aggregate là một loại API endpoint
D. Aggregate là message broker

**Câu 110.** Tổng hợp: Hệ thống fintech quy mô lớn cần: giao dịch phân tán giữa 8 service, audit trail mọi giao dịch, chịu lỗi khi service downstream chậm, logging/tracing thống nhất mà không sửa code nghiệp vụ, domain phức tạp cần tách biệt khỏi infrastructure. Bạn cần kết hợp TỐI THIỂU những mẫu nào?
A. Chỉ Layered
B. Saga (giao dịch phân tán) + Event Sourcing (audit trail) + Circuit Breaker (chịu lỗi) + Sidecar (logging/tracing) + Hexagonal (domain tách biệt)
C. Chỉ MVC + Client-Server
D. Chỉ P2P + Master-Slave

---

## Đáp án

Câu 1: B | Câu 2: C | Câu 3: C | Câu 4: B | Câu 5: C | Câu 6: B | Câu 7: B | Câu 8: B | Câu 9: C | Câu 10: B
Câu 11: A | Câu 12: C | Câu 13: B | Câu 14: A | Câu 15: B | Câu 16: B | Câu 17: A | Câu 18: C | Câu 19: B | Câu 20: C
Câu 21: B | Câu 22: B | Câu 23: B | Câu 24: B | Câu 25: B | Câu 26: B | Câu 27: C | Câu 28: C | Câu 29: B | Câu 30: C
Câu 31: B | Câu 32: C | Câu 33: B | Câu 34: B | Câu 35: B | Câu 36: B | Câu 37: B | Câu 38: B | Câu 39: B | Câu 40: B
Câu 41: B | Câu 42: B | Câu 43: C | Câu 44: A | Câu 45: B | Câu 46: B | Câu 47: B | Câu 48: B | Câu 49: B | Câu 50: B
Câu 51: B | Câu 52: C | Câu 53: A | Câu 54: B | Câu 55: B | Câu 56: B | Câu 57: B | Câu 58: B | Câu 59: B | Câu 60: B
Câu 61: C | Câu 62: B | Câu 63: C | Câu 64: B | Câu 65: C | Câu 66: B | Câu 67: C | Câu 68: B | Câu 69: C | Câu 70: B
Câu 71: D | Câu 72: B | Câu 73: B | Câu 74: B | Câu 75: C | Câu 76: B | Câu 77: B | Câu 78: B | Câu 79: B | Câu 80: B
Câu 81: B | Câu 82: B | Câu 83: C | Câu 84: B | Câu 85: C | Câu 86: B | Câu 87: B | Câu 88: B | Câu 89: D | Câu 90: B
Câu 91: B | Câu 92: B | Câu 93: B | Câu 94: B | Câu 95: B | Câu 96: B | Câu 97: B | Câu 98: B | Câu 99: B | Câu 100: B
Câu 101: B | Câu 102: B | Câu 103: B | Câu 104: B | Câu 105: B | Câu 106: B | Câu 107: B | Câu 108: B | Câu 109: B | Câu 110: B
