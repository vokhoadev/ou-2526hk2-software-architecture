# Lab 4.1: Quality Attribute Scenarios

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu trước** | Hoàn thành Lab 1.1 (Architectural Drivers), Lab 1.3 (Documenting Architecture) |
| **Công cụ cần thiết** | Text editor, diagramming tool (draw.io / Mermaid), spreadsheet |
| **Hệ thống mẫu** | E-Commerce Platform |
| **Tài liệu tham khảo chính** | Bass, Clements, Kazman – *Software Architecture in Practice*, Ch. 4-7 |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Phân loại** các quality attributes theo chuẩn ISO/IEC 25010 và giải thích vai trò của chúng trong thiết kế kiến trúc phần mềm
2. **Viết** quality attribute scenarios đầy đủ 6 thành phần (stimulus source, stimulus, artifact, environment, response, response measure) với các chỉ số đo lường cụ thể
3. **Xây dựng** utility tree để tổ chức và phân cấp các scenarios theo quality attribute và mức độ ưu tiên (H/M/L)
4. **Ánh xạ** (map) scenarios tới các architectural tactics và quyết định thiết kế tương ứng
5. **Điều phối** (facilitate) một buổi scenario workshop để thu thập và validate scenarios với stakeholders

---

## Phân bổ Thời gian

| Giai đoạn | Nội dung | Thời lượng | Ghi chú |
|-----------|----------|------------|---------|
| **Lý thuyết** | Quality attributes (ISO 25010), cấu trúc scenario 6 phần, utility tree, scenario prioritization | 40 phút | Lecture + discussion |
| **Lab 1** | Identify & classify quality attributes cho e-commerce system | 25 phút | Individual work |
| **Lab 2** | Viết 10 quality attribute scenarios đầy đủ | 35 phút | Pair work |
| **Lab 3** | Xây dựng utility tree và prioritize scenarios (H/M/L) | 30 phút | Team work |
| **Lab 4** | Map scenarios → architectural tactics & decisions | 30 phút | Team work |
| **Report & Review** | Trình bày kết quả, peer review, Q&A | 20 phút | Whole class |
| | **Tổng cộng** | **180 phút (3 giờ)** | |

---

## Lý thuyết

### 1. Quality Attributes và ISO/IEC 25010

Quality attributes (thuộc tính chất lượng) là các yêu cầu phi chức năng (non-functional requirements) mô tả **cách** hệ thống hoạt động, thay vì hệ thống làm **gì**. Chúng quyết định phần lớn các lựa chọn kiến trúc.

Chuẩn **ISO/IEC 25010:2011** (Product Quality Model) định nghĩa 8 đặc tính chất lượng chính:

| # | Đặc tính (Characteristic) | Mô tả | Sub-characteristics | Ví dụ trong E-Commerce |
|---|---------------------------|-------|---------------------|----------------------|
| 1 | **Functional Suitability** | Mức độ sản phẩm cung cấp đúng chức năng cần thiết | Functional completeness, Functional correctness, Functional appropriateness | Tính năng thanh toán xử lý đúng giá, thuế, giảm giá |
| 2 | **Performance Efficiency** | Hiệu suất so với tài nguyên sử dụng | Time behaviour, Resource utilization, Capacity | Trang chủ load < 2s, hỗ trợ 10K concurrent users |
| 3 | **Compatibility** | Khả năng tương tác với hệ thống khác | Co-existence, Interoperability | Tích hợp payment gateway (VNPay, MoMo, Stripe) |
| 4 | **Usability** | Dễ sử dụng và học | Appropriateness recognizability, Learnability, Operability, User error protection, UI aesthetics, Accessibility | Checkout flow ≤ 3 bước, hỗ trợ screen reader |
| 5 | **Reliability** | Thực hiện chức năng đúng trong điều kiện xác định | Maturity, Availability, Fault tolerance, Recoverability | Uptime 99.95%, tự phục hồi khi DB fail |
| 6 | **Security** | Bảo vệ thông tin và dữ liệu | Confidentiality, Integrity, Non-repudiation, Accountability, Authenticity | Mã hóa AES-256, RBAC, audit log |
| 7 | **Maintainability** | Dễ dàng sửa đổi, mở rộng | Modularity, Reusability, Analysability, Modifiability, Testability | Thêm payment provider trong 2 ngày, test coverage > 80% |
| 8 | **Portability** | Dễ chuyển đổi môi trường | Adaptability, Installability, Replaceability | Deploy trên AWS/GCP/Azure không cần thay đổi code |

> **Lưu ý:** Trong kiến trúc phần mềm, chúng ta thường tập trung vào **Performance, Availability, Security, Modifiability, Testability** vì đây là những attribute bị ảnh hưởng trực tiếp bởi quyết định kiến trúc.

### 2. Quality Attribute Scenarios — Cấu trúc 6 thành phần

Một quality attribute scenario là một câu phát biểu **cụ thể, đo lường được** mô tả yêu cầu chất lượng. Mỗi scenario gồm **6 phần (six parts)**:

```
┌──────────────────────────────────────────────────────────────────┐
│ QUALITY ATTRIBUTE SCENARIO │
│ │
│ ┌─────────────────┐ │
│ │ Stimulus Source │ Ai/cái gì tạo ra stimulus? │
│ │ (Nguồn kích thích)│ Ví dụ: User, attacker, timer, sensor │
│ └────────┬────────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────┐ │
│ │ Stimulus │ Sự kiện/điều kiện gì xảy ra? │
│ │ (Kích thích) │ Ví dụ: request, failure, attack │
│ └────────┬────────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────┐ │
│ │ Artifact │ Phần nào của hệ thống bị ảnh hưởng? │
│ │ (Thành phần) │ Ví dụ: service, database, module │
│ └────────┬────────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────┐ │
│ │ Environment │ Điều kiện khi stimulus xảy ra? │
│ │ (Môi trường) │ Ví dụ: normal, peak load, degraded │
│ └────────┬────────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────┐ │
│ │ Response │ Hệ thống phản ứng thế nào? │
│ │ (Phản hồi) │ Ví dụ: process, deny, switch over │
│ └────────┬────────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────┐ │
│ │Response Measure │ Đo lường phản hồi bằng gì? │
│ │(Chỉ số đo lường) │ Ví dụ: latency, uptime %, error rate │
│ └─────────────────┘ │
└──────────────────────────────────────────────────────────────────┘
```

**Chi tiết từng phần:**

| Phần | Giải thích | Câu hỏi gợi ý | Ví dụ (Performance) | Ví dụ (Security) |
|------|-----------|----------------|---------------------|-------------------|
| **Stimulus Source** | Thực thể tạo ra stimulus | Ai/cái gì gây ra sự kiện? | External user | Malicious attacker |
| **Stimulus** | Sự kiện hoặc điều kiện kích hoạt | Chuyện gì xảy ra? | Search request | SQL injection attempt |
| **Artifact** | Phần hệ thống chịu ảnh hưởng | Thành phần nào bị tác động? | Search Service | Login API |
| **Environment** | Bối cảnh khi stimulus xảy ra | Trong điều kiện nào? | Peak hours, 10K concurrent users | Normal operation |
| **Response** | Hành vi mong đợi của hệ thống | Hệ thống phải làm gì? | Return search results | Block request, log attempt |
| **Response Measure** | Chỉ số đo lường định lượng | Đo bằng gì? bao nhiêu? | < 500ms, 99th percentile | 100% blocked, alert within 10s |

**General Scenario vs. Concrete Scenario:**

| Loại | Mục đích | Ví dụ |
|------|----------|-------|
| **General Scenario** | Template/pattern tái sử dụng cho nhiều hệ thống | "Khi user request, system responds within X ms" |
| **Concrete Scenario** | Cụ thể cho một hệ thống, có giá trị đo lường rõ ràng | "Khi user search sản phẩm trên E-Commerce, Search Service trả kết quả trong 200ms cho 99% requests trong peak hours 10K concurrent users" |

### 3. Utility Tree

**Utility tree** là cấu trúc phân cấp (hierarchical) dùng để tổ chức, ưu tiên hóa các quality attribute scenarios. Đây là công cụ cốt lõi trong phương pháp **ATAM** (Architecture Tradeoff Analysis Method).

**Cấu trúc Utility Tree:**

```
 Utility (System Quality)
 │
 ┌───────────────────┼───────────────────┐
 │ │ │
 Performance Availability Security
 │ │ │
 ┌─────┴─────┐ ┌─────┴─────┐ ┌─────┴─────┐
 │ │ │ │ │ │
 Latency Throughput Uptime Recovery Auth Data
 │ │ │ │ │ Protection
 │ │ │ │ │ │
 PERF-1(H,H) PERF-2(M,L) AVAIL-1(H,H) AVAIL-2(H,M) SEC-1(H,H) SEC-2(H,M)
 PERF-3(M,M) AVAIL-3(M,L) SEC-3(M,L)
```

**Ý nghĩa rating (Importance, Difficulty):**

| Rating | Importance | Difficulty |
|--------|-----------|------------|
| **H (High)** | Rất quan trọng cho thành công của hệ thống | Khó đạt được, cần thiết kế kiến trúc cẩn thận |
| **M (Medium)** | Quan trọng nhưng có thể linh hoạt | Cần effort vừa phải |
| **L (Low)** | Nice-to-have, không critical | Dễ đạt được với kỹ thuật tiêu chuẩn |

**Ma trận ưu tiên:**

| | Difficulty: H | Difficulty: M | Difficulty: L |
|---|---|---|---|
| **Importance: H** | **(H,H)** — Ưu tiên cao nhất, rủi ro kiến trúc lớn nhất | **(H,M)** — Ưu tiên cao | **(H,L)** — Quan trọng nhưng dễ giải quyết |
| **Importance: M** | **(M,H)** — Cần chú ý đặc biệt | **(M,M)** — Ưu tiên trung bình | **(M,L)** — Xử lý sau |
| **Importance: L** | **(L,H)** — Cân nhắc trade-off | **(L,M)** — Thấp | **(L,L)** — Bỏ qua hoặc xử lý cuối |

> **Nguyên tắc:** Scenarios có rating **(H,H)** là những architectural drivers quan trọng nhất — chúng quyết định cấu trúc kiến trúc.

### 4. Scenario Prioritization

Quy trình ưu tiên hóa scenarios gồm 3 bước:

**Bước 1 — Voting:** Mỗi stakeholder được N phiếu (thường N = tổng scenarios / 3). Bỏ phiếu cho scenarios quan trọng nhất.

**Bước 2 — Ranking:** Xếp hạng theo tổng phiếu, chia thành 3 nhóm:
- **Top 1/3:** High priority — phải giải quyết trong kiến trúc
- **Middle 1/3:** Medium priority — nên giải quyết nếu có thể
- **Bottom 1/3:** Low priority — xem xét sau

**Bước 3 — Negotiation:** Thảo luận và điều chỉnh kết quả nếu có conflict giữa stakeholders.

### 5. Mapping Scenarios → Architectural Decisions

Mỗi scenario (đặc biệt H,H) cần được ánh xạ tới ít nhất một **architectural tactic** hoặc **design decision**.

| Quality Attribute | Tactics phổ biến | Pattern liên quan |
|-------------------|-----------------|-------------------|
| **Performance** | Caching, Resource pooling, Concurrency, Load balancing, CDN | CQRS, Event-driven |
| **Availability** | Redundancy, Failover, Heartbeat, Circuit breaker, Retry | Active-passive, Leader election |
| **Security** | Authentication, Authorization, Encryption, Input validation, Audit trail | Zero-trust, Defense in depth |
| **Modifiability** | Encapsulation, Loose coupling, High cohesion, Dependency injection | Microservices, Plugin architecture |
| **Testability** | Dependency injection, Interface abstraction, Test doubles, Observability | Hexagonal architecture |

### 6. Scenario Workshop Facilitation

Một buổi Quality Attribute Workshop (QAW) theo SEI gồm các bước:

1. **Presentation:** Giới thiệu business drivers và system context (15 phút)
2. **Architecture Plan Presentation:** Trình bày kiến trúc hiện tại/dự kiến (15 phút)
3. **Scenario Brainstorming:** Mỗi stakeholder đề xuất scenarios (30 phút)
4. **Scenario Consolidation:** Gom nhóm, loại trùng lặp (10 phút)
5. **Scenario Prioritization:** Bỏ phiếu và xếp hạng (15 phút)
6. **Scenario Refinement:** Chi tiết hóa top scenarios thành 6 phần đầy đủ (20 phút)

**Vai trò trong workshop:**
- **Facilitator:** Điều phối, đảm bảo mọi stakeholder đều tham gia
- **Scribe:** Ghi chép scenarios lên bảng/công cụ
- **Stakeholders:** Business owner, dev lead, QA, ops, end-user representative

---

## Step-by-step Labs

### Lab 1: Identify Quality Attributes (25 phút)

**Mục tiêu:** Xác định và phân loại quality attributes cho hệ thống E-Commerce theo ISO 25010.

**Bối cảnh hệ thống:**
> **ShopVN** — một nền tảng E-Commerce bán hàng trực tuyến tại Việt Nam. Hệ thống hỗ trợ 500K registered users, 50K daily active users, peak load trong các đợt sale (Flash Sale, 11/11, Black Friday). Bao gồm: Product Catalog, Shopping Cart, Order Management, Payment, User Management, Notification, Search, Recommendation.

**Bước 1 — Liệt kê quality attributes:**

Sử dụng bảng ISO 25010 ở phần lý thuyết, xác định quality attributes liên quan đến ShopVN:

| # | Quality Attribute | Relevant? (Y/N) | Lý do | Mức độ quan trọng (H/M/L) |
|---|-------------------|-----------------|-------|---------------------------|
| 1 | Performance Efficiency | | | |
| 2 | Reliability (Availability) | | | |
| 3 | Security | | | |
| 4 | Maintainability (Modifiability) | | | |
| 5 | Maintainability (Testability) | | | |
| 6 | Compatibility (Interoperability) | | | |
| 7 | Usability | | | |
| 8 | Portability | | | |

**Bước 2 — Phân tích stakeholder concerns:**

Với mỗi stakeholder, xác định quality attributes mà họ quan tâm nhất:

| Stakeholder | Vai trò | Top 3 Quality Attributes | Lý do |
|-------------|---------|--------------------------|-------|
| CEO / Business Owner | Quyết định chiến lược | | |
| Development Team Lead | Phát triển và bảo trì | | |
| End Users (Buyers) | Mua hàng trực tuyến | | |
| Operations / DevOps | Vận hành hệ thống | | |
| Security Officer | Bảo mật | | |

**Bước 3 — Prioritize quality attributes:**

Xếp hạng các quality attributes theo mức độ quan trọng cho ShopVN (1 = quan trọng nhất):

| Hạng | Quality Attribute | Justification |
|------|-------------------|---------------|
| 1 | | |
| 2 | | |
| 3 | | |
| 4 | | |
| 5 | | |

**Template kết quả Lab 1:**

```
┌─────────────────────────────────────────────────────┐
│ LAB 1 — QUALITY ATTRIBUTE IDENTIFICATION │
│ System: ShopVN E-Commerce │
│ Student: ___________________ │
│ Date: ___________________ │
│ │
│ Identified attributes: _____ / 8 │
│ Top 3 attributes: ___, ___, ___ │
│ Stakeholder conflicts: _________________________ │
│ Resolution approach: ___________________________ │
└─────────────────────────────────────────────────────┘
```

---

### Lab 2: Write Quality Attribute Scenarios (35 phút)

**Mục tiêu:** Viết 10 quality attribute scenarios đầy đủ 6 phần, covering 5 quality attributes chính.

**Yêu cầu:** Mỗi quality attribute viết **2 concrete scenarios** — tổng cộng **10 scenarios**.

#### Template cho mỗi scenario:

| Phần | Giá trị |
|------|---------|
| **ID** | [ATTR]-[N], ví dụ PERF-1 |
| **Quality Attribute** | |
| **Stimulus Source** | |
| **Stimulus** | |
| **Artifact** | |
| **Environment** | |
| **Response** | |
| **Response Measure** | |

#### Scenarios cần viết:

**Performance (PERF-1, PERF-2):**

| Phần | PERF-1 | PERF-2 |
|------|--------|--------|
| **Quality Attribute** | Performance — Latency | Performance — Throughput |
| **Stimulus Source** | | |
| **Stimulus** | | |
| **Artifact** | | |
| **Environment** | | |
| **Response** | | |
| **Response Measure** | | |

> **Gợi ý PERF-1:** User search sản phẩm trong peak hours → response time
> **Gợi ý PERF-2:** Batch processing đơn hàng cuối ngày → throughput

**Availability (AVAIL-1, AVAIL-2):**

| Phần | AVAIL-1 | AVAIL-2 |
|------|---------|---------|
| **Quality Attribute** | Availability — Fault tolerance | Availability — Recovery |
| **Stimulus Source** | | |
| **Stimulus** | | |
| **Artifact** | | |
| **Environment** | | |
| **Response** | | |
| **Response Measure** | | |

> **Gợi ý AVAIL-1:** Database server fails → failover
> **Gợi ý AVAIL-2:** Network partition giữa services → degraded mode

**Security (SEC-1, SEC-2):**

| Phần | SEC-1 | SEC-2 |
|------|-------|-------|
| **Quality Attribute** | Security — Authorization | Security — Data protection |
| **Stimulus Source** | | |
| **Stimulus** | | |
| **Artifact** | | |
| **Environment** | | |
| **Response** | | |
| **Response Measure** | | |

> **Gợi ý SEC-1:** Unauthorized user truy cập admin API → deny + alert
> **Gợi ý SEC-2:** SQL injection trên login form → sanitize + block

**Modifiability (MOD-1, MOD-2):**

| Phần | MOD-1 | MOD-2 |
|------|-------|-------|
| **Quality Attribute** | Modifiability — Extensibility | Modifiability — Configurability |
| **Stimulus Source** | | |
| **Stimulus** | | |
| **Artifact** | | |
| **Environment** | | |
| **Response** | | |
| **Response Measure** | | |

> **Gợi ý MOD-1:** Thêm payment provider mới → integration time
> **Gợi ý MOD-2:** Thay đổi UI theme → scope of change

**Testability (TEST-1, TEST-2):**

| Phần | TEST-1 | TEST-2 |
|------|--------|--------|
| **Quality Attribute** | Testability — Unit testability | Testability — Integration testability |
| **Stimulus Source** | | |
| **Stimulus** | | |
| **Artifact** | | |
| **Environment** | | |
| **Response** | | |
| **Response Measure** | | |

> **Gợi ý TEST-1:** Developer viết unit test cho service mới → test coverage
> **Gợi ý TEST-2:** QA team chạy integration test trên staging → execution time

#### Ví dụ mẫu hoàn chỉnh:

| Phần | PERF-SAMPLE |
|------|-------------|
| **ID** | PERF-SAMPLE |
| **Quality Attribute** | Performance — Latency |
| **Stimulus Source** | External user (buyer) |
| **Stimulus** | Gửi request tìm kiếm sản phẩm với keyword "áo thun" |
| **Artifact** | Search Service |
| **Environment** | Peak hours (20:00-22:00), 10K concurrent users, Flash Sale event |
| **Response** | Hệ thống trả về danh sách sản phẩm phù hợp, sắp xếp theo relevance |
| **Response Measure** | Response time ≤ 500ms cho 99th percentile, max 20 results/page |

**Checklist cho mỗi scenario:**

- [ ] Có đủ 6 phần?
- [ ] Response Measure có **quantitative** (số cụ thể) không?
- [ ] Environment có **realistic** không?
- [ ] Scenario có **testable** (có thể viết test) không?
- [ ] Scenario có **architecture-relevant** (ảnh hưởng kiến trúc) không?

---

### Lab 3: Build a Utility Tree (30 phút)

**Mục tiêu:** Tổ chức 10 scenarios từ Lab 2 thành utility tree và gán rating (H/M/L) cho importance và difficulty.

**Bước 1 — Tạo cấu trúc cây:**

Điền vào utility tree template sau:

```
 Utility
 (ShopVN Quality)
 │
 ┌───────────┬───────────┼───────────┬───────────┐
 │ │ │ │ │
 Performance Availability Security Modifiability Testability
 │ │ │ │ │
 ┌────┴────┐ ┌───┴───┐ ┌───┴───┐ ┌───┴───┐ ┌───┴───┐
 │ │ │ │ │ │ │ │ │ │
 Latency Throughput Fault Recovery Auth Data Extend Config Unit Integ
 │ │ Toler. │ │ Protect │ │ │ │
 │ │ │ │ │ │ │ │ │ │
 PERF-1 PERF-2 AVAIL-1 AVAIL-2 SEC-1 SEC-2 MOD-1 MOD-2 TEST-1 TEST-2
 (?,?) (?,?) (?,?) (?,?) (?,?) (?,?) (?,?) (?,?) (?,?) (?,?)
```

**Bước 2 — Gán rating cho mỗi scenario:**

| Scenario ID | Quality Attribute | Importance (H/M/L) | Difficulty (H/M/L) | Justification |
|-------------|-------------------|---------------------|---------------------|---------------|
| PERF-1 | Performance — Latency | | | |
| PERF-2 | Performance — Throughput | | | |
| AVAIL-1 | Availability — Fault tolerance | | | |
| AVAIL-2 | Availability — Recovery | | | |
| SEC-1 | Security — Authorization | | | |
| SEC-2 | Security — Data protection | | | |
| MOD-1 | Modifiability — Extensibility | | | |
| MOD-2 | Modifiability — Configurability | | | |
| TEST-1 | Testability — Unit | | | |
| TEST-2 | Testability — Integration | | | |

**Bước 3 — Xác định Architectural Drivers:**

Liệt kê các scenarios có rating **(H,H)** — đây là architectural drivers:

| # | Scenario ID | Mô tả ngắn | Tại sao là (H,H)? |
|---|-------------|-------------|-------------------|
| 1 | | | |
| 2 | | | |
| 3 | | | |

**Bước 4 — Phân tích trade-offs:**

Xác định cặp quality attributes có thể conflict:

| Quality Attribute A | Quality Attribute B | Trade-off | Giải pháp đề xuất |
|--------------------|--------------------|-----------|--------------------|
| Performance | Security | Encryption tăng latency | Hardware acceleration, async encryption |
| Availability | Consistency | CAP theorem | Eventual consistency cho non-critical data |
| Modifiability | Performance | Abstraction layers tăng overhead | Cache intermediate results |

---

### Lab 4: Map Scenarios to Architecture Tactics (30 phút)

**Mục tiêu:** Ánh xạ mỗi scenario tới architectural tactics và design decisions cụ thể.

**Bước 1 — Mapping template:**

Với mỗi scenario, xác định tactic(s) và design decision(s):

| Scenario ID | Scenario Summary | Tactic(s) | Design Decision | Technology/Pattern |
|-------------|-----------------|-----------|-----------------|-------------------|
| PERF-1 | Search < 500ms, 10K users | | | |
| PERF-2 | Batch processing throughput | | | |
| AVAIL-1 | DB failover < 30s | | | |
| AVAIL-2 | Network partition handling | | | |
| SEC-1 | Unauthorized access prevention | | | |
| SEC-2 | SQL injection protection | | | |
| MOD-1 | New payment provider in 2 days | | | |
| MOD-2 | UI theme change in 4 hours | | | |
| TEST-1 | Unit test coverage > 80% | | | |
| TEST-2 | Integration test < 10 min | | | |

**Bước 2 — Tactics Catalog (tham khảo):**

**Performance Tactics:**

| Tactic | Mô tả | Khi nào dùng |
|--------|--------|-------------|
| **Caching** | Lưu trữ kết quả tính toán để tái sử dụng | Read-heavy workloads, static data |
| **Resource pooling** | Tái sử dụng connections/threads thay vì tạo mới | Database connections, thread management |
| **Concurrency** | Xử lý song song | CPU-intensive tasks, independent operations |
| **Load balancing** | Phân tải giữa nhiều instances | High traffic, horizontal scaling |
| **CDN** | Phân phối static content gần user | Global users, media-heavy content |
| **Database indexing** | Tạo index cho truy vấn thường dùng | Slow queries, large datasets |

**Availability Tactics:**

| Tactic | Mô tả | Khi nào dùng |
|--------|--------|-------------|
| **Active redundancy** | Nhiều instances chạy đồng thời | Zero-downtime requirement |
| **Passive redundancy** | Standby instances sẵn sàng thay thế | Cost-sensitive, recovery time acceptable |
| **Heartbeat** | Giám sát health của components | Distributed systems |
| **Circuit breaker** | Ngắt kết nối khi service lỗi | Cascading failure prevention |
| **Retry with backoff** | Thử lại với khoảng cách tăng dần | Transient failures |
| **Graceful degradation** | Giảm tính năng thay vì crash | Partial failure scenarios |

**Security Tactics:**

| Tactic | Mô tả | Khi nào dùng |
|--------|--------|-------------|
| **Authentication** | Xác thực danh tính | User access |
| **Authorization (RBAC)** | Phân quyền theo vai trò | Multi-role systems |
| **Input validation** | Kiểm tra dữ liệu đầu vào | All user inputs |
| **Encryption** | Mã hóa dữ liệu (at rest + in transit) | Sensitive data |
| **Audit trail** | Ghi log các thao tác quan trọng | Compliance, forensics |
| **Rate limiting** | Giới hạn số request | DDoS prevention |

**Modifiability Tactics:**

| Tactic | Mô tả | Khi nào dùng |
|--------|--------|-------------|
| **Encapsulation** | Che giấu implementation details | All modules |
| **Loose coupling** | Giảm phụ thuộc giữa modules | Inter-service communication |
| **High cohesion** | Nhóm chức năng liên quan | Module design |
| **Dependency injection** | Inject dependencies thay vì hardcode | Testability + flexibility |
| **Configuration externalization** | Đưa config ra ngoài code | Multi-environment deployment |
| **Plugin architecture** | Cho phép mở rộng mà không sửa core | Extensible systems |

**Bước 3 — Ví dụ mapping hoàn chỉnh:**

| Scenario ID | Scenario Summary | Tactic(s) | Design Decision | Technology/Pattern |
|-------------|-----------------|-----------|-----------------|-------------------|
| PERF-1 | Search < 500ms, 10K users | Caching, CDN, Database indexing | Sử dụng Elasticsearch cho full-text search, Redis cache cho frequent queries | Elasticsearch + Redis + Nginx (reverse proxy) |
| AVAIL-1 | DB failover < 30s | Active-passive redundancy, Heartbeat, Automatic failover | Primary-replica DB cluster với health check mỗi 5s | PostgreSQL Streaming Replication + HAProxy |
| SEC-1 | Unauthorized access prevention | Authentication (JWT), Authorization (RBAC), Rate limiting, Audit trail | API Gateway xác thực JWT, service-level RBAC | Keycloak + API Gateway + ELK Stack |

---

## Self-Assessment

### Band 1: Cơ bản (Câu 1-10)

**Câu 1.** Quality attribute scenario gồm bao nhiêu phần (parts)?
- A) 4
- B) 5
- C) 6
- D) 7

**Đáp án: C) 6** — Stimulus Source, Stimulus, Artifact, Environment, Response, Response Measure.

---

**Câu 2.** "Response Measure" trong scenario phải có tính chất gì?
- A) Qualitative (định tính)
- B) Quantitative / Measurable (định lượng, đo được)
- C) Optional (tùy chọn)
- D) Chỉ cần dùng technical jargon

**Đáp án: B)** — Response Measure phải đo lường được bằng con số cụ thể (e.g., < 200ms, 99.9% uptime) để có thể kiểm chứng (testable).

---

**Câu 3.** "Environment" trong scenario mô tả điều gì?
- A) Production server configuration
- B) Điều kiện/bối cảnh khi stimulus xảy ra
- C) Development environment (IDE, OS)
- D) Cloud provider (AWS/GCP)

**Đáp án: B)** — Environment mô tả trạng thái của hệ thống tại thời điểm stimulus xảy ra, ví dụ: normal operation, peak load, degraded mode, startup.

---

**Câu 4.** Utility Tree đánh giá scenarios theo tiêu chí nào?
- A) Cost only
- B) Time only
- C) Importance và Difficulty
- D) Lines of code

**Đáp án: C)** — Mỗi scenario được đánh giá theo 2 chiều: Importance (tầm quan trọng cho business) và Difficulty (độ khó để đạt được về mặt kiến trúc). Rating: H/M/L.

---

**Câu 5.** Scenario nào sau đây là ví dụ **tốt**?
- A) "System should be fast"
- B) "Response time < 200ms for 99% of requests under 10K concurrent users"
- C) "Use microservices architecture"
- D) "Write clean code"

**Đáp án: B)** — Đây là scenario tốt vì có measurable response measure (< 200ms), có percentile (99%), và có environment context (10K concurrent users). Các đáp án khác đều vague hoặc là design decision, không phải quality scenario.

---

**Câu 6.** ISO/IEC 25010 định nghĩa bao nhiêu đặc tính chất lượng chính (top-level characteristics)?
- A) 5
- B) 6
- C) 8
- D) 10

**Đáp án: C) 8** — Functional Suitability, Performance Efficiency, Compatibility, Usability, Reliability, Security, Maintainability, Portability.

---

**Câu 7.** "Stimulus Source" trong scenario khác với "Stimulus" ở điểm nào?
- A) Chúng giống nhau
- B) Stimulus Source là thực thể **tạo ra** sự kiện, Stimulus là **bản thân sự kiện**
- C) Stimulus Source luôn là con người
- D) Stimulus luôn là lỗi hệ thống

**Đáp án: B)** — Stimulus Source = ai/cái gì gây ra (e.g., end user, attacker, internal timer). Stimulus = sự kiện cụ thể (e.g., HTTP request, DDoS attack, cron trigger). Source là nguồn, Stimulus là hành động/sự kiện.

---

**Câu 8.** "Artifact" trong scenario đề cập đến gì?
- A) Source code file
- B) Phần/thành phần của hệ thống bị ảnh hưởng bởi stimulus
- C) Documentation
- D) Test case

**Đáp án: B)** — Artifact là component, service, module, hoặc toàn bộ hệ thống chịu tác động của stimulus. Ví dụ: Order Service, Database, API Gateway, toàn hệ thống.

---

**Câu 9.** Scenario nào sau đây là **concrete** scenario (không phải general)?
- A) "When a user makes a request, system responds quickly"
- B) "When load increases, system scales"
- C) "When 5K users đồng thời search sản phẩm trên ShopVN trong Flash Sale 11/11, Search Service trả kết quả trong 300ms cho 95th percentile"
- D) "System should handle failures gracefully"

**Đáp án: C)** — Concrete scenario có giá trị cụ thể (5K users, ShopVN, Flash Sale 11/11, 300ms, 95th percentile). Các đáp án khác đều vague/general.

---

**Câu 10.** Trong bối cảnh E-Commerce, quality attribute nào sau đây ảnh hưởng trực tiếp đến doanh thu?
- A) Portability
- B) Performance và Availability
- C) Testability
- D) Functional Suitability

**Đáp án: B)** — Performance (page load time) ảnh hưởng trực tiếp đến conversion rate. Amazon: mỗi 100ms tăng latency → giảm 1% doanh thu. Availability: downtime = mất doanh thu. Cả hai đều là drivers chính cho E-Commerce.

---

### Band 2: Trung bình (Câu 11-20)

**Câu 11.** Sự khác biệt giữa General Scenario và Concrete Scenario là gì?
- A) General dùng cho development, Concrete dùng cho testing
- B) General là template tái sử dụng, Concrete có giá trị cụ thể cho hệ thống đang xét
- C) General ngắn hơn Concrete
- D) Không có sự khác biệt

**Đáp án: B)** — General Scenario là pattern/template áp dụng cho nhiều hệ thống (e.g., "System responds within X ms"). Concrete Scenario chứa giá trị cụ thể cho hệ thống đang phân tích (e.g., "ShopVN Search Service responds within 300ms for 95th percentile during Flash Sale").

---

**Câu 12.** Kỹ thuật nào được sử dụng để **elicit** scenarios từ stakeholders?
- A) Code review
- B) Quality Attribute Workshop (QAW) với brainstorming và voting
- C) Unit testing
- D) Performance profiling

**Đáp án: B)** — QAW (Quality Attribute Workshop) do SEI phát triển, sử dụng brainstorming để thu thập scenarios từ nhiều stakeholders, sau đó consolidate và prioritize bằng voting.

---

**Câu 13.** Khi nào một scenario được coi là "quá vague" (mơ hồ)?
- A) Khi có quá nhiều số liệu
- B) Khi thiếu measurable response measure hoặc environment context cụ thể
- C) Khi quá ngắn
- D) Khi liên quan đến security

**Đáp án: B)** — Scenario vague khi dùng từ như "fast", "secure", "reliable" mà không có chỉ số cụ thể. Ví dụ xấu: "System should be fast". Ví dụ tốt: "Response time < 200ms for 99th percentile under 10K concurrent users".

---

**Câu 14.** Khi nào một scenario "quá specific" (quá chi tiết)?
- A) Khi có response measure
- B) Khi bao gồm implementation details hoặc technology choices thay vì quality requirements
- C) Khi áp dụng cho nhiều hệ thống
- D) Khi có 6 phần đầy đủ

**Đáp án: B)** — Scenario quá specific khi chứa solution/implementation (e.g., "Use Redis cache with TTL 5 minutes"). Scenario nên mô tả **what** (quality requirement), không phải **how** (implementation). Implementation thuộc về architectural decisions.

---

**Câu 15.** Trong Utility Tree, scenario có rating (H,H) có ý nghĩa gì?
- A) Không quan trọng, dễ làm
- B) Rất quan trọng cho business VÀ khó đạt được về mặt kiến trúc — là architectural driver chính
- C) Quan trọng trung bình
- D) Cần thêm thông tin

**Đáp án: B)** — (H,H) = High Importance, High Difficulty. Đây là scenarios có rủi ro kiến trúc cao nhất, cần được giải quyết đầu tiên trong quá trình thiết kế. Chúng là **architectural drivers** — quyết định cấu trúc tổng thể của kiến trúc.

---

**Câu 16.** Quality Attribute Workshop (QAW) theo SEI gồm mấy bước chính?
- A) 3 bước
- B) 4 bước
- C) 6 bước
- D) 8 bước

**Đáp án: C) 6 bước** — (1) QAW Presentation & Introductions, (2) Business/Mission Presentation, (3) Architectural Plan Presentation, (4) Identification of Architectural Drivers, (5) Scenario Brainstorming, (6) Scenario Consolidation & Prioritization.

---

**Câu 17.** Tiêu chí nào dùng để prioritize scenarios?
- A) Chỉ dựa trên cost
- B) Business value, technical risk, stakeholder priority, và feasibility
- C) Chỉ dựa trên developer preference
- D) Alphabetical order

**Đáp án: B)** — Scenario prioritization dựa trên nhiều yếu tố: business value (ảnh hưởng doanh thu), technical risk (khó khăn kỹ thuật), stakeholder priority (ai quan tâm nhất), và feasibility (có thể thực hiện được không).

---

**Câu 18.** Một scenario có thể test được (testable) khi nào?
- A) Khi viết bằng tiếng Anh
- B) Khi có measurable response measure và có thể viết automated test để verify
- C) Khi developer đồng ý
- D) Khi đã có code

**Đáp án: B)** — Testable scenario phải có response measure đo lường được (e.g., latency < 200ms) và có thể tạo test tự động (e.g., load test với JMeter/k6) để verify scenario đạt hay không đạt.

---

**Câu 19.** Khi hai quality attributes conflict (ví dụ Performance vs Security), cách giải quyết tốt nhất là gì?
- A) Luôn chọn Performance
- B) Luôn chọn Security
- C) Phân tích trade-off, thảo luận với stakeholders, tìm giải pháp cân bằng hoặc đánh đổi có ý thức
- D) Bỏ qua conflict

**Đáp án: C)** — Trade-off analysis là kỹ năng cốt lõi của software architect. Cần: (1) Xác định rõ trade-off, (2) Lượng hóa tác động mỗi bên, (3) Thảo luận với stakeholders để quyết định ưu tiên, (4) Document quyết định (ADR).

---

**Câu 20.** Scenario có liên quan gì đến Non-Functional Requirements (NFRs)?
- A) Scenario và NFR hoàn toàn khác nhau
- B) Scenario là cách **cụ thể hóa** và **đo lường được** NFRs bằng 6 thành phần
- C) NFR thay thế scenario
- D) Scenario chỉ dùng cho functional requirements

**Đáp án: B)** — NFR thường vague (e.g., "System should be reliable"). Scenario cụ thể hóa NFR thành câu phát biểu đo lường được với 6 phần (e.g., "When DB fails → failover within 30s → 99.95% uptime"). Scenario là **cách operationalize NFRs**.

---

### Band 3: Nâng cao (Câu 21-30)

**Câu 21.** Scenario validation với stakeholders nên được thực hiện khi nào?
- A) Chỉ khi hoàn thành development
- B) Liên tục trong suốt vòng đời phát triển, đặc biệt sau khi viết scenario và trước khi ra quyết định kiến trúc
- C) Chỉ trong testing phase
- D) Không cần validate

**Đáp án: B)** — Scenarios phải được validate sớm và thường xuyên. Validate ngay sau khi viết (stakeholders đồng ý chỉ số chưa?), trước design decisions (scenario có đúng priority không?), sau implementation (scenario đạt chưa?). Continuous validation đảm bảo kiến trúc luôn align với business needs.

---

**Câu 22.** Scenario evolution trong Agile — scenarios thay đổi thế nào qua các sprint?
- A) Scenarios cố định, không thay đổi
- B) Scenarios được refine liên tục: thêm mới, cập nhật response measure, re-prioritize khi requirements thay đổi
- C) Viết lại toàn bộ mỗi sprint
- D) Chỉ thêm, không sửa

**Đáp án: B)** — Trong Agile, scenarios evolve cùng product: (1) Sprint 0: viết initial scenarios, (2) Mỗi sprint: refine scenarios dựa trên feedback và learnings, (3) Re-prioritize khi business context thay đổi, (4) Update response measures khi có production data. Scenarios là living documents.

---

**Câu 23.** Scenario dependencies — khi scenario A phụ thuộc scenario B, cần xử lý thế nào?
- A) Bỏ qua dependency
- B) Xác định rõ dependency, đảm bảo scenario B được giải quyết trước A, và document dependency chain
- C) Gộp thành một scenario
- D) Xóa scenario phụ thuộc

**Đáp án: B)** — Ví dụ: PERF-1 (search latency < 500ms) phụ thuộc AVAIL-1 (DB available). Nếu DB down, PERF-1 không thể đạt. Cần: (1) Document dependency, (2) Đảm bảo AVAIL-1 có priority ≥ PERF-1, (3) Test scenarios theo dependency order.

---

**Câu 24.** Scenario conflicts — khi 2 scenarios mâu thuẫn, ưu tiên scenario nào?
- A) Scenario viết trước
- B) Phân tích theo business value và stakeholder priority; scenario có (H,H) rating trong utility tree được ưu tiên
- C) Scenario của developer
- D) Scenario ngắn hơn

**Đáp án: B)** — Conflict resolution dựa trên: (1) Utility tree rating — (H,H) > (H,M) > (M,M), (2) Business value — scenario nào ảnh hưởng revenue/user nhiều hơn, (3) Stakeholder consensus — voting/negotiation, (4) Technical feasibility — scenario nào khả thi hơn.

---

**Câu 25.** Scenario metrics — KPIs nào dùng để đánh giá "sức khỏe" của scenario process?
- A) Số dòng code
- B) Scenario coverage (% quality attributes covered), scenario testability rate, scenario-to-tactic mapping completeness
- C) Số cuộc họp
- D) Số trang tài liệu

**Đáp án: B)** — KPIs cho scenario process: (1) Coverage — bao nhiêu quality attributes có scenarios? (2) Testability rate — bao nhiêu % scenarios có automated test? (3) Mapping completeness — bao nhiêu % scenarios đã map tới tactics? (4) Validation rate — bao nhiêu % scenarios được stakeholders validate?

---

**Câu 26.** Automated scenario testing — cách nào hiệu quả nhất để automate việc kiểm tra scenarios?
- A) Manual testing
- B) Sử dụng architecture fitness functions: automated tests chạy trong CI/CD để verify scenarios liên tục
- C) Code review
- D) Documentation review

**Đáp án: B)** — Architecture fitness functions (từ "Building Evolutionary Architectures") là automated tests verify scenarios: (1) Performance scenario → load test trong CI/CD (k6, JMeter), (2) Availability → chaos testing (Chaos Monkey), (3) Security → automated security scanning (OWASP ZAP). Chạy liên tục trong pipeline.

---

**Câu 27.** Scenario-driven design — làm thế nào để scenarios "lái" quá trình thiết kế kiến trúc?
- A) Viết scenarios sau khi thiết kế xong
- B) Sử dụng (H,H) scenarios làm input cho ADD (Attribute-Driven Design): chọn tactic → evaluate → iterate
- C) Scenarios chỉ để documentation
- D) Không liên quan đến design

**Đáp án: B)** — ADD process: (1) Chọn module/component cần thiết kế, (2) Chọn (H,H) scenario làm driver, (3) Chọn architectural pattern/tactic giải quyết scenario, (4) Evaluate bằng scenario — đạt thì qua, không đạt thì iterate. Scenarios là criteria để evaluate design decisions.

---

**Câu 28.** Trong ATAM (Architecture Tradeoff Analysis Method), utility tree đóng vai trò gì?
- A) Chỉ là document phụ
- B) Là công cụ trung tâm để tổ chức scenarios, xác định architectural drivers (H,H), và phát hiện trade-off points
- C) Chỉ dùng trong coding
- D) Thay thế source code

**Đáp án: B)** — Trong ATAM, utility tree là bước quan trọng (Phase 1, Step 5): (1) Tổ chức tất cả scenarios theo quality attribute hierarchy, (2) Rating (H,H) xác định architectural drivers, (3) Các drivers này được dùng để phân tích kiến trúc, tìm sensitivity points, trade-off points, và risks.

---

**Câu 29.** Scenario documentation best practices — 5 nguyên tắc quan trọng nhất?
- A) Viết càng dài càng tốt
- B) (1) Measurable response measures, (2) Realistic values từ production data, (3) Review bởi stakeholders, (4) Version control, (5) Traceability tới architectural decisions
- C) Chỉ cần viết một lần
- D) Không cần document

**Đáp án: B)** — Best practices: (1) **Measurable** — response measure phải có số cụ thể, (2) **Realistic** — dựa trên production data hoặc industry benchmarks, (3) **Reviewed** — stakeholders phải validate, (4) **Versioned** — track changes qua thời gian, (5) **Traceable** — mỗi scenario link tới ADR/tactic/test.

---

**Câu 30.** Khi thiết kế kiến trúc cho hệ thống mới chưa có production data, làm thế nào để đặt response measure cho scenarios?
- A) Không đặt response measure
- B) Dùng industry benchmarks, competitor analysis, business SLAs, và prototype testing — sau đó refine khi có production data
- C) Đặt giá trị lý tưởng (0ms latency, 100% uptime)
- D) Copy từ hệ thống khác

**Đáp án: B)** — Khi chưa có production data: (1) **Industry benchmarks** — Google: page load < 3s, Amazon: < 200ms, (2) **Competitor analysis** — đo performance của đối thủ, (3) **Business SLAs** — contractual obligations, (4) **Prototype/POC** — chạy load test trên prototype, (5) **Refine** — cập nhật khi có real data. Tránh giá trị lý tưởng không khả thi.

---

## Extend Labs (10 bài)

### EL1: Complete Scenario Set ***

**Mục tiêu:** Viết bộ scenario đầy đủ cho một hệ thống.

**Yêu cầu:**
- Viết **20+ concrete scenarios** cho hệ thống ShopVN E-Commerce
- Cover **tất cả 8 quality attributes** trong ISO 25010
- Mỗi quality attribute có ít nhất **2 scenarios**
- Xây dựng **utility tree** hoàn chỉnh với rating (H/M/L)
- Xác định **top 5 architectural drivers** (H,H scenarios)

**Deliverable:** File markdown hoặc spreadsheet chứa toàn bộ scenarios + utility tree diagram.

---

### EL2: E-Commerce Domain Deep Dive ***

**Mục tiêu:** Phân tích sâu quality scenarios cho domain E-Commerce.

**Yêu cầu:**
- Viết scenarios cho các business flows cụ thể: **Checkout**, **Flash Sale**, **Search**, **Payment**, **Inventory**
- Mỗi flow có ít nhất **3 scenarios** (Performance + Availability + Security)
- Xác định **SLI/SLO** cho mỗi scenario
- So sánh scenarios giữa **startup** vs **enterprise-scale** e-commerce

**Deliverable:** Scenario matrix + SLI/SLO definitions.

---

### EL3: Healthcare System Scenarios ****

**Mục tiêu:** Viết scenarios cho hệ thống y tế — domain có nhiều ràng buộc regulatory.

**Yêu cầu:**
- Viết scenarios liên quan **HIPAA compliance** (data privacy, access control, audit)
- Availability scenario: **99.99% uptime** cho critical care systems
- Security scenarios cho **PHI** (Protected Health Information)
- Interoperability scenarios cho **HL7 FHIR** integration
- Xác định trade-offs giữa usability và security trong clinical workflow

**Deliverable:** 15+ scenarios + compliance mapping matrix.

---

### EL4: Gaming Platform Scenarios ****

**Mục tiêu:** Viết scenarios cho hệ thống real-time gaming.

**Yêu cầu:**
- Performance scenarios: **latency < 50ms** cho game state synchronization
- Scalability: **1M+ concurrent players** trong MMO environment
- Consistency: **state reconciliation** khi network jitter
- Availability: **zero perceived downtime** during deployment (rolling update)
- Anti-cheat: scenarios cho **cheat detection** và fair play

**Deliverable:** 12+ scenarios + latency budget breakdown.

---

### EL5: IoT Edge Computing Scenarios ****

**Mục tiêu:** Viết scenarios cho hệ thống IoT với edge computing.

**Yêu cầu:**
- Reliability scenarios cho **device failures** (sensor offline, battery drain)
- Network scenarios: hoạt động trong **intermittent connectivity**
- Scalability: **millions of devices** gửi telemetry data
- Security: **device authentication** và firmware update over-the-air (OTA)
- Performance: **edge processing** latency < 10ms cho real-time control

**Deliverable:** 12+ scenarios + edge-cloud architecture decisions.

---

### EL6: Scenario Workshop Facilitation ***

**Mục tiêu:** Thực hành điều phối buổi scenario workshop.

**Yêu cầu:**
- Chuẩn bị **workshop plan** (agenda, stakeholder list, materials)
- Thiết kế **brainstorming template** cho stakeholders
- Thực hành **facilitation techniques**: round-robin, affinity grouping, dot voting
- Xử lý **conflicting priorities** giữa stakeholders
- Document **workshop minutes** và kết quả

**Deliverable:** Workshop plan + facilitation guide + sample minutes.

---

### EL7: Automated Scenario Testing ****

**Mục tiêu:** Chuyển đổi scenarios thành automated tests.

**Yêu cầu:**
- Viết **performance test** (k6 hoặc JMeter) cho 3 performance scenarios
- Viết **chaos test** script cho 2 availability scenarios (kill process, network partition)
- Viết **security scan** configuration cho 2 security scenarios (OWASP ZAP)
- Tích hợp tests vào **CI/CD pipeline** (GitHub Actions hoặc GitLab CI)
- Tạo **dashboard** hiển thị scenario compliance status

**Deliverable:** Test scripts + CI/CD config + dashboard screenshot.

---

### EL8: Scenario Lifecycle Management ***

**Mục tiêu:** Quản lý vòng đời scenarios qua các phase.

**Yêu cầu:**
- Thiết kế **scenario versioning scheme** (semantic versioning cho scenarios)
- Tạo **status tracking** workflow: Draft → Reviewed → Approved → Implemented → Verified → Retired
- Xây dựng **traceability matrix**: Scenario → ADR → Code → Test → Monitoring
- Định nghĩa **scenario change management** process
- Tạo **scenario report** template cho stakeholder review

**Deliverable:** Lifecycle workflow diagram + traceability matrix + report template.

---

### EL9: Scenario Visualization Dashboard ***

**Mục tiêu:** Trực quan hóa scenarios cho communication với stakeholders.

**Yêu cầu:**
- Vẽ **utility tree** bằng D3.js, Mermaid, hoặc draw.io (interactive nếu có thể)
- Tạo **priority matrix** (Importance vs Difficulty) 2D scatter plot
- Tạo **coverage heatmap**: quality attributes x system components
- Thiết kế **scenario status dashboard** hiển thị real-time compliance
- Export ra **PDF report** cho management presentation

**Deliverable:** Interactive visualization hoặc static diagrams + dashboard mockup.

---

### EL10: SLI/SLO Alignment ****

**Mục tiêu:** Liên kết scenarios với SLI/SLO/SLA framework.

**Yêu cầu:**
- Với mỗi scenario, định nghĩa **SLI** (Service Level Indicator) — metric đo lường
- Đặt **SLO** (Service Level Objective) — target value cho SLI
- Xác định **error budget** cho mỗi SLO
- Map SLOs tới **SLA** (Service Level Agreement) commitments
- Thiết kế **alerting rules** khi SLO bị vi phạm
- Tạo **error budget policy** (hành động khi error budget exhausted)

**Deliverable:** SLI/SLO/SLA matrix + error budget calculations + alerting config.

---

## Deliverables

Sinh viên cần nộp các sản phẩm sau:

- [ ] **Lab 1:** Bảng phân loại quality attributes theo ISO 25010 cho ShopVN, kèm stakeholder concern mapping và priority ranking
- [ ] **Lab 2:** 10 concrete quality attribute scenarios đầy đủ 6 phần (2 mỗi attribute: Performance, Availability, Security, Modifiability, Testability)
- [ ] **Lab 3:** Utility tree diagram với rating (Importance, Difficulty) cho tất cả 10 scenarios, danh sách architectural drivers (H,H)
- [ ] **Lab 4:** Scenario-to-tactics mapping table với design decisions và technology choices cho tất cả 10 scenarios
- [ ] **Self-Assessment:** Hoàn thành 30 câu hỏi, tự chấm điểm
- [ ] **Extend Lab (tùy chọn):** Ít nhất 1 bài EL với deliverable tương ứng

---

## Lỗi Thường Gặp

| # | Lỗi | Mô tả | Ví dụ sai | Cách sửa | Ví dụ đúng |
|---|------|--------|-----------|----------|------------|
| 1 | **Scenario quá vague** | Dùng từ mơ hồ, thiếu chỉ số đo lường | "System should be fast" | Thêm response measure cụ thể với số liệu | "Response time < 200ms for 99% requests under 10K concurrent users" |
| 2 | **Thiếu Environment** | Không mô tả điều kiện khi stimulus xảy ra | Chỉ viết "User requests page → response < 1s" | Thêm context: peak/normal, số users, trạng thái hệ thống | "During peak hours (20:00-22:00) with 10K concurrent users" |
| 3 | **Response Measure không testable** | Chỉ số không thể đo hoặc verify tự động | "System responds acceptably" | Dùng số cụ thể + percentile + công cụ đo | "Latency ≤ 500ms for p99, measured by Prometheus" |
| 4 | **Trộn lẫn scenario với design decision** | Scenario chứa implementation details | "Use Redis cache to achieve < 100ms response" | Tách: scenario mô tả WHAT, design decision mô tả HOW | Scenario: "< 100ms response". Decision: "Use Redis" |
| 5 | **Thiếu Stimulus Source** | Không rõ ai/cái gì tạo stimulus | "When attack happens..." | Xác định rõ nguồn | "When external attacker from unknown IP..." |
| 6 | **Rating không có justification** | Gán H/M/L mà không giải thích | "PERF-1: (H,H)" — không lý do | Thêm 1-2 câu giải thích | "(H,H) vì Flash Sale là peak revenue event, cần search nhanh để không mất đơn" |
| 7 | **Bỏ sót quality attributes** | Chỉ viết Performance và Security, quên Modifiability, Testability | Scenario set chỉ có 2 attributes | Cover ít nhất 5 attributes chính | Performance, Availability, Security, Modifiability, Testability |
| 8 | **Giá trị không realistic** | Response measure phi thực tế | "0ms latency", "100% uptime", "handle 1 trillion users" | Dùng industry benchmarks, dữ liệu thực | "< 200ms latency", "99.95% uptime", "10K concurrent users" |
| 9 | **Không xét trade-offs** | Ignore conflicts giữa quality attributes | Yêu cầu max performance VÀ max security mà không acknowledge trade-off | Phân tích trade-off, document quyết định | "Encryption tăng latency 20ms — acceptable cho security gain" |
| 10 | **Scenario không liên quan đến kiến trúc** | Viết scenario về UI details hoặc functional requirements | "Button color should be blue" | Focus vào attributes ảnh hưởng architectural decisions | "When user clicks checkout, order processed < 2s" |

---

## Rubric Chấm điểm

**Tổng điểm: 100**

| Tiêu chí | Điểm | Mô tả chi tiết |
|----------|------|-----------------|
| **Lab 1: Quality Attribute Identification** | **15** | |
| Phân loại đúng ISO 25010 | 5 | Xác định đúng ≥ 6/8 attributes liên quan đến E-Commerce |
| Stakeholder concern mapping | 5 | Map concerns cho ≥ 4 stakeholders, logical reasoning |
| Priority ranking + justification | 5 | Ranking hợp lý với justification rõ ràng |
| **Lab 2: Quality Attribute Scenarios** | **30** | |
| Đủ 10 scenarios, 6 phần mỗi scenario | 10 | Không thiếu phần nào, cover 5 quality attributes |
| Response Measure quantitative & testable | 10 | Có số cụ thể, percentile, measurement method |
| Environment realistic & diverse | 5 | Có peak/normal, số users cụ thể, không generic |
| Scenario quality (clear, architecture-relevant) | 5 | Scenario rõ ràng, ảnh hưởng kiến trúc, không trộn lẫn design decision |
| **Lab 3: Utility Tree** | **25** | |
| Cấu trúc cây đúng (Quality → Sub-attribute → Scenario) | 8 | Hierarchy hợp lý, tất cả 10 scenarios được tổ chức |
| Rating (H/M/L) hợp lý với justification | 8 | Rating có lý do, không đánh đại H cho tất cả |
| Xác định architectural drivers (H,H) | 5 | Liệt kê đúng (H,H) scenarios với giải thích |
| Trade-off analysis | 4 | Xác định ≥ 2 cặp trade-off với giải pháp đề xuất |
| **Lab 4: Scenario-Tactics Mapping** | **20** | |
| Map đúng tactics cho mỗi scenario | 8 | Mỗi scenario có ≥ 1 tactic hợp lý |
| Design decisions cụ thể | 6 | Không chỉ liệt kê tactic mà có quyết định thiết kế rõ ràng |
| Technology/pattern choices justified | 6 | Giải thích tại sao chọn technology/pattern đó |
| **Self-Assessment** | **10** | |
| Hoàn thành 30 câu hỏi | 5 | Trả lời đủ 30 câu |
| Tự đánh giá chính xác (so với đáp án) | 5 | Tỷ lệ đúng ≥ 70% |

**Thang điểm:**

| Mức | Điểm | Mô tả |
|-----|------|-------|
| **Xuất sắc** | 90-100 | Scenarios rõ ràng, đo lường được, utility tree logic, mapping đầy đủ, hiểu sâu trade-offs |
| **Giỏi** | 80-89 | Phần lớn scenarios tốt, utility tree đúng, mapping hợp lý, có trade-off analysis |
| **Khá** | 65-79 | Scenarios cơ bản đúng, một số thiếu response measure hoặc environment, utility tree có cấu trúc |
| **Trung bình** | 50-64 | Thiếu nhiều phần, scenarios vague, utility tree thiếu rating hoặc justification |
| **Yếu** | < 50 | Scenarios không đầy đủ, không có utility tree, không map tactics |

---

## Tài liệu Tham khảo

1. **Bass, Clements, Kazman** — *Software Architecture in Practice*, 4th Edition — Chapters 4-7 (Quality Attributes, Tactics)
2. **SEI/CMU** — Quality Attribute Workshop (QAW) method
3. **ISO/IEC 25010:2011** — Systems and software Quality Requirements and Evaluation (SQuaRE)
4. **Len Bass** — *Architecture Tactics Catalog* — [SEI Resources](https://resources.sei.cmu.edu/)
5. **Neal Ford, Rebecca Parsons** — *Building Evolutionary Architectures* — Architecture Fitness Functions
6. **Google SRE Book** — SLI/SLO/SLA framework — [sre.google](https://sre.google/)
