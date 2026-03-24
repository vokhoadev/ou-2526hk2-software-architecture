# Bảng chú giải thuật ngữ (Glossary) — hợp nhất

Phần I không có file glossary riêng; thuật ngữ được mở nghĩa trong từng chương.

## Phần II — Kiến trúc phân tán


**ACID** — Bốn tính chất giao dịch cơ sở dữ liệu: Atomicity (nguyên tử), Consistency (nhất quán), Isolation (cách ly), Durability (bền vững).

**AMQP (Advanced Message Queuing Protocol)** — Giao thức chuẩn cho message-oriented middleware; RabbitMQ là triển khai phổ biến nhất.

**API Gateway** — Thành phần đóng vai trò cổng vào duy nhất cho hệ thống microservices, xử lý routing, authentication, rate limiting, load balancing.

**Availability** — Khả năng hệ thống sẵn sàng phục vụ request tại bất kỳ thời điểm nào; thường đo bằng phần trăm uptime (99.9%, 99.99%).

**Bounded Context** — Khái niệm trong Domain-Driven Design: phạm vi mà một model (mô hình) cụ thể có ý nghĩa; thường ánh xạ 1:1 với một microservice.

**CAP Theorem** — Định lý phát biểu rằng hệ thống phân tán chỉ đảm bảo tối đa hai trong ba: Consistency, Availability, Partition Tolerance. Trong thực tế, P là bắt buộc nên chọn giữa CP và AP.

**CDN (Content Delivery Network)** — Mạng phân phối nội dung: đặt bản sao dữ liệu tĩnh (hình ảnh, video, CSS) tại nhiều edge location gần người dùng để giảm latency.

**Circuit Breaker** — Mẫu ngắt kết nối tới service lỗi sau một ngưỡng thất bại liên tục; tránh cascading failure. Ba trạng thái: Closed (bình thường), Open (ngắt), Half-Open (thử lại).

**Compensating Transaction** — Giao dịch bù trừ: trong Saga pattern, khi một bước thất bại, các bước trước được hoàn tác bằng compensating transaction.

**Connection Pooling** — Tái sử dụng kết nối database thay vì mở/đóng cho mỗi request; giảm overhead đáng kể.

**Conway's Law** — "Tổ chức nào thiết kế hệ thống sẽ tạo ra bản sao của cấu trúc giao tiếp của tổ chức đó." Áp dụng: cấu trúc team ảnh hưởng đến cấu trúc microservice.

**CORBA (Common Object Request Broker Architecture)** — ORB middleware thập niên 1990; hiện tại không còn khuyến nghị, được thay thế bởi gRPC.

**Distributed System** — Hệ thống gồm nhiều máy tính độc lập phối hợp qua mạng, xuất hiện với người dùng như một hệ thống thống nhất.

**Eventual Consistency** — Mô hình nhất quán phân tán: dữ liệu sẽ hội tụ về trạng thái nhất quán sau một khoảng thời gian, không đảm bảo ngay lập tức.

**Fallacies of Distributed Computing** — Tám giả định sai phổ biến khi thiết kế hệ thống phân tán (Peter Deutsch, 1994): mạng đáng tin cậy, latency bằng không, v.v.

**gRPC** — Framework RPC hiệu năng cao của Google; dùng Protocol Buffers (nhị phân), HTTP/2, hỗ trợ streaming và đa ngôn ngữ.

**GraphQL** — Ngôn ngữ truy vấn API (Facebook, 2015); client yêu cầu chính xác dữ liệu cần qua một endpoint duy nhất.

**Horizontal Scaling** — Mở rộng bằng cách thêm node/instance mới (scale out), đối lập với vertical scaling (tăng capacity một máy).

**Idempotency** — Tính chất: thực hiện cùng thao tác nhiều lần cho cùng kết quả; quan trọng khi retry network call.

**Latency** — Thời gian từ khi gửi request đến khi nhận response; network latency là thách thức lớn nhất của hệ thống phân tán.

**Load Balancer** — Thành phần phân phối request đến nhiều instance/server để tránh quá tải; chiến lược: round-robin, least connections, weighted.

**Message Broker** — Thành phần trung gian nhận, lưu trữ và chuyển tiếp message giữa producer và consumer (RabbitMQ, Kafka).

**Microservices** — Phong cách kiến trúc: ứng dụng gồm nhiều service nhỏ, độc lập, triển khai riêng biệt, mô hình hóa quanh business domain.

**Middleware** — Lớp phần mềm giữa ứng dụng và hệ điều hành, cung cấp dịch vụ chung (giao tiếp, bảo mật, transaction) cho ứng dụng phân tán.

**Monolithic** — Kiến trúc "một khối": toàn bộ ứng dụng chạy trong một process / một bản triển khai.

**mTLS (Mutual TLS)** — Xác thực hai chiều giữa client và server bằng chứng chỉ TLS; phổ biến trong service mesh.

**Network Partition** — Phân mảnh mạng: một số node không thể giao tiếp với nhau do lỗi mạng; là "P" trong định lý CAP.

**ORM (Object-Relational Mapping)** — Ánh xạ đối tượng trong code sang bảng database; developer thao tác đối tượng thay vì viết SQL.

**Partition Tolerance** — Khả năng hệ thống tiếp tục hoạt động khi mạng bị phân mảnh; bắt buộc cho hệ thống phân tán thực sự.

**Polyglot Persistence** — Mỗi microservice dùng loại database phù hợp nhất (SQL, NoSQL, graph, search engine…).

**Protocol Buffers** — Định dạng tuần tự hóa nhị phân của Google; nhỏ gọn, nhanh hơn JSON/XML, type-safe.

**REST (Representational State Transfer)** — Phong cách kiến trúc API (Fielding, 2000): thao tác trên resource qua HTTP verbs (GET, POST, PUT, DELETE).

**Saga Pattern** — Quản lý giao dịch phân tán bằng chuỗi giao dịch cục bộ + compensating transaction khi lỗi; thay thế 2PC trong microservices.

**Scalability** — Khả năng mở rộng hệ thống (thêm tài nguyên, tăng tải) mà vẫn đáp ứng yêu cầu; horizontal vs. vertical.

**Service Discovery** — Cơ chế tự động tìm vị trí (IP, port) của service trong hệ thống phân tán; client-side (Eureka) hoặc server-side (load balancer).

**Service Mesh** — Lớp hạ tầng quản lý giao tiếp service-to-service qua sidecar proxy; tự động xử lý mTLS, load balancing, circuit breaker, observability. Ví dụ: Istio, Linkerd.

**Sidecar** — Container/process chạy cạnh ứng dụng chính, xử lý cross-cutting concern (logging, proxy, security) mà không thay đổi code ứng dụng.

**SOAP (Simple Object Access Protocol)** — Giao thức web service dựa trên XML; hỗ trợ WS-Security, WS-Transaction; phù hợp cho enterprise nhưng nặng.

**SPOF (Single Point of Failure)** — Điểm đơn lỗi: thành phần mà khi hỏng sẽ làm toàn bộ hệ thống hoặc luồng dừng.

**Strong Consistency** — Mô hình nhất quán: đọc luôn nhận giá trị mới nhất đã ghi; đảm bảo ACID nhưng latency cao hơn.

**Throughput** — Số đơn vị xử lý được trong khoảng thời gian (request/giây, message/giây).

**Transparency** — Trong hệ thống phân tán: khả năng che giấu sự phức tạp phân tán (location, failure, replication…) khỏi người dùng và ứng dụng.

**Two-Phase Commit (2PC)** — Giao thức giao dịch phân tán: Phase 1 (Prepare — hỏi tất cả resource sẵn sàng?), Phase 2 (Commit hoặc Abort). Đảm bảo ACID nhưng chậm và coordinator là SPOF.

**Vertical Scaling** — Mở rộng bằng cách tăng capacity (CPU, RAM) của một máy duy nhất (scale up).

**WSDL (Web Services Description Language)** — Ngôn ngữ mô tả interface của SOAP web service; định nghĩa operation, message, binding.

---
*Có thể bổ sung thêm thuật ngữ theo nội dung mở rộng.*

---

## Phần III — Các mẫu kiến trúc


**2-Tier / 3-Tier** — Cách chia hệ thống Client-Server: 2-tier = Client (giao diện + logic) + Server (dữ liệu); 3-tier = Client + Máy chủ ứng dụng (logic) + Máy chủ cơ sở dữ liệu.

**ACID** — Bốn tính chất giao dịch cơ sở dữ liệu: Atomicity (toàn vẹn từng bước), Consistency (dữ liệu nhất quán), Isolation (cách ly), Durability (lưu vĩnh viễn).

**API (Application Programming Interface)** — Giao diện lập trình: cách một phần mềm “gọi” phần mềm khác (hoặc dịch vụ) qua các hàm/lệnh chuẩn.

**ADR (Architecture Decision Record)** — Tài liệu ghi lại một quyết định kiến trúc, gồm Context, Decision, Consequences.

**Architecture Pattern** — Giải pháp tái sử dụng cho bài toán kiến trúc ở mức tổng thể hệ thống; ví dụ Layered, Client-Server.

**Broker** — Thành phần trung gian điều phối giao tiếp giữa các component; ví dụ message queue, API gateway.

**Circuit Breaker** — Mẫu ngắt kết nối tới service lỗi sau một ngưỡng thất bại để tránh cascading failure.

**Client-Server** — Mẫu kiến trúc phân chia Client (yêu cầu dịch vụ) và Server (cung cấp dịch vụ), giao tiếp request-response.

**Clean Architecture** — Kiến trúc vòng tròn (Uncle Bob), dependency hướng vào trong; Entities, Use Cases, Adapters, Frameworks.

**Coupling (sự ràng buộc)** — Mức độ phụ thuộc lẫn nhau giữa các phần; coupling cao = sửa một chỗ dễ ảnh hưởng chỗ khác.

**CQRS (Command Query Responsibility Segregation)** — Tách luồng ghi (Command) và luồng đọc (Query), thường kết hợp Event Sourcing.

**CRUD** — Bốn thao tác cơ bản với dữ liệu: Create (tạo), Read (đọc), Update (cập nhật), Delete (xóa).

**Design Pattern** — Giải pháp tái sử dụng ở mức component/module; ví dụ Singleton, Observer, Factory.

**DHT (Distributed Hash Table)** — Bảng băm phân tán: cơ chế tìm kiếm tài nguyên trong mạng P2P mà không cần server trung tâm.

**Event-Driven Architecture (EDA)** — Kiến trúc giao tiếp qua events; producer phát event, consumer subscribe và xử lý; async, loosely coupled.

**Event Sourcing** — Lưu trữ chuỗi events làm nguồn chân lý; state được tái tạo bằng replay events.

**Eventual Consistency** — Mô hình nhất quán phân tán: sau một khoảng thời gian hệ thống hội tụ về trạng thái nhất quán, không đảm bảo ngay lập tức.

**Hexagonal Architecture** — Kiến trúc Ports and Adapters; domain ở trung tâm, giao tiếp với bên ngoài qua ports (interfaces) và adapters (implementation).

**JWT (JSON Web Token)** — Chuẩn token dùng để xác thực người dùng (ví dụ sau khi đăng nhập), máy chủ không cần lưu session.

**Latency (độ trễ)** — Thời gian từ khi gửi yêu cầu đến khi nhận phản hồi (ví dụ vài millisecond đến vài giây).

**Layered Architecture** — Kiến trúc phân tầng; mỗi lớp cung cấp dịch vụ cho lớp trên và dùng dịch vụ lớp dưới.

**Load balancer** — Thành phần phân phối lưu lượng (request) sang nhiều máy chủ để tránh quá tải một máy.

**Master-Slave** — Mẫu một node Master điều phối và nhiều node Slave thực hiện công việc; thường dùng cho replication, MapReduce.

**Mock** — Đối tượng giả lập dùng khi kiểm thử: thay thế thành phần thật (ví dụ database) bằng bản “giả” trả dữ liệu cố định.

**Monolithic** — Kiến trúc “một khối”: toàn bộ ứng dụng chạy trong một process/một bản triển khai, khác với microservices (nhiều service nhỏ).

**MVC (Model-View-Controller)** — Mẫu tách Model (dữ liệu và logic), View (hiển thị), Controller (điều phối input và gọi Model/View).

**ORM (Object-Relational Mapping)** — Công cụ ánh xạ đối tượng trong code sang bảng cơ sở dữ liệu; developer gọi hàm thay vì viết SQL trực tiếp.

**P2P (Peer-to-Peer)** — Mạng phân tán trong đó các node vai trò ngang nhau, vừa client vừa server, không node trung tâm.

**Pipe-and-Filter** — Kiến trúc luồng dữ liệu qua chuỗi filter nối bởi pipe; mỗi filter transform dữ liệu.

**Port (Hexagonal)** — Interface định nghĩa cách giao tiếp: Inbound (driving) hoặc Outbound (driven).

**Request-Response** — Mô hình giao tiếp: bên A gửi yêu cầu (request), bên B xử lý và gửi trả lời (response).

**Saga** — Mẫu quản lý giao dịch phân tán bằng chuỗi bước và compensating transactions khi lỗi.

**Scalability** — Khả năng mở rộng hệ thống (thêm tài nguyên, tăng tải) mà vẫn đáp ứng yêu cầu.

**Sidecar** — Process/container chạy cạnh ứng dụng chính để đảm nhiệm cross-cutting (logging, proxy, security).

**SLA (Service Level Agreement)** — Thỏa thuận mức dịch vụ (ví dụ 99.9% thời gian hoạt động, phản hồi dưới 200 ms).

**SPOF (Single Point of Failure)** — Điểm đơn lỗi: thành phần mà khi hỏng sẽ làm toàn bộ hệ thống hoặc luồng dừng.

**Throughput (thông lượng)** — Số đơn vị xử lý được trong một khoảng thời gian (ví dụ số request/giây).

**Trade-off** — Sự đánh đổi giữa các tiêu chí (ví dụ đơn giản vs khả năng mở rộng, consistency vs availability).

**Transaction (giao dịch)** — Một chuỗi thao tác được xử lý “cùng thành công hoặc cùng hủy” để đảm bảo tính nhất quán dữ liệu.

---
*Có thể bổ sung thêm thuật ngữ theo từ khóa trong Index.*
