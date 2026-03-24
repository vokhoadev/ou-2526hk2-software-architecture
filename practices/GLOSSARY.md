# Từ điển Thuật ngữ Kiến trúc Phần mềm (Anh-Việt)

## Tổng quan

Từ điển song ngữ **Anh-Việt** bao gồm các thuật ngữ quan trọng trong lĩnh vực Kiến trúc Phần mềm, được phân loại theo chủ đề và cấp độ.

**Mục tiêu:**
- Chuẩn hóa thuật ngữ kỹ thuật
- Hỗ trợ đọc tài liệu tiếng Anh
- Sử dụng đúng thuật ngữ trong giao tiếp chuyên môn
- Chuẩn bị cho phỏng vấn và làm việc quốc tế

---

## Mục lục

1. [Thuật ngữ Cơ bản](#i-thuật-ngữ-cơ-bản)
2. [Kiến trúc & Patterns](#ii-kiến-trúc--patterns)
3. [Quality Attributes](#iii-quality-attributes)
4. [Distributed Systems](#iv-distributed-systems)
5. [Cloud & DevOps](#v-cloud--devops)
6. [Security](#vi-security)
7. [Data & Database](#vii-data--database)
8. [API & Integration](#viii-api--integration)
9. [Testing & Quality](#ix-testing--quality)
10. [Processes & Practices](#x-processes--practices)
11. [Acronyms](#xi-acronyms)

---

## I. Thuật ngữ Cơ bản

### A

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Abstraction** | Trừu tượng hóa | Ẩn đi chi tiết triển khai, chỉ hiển thị giao diện cần thiết |
| **Agile** | Phương pháp Agile | Phương pháp phát triển linh hoạt, lặp lại |
| **API (Application Programming Interface)** | Giao diện lập trình ứng dụng | Tập hợp các định nghĩa và giao thức cho phép các ứng dụng giao tiếp |
| **Architecture** | Kiến trúc | Cấu trúc tổng thể của hệ thống phần mềm |
| **Artifact** | Sản phẩm | Kết quả đầu ra của quá trình phát triển (code, tài liệu, bản build) |
| **Async/Asynchronous** | Bất đồng bộ | Xử lý không cần chờ đợi kết quả ngay lập tức |

### B

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Backend** | Phần phục vụ | Phần xử lý logic và dữ liệu phía máy chủ |
| **Batch Processing** | Xử lý theo lô | Xử lý nhóm dữ liệu cùng lúc, không real-time |
| **Best Practice** | Thực tiễn tốt nhất | Phương pháp được chứng minh hiệu quả |
| **Bottleneck** | Điểm nghẽn | Điểm giới hạn hiệu năng của hệ thống |
| **Build** | Bản dựng | Quá trình biên dịch và đóng gói phần mềm |
| **Business Logic** | Logic nghiệp vụ | Quy tắc và xử lý liên quan đến nghiệp vụ |

### C

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Cache** | Bộ nhớ đệm | Lưu trữ tạm thời để tăng tốc truy cập |
| **Capacity** | Dung lượng/Công suất | Khả năng xử lý tối đa của hệ thống |
| **Client** | Máy khách | Phần ứng dụng phía người dùng |
| **Cloud** | Điện toán đám mây | Dịch vụ tính toán qua internet |
| **Component** | Thành phần | Đơn vị phần mềm có chức năng riêng biệt |
| **Configuration** | Cấu hình | Thiết lập tham số cho hệ thống |
| **Constraint** | Ràng buộc | Giới hạn hoặc điều kiện phải tuân thủ |
| **Container** | Container | Đóng gói ứng dụng và dependencies |
| **Coupling** | Sự phụ thuộc | Mức độ liên kết giữa các thành phần |
| **Cohesion** | Sự gắn kết | Mức độ liên quan của các chức năng trong một thành phần |

### D

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Database** | Cơ sở dữ liệu | Hệ thống lưu trữ và quản lý dữ liệu |
| **Decoupling** | Tách rời | Giảm sự phụ thuộc giữa các thành phần |
| **Dependency** | Phụ thuộc | Thành phần hoặc thư viện mà code cần để hoạt động |
| **Deploy/Deployment** | Triển khai | Đưa phần mềm vào môi trường sản xuất |
| **Design** | Thiết kế | Quá trình lên kế hoạch cấu trúc hệ thống |
| **Domain** | Miền/Lĩnh vực | Phạm vi nghiệp vụ của hệ thống |

### E-F

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Endpoint** | Điểm cuối | URL hoặc địa chỉ để truy cập dịch vụ |
| **Environment** | Môi trường | Nơi phần mềm chạy (dev, staging, production) |
| **Error** | Lỗi | Vấn đề xảy ra trong quá trình thực thi |
| **Exception** | Ngoại lệ | Tình huống bất thường cần xử lý đặc biệt |
| **Fault** | Lỗi | Nguyên nhân gốc rễ của sự cố |
| **Feature** | Tính năng | Chức năng của phần mềm |
| **Framework** | Khung/Framework | Nền tảng cung cấp cấu trúc và công cụ phát triển |
| **Frontend** | Giao diện người dùng | Phần hiển thị và tương tác với người dùng |

### G-L

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Gateway** | Cổng | Điểm vào/ra của hệ thống |
| **High Availability (HA)** | Tính sẵn sàng cao | Khả năng hoạt động liên tục với downtime tối thiểu |
| **Infrastructure** | Hạ tầng | Các thành phần nền tảng (servers, network, storage) |
| **Integration** | Tích hợp | Kết nối các hệ thống khác nhau |
| **Interface** | Giao diện | Điểm tương tác giữa các thành phần |
| **Latency** | Độ trễ | Thời gian từ request đến response |
| **Layer** | Tầng/Lớp | Phân chia logic theo chức năng |
| **Load** | Tải | Khối lượng công việc hệ thống phải xử lý |
| **Log** | Nhật ký | Ghi lại hoạt động của hệ thống |

### M-P

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Middleware** | Phần mềm trung gian | Phần mềm kết nối các thành phần khác |
| **Migration** | Di chuyển | Chuyển dữ liệu hoặc hệ thống sang nền tảng mới |
| **Module** | Mô-đun | Đơn vị phần mềm độc lập |
| **Node** | Nút | Một thể hiện của server hoặc service |
| **Orchestration** | Điều phối | Quản lý tự động nhiều containers/services |
| **Pattern** | Mẫu | Giải pháp đã được chứng minh cho vấn đề phổ biến |
| **Performance** | Hiệu năng | Tốc độ và hiệu quả hoạt động |
| **Pipeline** | Đường ống | Chuỗi các bước xử lý tuần tự |
| **Platform** | Nền tảng | Hạ tầng và dịch vụ để chạy ứng dụng |
| **Protocol** | Giao thức | Quy tắc giao tiếp giữa các hệ thống |
| **Proxy** | Đại diện | Thành phần trung gian xử lý requests |

### R-S

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Redundancy** | Dự phòng | Có thêm components để đảm bảo khả dụng |
| **Refactoring** | Tái cấu trúc | Cải thiện code mà không thay đổi chức năng |
| **Release** | Phát hành | Đưa phiên bản mới đến người dùng |
| **Replica** | Bản sao | Copy của dữ liệu hoặc service |
| **Repository** | Kho lưu trữ | Nơi lưu code hoặc dữ liệu |
| **Requirement** | Yêu cầu | Điều kiện mà hệ thống phải đáp ứng |
| **Resource** | Tài nguyên | CPU, memory, storage, network |
| **Runtime** | Thời điểm chạy | Khi ứng dụng đang thực thi |
| **Scalability** | Khả năng mở rộng | Có thể tăng năng lực xử lý |
| **Server** | Máy chủ | Máy tính cung cấp dịch vụ |
| **Service** | Dịch vụ | Đơn vị chức năng cung cấp qua API |
| **Stack** | Ngăn xếp công nghệ | Tập hợp các công nghệ sử dụng |
| **Stateless** | Không trạng thái | Không lưu thông tin giữa các requests |
| **Stateful** | Có trạng thái | Lưu trữ thông tin giữa các requests |

### T-Z

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Throughput** | Thông lượng | Số lượng xử lý trong một đơn vị thời gian |
| **Timeout** | Hết thời gian | Giới hạn thời gian chờ |
| **Transaction** | Giao dịch | Đơn vị công việc có tính nguyên tử |
| **Trade-off** | Đánh đổi | Chọn một lợi ích và chấp nhận bất lợi khác |
| **Trigger** | Kích hoạt | Sự kiện bắt đầu một hành động |
| **Version** | Phiên bản | Đánh dấu các thay đổi của phần mềm |
| **Workload** | Khối lượng công việc | Lượng xử lý mà hệ thống phải thực hiện |

---

## II. Kiến trúc & Patterns

### Architecture Styles

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Clean Architecture** | Kiến trúc sạch | Kiến trúc tách biệt business logic khỏi frameworks |
| **Event-Driven Architecture (EDA)** | Kiến trúc hướng sự kiện | Giao tiếp qua events bất đồng bộ |
| **Hexagonal Architecture** | Kiến trúc lục giác | Ports and Adapters - tách core khỏi external |
| **Layered Architecture** | Kiến trúc phân tầng | Chia thành các layer có trách nhiệm riêng |
| **Microservices** | Dịch vụ siêu nhỏ | Chia nhỏ thành các services độc lập |
| **Monolith** | Nguyên khối | Một ứng dụng duy nhất chứa tất cả |
| **Serverless** | Không máy chủ | Chạy code mà không quản lý infrastructure |
| **Service-Oriented Architecture (SOA)** | Kiến trúc hướng dịch vụ | Các services độc lập giao tiếp qua messages |

### Design Patterns

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **API Gateway** | Cổng API | Điểm vào duy nhất cho tất cả clients |
| **Backend for Frontend (BFF)** | Backend cho Frontend | Backend riêng cho mỗi loại client |
| **Bulkhead** | Vách ngăn | Cô lập failures để không lan rộng |
| **Circuit Breaker** | Ngắt mạch | Ngắt kết nối khi downstream fail |
| **CQRS** | Tách Command và Query | Tách read model và write model |
| **Database per Service** | CSDL riêng mỗi service | Mỗi service có database riêng |
| **Event Sourcing** | Lưu trữ sự kiện | Lưu mọi thay đổi dưới dạng events |
| **Factory** | Nhà máy | Tạo objects mà không expose logic tạo |
| **Outbox Pattern** | Mẫu hộp thư đi | Đảm bảo gửi events sau khi commit |
| **Retry** | Thử lại | Tự động thử lại khi thất bại |
| **Saga** | Chuỗi giao dịch | Quản lý distributed transactions |
| **Sidecar** | Xe bên cạnh | Deploy helper process bên cạnh service |
| **Singleton** | Đơn thể | Chỉ một instance của class |
| **Strangler Fig** | Cây đa siết | Dần thay thế hệ thống cũ bằng mới |

### Architecture Concepts

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Bounded Context** | Ngữ cảnh giới hạn | Ranh giới logic của một domain |
| **Cross-cutting Concerns** | Mối quan tâm xuyên suốt | Chức năng ảnh hưởng nhiều components (logging, security) |
| **Domain-Driven Design (DDD)** | Thiết kế hướng miền | Thiết kế tập trung vào business domain |
| **Eventual Consistency** | Nhất quán cuối cùng | Dữ liệu sẽ nhất quán sau một khoảng thời gian |
| **Separation of Concerns** | Tách biệt mối quan tâm | Mỗi module chỉ lo một việc |
| **Single Responsibility** | Trách nhiệm đơn lẻ | Mỗi class/module chỉ có một lý do để thay đổi |

---

## III. Quality Attributes

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Availability** | Tính khả dụng | Hệ thống sẵn sàng phục vụ khi cần |
| **Compatibility** | Tính tương thích | Hoạt động được với các hệ thống khác |
| **Deployability** | Khả năng triển khai | Dễ dàng deploy và release |
| **Durability** | Độ bền | Dữ liệu không bị mất |
| **Elasticity** | Tính co giãn | Tự động scale theo nhu cầu |
| **Fault Tolerance** | Chịu lỗi | Tiếp tục hoạt động khi có lỗi |
| **Interoperability** | Khả năng tương tác | Làm việc được với các hệ thống khác |
| **Maintainability** | Khả năng bảo trì | Dễ sửa chữa và cập nhật |
| **Modifiability** | Khả năng sửa đổi | Dễ thêm/sửa tính năng |
| **Observability** | Khả năng quan sát | Hiểu được trạng thái hệ thống |
| **Performance** | Hiệu năng | Tốc độ và hiệu quả xử lý |
| **Portability** | Tính di động | Chạy được trên nhiều môi trường |
| **Recoverability** | Khả năng phục hồi | Khôi phục sau sự cố |
| **Reliability** | Độ tin cậy | Hoạt động đúng như mong đợi |
| **Resilience** | Khả năng phục hồi | Chịu được và phục hồi từ failures |
| **Reusability** | Khả năng tái sử dụng | Components có thể dùng lại |
| **Scalability** | Khả năng mở rộng | Xử lý được tải tăng lên |
| **Security** | Bảo mật | Bảo vệ khỏi truy cập trái phép |
| **Testability** | Khả năng kiểm thử | Dễ viết và chạy tests |
| **Usability** | Khả năng sử dụng | Dễ sử dụng cho end users |

---

## IV. Distributed Systems

### Core Concepts

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **CAP Theorem** | Định lý CAP | Chỉ đạt được 2/3: Consistency, Availability, Partition Tolerance |
| **Consensus** | Đồng thuận | Nhiều nodes đồng ý về một giá trị |
| **Consistency** | Tính nhất quán | Tất cả nodes thấy cùng dữ liệu |
| **Distributed System** | Hệ thống phân tán | Hệ thống chạy trên nhiều máy tính |
| **Distributed Transaction** | Giao dịch phân tán | Transaction span qua nhiều services |
| **Leader Election** | Bầu cử leader | Chọn một node làm leader |
| **Partition Tolerance** | Chịu phân vùng | Hoạt động khi mạng bị chia cắt |
| **Replication** | Sao chép | Copy dữ liệu sang nhiều nodes |
| **Sharding** | Phân mảnh | Chia dữ liệu thành nhiều phần |

### Messaging

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **At-least-once** | Ít nhất một lần | Đảm bảo gửi ít nhất một lần (có thể duplicate) |
| **At-most-once** | Nhiều nhất một lần | Không retry, có thể mất message |
| **Broker** | Trung gian | Quản lý message queue |
| **Consumer** | Người tiêu thụ | Nhận và xử lý messages |
| **Dead Letter Queue** | Hàng đợi thư chết | Queue chứa messages không xử lý được |
| **Exactly-once** | Đúng một lần | Đảm bảo xử lý đúng một lần |
| **Event** | Sự kiện | Thông báo về điều đã xảy ra |
| **Message** | Thông điệp | Dữ liệu truyền giữa các hệ thống |
| **Producer** | Người sản xuất | Gửi messages |
| **Publish/Subscribe** | Xuất bản/Đăng ký | Mô hình gửi nhận message theo topics |
| **Queue** | Hàng đợi | Lưu trữ messages theo thứ tự |
| **Topic** | Chủ đề | Kênh để publish/subscribe messages |

### Containers & Orchestration

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Container** | Container | Đóng gói ứng dụng và dependencies |
| **Container Image** | Ảnh container | Template để tạo container |
| **Deployment** | Triển khai | Cấu hình số lượng pods chạy |
| **Helm** | Helm | Package manager cho Kubernetes |
| **Kubernetes (K8s)** | Kubernetes | Nền tảng điều phối containers |
| **Namespace** | Không gian tên | Phân vùng logic trong cluster |
| **Node** | Nút | Một máy chạy trong cluster |
| **Pod** | Pod | Đơn vị nhỏ nhất trong Kubernetes |
| **Service** | Dịch vụ | Expose pods qua network |
| **Service Mesh** | Lưới dịch vụ | Layer quản lý giao tiếp giữa services |

---

## V. Cloud & DevOps

### Cloud Concepts

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Auto-scaling** | Tự động mở rộng | Tự động thêm/bớt resources theo tải |
| **Availability Zone (AZ)** | Vùng khả dụng | Data center độc lập trong một region |
| **CDN (Content Delivery Network)** | Mạng phân phối nội dung | Cache content gần người dùng |
| **Cloud-Native** | Ứng dụng đám mây gốc | Thiết kế cho cloud từ đầu |
| **Edge Computing** | Tính toán biên | Xử lý gần nguồn dữ liệu |
| **IaaS** | Hạ tầng dịch vụ | Infrastructure as a Service |
| **Multi-cloud** | Đa đám mây | Sử dụng nhiều cloud providers |
| **PaaS** | Nền tảng dịch vụ | Platform as a Service |
| **Region** | Vùng | Khu vực địa lý của cloud provider |
| **SaaS** | Phần mềm dịch vụ | Software as a Service |
| **VPC (Virtual Private Cloud)** | Đám mây riêng ảo | Mạng riêng trong cloud |

### DevOps

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Blue-Green Deployment** | Triển khai xanh-lục | 2 môi trường, chuyển đổi traffic |
| **Canary Deployment** | Triển khai canary | Release dần cho một % users |
| **CI/CD** | Tích hợp/Triển khai liên tục | Continuous Integration/Continuous Deployment |
| **Configuration Management** | Quản lý cấu hình | Quản lý settings và configs |
| **Feature Flag** | Cờ tính năng | Bật/tắt tính năng không cần deploy |
| **GitOps** | GitOps | Quản lý infrastructure qua Git |
| **Infrastructure as Code (IaC)** | Hạ tầng như code | Định nghĩa infrastructure bằng code |
| **Rolling Deployment** | Triển khai cuốn chiếu | Update từng instance một |

### SRE (Site Reliability Engineering)

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Alert** | Cảnh báo | Thông báo khi có vấn đề |
| **Chaos Engineering** | Kỹ thuật hỗn loạn | Gây lỗi có chủ đích để test resilience |
| **Dashboard** | Bảng điều khiển | Hiển thị metrics và trạng thái |
| **Error Budget** | Ngân sách lỗi | Cho phép lượng downtime nhất định |
| **Incident** | Sự cố | Vấn đề ảnh hưởng dịch vụ |
| **Mean Time Between Failures (MTBF)** | Thời gian trung bình giữa các lỗi | Thời gian hệ thống chạy trước khi fail |
| **Mean Time To Recovery (MTTR)** | Thời gian trung bình phục hồi | Thời gian khắc phục sự cố |
| **Metrics** | Chỉ số | Dữ liệu đo lường về hệ thống |
| **Monitoring** | Giám sát | Theo dõi trạng thái hệ thống |
| **On-call** | Trực chiến | Sẵn sàng xử lý sự cố |
| **Postmortem** | Phân tích sau sự cố | Review và học từ incidents |
| **Runbook** | Sổ tay vận hành | Hướng dẫn xử lý tình huống |
| **SLA (Service Level Agreement)** | Thỏa thuận mức dịch vụ | Cam kết về chất lượng dịch vụ |
| **SLI (Service Level Indicator)** | Chỉ số mức dịch vụ | Metric đo lường chất lượng |
| **SLO (Service Level Objective)** | Mục tiêu mức dịch vụ | Mục tiêu nội bộ cho SLI |
| **Tracing** | Theo dõi | Trace request qua nhiều services |

---

## VI. Security

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Access Control** | Kiểm soát truy cập | Quản lý quyền truy cập |
| **Authentication (AuthN)** | Xác thực | Xác minh danh tính |
| **Authorization (AuthZ)** | Ủy quyền | Xác định quyền truy cập |
| **Certificate** | Chứng chỉ | Chứng nhận danh tính digital |
| **Encryption** | Mã hóa | Chuyển dữ liệu thành dạng không đọc được |
| **Firewall** | Tường lửa | Lọc traffic mạng |
| **Hash** | Băm | Chuyển dữ liệu thành giá trị cố định |
| **IAM (Identity and Access Management)** | Quản lý danh tính và quyền | Quản lý users và permissions |
| **JWT (JSON Web Token)** | Token JWT | Token chứa thông tin xác thực |
| **MFA (Multi-Factor Authentication)** | Xác thực đa yếu tố | Nhiều bước xác thực |
| **mTLS** | TLS hai chiều | Cả client và server đều verify |
| **OAuth** | OAuth | Giao thức ủy quyền |
| **RBAC** | Kiểm soát theo vai trò | Role-Based Access Control |
| **Secret** | Bí mật | Thông tin nhạy cảm (passwords, keys) |
| **TLS/SSL** | Mã hóa truyền tải | Mã hóa dữ liệu khi truyền |
| **Token** | Token | Chuỗi đại diện cho quyền truy cập |
| **Vulnerability** | Lỗ hổng | Điểm yếu bảo mật |
| **Zero Trust** | Không tin tưởng | Verify mọi request, không tin mặc định |

---

## VII. Data & Database

### Database Types

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **Document Database** | CSDL tài liệu | Lưu trữ dạng JSON/BSON (MongoDB) |
| **Graph Database** | CSDL đồ thị | Tối ưu cho quan hệ phức tạp (Neo4j) |
| **In-memory Database** | CSDL trong bộ nhớ | Lưu trữ trong RAM (Redis) |
| **Key-Value Store** | Kho khóa-giá trị | Lưu theo cặp key-value (Redis, DynamoDB) |
| **NoSQL** | NoSQL | Không dùng SQL, schema linh hoạt |
| **Relational Database** | CSDL quan hệ | Dạng bảng với SQL (MySQL, PostgreSQL) |
| **Time-Series Database** | CSDL chuỗi thời gian | Tối ưu cho dữ liệu theo thời gian (InfluxDB) |
| **Wide-Column Store** | Kho cột rộng | Lưu theo column families (Cassandra) |

### Database Concepts

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **ACID** | ACID | Atomicity, Consistency, Isolation, Durability |
| **BASE** | BASE | Basically Available, Soft state, Eventually consistent |
| **Connection Pool** | Pool kết nối | Tái sử dụng database connections |
| **Index** | Chỉ mục | Tăng tốc tìm kiếm dữ liệu |
| **Migration** | Di chuyển | Thay đổi schema database |
| **N+1 Problem** | Vấn đề N+1 | Query không hiệu quả trong loops |
| **Normalization** | Chuẩn hóa | Tổ chức dữ liệu giảm redundancy |
| **ORM** | Ánh xạ đối tượng quan hệ | Object-Relational Mapping |
| **Partitioning** | Phân vùng | Chia bảng thành các phần nhỏ hơn |
| **Primary Key** | Khóa chính | Định danh duy nhất cho record |
| **Read Replica** | Bản sao đọc | Copy database cho read operations |
| **Schema** | Lược đồ | Cấu trúc của database |
| **Transaction** | Giao dịch | Nhóm operations có tính nguyên tử |

---

## VIII. API & Integration

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **API Contract** | Hợp đồng API | Định nghĩa interface của API |
| **API Versioning** | Phiên bản API | Quản lý các versions của API |
| **Backward Compatibility** | Tương thích ngược | Phiên bản mới hỗ trợ clients cũ |
| **Consumer** | Người sử dụng | Ứng dụng sử dụng API |
| **CORS** | Chia sẻ tài nguyên gốc chéo | Cross-Origin Resource Sharing |
| **gRPC** | gRPC | Framework RPC hiệu năng cao |
| **GraphQL** | GraphQL | Query language cho APIs |
| **Idempotency** | Tính lũy đẳng | Nhiều lần gọi cho cùng kết quả |
| **OpenAPI** | OpenAPI | Chuẩn mô tả REST APIs |
| **Pagination** | Phân trang | Chia kết quả thành nhiều pages |
| **Payload** | Tải trọng | Dữ liệu chính trong request/response |
| **Rate Limiting** | Giới hạn tốc độ | Hạn chế số requests |
| **REST** | REST | Representational State Transfer |
| **Webhook** | Webhook | HTTP callback khi có sự kiện |
| **WebSocket** | WebSocket | Giao tiếp hai chiều real-time |

---

## IX. Testing & Quality

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **A/B Testing** | Thử nghiệm A/B | So sánh hai phiên bản |
| **Code Coverage** | Độ phủ code | % code được test |
| **Contract Testing** | Kiểm thử hợp đồng | Test API contracts giữa services |
| **E2E Testing** | Kiểm thử đầu cuối | Test toàn bộ flow |
| **Integration Testing** | Kiểm thử tích hợp | Test nhiều components cùng nhau |
| **Load Testing** | Kiểm thử tải | Test với lượng traffic lớn |
| **Mock** | Giả lập | Thay thế dependencies trong testing |
| **Performance Testing** | Kiểm thử hiệu năng | Đo lường tốc độ và resources |
| **Regression Testing** | Kiểm thử hồi quy | Đảm bảo không break functionality cũ |
| **Smoke Testing** | Kiểm thử khói | Quick test các tính năng chính |
| **Stress Testing** | Kiểm thử áp lực | Test giới hạn của hệ thống |
| **Unit Testing** | Kiểm thử đơn vị | Test từng unit riêng lẻ |

---

## X. Processes & Practices

| English | Tiếng Việt | Định nghĩa |
|---------|------------|------------|
| **ADR (Architecture Decision Record)** | Bản ghi quyết định kiến trúc | Document các quyết định quan trọng |
| **Agile** | Phương pháp Agile | Phát triển linh hoạt, lặp lại |
| **Architecture Review** | Đánh giá kiến trúc | Review thiết kế kiến trúc |
| **ATAM** | Phương pháp ATAM | Architecture Tradeoff Analysis Method |
| **Code Review** | Đánh giá code | Review code của nhau |
| **DevOps** | DevOps | Kết hợp Development và Operations |
| **Documentation** | Tài liệu | Ghi chép về hệ thống |
| **DRY** | Không lặp lại | Don't Repeat Yourself |
| **KISS** | Đơn giản | Keep It Simple, Stupid |
| **Pair Programming** | Lập trình đôi | Hai người cùng code |
| **Proof of Concept (PoC)** | Bằng chứng khái niệm | Demo nhỏ để verify ý tưởng |
| **Retrospective** | Họp nhìn lại | Review và cải tiến process |
| **Scrum** | Scrum | Framework Agile phổ biến |
| **Sprint** | Chu kỳ | Khoảng thời gian phát triển (1-4 tuần) |
| **Technical Debt** | Nợ kỹ thuật | Chi phí ẩn do shortcuts |
| **YAGNI** | Không cần thiết | You Aren't Gonna Need It |

---

## XI. Acronyms

### Common Acronyms

| Acronym | Full Form | Tiếng Việt |
|---------|-----------|------------|
| **ACL** | Access Control List | Danh sách kiểm soát truy cập |
| **ACID** | Atomicity, Consistency, Isolation, Durability | Nguyên tử, Nhất quán, Cô lập, Bền vững |
| **API** | Application Programming Interface | Giao diện lập trình ứng dụng |
| **ARB** | Architecture Review Board | Hội đồng đánh giá kiến trúc |
| **AWS** | Amazon Web Services | Dịch vụ đám mây Amazon |
| **BASE** | Basically Available, Soft state, Eventually consistent | Khả dụng cơ bản, Trạng thái mềm, Nhất quán cuối cùng |
| **BFF** | Backend for Frontend | Backend cho Frontend |
| **CAP** | Consistency, Availability, Partition tolerance | Nhất quán, Khả dụng, Chịu phân vùng |
| **CDC** | Change Data Capture | Bắt thay đổi dữ liệu |
| **CDN** | Content Delivery Network | Mạng phân phối nội dung |
| **CI/CD** | Continuous Integration/Continuous Deployment | Tích hợp/Triển khai liên tục |
| **CLI** | Command Line Interface | Giao diện dòng lệnh |
| **CORS** | Cross-Origin Resource Sharing | Chia sẻ tài nguyên gốc chéo |
| **CQRS** | Command Query Responsibility Segregation | Tách trách nhiệm Command và Query |
| **CRUD** | Create, Read, Update, Delete | Tạo, Đọc, Cập nhật, Xóa |
| **DDD** | Domain-Driven Design | Thiết kế hướng miền |
| **DLQ** | Dead Letter Queue | Hàng đợi thư chết |
| **DNS** | Domain Name System | Hệ thống tên miền |
| **EDA** | Event-Driven Architecture | Kiến trúc hướng sự kiện |
| **ELK** | Elasticsearch, Logstash, Kibana | Stack ELK |
| **GDPR** | General Data Protection Regulation | Quy định bảo vệ dữ liệu chung (EU) |
| **gRPC** | gRPC Remote Procedure Call | Gọi thủ tục từ xa gRPC |
| **HA** | High Availability | Tính sẵn sàng cao |
| **HTTP** | Hypertext Transfer Protocol | Giao thức truyền siêu văn bản |
| **IaC** | Infrastructure as Code | Hạ tầng như code |
| **IAM** | Identity and Access Management | Quản lý danh tính và quyền |
| **IDE** | Integrated Development Environment | Môi trường phát triển tích hợp |
| **JWT** | JSON Web Token | Token web JSON |
| **K8s** | Kubernetes | Kubernetes |
| **LB** | Load Balancer | Cân bằng tải |
| **MFA** | Multi-Factor Authentication | Xác thực đa yếu tố |
| **MTBF** | Mean Time Between Failures | Thời gian trung bình giữa các lỗi |
| **MTTR** | Mean Time To Recovery | Thời gian trung bình phục hồi |
| **MVP** | Minimum Viable Product | Sản phẩm khả thi tối thiểu |
| **OAuth** | Open Authorization | Ủy quyền mở |
| **ORM** | Object-Relational Mapping | Ánh xạ đối tượng quan hệ |
| **PII** | Personally Identifiable Information | Thông tin định danh cá nhân |
| **POC** | Proof of Concept | Bằng chứng khái niệm |
| **QA** | Quality Assurance | Đảm bảo chất lượng |
| **QAS** | Quality Attribute Scenario | Kịch bản thuộc tính chất lượng |
| **RBAC** | Role-Based Access Control | Kiểm soát truy cập theo vai trò |
| **REST** | Representational State Transfer | Chuyển trạng thái đại diện |
| **RPO** | Recovery Point Objective | Mục tiêu điểm phục hồi |
| **RTO** | Recovery Time Objective | Mục tiêu thời gian phục hồi |
| **SDK** | Software Development Kit | Bộ công cụ phát triển phần mềm |
| **SLA** | Service Level Agreement | Thỏa thuận mức dịch vụ |
| **SLI** | Service Level Indicator | Chỉ số mức dịch vụ |
| **SLO** | Service Level Objective | Mục tiêu mức dịch vụ |
| **SOA** | Service-Oriented Architecture | Kiến trúc hướng dịch vụ |
| **SOLID** | Single responsibility, Open-closed, Liskov, Interface segregation, Dependency inversion | Nguyên tắc SOLID |
| **SQL** | Structured Query Language | Ngôn ngữ truy vấn có cấu trúc |
| **SRE** | Site Reliability Engineering | Kỹ thuật độ tin cậy site |
| **SSO** | Single Sign-On | Đăng nhập một lần |
| **TDD** | Test-Driven Development | Phát triển hướng kiểm thử |
| **TLS** | Transport Layer Security | Bảo mật tầng vận chuyển |
| **TTL** | Time To Live | Thời gian sống |
| **UI** | User Interface | Giao diện người dùng |
| **UX** | User Experience | Trải nghiệm người dùng |
| **VM** | Virtual Machine | Máy ảo |
| **VPC** | Virtual Private Cloud | Đám mây riêng ảo |

---

## XII. Quick Reference

### Architecture Decision Vocabulary

```
When making decisions, use these terms:

PROS: Advantages, Benefits, Strengths
CONS: Disadvantages, Drawbacks, Weaknesses
TRADE-OFF: We chose X and accepted Y
RATIONALE: The reason for the decision
ALTERNATIVE: Other options considered
RISK: Potential problems
MITIGATION: How to address risks
ASSUMPTION: What we're taking for granted
CONSTRAINT: Limitations we must work within
```

### Common Phrases

| English | Tiếng Việt |
|---------|------------|
| "This approach scales well" | "Cách tiếp cận này mở rộng tốt" |
| "We need to consider trade-offs" | "Chúng ta cần xem xét các đánh đổi" |
| "Let's discuss the architecture" | "Hãy thảo luận về kiến trúc" |
| "What are the quality requirements?" | "Các yêu cầu chất lượng là gì?" |
| "How does this handle failures?" | "Hệ thống này xử lý lỗi như thế nào?" |
| "What's the latency requirement?" | "Yêu cầu về độ trễ là gì?" |
| "Can this scale horizontally?" | "Hệ thống này có thể scale ngang không?" |
| "What's the deployment strategy?" | "Chiến lược triển khai là gì?" |
| "Let's document this decision" | "Hãy ghi lại quyết định này" |

---

**Nắm vững thuật ngữ - Giao tiếp chuyên nghiệp! **

---

*Cập nhật: Tháng 01/2026*
