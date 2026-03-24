# Lab 4.2: Architecture Tradeoff Analysis Method (ATAM)

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 4 giờ |
| **Độ khó** | Intermediate → Advanced |
| **Yêu cầu trước** | Lab 4.1 (Architecture Evaluation Fundamentals) |
| **CLO** | CLO1, CLO2, CLO3 |
| **Framework** | ATAM Methodology (SEI/CMU) |
| **Công cụ** | Markdown, draw.io, whiteboard |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có khả năng:

1. **Giải thích** ATAM methodology, các phases, và vai trò của từng participant trong quy trình đánh giá kiến trúc
2. **Xây dựng** Quality Attribute Utility Tree hoàn chỉnh với scenarios được ưu tiên theo (Importance, Difficulty)
3. **Phân tích** architectural approaches để xác định sensitivity points, tradeoff points, risks và non-risks
4. **Mô phỏng** một phiên ATAM đầy đủ 9 bước với case study thực tế (role-play)
5. **Tổng hợp** kết quả đánh giá thành ATAM Evaluation Report chuyên nghiệp với recommendations

---

## Phân bổ Thời gian

| Thứ tự | Hoạt động | Thời lượng | Hình thức |
|--------|-----------|------------|-----------|
| 1 | Lý thuyết ATAM & 9 Steps | 40 phút | Lecture |
| 2 | Lab 1: Present Business Drivers & Architecture | 30 phút | Cá nhân |
| 3 | Lab 2: Build Utility Tree | 40 phút | Cá nhân / Nhóm |
| 4 | Lab 3: Analyze Architectural Approaches | 40 phút | Nhóm |
| 5 | Lab 4: Full ATAM Session Simulation | 60 phút | Role-play nhóm |
| 6 | Self-Assessment & Review | 20 phút | Cá nhân |
| 7 | Wrap-up & Deliverables | 10 phút | Cá nhân |
| | **Tổng cộng** | **4 giờ** | |

---

## Lý thuyết

### 1. ATAM là gì?

**ATAM (Architecture Tradeoff Analysis Method)** là phương pháp đánh giá kiến trúc phần mềm được phát triển bởi **SEI (Software Engineering Institute)** tại **Carnegie Mellon University (CMU)**. ATAM được thiết kế để:

- **Đánh giá** các quyết định kiến trúc (architectural decisions) dựa trên quality attributes
- **Phát hiện** risks, sensitivity points, và tradeoff points trong kiến trúc
- **Tạo sự đồng thuận** giữa các stakeholders về quality attribute priorities
- **Cung cấp** framework có cấu trúc để phân tích architecture trước khi triển khai

> **Lưu ý**: ATAM không đưa ra kiến trúc mới, mà **đánh giá kiến trúc hiện có** (hoặc đề xuất) dựa trên quality attributes.

### 2. Chín bước (9 Steps) của ATAM

ATAM được tổ chức thành **4 phases** với **9 steps**:

```
╔══════════════════════════════════════════════════════════════════╗
║ PHASE 0: Partnership & Preparation (2-3 tuần trước) ║
║ ┌─────────────────────────────────────────────────────────┐ ║
║ │ - Thống nhất scope, logistics │ ║
║ │ - Xác định stakeholders │ ║
║ │ - Chuẩn bị tài liệu architecture │ ║
║ └─────────────────────────────────────────────────────────┘ ║
╠══════════════════════════════════════════════════════════════════╣
║ PHASE 1: Initial Evaluation (1-2 ngày, evaluation team + ║
║ decision makers) ║
║ ║
║ Step 1: Present ATAM ║
║ │ → Giới thiệu phương pháp cho stakeholders ║
║ ▼ ║
║ Step 2: Present Business Drivers ║
║ │ → Project manager trình bày business context ║
║ ▼ ║
║ Step 3: Present Architecture ║
║ │ → Architect trình bày architecture overview ║
║ ▼ ║
║ Step 4: Identify Architectural Approaches ║
║ │ → Xác định patterns/styles đã dùng ║
║ ▼ ║
║ Step 5: Generate Quality Attribute Utility Tree ║
║ │ → Xây dựng cây utility với scenarios ║
║ ▼ ║
║ Step 6: Analyze Architectural Approaches ║
║ → Phân tích approaches theo top scenarios ║
╠══════════════════════════════════════════════════════════════════╣
║ PHASE 2: Complete Evaluation (1-2 ngày, thêm stakeholders) ║
║ ║
║ Step 7: Brainstorm & Prioritize Scenarios ║
║ │ → Stakeholders brainstorm thêm scenarios, vote ║
║ ▼ ║
║ Step 8: Analyze Architectural Approaches (continued) ║
║ │ → Phân tích thêm với scenarios mới ║
║ ▼ ║
║ Step 9: Present Results ║
║ → Trình bày findings cho tất cả stakeholders ║
╠══════════════════════════════════════════════════════════════════╣
║ PHASE 3: Follow-up (1-2 tuần sau) ║
║ ┌─────────────────────────────────────────────────────────┐ ║
║ │ - Viết final report │ ║
║ │ - Distribute findings │ ║
║ │ - Track action items │ ║
║ └─────────────────────────────────────────────────────────┘ ║
╚══════════════════════════════════════════════════════════════════╝
```

### 3. Vai trò trong ATAM (Roles)

| Nhóm | Vai trò | Trách nhiệm | Ví dụ |
|------|---------|-------------|-------|
| **Evaluation Team** | ATAM Lead / Facilitator | Điều phối phiên đánh giá, giải thích method | External evaluator, Senior architect |
| | Evaluation Team Members | Phân tích architecture, đặt câu hỏi, ghi chép | Architects từ team khác |
| **Project Decision Makers** | Project Manager | Trình bày business drivers, constraints | PM, Product Owner |
| | Lead Architect | Trình bày architecture, trả lời câu hỏi kỹ thuật | Solution Architect |
| | Customer Representative | Cung cấp business perspective | CTO, Business Analyst |
| **Architecture Stakeholders** | Developers | Góc nhìn implementation, feasibility | Dev team leads |
| | Testers | Góc nhìn testability, quality | QA leads |
| | Operators / DevOps | Góc nhìn deployment, operations | SRE, DevOps engineers |
| | End Users | Góc nhìn usability, performance | UX designer, user representatives |

### 4. Outputs của ATAM

ATAM tạo ra **5 loại output chính**:

#### 4.1 Sensitivity Points

**Sensitivity Point** = một quyết định kiến trúc ảnh hưởng đến **một** quality attribute.

| ID | Architectural Decision | QA Affected | Mô tả |
|----|----------------------|-------------|--------|
| S1 | Sử dụng CDN cho static assets | Performance | Thay đổi CDN config trực tiếp ảnh hưởng latency |
| S2 | Connection pool size = 50 | Performance | Tăng/giảm pool size ảnh hưởng throughput |
| S3 | JWT token expiry = 15 phút | Security | Thời gian expire ảnh hưởng mức độ bảo mật |

#### 4.2 Tradeoff Points

**Tradeoff Point** = một quyết định kiến trúc ảnh hưởng đến **nhiều** quality attributes theo các hướng khác nhau.

| ID | Architectural Decision | QA Tích cực | QA Tiêu cực | Mô tả |
|----|----------------------|-------------|-------------|--------|
| T1 | Encrypt tất cả data at rest | Security ↑ | Performance ↓ | Bảo mật tăng nhưng read/write chậm hơn |
| T2 | Microservices architecture | Scalability ↑, Deployability ↑ | Complexity ↑, Performance ↓ | Scale tốt hơn nhưng network overhead |
| T3 | Synchronous API calls | Consistency ↑ | Availability ↓ | Dữ liệu nhất quán nhưng nếu 1 service down thì cascade |

#### 4.3 Risks

**Risk** = quyết định kiến trúc có tiềm ẩn vấn đề (potentially problematic decision).

| ID | Risk | Impact | Likelihood |
|----|------|--------|------------|
| R1 | Không có caching strategy | High latency under load | High |
| R2 | Single database cho mọi services | Single point of failure | Medium |
| R3 | Chưa xác định failover mechanism | Downtime kéo dài khi failure | High |

#### 4.4 Non-risks

**Non-risk** = quyết định kiến trúc đã được đánh giá là hợp lý (sound decision).

| ID | Decision | Rationale |
|----|----------|-----------|
| N1 | PostgreSQL cho order data | ACID transactions, mature ecosystem |
| N2 | OAuth2 + JWT authentication | Industry standard, stateless |
| N3 | Kubernetes cho orchestration | Auto-scaling, self-healing |

#### 4.5 Prioritized Scenarios

Danh sách scenarios được vote và xếp hạng theo business importance và technical risk.

### 5. Utility Tree

Utility Tree là công cụ cốt lõi của ATAM, tổ chức quality attributes thành cây phân cấp:

```
 System Quality
 │
 ┌─────────────────┼──────────────────┐
 │ │ │
 Performance Availability Security
 │ │ │
 ┌──────┴──────┐ ┌────┴────┐ ┌────┴────┐
 │ │ │ │ │ │
 Latency Throughput Uptime Recovery AuthN AuthZ
 │ │ │ │ │ │
 Scenario Scenario Scenario Scenario Scenario Scenario
 (H,H) (M,H) (H,H) (M,M) (H,H) (M,H)
```

Mỗi scenario được gán **2 giá trị ưu tiên**: **(Importance, Difficulty)**

| Rating | Importance (Business Value) | Difficulty (Technical Risk) |
|--------|----------------------------|---------------------------|
| **H** (High) | Rất quan trọng với business | Khó implement, rủi ro cao |
| **M** (Medium) | Quan trọng vừa phải | Complexity trung bình |
| **L** (Low) | Ít quan trọng | Dễ implement, rủi ro thấp |

> **Key Insight**: Scenarios (H,H) cần được phân tích kỹ nhất vì vừa quan trọng với business vừa khó về mặt kỹ thuật.

### 6. Scenario Generation

**Ba loại scenarios** trong ATAM:

| Loại | Mô tả | Ví dụ |
|------|--------|-------|
| **Use Case** | Hoạt động bình thường của hệ thống | "User đặt hàng thành công trong giờ cao điểm" |
| **Growth** | Hệ thống cần scale trong tương lai | "Hệ thống cần hỗ trợ 10x users trong 2 năm tới" |
| **Exploratory** | Câu hỏi what-if, stress test | "Điều gì xảy ra nếu database primary fail?" |

### 7. Architectural Approaches Analysis

Khi phân tích architectural approaches, cần xem xét:

1. **Approach nào đã được áp dụng?** (patterns, tactics, styles)
2. **Approach đó ảnh hưởng đến quality attributes nào?**
3. **Sensitivity points** — thay đổi approach → ảnh hưởng 1 QA
4. **Tradeoff points** — approach tạo conflict giữa các QAs
5. **Risks** — approach có thể gây vấn đề
6. **Non-risks** — approach đã được xác nhận là hợp lý

---

## Step-by-step Labs

### Lab 1: Present Business Drivers & Architecture (30 phút)

**Mục tiêu**: Chuẩn bị bài trình bày về business drivers và architecture overview — tương ứng Step 2 và Step 3 của ATAM.

**Case Study**: E-Commerce Platform "ShopVN"

> **Bối cảnh**: ShopVN là nền tảng thương mại điện tử với 500K users, cần mở rộng lên 2M users trong 18 tháng tới. Hệ thống hiện tại gặp vấn đề performance khi flash sale và chưa có strategy rõ ràng cho high availability.

#### Task 1.1: Viết Business Drivers Document

Sử dụng template sau để tổng hợp business drivers:

```markdown
# Business Drivers — ShopVN E-Commerce Platform

## 1. Business Context
- **Domain**: E-commerce (B2C)
- **Quy mô hiện tại**: 500K registered users, 50K daily active users
- **Mục tiêu**: Mở rộng lên 2M users trong 18 tháng

## 2. Key Business Goals
| # | Business Goal | Priority |
|---|---------------|----------|
| BG1 | Tăng conversion rate 20% thông qua performance improvement | High |
| BG2 | Hỗ trợ flash sale với 10x traffic spike | High |
| BG3 | Giảm downtime xuống < 0.1% (99.9% uptime) | High |
| BG4 | Tích hợp thêm 5 payment gateways trong 6 tháng | Medium |
| BG5 | Ra mắt mobile app trong Q3 | Medium |

## 3. Key Constraints
- Budget: $500K cho infrastructure upgrade
- Team: 15 developers, 3 DevOps
- Timeline: 18 tháng
- Regulatory: PCI-DSS compliance cho payment

## 4. Key Quality Attributes
- Performance (response time, throughput)
- Availability (uptime, disaster recovery)
- Scalability (horizontal scaling)
- Security (data protection, authentication)
- Modifiability (thêm features mới nhanh)
```

#### Task 1.2: Viết Architecture Overview

```markdown
# Architecture Overview — ShopVN

## Architecture Style
Microservices architecture với API Gateway

## Technology Stack
| Component | Technology |
|-----------|-----------|
| API Gateway | Kong / Nginx |
| Services | Java Spring Boot, Node.js |
| Database | PostgreSQL (orders), MongoDB (catalog) |
| Cache | Redis |
| Message Queue | RabbitMQ |
| Search | Elasticsearch |
| Orchestration | Kubernetes on AWS EKS |
| CDN | CloudFront |
| Monitoring | Prometheus + Grafana |

## Key Services
1. User Service — authentication, profile management
2. Catalog Service — product listing, search
3. Order Service — order management, workflow
4. Payment Service — payment processing, refund
5. Notification Service — email, SMS, push
6. Inventory Service — stock management

## Architecture Diagram (mô tả text)
┌──────────┐ ┌─────────────┐ ┌────────────────────────┐
│ Client │───│ API Gateway │───│ Microservices Cluster │
│ (Web/App)│ │ (Kong) │ │ ┌────┐ ┌─────┐ ┌────┐ │
└──────────┘ └─────────────┘ │ │User│ │Order│ │Pay │ │
 │ └─┬──┘ └──┬──┘ └─┬──┘ │
 │ │ │ │ │
 │ ┌─▼──┐ ┌──▼──┐ ┌─▼──┐│
 │ │ PG │ │ PG │ │ PG ││
 │ └────┘ └─────┘ └────┘│
 └────────────────────────┘
```

**Deliverable Lab 1**: Nộp file `business-drivers.md` và `architecture-overview.md`.

---

### Lab 2: Build Utility Tree (40 phút)

**Mục tiêu**: Xây dựng Quality Attribute Utility Tree hoàn chỉnh với scenarios — tương ứng Step 5 của ATAM.

#### Task 2.1: Tham khảo Utility Tree mẫu

Dưới đây là ví dụ Utility Tree cho ShopVN:

```
Quality Attributes (ShopVN E-Commerce)
│
├── Performance
│ ├── Latency
│ │ ├── (H,H) Homepage loads in < 2s under 1000 concurrent users
│ │ ├── (H,M) Product search returns results in < 500ms
│ │ └── (M,M) Checkout flow completes in < 3s end-to-end
│ ├── Throughput
│ │ ├── (H,H) System handles 500 orders/minute during flash sale
│ │ └── (M,H) API Gateway handles 10,000 requests/second
│ └── Resource Usage
│ └── (L,M) CPU usage stays under 70% during normal load
│
├── Availability
│ ├── Uptime
│ │ ├── (H,H) 99.9% availability = max 8.76 hours downtime/year
│ │ └── (H,M) Zero downtime deployment cho critical services
│ ├── Fault Tolerance
│ │ ├── (H,H) System continues operating when 1 service instance fails
│ │ └── (M,H) Graceful degradation khi external payment gateway down
│ └── Recovery
│ └── (M,M) Recovery Time Objective (RTO) < 5 minutes
│
├── Security
│ ├── Authentication
│ │ ├── (H,H) All API endpoints require valid JWT token
│ │ └── (H,M) MFA cho admin và seller accounts
│ ├── Authorization
│ │ └── (M,H) Role-based access control với least privilege
│ ├── Data Protection
│ │ ├── (H,H) PCI-DSS compliance cho payment data
│ │ └── (M,M) All data encrypted in transit (TLS 1.3)
│ └── Audit
│ └── (M,M) Mọi transaction được logged cho audit trail
│
├── Scalability
│ ├── Horizontal Scaling
│ │ ├── (H,H) Auto-scale từ 5 lên 50 instances trong 5 phút
│ │ └── (M,M) Database read replicas cho query-heavy services
│ └── Data Scaling
│ └── (M,H) Support 100M products trong catalog
│
└── Modifiability
 ├── Feature Addition
 │ ├── (M,M) Thêm payment method mới trong < 3 person-days
 │ └── (L,M) Thêm notification channel mới trong < 1 person-day
 └── Technology Change
 └── (L,L) Thay đổi database engine cho 1 service không ảnh hưởng services khác
```

#### Task 2.2: Tự xây dựng Utility Tree

**Yêu cầu**: Tạo Utility Tree cho ShopVN với các quality attributes sau. Mỗi attribute cần tối thiểu **2 scenarios** với priority rating (Importance, Difficulty):

| Quality Attribute | Số scenarios tối thiểu |
|-------------------|----------------------|
| Performance | 3 |
| Availability | 2 |
| Security | 3 |
| Scalability | 2 |

**Template**:

```
Quality Attributes
│
├── Performance
│ ├── [Refinement 1]
│ │ └── (?, ?) [Mô tả scenario cụ thể, đo lường được]
│ ├── [Refinement 2]
│ │ └── (?, ?) [Scenario]
│ └── [Refinement 3]
│ └── (?, ?) [Scenario]
│
├── Availability
│ ├── [Refinement 1]
│ │ └── (?, ?) [Scenario]
│ └── [Refinement 2]
│ └── (?, ?) [Scenario]
│
├── Security
│ ├── [Refinement 1]
│ │ └── (?, ?) [Scenario]
│ ├── [Refinement 2]
│ │ └── (?, ?) [Scenario]
│ └── [Refinement 3]
│ └── (?, ?) [Scenario]
│
└── Scalability
 ├── [Refinement 1]
 │ └── (?, ?) [Scenario]
 └── [Refinement 2]
 └── (?, ?) [Scenario]
```

> **Hướng dẫn viết scenario tốt**: Scenario phải **cụ thể**, **đo lường được**, và có **context** rõ ràng.
>
> - **Tốt**: "Homepage loads in < 2 seconds under 1000 concurrent users"
> - **Xấu**: "System should be fast"

**Deliverable Lab 2**: Nộp file `utility-tree.md`.

---

### Lab 3: Analyze Architectural Approaches (40 phút)

**Mục tiêu**: Phân tích các architectural approaches để xác định sensitivity points, tradeoff points, risks, và non-risks — tương ứng Step 4 + Step 6 của ATAM.

#### Task 3.1: Liệt kê Architectural Approaches

Cho kiến trúc ShopVN, các architectural approaches chính:

| # | Architectural Approach | Mô tả |
|---|----------------------|-------|
| AA1 | Microservices Architecture | Tách hệ thống thành 6 services độc lập |
| AA2 | PostgreSQL cho transactional data | RDBMS cho orders, payments, users |
| AA3 | Redis caching layer | Cache hot data, session, rate limiting |
| AA4 | RabbitMQ async messaging | Event-driven communication giữa services |
| AA5 | Kubernetes orchestration | Container orchestration, auto-scaling |
| AA6 | API Gateway pattern (Kong) | Single entry point, routing, rate limiting |
| AA7 | CQRS cho Order Service | Tách read/write model cho order processing |

#### Task 3.2: Phân tích từng Approach

Sử dụng template sau cho **mỗi** architectural approach:

```markdown
### Approach: [Tên Approach]

**Mô tả**: [Giải thích ngắn]

**Scenarios liên quan**: [List scenarios từ Utility Tree]

| Loại | ID | Mô tả |
|------|----|-------|
| Sensitivity Point | S-? | [Mô tả] |
| Tradeoff Point | T-? | [Mô tả — QA↑ vs QA↓] |
| Risk | R-? | [Mô tả — impact + likelihood] |
| Non-risk | N-? | [Mô tả — rationale] |
```

**Ví dụ phân tích cho AA1 (Microservices)**:

| Loại | ID | Mô tả |
|------|----|-------|
| Sensitivity | S1 | Service granularity ảnh hưởng trực tiếp đến deployment complexity |
| Sensitivity | S2 | Inter-service communication latency ảnh hưởng response time |
| Tradeoff | T1 | Scalability ↑ nhưng Operational Complexity ↑ (cần K8s, service mesh) |
| Tradeoff | T2 | Deployability ↑ (deploy từng service) nhưng Consistency ↓ (distributed data) |
| Risk | R1 | Network partition giữa services gây data inconsistency |
| Risk | R2 | Chưa có distributed tracing → khó debug production issues |
| Non-risk | N1 | Mỗi service có database riêng → independent evolution |
| Non-risk | N2 | Container-based → portable across cloud providers |

#### Task 3.3: Tổng hợp Analysis

Hoàn thành bảng tổng hợp cho **tất cả 7 approaches**:

| Approach | Sensitivity Points | Tradeoff Points | Risks | Non-risks |
|----------|-------------------|-----------------|-------|-----------|
| AA1: Microservices | S1, S2 | T1, T2 | R1, R2 | N1, N2 |
| AA2: PostgreSQL | | | | |
| AA3: Redis Cache | | | | |
| AA4: RabbitMQ | | | | |
| AA5: Kubernetes | | | | |
| AA6: API Gateway | | | | |
| AA7: CQRS | | | | |

**Deliverable Lab 3**: Nộp file `approach-analysis.md` với phân tích đầy đủ.

---

### Lab 4: Full ATAM Session Simulation (60 phút)

**Mục tiêu**: Mô phỏng đầy đủ 9 bước ATAM với case study e-commerce, đóng vai (role-play) các vai trò khác nhau.

#### Phân công vai trò (Nhóm 4-6 người)

| Vai trò | Số người | Trách nhiệm trong simulation |
|---------|----------|------------------------------|
| ATAM Lead (Facilitator) | 1 | Điều phối toàn bộ phiên, giải thích method |
| Architect | 1 | Trình bày architecture, trả lời câu hỏi |
| Project Manager | 1 | Trình bày business drivers |
| Developer Stakeholder | 1 | Đặt câu hỏi từ góc nhìn implementation |
| QA/Ops Stakeholder | 1 | Đặt câu hỏi từ góc nhìn testing & operations |
| Scribe (Note-taker) | 1 | Ghi chép mọi findings |

#### Chạy 9 Steps

**Step 1: Present ATAM (5 phút)**
ATAM Lead giải thích cho "stakeholders":
- ATAM là gì, mục đích
- Quy trình 9 bước
- Kết quả mong đợi (risks, tradeoffs, sensitivity points)
- Kỳ vọng từ participants

**Step 2: Present Business Drivers (5 phút)**
Project Manager trình bày (sử dụng kết quả Lab 1):
- Business context và goals
- Key constraints
- Quality attribute priorities
- Stakeholder concerns

**Step 3: Present Architecture (10 phút)**
Architect trình bày:
- Architecture overview diagram
- Key components và responsibilities
- Technology stack
- Data flow
- Deployment model

**Step 4: Identify Architectural Approaches (5 phút)**
ATAM Lead cùng team liệt kê:
- Patterns đã dùng (microservices, CQRS, event-driven, ...)
- Tactics đã áp dụng (caching, load balancing, replication, ...)
- Styles (REST, async messaging, ...)

**Step 5: Generate Quality Attribute Utility Tree (10 phút)**
Cả team cùng xây dựng (sử dụng kết quả Lab 2):
- Liệt kê quality attributes
- Refine thành sub-attributes
- Viết scenarios cụ thể
- Assign priority (H/M/L, H/M/L)
- Chọn top 5-8 scenarios (H,H) và (H,M) để phân tích

**Step 6: Analyze Architectural Approaches — Round 1 (10 phút)**
Với mỗi top scenario:
- Approach nào support scenario này?
- Xác định sensitivity points
- Xác định tradeoff points
- Ghi nhận risks và non-risks

**Step 7: Brainstorm & Prioritize Scenarios (5 phút)**
Mở rộng scenarios:
- Mỗi stakeholder brainstorm thêm 2-3 scenarios
- Gom lại toàn bộ scenarios
- Mỗi người vote 5 dots cho scenarios quan trọng nhất
- Xếp hạng theo tổng votes

**Step 8: Analyze Architectural Approaches — Round 2 (5 phút)**
Phân tích thêm cho scenarios mới được vote cao:
- Lặp lại quy trình Step 6
- Tìm thêm risks và tradeoffs

**Step 9: Present Results (5 phút)**
ATAM Lead tổng hợp và trình bày:
- Tổng quan findings
- Danh sách risks (xếp theo severity)
- Sensitivity points và tradeoff points
- Top scenarios và analysis
- Recommendations

#### Template ATAM Evaluation Report

```markdown
# ATAM Evaluation Report — ShopVN E-Commerce

## 1. Executive Summary
[Tóm tắt 3-5 câu: scope, key findings, top risks]

## 2. Evaluation Context
- **Ngày đánh giá**: [DD/MM/YYYY]
- **Evaluation Team**: [Danh sách]
- **Stakeholders tham gia**: [Danh sách]
- **Architecture version**: [Version]

## 3. Business Drivers
| # | Goal | Priority |
|---|------|----------|
| BG1 | [Goal] | H/M/L |

## 4. Architecture Overview
[Mô tả ngắn + diagram reference]

## 5. Architectural Approaches Identified
| # | Approach | Description |
|---|----------|-------------|
| AA1 | [Approach] | [Description] |

## 6. Quality Attribute Utility Tree
[Paste utility tree]

## 7. Scenario Prioritization
| Rank | Scenario | Type | Votes | Priority |
|------|----------|------|-------|----------|
| 1 | [Scenario] | Use Case/Growth/Exploratory | [N] | (H,H) |

## 8. Analysis Results

### 8.1 Sensitivity Points
| ID | Approach | Affected QA | Description |
|----|----------|-------------|-------------|
| S1 | AA1 | Performance | [Description] |

### 8.2 Tradeoff Points
| ID | Approach | QA Positive | QA Negative | Description |
|----|----------|-------------|-------------|-------------|
| T1 | AA1 | Scalability | Complexity | [Description] |

### 8.3 Risks
| ID | Risk | Approach | Impact | Likelihood | Mitigation |
|----|------|----------|--------|------------|------------|
| R1 | [Risk] | AA1 | H/M/L | H/M/L | [Mitigation] |

### 8.4 Non-risks
| ID | Decision | Rationale |
|----|----------|-----------|
| N1 | [Decision] | [Rationale] |

## 9. Recommendations
| # | Recommendation | Priority | Effort |
|---|---------------|----------|--------|
| 1 | [Recommendation] | H/M/L | H/M/L |

## 10. Appendix
- Brainstormed scenarios (full list)
- Meeting notes
- Voting results
```

**Deliverable Lab 4**: Nộp file `atam-report.md` hoàn chỉnh.

---

## Self-Assessment (30 câu)

### Band 1 — Cơ bản (Câu 1-10)

**Câu 1**: ATAM là viết tắt của gì?

> **Đáp án**: **Architecture Tradeoff Analysis Method** — phương pháp phân tích tradeoff kiến trúc phần mềm, được phát triển bởi SEI tại Carnegie Mellon University.

**Câu 2**: ATAM được phát triển bởi tổ chức nào?

> **Đáp án**: **SEI (Software Engineering Institute)** tại **Carnegie Mellon University (CMU)**. ATAM được giới thiệu lần đầu bởi Rick Kazman, Mark Klein, và Paul Clements.

**Câu 3**: Mục đích chính của ATAM là gì?

> **Đáp án**: Mục đích chính là **đánh giá các quyết định kiến trúc** (architectural decisions) dựa trên quality attributes. ATAM giúp: (1) phát hiện risks, (2) xác định sensitivity points và tradeoff points, (3) tạo sự đồng thuận giữa stakeholders về chất lượng kiến trúc.

**Câu 4**: ATAM đánh giá cái gì — code, design, hay architecture?

> **Đáp án**: ATAM đánh giá **software architecture** (kiến trúc phần mềm), không phải code hay detailed design. ATAM tập trung vào architectural decisions và ảnh hưởng của chúng đến quality attributes. ATAM có thể đánh giá kiến trúc đã triển khai hoặc kiến trúc đề xuất (proposed).

**Câu 5**: Utility Tree trong ATAM dùng để làm gì?

> **Đáp án**: Utility Tree dùng để **tổ chức và ưu tiên hóa quality attribute scenarios**. Cây utility phân cấp: Quality Attribute → Refinement → Scenario, mỗi scenario được gán priority (Importance, Difficulty) với giá trị H/M/L. Utility Tree giúp team tập trung phân tích vào scenarios quan trọng nhất.

**Câu 6**: Scenario trong ATAM là gì? Cho ví dụ.

> **Đáp án**: Scenario là **mô tả cụ thể, đo lường được** về cách hệ thống cần hoạt động dưới một quality attribute. Có 3 loại: (1) **Use Case** — hoạt động bình thường, (2) **Growth** — scaling tương lai, (3) **Exploratory** — what-if. Ví dụ: "Homepage loads in < 2 seconds under 1000 concurrent users" (use case scenario cho Performance/Latency).

**Câu 7**: Ai tham gia trong ATAM evaluation?

> **Đáp án**: Ba nhóm chính: (1) **Evaluation Team** — ATAM lead và members, điều phối và phân tích; (2) **Project Decision Makers** — PM, architect, customer, có quyền ra quyết định; (3) **Architecture Stakeholders** — developers, testers, operators, end users, cung cấp góc nhìn đa chiều.

**Câu 8**: Quality Attribute trong ATAM bao gồm những gì?

> **Đáp án**: Quality Attributes (thuộc tính chất lượng) là các đặc tính phi chức năng của hệ thống, bao gồm: **Performance** (hiệu năng), **Availability** (khả dụng), **Security** (bảo mật), **Modifiability** (khả năng thay đổi), **Scalability** (khả năng mở rộng), **Usability** (tính dễ sử dụng), **Testability** (khả năng kiểm thử), **Interoperability** (khả năng tương tác).

**Câu 9**: Architectural approach là gì?

> **Đáp án**: Architectural approach là **pattern, tactic, hoặc style** được áp dụng trong kiến trúc để đạt quality attributes. Ví dụ: microservices (scalability), caching (performance), replication (availability), encryption (security). Mỗi approach ảnh hưởng đến một hoặc nhiều quality attributes.

**Câu 10**: ATAM có bao nhiêu phases và bao nhiêu steps?

> **Đáp án**: ATAM có **4 phases** và **9 steps**. Phase 0: Partnership & Preparation. Phase 1: Initial Evaluation (Steps 1-6). Phase 2: Complete Evaluation (Steps 7-9). Phase 3: Follow-up. Phases 1 và 2 là core evaluation, thường diễn ra trong 2-4 ngày.

### Band 2 — Trung bình (Câu 11-20)

**Câu 11**: Sensitivity Point là gì? Cho ví dụ.

> **Đáp án**: Sensitivity Point là quyết định kiến trúc mà khi thay đổi sẽ ảnh hưởng đến **một** quality attribute cụ thể. Ví dụ: "Connection pool size = 50" là sensitivity point cho Performance — tăng pool size sẽ cải thiện throughput, giảm pool size sẽ làm giảm throughput. Chỉ Performance bị ảnh hưởng.

**Câu 12**: Tradeoff Point là gì? Cho ví dụ.

> **Đáp án**: Tradeoff Point là quyết định kiến trúc ảnh hưởng đến **nhiều** quality attributes theo **các hướng khác nhau** (cải thiện QA này nhưng làm giảm QA khác). Ví dụ: "Encrypt tất cả data at rest" → Security ↑ nhưng Performance ↓. "Dùng microservices" → Scalability ↑ nhưng Complexity ↑ và Consistency ↓.

**Câu 13**: Risk trong ATAM là gì? Phân biệt với Non-risk.

> **Đáp án**: **Risk** là quyết định kiến trúc có tiềm ẩn vấn đề (potentially problematic). Ví dụ: "Không có caching strategy" → risk cho performance. **Non-risk** là quyết định đã được đánh giá là hợp lý. Ví dụ: "Dùng PostgreSQL cho ACID transactions" → non-risk vì đây là lựa chọn phù hợp và đã được chứng minh.

**Câu 14**: Prioritize scenarios bằng cách nào trong ATAM?

> **Đáp án**: Sử dụng phương pháp **dot voting**: mỗi stakeholder được cấp N dots (thường 5-7), bỏ phiếu cho scenarios quan trọng nhất. Có thể dồn nhiều dots vào 1 scenario. Tổng votes xác định thứ tự ưu tiên. Ngoài ra, Utility Tree sử dụng cặp giá trị (Importance, Difficulty) để ưu tiên — scenarios (H,H) cần phân tích kỹ nhất.

**Câu 15**: ATAM evaluation team gồm những ai và vai trò cụ thể?

> **Đáp án**: Evaluation team gồm: (1) **ATAM Lead/Facilitator** — điều phối phiên, giải thích method, đặt câu hỏi; (2) **Evaluation Team Members** — phân tích architecture, xác định risks; (3) **Scribe** — ghi chép findings. Evaluation team thường là **external** (không phải từ project đang đánh giá) để đảm bảo tính khách quan.

**Câu 16**: Phase 0 (Preparation) cần làm gì?

> **Đáp án**: Phase 0 diễn ra **2-3 tuần trước evaluation**, bao gồm: (1) Xác định scope và mục tiêu evaluation; (2) Identify stakeholders và mời tham gia; (3) Thu thập tài liệu architecture (diagrams, documentation); (4) Logistics — book phòng, thời gian, agenda; (5) Brief architect về cách trình bày architecture; (6) Evaluation team review tài liệu trước.

**Câu 17**: Step 6 và Step 8 đều là "Analyze Architectural Approaches" — khác nhau thế nào?

> **Đáp án**: **Step 6** (Phase 1) phân tích dựa trên scenarios từ **Utility Tree** do evaluation team và decision makers tạo ra. **Step 8** (Phase 2) phân tích dựa trên scenarios mới từ **brainstorming** ở Step 7 với sự tham gia của **nhiều stakeholders hơn**. Step 8 thường phát hiện thêm risks và tradeoffs mà Step 6 bỏ sót vì có thêm perspectives.

**Câu 18**: Phase 3 (Follow-up) bao gồm những gì?

> **Đáp án**: Phase 3 diễn ra **1-2 tuần sau evaluation**, bao gồm: (1) Viết ATAM Evaluation Report hoàn chỉnh; (2) Distribute report cho tất cả stakeholders; (3) Tạo action items từ findings; (4) Prioritize risks cần mitigate; (5) Track progress của recommendations. Đây là phase quan trọng nhưng thường bị bỏ qua.

**Câu 19**: Khi nào nên dùng ATAM?

> **Đáp án**: Nên dùng ATAM khi: (1) Hệ thống có **nhiều quality attributes quan trọng** cần balance; (2) **Early-stage** — kiến trúc đã được đề xuất nhưng chưa implement hoàn toàn; (3) Hệ thống **critical** — banking, healthcare, e-commerce quy mô lớn; (4) Có **nhiều stakeholders** với concerns khác nhau; (5) Cần **đồng thuận** về architectural decisions. Không phù hợp cho hệ thống nhỏ, đơn giản.

**Câu 20**: Ba loại scenarios (Use Case, Growth, Exploratory) khác nhau thế nào?

> **Đáp án**: (1) **Use Case Scenario**: mô tả hoạt động bình thường — "User search product và nhận kết quả trong < 500ms". (2) **Growth Scenario**: mô tả scaling tương lai — "Hệ thống cần hỗ trợ 10x users trong 2 năm". (3) **Exploratory Scenario**: mô tả what-if situations — "Điều gì xảy ra nếu primary database fail?". Growth và Exploratory thường phát hiện nhiều risks hơn Use Case.

### Band 3 — Nâng cao (Câu 21-30)

**Câu 21**: So sánh ATAM và SAAM — khác nhau thế nào?

> **Đáp án**: **SAAM (Software Architecture Analysis Method)** là predecessor của ATAM, tập trung vào **modifiability** (1 quality attribute). **ATAM** mở rộng SAAM để phân tích **nhiều quality attributes** đồng thời và đặc biệt tập trung vào **tradeoffs** giữa các QAs. ATAM phức tạp hơn, cần nhiều stakeholders hơn, nhưng cho kết quả toàn diện hơn. SAAM phù hợp khi chỉ quan tâm modifiability.

**Câu 22**: So sánh ATAM với Architecture Review Board — dùng khi nào?

> **Đáp án**: **ATAM** là phương pháp đánh giá chính thức (formal), sử dụng cho major architectural decisions, thường 2-4 ngày, cần external team. **Architecture Review Board (ARB)** là cơ chế governance liên tục (ongoing), thường là cuộc họp định kỳ (weekly/bi-weekly), nội bộ team, review incremental changes. Nên dùng ATAM cho initial architecture hoặc major changes; ARB cho day-to-day governance.

**Câu 23**: Chi phí (cost) của ATAM evaluation là bao nhiêu?

> **Đáp án**: Typical cost: (1) **Preparation**: 2-3 person-weeks; (2) **Evaluation**: 2-4 days x 5-15 people = 10-60 person-days; (3) **Follow-up**: 1-2 person-weeks. Tổng: khoảng **70-120 person-days** cho full ATAM. Nghiên cứu của SEI cho thấy ATAM cost ~ 1-3% tổng project effort nhưng **phát hiện risks sớm giúp tiết kiệm 10-100x** chi phí sửa lỗi sau deployment.

**Câu 24**: ATAM phù hợp với Agile development không? Nếu có thì adapt thế nào?

> **Đáp án**: ATAM truyền thống (full ceremony) **không phù hợp** với Agile vì quá heavy và waterfall-oriented. Tuy nhiên, có thể **adapt** bằng: (1) **Lightweight ATAM** — rút gọn thành 1/2 ngày; (2) **Mini-ATAM** mỗi sprint cho major architecture changes; (3) Tích hợp utility tree vào product backlog refinement; (4) Continuous scenario evaluation thay vì one-time event. Concept "architecture runway" trong SAFe cũng kết hợp với ATAM.

**Câu 25**: Lightweight ATAM là gì?

> **Đáp án**: Lightweight ATAM là phiên bản rút gọn, thường **nửa ngày đến 1 ngày**, tập trung vào: (1) Top 3-5 quality attributes thay vì tất cả; (2) Utility tree đơn giản với 10-15 scenarios; (3) Ít stakeholders hơn (5-8 người); (4) Tập trung vào risks cao nhất. Phù hợp cho: (a) Agile projects, (b) smaller systems, (c) periodic re-evaluation, (d) budget-constrained teams.

**Câu 26**: ATAM tạo ra những outputs chính nào?

> **Đáp án**: Năm outputs chính: (1) **Sensitivity Points** — decisions ảnh hưởng 1 QA; (2) **Tradeoff Points** — decisions ảnh hưởng nhiều QAs theo hướng khác nhau; (3) **Risks** — decisions có tiềm ẩn vấn đề; (4) **Non-risks** — decisions hợp lý, đã verified; (5) **Prioritized Scenarios** — ranked by business importance. Ngoài ra còn có: architectural approaches catalog, utility tree, và recommendations.

**Câu 27**: Làm sao present ATAM findings hiệu quả cho stakeholders?

> **Đáp án**: Best practices: (1) **Executive Summary** trước — 3-5 bullet points cho management; (2) **Visual aids** — risk heatmap, tradeoff matrix, utility tree diagram; (3) **Prioritize findings** — top 5 risks trước, không dump toàn bộ; (4) **Actionable recommendations** — mỗi risk kèm mitigation strategy; (5) **Different views** cho different audiences — technical detail cho dev team, business impact cho management; (6) Kết thúc bằng **concrete next steps** và timeline.

**Câu 28**: ATAM có những limitations gì?

> **Đáp án**: (1) **Cost cao** — cần nhiều person-days và stakeholder commitment; (2) **Snapshot evaluation** — đánh giá tại một thời điểm, không continuous; (3) **Phụ thuộc facilitator** — chất lượng evaluation phụ thuộc nhiều vào kinh nghiệm ATAM lead; (4) **Architecture documentation** — cần documentation tốt, nhiều project thiếu; (5) **Không cover tất cả risks** — chỉ tìm risks liên quan đến quality attributes đã chọn; (6) **Subjective elements** — priority ratings và scenario generation phụ thuộc participants.

**Câu 29**: ATAM success factors — yếu tố nào giúp ATAM thành công?

> **Đáp án**: (1) **Stakeholder engagement** — đủ và đúng stakeholders tham gia; (2) **Architecture documentation** — có sẵn và up-to-date; (3) **Experienced facilitator** — ATAM lead có kinh nghiệm; (4) **Management support** — leadership ủng hộ và commit resources; (5) **Clear scope** — xác định rõ evaluation scope; (6) **Follow-through** — thực hiện recommendations sau evaluation; (7) **Safe environment** — stakeholders cảm thấy thoải mái nêu concerns.

**Câu 30**: Continuous architecture evaluation là gì? Liên hệ với ATAM?

> **Đáp án**: Continuous architecture evaluation là quá trình **đánh giá kiến trúc liên tục** (ongoing) thay vì one-time event. Liên hệ ATAM: (1) Sử dụng **Architecture Fitness Functions** (tự động kiểm tra architectural constraints trong CI/CD); (2) **Periodic lightweight ATAM** mỗi quarter; (3) Duy trì và cập nhật **living utility tree** trong wiki/docs; (4) **Architecture Decision Records (ADRs)** ghi nhận mọi decisions; (5) **Metrics-driven** — đo quality attributes thực tế vs scenarios. Phù hợp Agile và DevOps.

---

## Extend Labs (10 bài)

### EL1: Full ATAM Workshop — Healthcare System *****

**Mục tiêu**: Thực hiện ATAM workshop đầy đủ 9 steps cho Healthcare Management System.

**Yêu cầu**:
- Tổ chức workshop 3 buổi (preparation, evaluation, follow-up)
- Phân vai đầy đủ: evaluation team, decision makers, stakeholders
- Business drivers: HIPAA compliance, 24/7 availability, EHR integration
- Tạo utility tree với tối thiểu 20 scenarios
- Xác định ≥ 10 risks, ≥ 5 tradeoff points
- Viết ATAM report hoàn chỉnh (≥ 10 trang)

### EL2: E-Commerce ATAM — Flash Sale Focus ****

**Mục tiêu**: Đánh giá kiến trúc e-commerce tập trung vào flash sale performance.

**Yêu cầu**:
- Kiến trúc: microservices, Redis, Kafka, K8s
- Focus: Performance và Scalability scenarios cho flash sale (100x traffic spike)
- Brainstorm ≥ 15 scenarios, prioritize top 8
- Phân tích tradeoffs: consistency vs availability khi flash sale
- Đề xuất ≥ 5 mitigations cho top risks

### EL3: Banking System ATAM — Security Focus *****

**Mục tiêu**: ATAM cho core banking system với focus security & compliance.

**Yêu cầu**:
- Regulatory requirements: PCI-DSS, SOX, data residency
- Quality attributes chính: Security, Availability, Auditability
- Xác định security-related sensitivity và tradeoff points
- Risk assessment chi tiết với impact x likelihood matrix
- Compliance mapping: architectural decisions → regulatory requirements

### EL4: Microservices Migration ATAM ****

**Mục tiêu**: Đánh giá kiến trúc migration từ monolith sang microservices.

**Yêu cầu**:
- So sánh current (monolith) vs target (microservices) architecture
- Utility tree cho cả hai architectures
- Identify migration risks và tradeoffs
- Scenarios tập trung: service boundaries, data consistency, deployment complexity
- Propose phased migration strategy dựa trên ATAM findings

### EL5: Legacy System Modernization ATAM ****

**Mục tiêu**: ATAM cho legacy system modernization (strangler fig pattern).

**Yêu cầu**:
- Legacy: COBOL/mainframe, 30 năm tuổi
- Target: cloud-native, API-first
- Scenarios: coexistence period, data sync, feature parity
- Risks: data migration, skill gap, business continuity
- Tradeoff analysis: big bang vs incremental migration

### EL6: Cloud Migration ATAM ****

**Mục tiêu**: Đánh giá readiness và risks cho cloud migration.

**Yêu cầu**:
- Cloud patterns: multi-region, auto-scaling, managed services
- Quality attributes: Cost Efficiency, Availability, Security, Vendor Lock-in
- Scenarios: region failover, cost spike, data sovereignty
- Tradeoff analysis: managed services vs self-hosted (control vs cost)
- Risk: vendor lock-in → mitigation strategies

### EL7: Lightweight ATAM Sprint ***

**Mục tiêu**: Thực hiện lightweight ATAM trong 2 giờ.

**Yêu cầu**:
- Chọn 3 quality attributes quan trọng nhất
- Utility tree tối giản: 10 scenarios
- Focus trên top 5 scenarios (H,H)
- Quick risk identification và prioritization
- Output: 1-page summary với top 3 risks và recommendations

### EL8: Continuous Architecture Evaluation ****

**Mục tiêu**: Thiết kế continuous evaluation framework dựa trên ATAM concepts.

**Yêu cầu**:
- Định nghĩa Architecture Fitness Functions cho top scenarios
- Tích hợp fitness functions vào CI/CD pipeline
- Dashboard: quality attribute metrics vs targets
- Alerting: khi fitness function fail
- Quarterly lightweight ATAM review process

### EL9: ATAM Presentation & Communication ***

**Mục tiêu**: Tạo executive presentation từ ATAM findings.

**Yêu cầu**:
- Slide deck ≤ 15 slides cho C-level audience
- Risk heatmap visualization (impact x likelihood)
- Tradeoff matrix visualization
- Business impact quantification (ước tính $ impact của risks)
- Action plan với timeline và resource requirements

### EL10: ATAM Tooling Development *****

**Mục tiêu**: Xây dựng tool hỗ trợ ATAM evaluation process.

**Yêu cầu**:
- Web application cho ATAM session management
- Features: utility tree builder, scenario voting, risk tracking
- Tradeoff visualization (graph: QA relationships)
- Auto-generate ATAM report (Markdown/PDF)
- Collaborative: multiple users, real-time updates
- Tech stack tự chọn (recommend: React + Node.js hoặc Python Flask)

---

## Deliverables

Checklist bài nộp:

- [ ] **Lab 1**: `business-drivers.md` — Business drivers document cho ShopVN
- [ ] **Lab 1**: `architecture-overview.md` — Architecture overview với diagram
- [ ] **Lab 2**: `utility-tree.md` — Quality Attribute Utility Tree (≥ 10 scenarios, có priority ratings)
- [ ] **Lab 3**: `approach-analysis.md` — Phân tích 7 architectural approaches (sensitivity, tradeoff, risk, non-risk)
- [ ] **Lab 4**: `atam-report.md` — ATAM Evaluation Report hoàn chỉnh
- [ ] **Self-Assessment**: Trả lời 30 câu hỏi (tự kiểm tra, không cần nộp)

---

## Lỗi Thường Gặp

| # | Lỗi | Mô tả | Cách sửa |
|---|------|--------|----------|
| 1 | Scenario quá mơ hồ | "System should be fast" — không đo lường được | Viết cụ thể: "Page load < 2s under 1000 users" |
| 2 | Thiếu priority rating | Không gán (Importance, Difficulty) cho scenarios | Mọi scenario phải có (H/M/L, H/M/L) |
| 3 | Nhầm Sensitivity với Tradeoff | Gọi tradeoff point là sensitivity point | Sensitivity = 1 QA; Tradeoff = nhiều QAs xung đột |
| 4 | Bỏ qua stakeholder concerns | Chỉ lấy ý kiến architect, bỏ qua dev/ops/users | Mời đầy đủ stakeholders, khuyến khích brainstorm |
| 5 | Không phân biệt Risk vs Non-risk | Liệt kê mọi decision là risk | Risk = potentially problematic; Non-risk = verified sound |
| 6 | Utility tree quá nông | Chỉ có Quality Attribute → Scenario, thiếu refinement | Phải có 3 levels: QA → Refinement → Scenario |
| 7 | Focus quá hẹp | Chỉ phân tích 1-2 quality attributes | Cover ít nhất 4 quality attributes |
| 8 | Thiếu mitigation cho risks | Liệt kê risk nhưng không đề xuất giải pháp | Mỗi risk cần ≥ 1 mitigation strategy |
| 9 | Không map scenario → approach | Scenarios không liên kết với architectural decisions | Mỗi scenario phải chỉ ra approach nào support/violate |
| 10 | Report thiếu actionable recommendations | Kết luận chung chung, không có next steps cụ thể | Recommendations phải có: action + priority + effort + timeline |

---

## Rubric Chấm điểm

| Tiêu chí | Điểm | Mô tả chi tiết |
|----------|------|-----------------|
| **Business Drivers & Architecture Presentation** | **15** | |
| — Business drivers document đầy đủ, rõ ràng | 8 | Goals, constraints, priorities, quality attributes |
| — Architecture overview chính xác, có diagram | 7 | Components, tech stack, data flow, deployment |
| **Utility Tree** | **25** | |
| — Đủ quality attributes (≥ 4) | 5 | Performance, Availability, Security, Scalability, ... |
| — Scenarios cụ thể, đo lường được | 10 | Mỗi scenario có metric, context, threshold |
| — Priority ratings hợp lý (H/M/L) | 5 | Importance và Difficulty phù hợp business context |
| — Cấu trúc 3 levels (QA → Refinement → Scenario) | 5 | Phân cấp rõ ràng, logical grouping |
| **Architectural Approaches Analysis** | **25** | |
| — Liệt kê đầy đủ approaches | 5 | ≥ 5 approaches, mô tả chính xác |
| — Sensitivity points chính xác | 5 | Đúng definition, mapping hợp lý |
| — Tradeoff points chính xác | 5 | Identify đúng QA conflicts |
| — Risks và Non-risks hợp lý | 5 | Phân biệt đúng, có rationale |
| — Mapping scenarios → approaches | 5 | Mỗi scenario linked với relevant approach |
| **ATAM Simulation & Report** | **25** | |
| — Thực hiện đủ 9 steps | 10 | Evidence cho mỗi step (notes, outputs) |
| — Report đầy đủ sections | 8 | Theo template, không thiếu section |
| — Recommendations actionable | 7 | Cụ thể, có priority, effort, timeline |
| **Presentation & Communication** | **10** | |
| — Trình bày rõ ràng, logic | 5 | Cấu trúc tốt, dễ follow |
| — Định dạng chuyên nghiệp | 5 | Tables, diagrams, consistent formatting |
| **Tổng** | **100** | |

---

## Tài liệu Tham khảo

1. Clements, P., Kazman, R., Klein, M. (2002). *Evaluating Software Architectures: Methods and Case Studies*. Addison-Wesley.
2. Bass, L., Clements, P., Kazman, R. (2021). *Software Architecture in Practice* (4th ed.). Addison-Wesley. Chapter 21: Architecture Evaluation.
3. SEI ATAM Method: https://resources.sei.cmu.edu/library/asset-view.cfm?assetid=513908
4. Kazman, R., Klein, M., Clements, P. (2000). *ATAM: Method for Architecture Evaluation*. SEI Technical Report CMU/SEI-2000-TR-004.

---

## Tiếp theo

Chuyển đến: `lab-4.3-saam/` — Software Architecture Analysis Method (SAAM)
