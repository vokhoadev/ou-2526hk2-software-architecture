# Lab 4.8: Architecture Review Board (ARB)

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ (180 phút) |
| **Độ khó** | Intermediate → Advanced |
| **Yêu cầu trước** | Hoàn thành Lab 4.1 – 4.7 (Architecture Documentation, Quality Attributes, ATAM, ADR, Fitness Functions, Technical Debt, Governance) |
| **Công cụ** | Markdown editor, whiteboard (physical/digital), role-play setup |
| **Hình thức** | Lý thuyết + Workshop nhóm + Mô phỏng ARB Session |
| **Số người** | Nhóm 5–7 sinh viên (tối thiểu 5 vai trò ARB) |
| **Output** | ARB Charter, Architecture Review Request, Decision Log, Compliance Tracker |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Giải thích** vai trò, mục đích và cấu trúc của Architecture Review Board trong một tổ chức phần mềm, phân biệt ARB với peer review và code review
2. **Thiết kế** ARB Charter hoàn chỉnh bao gồm mission, scope, thành viên, quy trình quyết định và lịch họp
3. **Chuẩn bị** Architecture Review Request chuyên nghiệp với đầy đủ problem statement, proposed solution, alternatives analysis, risk assessment và compliance check
4. **Tiến hành** mô phỏng ARB session với vai trò cụ thể (Chief Architect, Domain Architect, Dev Lead, QA, Security), đánh giá proposal và ra quyết định có cơ sở
5. **Xây dựng** hệ thống post-review tracking bao gồm decision log, compliance monitoring và exception management

---

## Phân bổ Thời gian

| Giai đoạn | Thời lượng | Nội dung chi tiết |
|-----------|-----------|-------------------|
| **Lý thuyết** | 40 phút | ARB concepts, governance framework, review types, ARB process, metrics, anti-patterns |
| **Lab 1** | 25 phút | Thiết kế ARB Charter |
| **Lab 2** | 30 phút | Viết Architecture Review Request (microservice migration scenario) |
| **Lab 3** | 45 phút | Mô phỏng ARB Session (role-play: trình bày → Q&A → chấm điểm → quyết định) |
| **Lab 4** | 20 phút | Post-Review tracking (decision log, compliance, exception register) |
| **Self-Assessment** | 10 phút | 30 câu hỏi trắc nghiệm + tự luận |
| **Review & Wrap-up** | 10 phút | Tổng kết, feedback, hướng dẫn Extend Labs |
| **Tổng** | **180 phút** | **3 giờ** |

---

## Phần Lý thuyết

### 1. ARB — Mục đích và Trách nhiệm

**Architecture Review Board (ARB)** là một governance body chính thức trong tổ chức phần mềm, chịu trách nhiệm đảm bảo các quyết định kiến trúc được đưa ra một cách nhất quán, có cơ sở và phù hợp với chiến lược công nghệ tổng thể.

#### 1.1 Tại sao cần ARB?

| Vấn đề khi KHÔNG có ARB | ARB giải quyết như thế nào |
|--------------------------|---------------------------|
| Mỗi team tự chọn technology stack → fragmentation | Đánh giá và chuẩn hóa technology choices |
| Quyết định kiến trúc không được document → mất knowledge | Duy trì Architecture Decision Records |
| Rủi ro bảo mật bị bỏ qua → security incidents | Security review là bắt buộc cho mọi proposal |
| Kiến trúc không đồng nhất → integration pain | Đảm bảo consistency across systems |
| Technical debt tích tụ → cost tăng theo thời gian | Đánh giá trade-offs và long-term impact |
| Không có ai chịu trách nhiệm → blame game | Rõ ràng accountability cho decisions |

#### 1.2 Trách nhiệm cốt lõi của ARB

| Lĩnh vực | Trách nhiệm | Ví dụ |
|-----------|-------------|-------|
| **Standards** | Định nghĩa và duy trì architecture standards | API design guidelines, security policies, data standards |
| **Review** | Đánh giá architecture proposals | New system design, technology adoption, major refactoring |
| **Decisions** | Phê duyệt / từ chối / hoãn proposals | Approve microservice migration, reject unproven tech |
| **Guidance** | Cung cấp architectural direction | Recommend patterns, suggest alternatives |
| **Documentation** | Duy trì architecture decision log | ADR repository, decision tracking |
| **Compliance** | Giám sát tuân thủ sau decision | Post-implementation review, compliance audit |
| **Knowledge Sharing** | Phổ biến best practices | Architecture newsletter, brown-bag sessions |

#### 1.3 Khi nào CẦN và KHÔNG CẦN ARB Review

```
┌─────────────────────────────────────────────────────────────────┐
│ ARB Review Triggers │
│ │
│ [OK] CẦN ARB Review: │
│ - Giới thiệu công nghệ mới (new language, framework, DB) │
│ - Thay đổi kiến trúc đáng kể (monolith → microservices) │
│ - Cross-team dependencies (shared services, APIs) │
│ - Security-critical decisions (auth, encryption, PII) │
│ - Chi phí vượt ngưỡng (cost > $50K hoặc > 3 sprints) │
│ - Deviation from existing standards (exception request) │
│ - Third-party integration (vendor lock-in risk) │
│ - Data architecture changes (new data store, migration) │
│ │
│ [Khong] KHÔNG CẦN ARB Review: │
│ - Bug fixes và minor patches │
│ - UI/UX changes (không ảnh hưởng architecture) │
│ - Within-team refactoring (không cross-boundary) │
│ - Configuration changes │
│ - Library version upgrades (minor/patch) │
│ - Documentation updates │
└─────────────────────────────────────────────────────────────────┘
```

---

### 2. ARB Composition — Thành phần và Vai trò

| Vai trò | Trách nhiệm | Quyền bỏ phiếu | Bắt buộc |
|---------|-------------|-----------------|----------|
| **Chief Architect** (Chair) | Chủ trì cuộc họp, ra quyết định cuối cùng khi có tie, đảm bảo process được tuân thủ | [OK] (tie-breaking vote) | [OK] |
| **Domain Architect(s)** | Đánh giá proposal từ góc độ domain expertise (backend, frontend, data, cloud) | [OK] | [OK] (ít nhất 1) |
| **Development Lead** | Đánh giá feasibility, implementation complexity, team capacity | [OK] | [OK] |
| **QA / Test Lead** | Đánh giá testability, quality risks, test strategy impact | [OK] | [OK] |
| **Security Architect** | Đánh giá security implications, compliance, threat modeling | [OK] | [OK] |
| **Presenter** (Submitter) | Trình bày proposal, trả lời câu hỏi — KHÔNG bỏ phiếu | [Khong] | [OK] |
| **Scribe** | Ghi chép minutes, action items, decisions | [Khong] | [OK] |
| **Subject Matter Expert** | Invited guest cho specific expertise (DBA, DevOps, etc.) | [Khong] (advisory) | [Khong] |

**Nguyên tắc quorum:** ARB meeting hợp lệ khi có ≥ 4/5 voting members tham dự (bao gồm bắt buộc Chief Architect hoặc delegate).

---

### 3. Governance Framework

#### 3.1 Architecture Governance Pyramid

```
 ┌─────────────┐
 │ Enterprise │ ← Strategy & Vision
 │ Architecture│
 ├─────────────┤
 ┌──┤ ARB ├──┐ ← Governance & Decisions
 │ └─────────────┘ │
 ┌─────┴─────┐ ┌───────┴──────┐
 │ Standards │ │ Compliance │ ← Policies & Monitoring
 │ & Policies │ │ & Auditing │
 └─────┬─────┘ └───────┬──────┘
 │ │
 ┌─────┴──────────────────┴─────┐
 │ Project / Team Level │ ← Implementation
 │ Architecture Decisions │
 └──────────────────────────────┘
```

#### 3.2 Governance Levels

| Level | Scope | ARB Involvement | Ví dụ |
|-------|-------|-----------------|-------|
| **Strategic** | Enterprise-wide | Full board review | Cloud migration strategy, platform selection |
| **Tactical** | Cross-team | Standard review | Shared service design, API versioning |
| **Operational** | Within-team | Fast-track / Advisory | Internal refactoring, tool selection |

---

### 4. Review Types — Các loại Review

#### 4.1 Design Review

| Aspect | Mô tả |
|--------|-------|
| **Mục đích** | Đánh giá thiết kế kiến trúc của hệ thống mới hoặc major change |
| **Khi nào** | Trước khi bắt đầu implementation (gate review) |
| **Focus** | Architecture patterns, component design, data flow, integration points |
| **Output** | Approved / Approved with Conditions / Deferred / Rejected |
| **Duration** | 45–60 phút |

#### 4.2 Technology Selection Review

| Aspect | Mô tả |
|--------|-------|
| **Mục đích** | Đánh giá proposal áp dụng công nghệ mới vào technology landscape |
| **Khi nào** | Khi team muốn introduce new language, framework, database, cloud service |
| **Focus** | Maturity, community support, licensing, vendor lock-in, team capability, total cost |
| **Output** | Approved (add to Tech Radar) / Trial / Hold / Reject |
| **Duration** | 30–45 phút |

#### 4.3 Exception Handling Review

| Aspect | Mô tả |
|--------|-------|
| **Mục đích** | Xem xét yêu cầu poach khỏi standard đã được establish |
| **Khi nào** | Khi project cần deviate from architecture standards |
| **Focus** | Justification, impact, timeline (temporary vs permanent), migration plan |
| **Output** | Exception Granted (with expiry) / Denied |
| **Duration** | 20–30 phút |

---

### 5. ARB Process — Quy trình ARB

```
┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ SUBMIT │───│ REVIEW │───│ DECISION │───│ TRACK │
│ │ │ │ │ │ │ │
│ - Proposal │ │ - Pre-screen │ │ - Vote │ │ - Log │
│ - Supporting │ │ - ARB Meet │ │ - Conditions │ │ - Compliance │
│ docs │ │ - Q&A │ │ - Document │ │ - Follow-up │
│ - Self-check │ │ - Scoring │ │ - Notify │ │ - Exceptions │
└──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘
```

**Chi tiết từng bước:**

| Bước | Ai thực hiện | Hoạt động | Timeline |
|------|-------------|-----------|----------|
| **1. Submit** | Submitter | Điền Architecture Review Request template, đính kèm diagrams, tự kiểm tra completeness checklist | ≥ 5 ngày trước meeting |
| **2. Pre-screen** | Chief Architect | Kiểm tra proposal có đủ thông tin, assign reviewers, schedule slot | 3 ngày trước meeting |
| **3. Pre-read** | ARB Members | Đọc proposal trước, chuẩn bị câu hỏi | 2 ngày trước meeting |
| **4. Present** | Submitter | Trình bày proposal (15 phút), architecture diagrams, key trade-offs | Trong meeting |
| **5. Q&A** | All | Hỏi đáp, clarification, challenge assumptions | Trong meeting (20 phút) |
| **6. Deliberate** | ARB Members | Thảo luận kín (submitter rời phòng), đánh giá scoring | Trong meeting (10 phút) |
| **7. Decision** | Chief Architect | Công bố kết quả, conditions (nếu có), next steps | Trong meeting (5 phút) |
| **8. Document** | Scribe | Ghi nhận vào Decision Log, cập nhật ADR, thông báo stakeholders | Trong 24h sau meeting |
| **9. Track** | Chief Architect | Theo dõi compliance, review conditions fulfillment | Ongoing |

---

### 6. ARB Meeting Structure

| Phase | Thời lượng | Hoạt động | Người dẫn |
|-------|-----------|-----------|-----------|
| **Opening** | 2 phút | Welcome, agenda, quorum check | Chief Architect |
| **Previous Actions** | 3 phút | Review action items từ meeting trước | Scribe |
| **Presentation** | 15 phút | Submitter trình bày proposal | Submitter |
| **Q&A** | 20 phút | ARB members đặt câu hỏi, submitter trả lời | Chief Architect moderates |
| **Deliberation** | 10 phút | Board discussion (submitter rời phòng) | Chief Architect |
| **Scoring** | 3 phút | Mỗi member cho điểm theo rubric | All voting members |
| **Decision** | 5 phút | Announce kết quả, conditions, action items | Chief Architect |
| **Wrap-up** | 2 phút | Confirm next meeting, any other business | Chief Architect |
| **Tổng** | **~60 phút** | *(per proposal, ARB meeting có thể review 1–2 proposals)* | |

---

### 7. ARB Scoring Rubric (dùng trong meeting)

| Tiêu chí | Trọng số | 1 (Poor) | 2 (Fair) | 3 (Good) | 4 (Excellent) |
|----------|---------|----------|----------|----------|----------------|
| **Problem Clarity** | 15% | Vague, không rõ ràng | Có nhưng thiếu context | Rõ ràng, có data | Xuất sắc, compelling |
| **Solution Fitness** | 25% | Không phù hợp | Phù hợp một phần | Phù hợp, có trade-offs | Tối ưu, well-reasoned |
| **Alternatives Analysis** | 15% | Không có | 1 alternative, sơ sài | 2+ alternatives, có so sánh | Thorough, data-driven |
| **Risk Assessment** | 15% | Không nhắc risk | Liệt kê risk, không mitigation | Risk + mitigation | Comprehensive risk mgmt |
| **Standards Compliance** | 15% | Vi phạm nhiều | Comply một phần | Comply đầy đủ | Exceed standards |
| **Implementation Plan** | 15% | Không có | Sơ sài | Rõ ràng, có timeline | Detailed, realistic |

**Decision thresholds:**
- **Approved:** Average score ≥ 3.0, không có tiêu chí nào ≤ 1
- **Approved with Conditions:** Average score ≥ 2.5, có tiêu chí cần cải thiện
- **Deferred:** Average score 2.0–2.5, cần thêm thông tin
- **Rejected:** Average score < 2.0 hoặc có fundamental issue

---

### 8. ARB Metrics

| Metric | Cách đo | Target | Mục đích |
|--------|---------|--------|----------|
| **Review Cycle Time** | Số ngày từ submit → decision | ≤ 10 ngày | Đảm bảo ARB không là bottleneck |
| **Approval Rate** | % proposals approved (bao gồm with conditions) | 60–80% | Quá cao = rubber stamp; quá thấp = quá strict |
| **Condition Fulfillment Rate** | % conditions được hoàn thành đúng hạn | ≥ 90% | Đảm bảo decisions được thực thi |
| **Exception Rate** | % proposals yêu cầu exception | ≤ 15% | Standards có thực tế không |
| **Resubmission Rate** | % proposals phải submit lại | ≤ 20% | Chất lượng submission |
| **Stakeholder Satisfaction** | Survey score (1–5) | ≥ 3.5 | ARB có hữu ích không |
| **Decision Reversal Rate** | % decisions bị thay đổi | ≤ 5% | Chất lượng decision |
| **Compliance Rate** | % implementations tuân thủ approved architecture | ≥ 85% | Governance effectiveness |

---

### 9. ARB Anti-patterns

| Anti-pattern | Mô tả | Hậu quả | Cách khắc phục |
|-------------|-------|---------|----------------|
| **Rubber Stamp** | ARB approve mọi thứ mà không review kỹ | Quyết định kém chất lượng, mất uy tín | Enforce scoring rubric, require discussion |
| **Bottleneck Board** | ARB review quá nhiều, queue dài, block teams | Slow delivery, teams bypass ARB | Phân loại review (fast-track vs full), delegate |
| **Ivory Tower** | ARB members xa rời thực tế development | Decisions không khả thi, teams bất mãn | Rotate members, include dev leads |
| **Architecture Police** | ARB chỉ nói "không", không cung cấp alternatives | Teams sợ submit, innovation bị chặn | Shift to guidance, "yes, and..." approach |
| **Paper Tiger** | ARB có quyền trên giấy nhưng decisions bị ignore | Governance vô nghĩa | Executive sponsorship, compliance tracking |
| **Scope Creep** | ARB review cả trivial decisions | Waste time, frustrate teams | Clear thresholds, tiered review |
| **Single Point of Failure** | Phụ thuộc 1 Chief Architect, nghỉ = ARB ngưng | Delay, dependency | Deputy chair, knowledge sharing |
| **Analysis Paralysis** | Thảo luận quá lâu, không ra decision | Delayed projects, lost opportunity | Time-box, voting mechanism, tie-breaker |

---

## Bài tập Thực hành

### Lab 1: Thiết kế ARB Charter (25 phút)

**Mục tiêu:** Tạo một ARB Charter hoàn chỉnh cho một công ty phần mềm có 200 developers, 15 teams.

**Hướng dẫn:** Sử dụng template dưới đây, điền đầy đủ thông tin cho tổ chức giả định "TechViet Corp" — công ty phát triển nền tảng e-commerce.

#### Template: ARB Charter

```markdown
# ARCHITECTURE REVIEW BOARD CHARTER
# TechViet Corp

## 1. Mission Statement
[Tuyên bố sứ mệnh của ARB — tại sao ARB tồn tại, giá trị mang lại]

Ví dụ: "The Architecture Review Board ensures that all significant
architecture decisions at TechViet Corp are made with consistency,
quality, and alignment to our technology strategy, while enabling
teams to innovate and deliver value efficiently."

## 2. Scope
### 2.1 In Scope — ARB review bắt buộc khi:
- [ ] Giới thiệu công nghệ mới vào technology landscape
- [ ] Thay đổi kiến trúc ảnh hưởng ≥ 2 teams
- [ ] Dự án có chi phí infrastructure > 100 triệu VNĐ/năm
- [ ] Thay đổi liên quan đến dữ liệu khách hàng (PII)
- [ ] Deviation from Architecture Standards (exception request)
- [ ] [Thêm criteria phù hợp với TechViet Corp]

### 2.2 Out of Scope:
- [ ] Bug fixes, minor refactoring within team boundary
- [ ] UI/UX changes không ảnh hưởng backend architecture
- [ ] Library upgrades (minor/patch version)
- [ ] [Thêm exclusions]

## 3. Membership

| Vai trò | Tên | Bộ phận | Nhiệm kỳ | Bỏ phiếu |
|---------|-----|---------|-----------|-----------|
| Chief Architect (Chair) | [Tên] | Engineering | Permanent | [OK] (tie-break) |
| Domain Architect — Backend | [Tên] | Platform Team | 1 năm rotating | [OK] |
| Domain Architect — Data | [Tên] | Data Engineering | 1 năm rotating | [OK] |
| Development Lead | [Tên] | Feature Teams | 6 tháng rotating | [OK] |
| QA Lead | [Tên] | Quality Assurance | 1 năm rotating | [OK] |
| Security Architect | [Tên] | InfoSec | Permanent | [OK] |
| Scribe | [Tên] | Engineering | Rotating per meeting | [Khong] |

## 4. Meeting Cadence
- **Regular meetings:** Mỗi 2 tuần, thứ Năm, 14:00–16:00
- **Fast-track reviews:** Ad-hoc, cần ≥ 3 voting members async approval
- **Emergency reviews:** Within 48h khi có critical decision
- **Quorum:** ≥ 4/6 voting members (bắt buộc có Chair hoặc Deputy)

## 5. Decision Process
### 5.1 Submission
- Submitter điền Architecture Review Request template
- Submit ≥ 5 business days trước scheduled meeting
- Chief Architect pre-screen trong 2 ngày

### 5.2 Review & Voting
- Majority vote (≥ 50% + 1 voting members)
- Chair có tie-breaking vote
- Security Architect có VETO quyền cho security-critical issues

### 5.3 Decision Outcomes
| Decision | Điều kiện | Action |
|----------|-----------|--------|
| Approved | Score ≥ 3.0, no blockers | Proceed, log ADR |
| Approved with Conditions | Score ≥ 2.5, conditions attached | Proceed after conditions met |
| Deferred | Need more info | Resubmit with additional info |
| Rejected | Fundamental issues | Do not proceed, provide guidance |

### 5.4 Appeals Process
1. Submitter yêu cầu appeal trong 5 ngày
2. Provide additional evidence hoặc modified proposal
3. Escalate lên VP Engineering nếu cần
4. VP Engineering decision là final

## 6. Communication
- Decisions published trong 24h trên Confluence
- Monthly Architecture Newsletter
- Quarterly Architecture All-hands

## 7. Review & Improvement
- ARB Charter được review mỗi 6 tháng
- Annual retrospective với stakeholder feedback
- Metrics review hàng quý

## 8. Effective Date
Charter có hiệu lực từ: [DD/MM/YYYY]
Approved by: [VP Engineering]
```

**Yêu cầu nộp bài:**
- Điền đầy đủ template với thông tin cụ thể cho TechViet Corp
- Giải thích lý do cho mỗi quyết định (ví dụ: tại sao meeting bi-weekly thay vì weekly)
- Xác định ít nhất 3 rủi ro khi ARB hoạt động và mitigation plan

---

### Lab 2: Architecture Review Request — Microservice Migration (30 phút)

**Mục tiêu:** Viết một Architecture Review Request hoàn chỉnh cho proposal chuyển đổi từ monolith sang microservices.

**Scenario:** TechViet Corp hiện có monolithic e-commerce platform (Java/Spring Boot, PostgreSQL), phục vụ 500K users/ngày. Team muốn tách Order Management thành microservice riêng.

#### Template: Architecture Review Request

```markdown
# ARCHITECTURE REVIEW REQUEST

## Metadata
| Field | Value |
|-------|-------|
| **Request ID** | ARR-2026-015 |
| **Title** | Tách Order Management Microservice từ E-commerce Monolith |
| **Submitter** | [Tên], Senior Software Engineer, Order Team |
| **Date Submitted** | [DD/MM/YYYY] |
| **Review Type** | [OK] Design Review ☐ Technology Selection ☐ Exception |
| **Priority** | ☐ Standard [OK] High ☐ Emergency |
| **Target ARB Date** | [DD/MM/YYYY] |

---

## 1. Executive Summary
[Viết 1 đoạn tóm tắt — 100-150 từ]

Đề xuất tách module Order Management ra khỏi monolithic e-commerce
platform thành independent microservice. Hiện tại module này đang
gây bottleneck do coupled tightly với Inventory và Payment modules.
Order processing latency trung bình 2.5s (target: <500ms). Đề xuất
sử dụng Event-Driven Architecture với Apache Kafka để decouple,
deploy service trên Kubernetes. Expected outcome: giảm latency 80%,
independent scaling, và faster release cycle cho Order team.

---

## 2. Problem Statement

### 2.1 Current State
[Mô tả kiến trúc hiện tại]

- Monolithic Java/Spring Boot application (350K LOC)
- Single PostgreSQL database (shared schema, 200+ tables)
- Deployment: 1 WAR file trên 4 VM instances
- Release cycle: 2 tuần, toàn bộ application
- Order module: 45K LOC, 35 tables

### 2.2 Pain Points
| # | Pain Point | Impact | Evidence |
|---|-----------|--------|----------|
| 1 | Order processing latency cao | Customer complaints tăng 40% | APM data: avg 2.5s, p99 8s |
| 2 | Không thể scale Order riêng | Over-provisioning resources | 70% CPU chỉ từ Order module |
| 3 | Release coupling | Bug ở module khác block Order release | 3 lần delay trong Q4/2025 |
| 4 | Database contention | Lock conflicts giữa Order và Inventory | 200+ deadlocks/ngày |
| 5 | Team autonomy thấp | 3 teams merge cùng 1 codebase | 15 merge conflicts/tuần |

### 2.3 Business Impact
- Revenue loss: ~500M VNĐ/tháng do slow checkout
- Customer churn rate tăng 12% (NPS giảm 15 điểm)
- Time-to-market cho Order features: 4 tuần → target 1 tuần

---

## 3. Proposed Solution

### 3.1 Architecture Overview
[Mô tả high-level giải pháp]

Tách Order Management thành standalone microservice với:
- Separate codebase (Java 21, Spring Boot 3.x)
- Dedicated database (PostgreSQL instance riêng)
- Event-driven communication qua Apache Kafka
- API Gateway (Kong) cho external traffic
- Deploy trên Kubernetes (EKS)

### 3.2 Architecture Diagram

~~~text
┌──────────────────────────────────────────────────────────────┐
│ API Gateway (Kong)                                           │
└──────────┬───────────────────────────────────┬───────────────┘
           │                                   │
    ┌──────▼────────┐                 ┌───────▼────────┐
    │ Order Service │                 │ Monolith       │
    │ (new μservice)│                 │ (remaining)    │
    │               │                 │                │
    │ - Create Order│◄──── Kafka ────│ - Inventory    │
    │ - Update Order│    (events)    │ - Payment      │
    │ - Query Order │                 │ - User Mgmt    │
    │ - Cancel Order│                 │ - Catalog      │
    └──────┬────────┘                 └───────┬────────┘
           │                                   │
    ┌──────▼────────┐                 ┌───────▼────────┐
    │ Order DB      │                 │ Main DB        │
    │ (PostgreSQL)  │                 │ (PostgreSQL)   │
    └───────────────┘                 └────────────────┘
~~~

### 3.3 Key Design Decisions
| # | Decision | Rationale |
|---|----------|-----------|
| 1 | Event-driven (Kafka) thay vì REST sync | Decoupling, reliability, replay capability |
| 2 | Separate database (Database per Service) | Independent schema evolution, no lock contention |
| 3 | Strangler Fig pattern | Gradual migration, rollback capability |
| 4 | Saga pattern cho distributed transactions | Consistency across Order-Inventory-Payment |

---

## 4. Alternatives Considered

| # | Option | Pros | Cons | Tại sao không chọn |
|---|--------|------|------|-------------------|
| 1 | Optimize monolith (caching, indexing) | Low risk, fast | Không giải quyết root cause coupling | Short-term fix, không scale |
| 2 | Full microservices (tách tất cả) | Maximum flexibility | High risk, quá lớn scope | Too ambitious, prefer incremental |
| 3 | Modular monolith | Medium risk, simpler ops | Vẫn shared DB, limited scaling | Không giải quyết DB contention |
| **4** | **Extract Order Service (đề xuất)** | **Balanced risk/reward** | **Distributed system complexity** | **← SELECTED** |

---

## 5. Quality Attributes

| Attribute | Current | Target | How Addressed |
|-----------|---------|--------|---------------|
| **Performance** | Avg 2.5s latency | < 500ms | Dedicated resources, optimized queries |
| **Scalability** | Vertical only | Horizontal, independent | Kubernetes HPA, separate DB |
| **Availability** | 99.5% | 99.9% | Circuit breaker, retry, fallback |
| **Security** | Shared auth | Service-to-service mTLS | Istio service mesh |
| **Maintainability** | High coupling | Loose coupling | Domain boundary, clear API contract |

---

## 6. Risks and Mitigations

| # | Risk | Likelihood | Impact | Mitigation |
|---|------|-----------|--------|------------|
| 1 | Data consistency issues (distributed) | High | High | Saga pattern, eventual consistency, compensation |
| 2 | Network latency between services | Medium | Medium | Service mesh, connection pooling, caching |
| 3 | Team lacks microservice experience | High | Medium | Training, pair programming, gradual rollout |
| 4 | Operational complexity tăng | High | Medium | Observability stack (Prometheus, Grafana, Jaeger) |
| 5 | Data migration failures | Medium | High | Blue-green migration, dual-write period, rollback plan |

---

## 7. Implementation Plan

### 7.1 Timeline
| Phase | Duration | Activities |
|-------|----------|------------|
| Phase 1: Foundation | 4 tuần | Setup K8s, Kafka, CI/CD pipeline, observability |
| Phase 2: Build Service | 6 tuần | Implement Order Service, API, events, testing |
| Phase 3: Migration | 4 tuần | Data migration, strangler fig, dual-write |
| Phase 4: Cutover | 2 tuần | Traffic switch, monitoring, old code removal |
| **Total** | **16 tuần** | |

### 7.2 Resources
| Resource | Quantity | Cost Estimate |
|----------|---------|---------------|
| Engineers | 4 full-time | 800M VNĐ (4 tháng) |
| Infrastructure (K8s, Kafka) | — | 50M VNĐ/tháng |
| Training | 5 engineers | 30M VNĐ |
| **Total** | | **~1B VNĐ** |

### 7.3 Dependencies
- DevOps team: Kubernetes cluster setup (đã confirm capacity)
- Data team: Data migration support (cần negotiate)
- Payment team: API contract agreement (cần align)

---

## 8. Standards Compliance

| Standard | Compliant? | Notes |
|----------|------------|-------|
| API Design Guidelines v2.1 | [OK] | RESTful, OpenAPI 3.0 spec |
| Security Policy SP-2024 | [OK] | mTLS, OAuth2, encryption at rest |
| Data Classification Policy | [OK] | PII encrypted, audit logging |
| Logging Standard LS-001 | [OK] | Structured JSON, correlation IDs |
| Cloud Standards CS-003 | [OK] | EKS, approved cloud services only |
| Naming Convention NC-001 | [OK] | order-service, order-db |

---

## 9. Appendices
- Appendix A: Detailed sequence diagrams
- Appendix B: Kafka topic design
- Appendix C: Database migration scripts (draft)
- Appendix D: Performance benchmark data
- Appendix E: Team skill assessment
```

**Yêu cầu nộp bài:**
- Hoàn thành tất cả sections trong template
- Đảm bảo data/evidence có tính thuyết phục
- Tự đánh giá bằng Completeness Checklist (xem bên dưới)

**Completeness Checklist cho submitter:**

| # | Item | [OK]/[Khong] |
|---|------|-------|
| 1 | Executive Summary ≤ 150 từ | |
| 2 | Problem Statement có evidence/data | |
| 3 | Architecture diagram rõ ràng | |
| 4 | ≥ 3 alternatives analyzed | |
| 5 | Quality attributes có current vs target | |
| 6 | ≥ 5 risks với mitigation | |
| 7 | Timeline realistic (phased) | |
| 8 | Cost estimate có breakdown | |
| 9 | Dependencies identified | |
| 10 | Standards compliance checked | |

---

### Lab 3: Mô phỏng ARB Session (45 phút)

**Mục tiêu:** Thực hành role-play một ARB meeting hoàn chỉnh sử dụng proposal từ Lab 2.

#### 3.1 Chuẩn bị (5 phút)

**Phân vai trò:**

| Vai trò | Số người | Focus khi review |
|---------|---------|-----------------|
| **Chief Architect** (Chair) | 1 | Process, overall fitness, strategic alignment |
| **Domain Architect** | 1 | Technical design, patterns, integration |
| **Development Lead** | 1 | Feasibility, complexity, team capacity |
| **QA Lead** | 1 | Testability, quality risks, monitoring |
| **Security Architect** | 1 | Security threats, compliance, data protection |
| **Presenter** (Submitter) | 1 | Trình bày proposal, trả lời câu hỏi |
| **Scribe** | 1 | Ghi chép minutes, action items |

#### 3.2 Câu hỏi gợi ý cho từng vai trò

**Chief Architect:**
- "Proposal này align với technology roadmap của chúng ta như thế nào?"
- "Có precedent nào trong tổ chức cho pattern này chưa?"
- "Exit strategy là gì nếu microservice approach không work?"

**Domain Architect:**
- "Tại sao chọn Kafka thay vì RabbitMQ cho use case này?"
- "Saga pattern sẽ handle compensation như thế nào khi payment fails?"
- "API contract versioning strategy là gì?"

**Development Lead:**
- "Team có kinh nghiệm với Kubernetes và Kafka không?"
- "16 tuần timeline có realistic với 4 engineers không?"
- "Làm sao đảm bảo feature delivery không bị block trong migration period?"

**QA Lead:**
- "Test strategy cho distributed transactions là gì?"
- "Làm sao test end-to-end khi service tách ra?"
- "Monitoring và alerting plan cho production?"

**Security Architect:**
- "Service-to-service authentication mechanism cụ thể?"
- "PII data có được encrypt at rest và in transit không?"
- "Audit trail cho order data khi migrate giữa 2 DB?"

#### 3.3 Flow ARB Session

```
Bước 1: Opening (2 phút)
 Chair: "Welcome to ARB meeting. Today we review ARR-2026-015:
 Order Service extraction. Quorum check... [5/6] present.
 Quorum met. [Presenter], please begin."

Bước 2: Presentation (15 phút)
 Presenter trình bày proposal theo template Lab 2.
 Các member lắng nghe, ghi chú câu hỏi.
 KHÔNG ngắt lời trong phần trình bày.

Bước 3: Q&A (20 phút)
 Chair điều phối lượt hỏi.
 Mỗi member hỏi ≥ 2 câu liên quan đến focus area.
 Presenter trả lời hoặc ghi nhận "sẽ bổ sung sau".

Bước 4: Deliberation (5 phút)
 Presenter rời phòng.
 Members thảo luận, nêu concerns.
 Chair tổng hợp key points.

Bước 5: Scoring (3 phút)
 Mỗi voting member điền Scoring Sheet (xem dưới).
 Scribe tính average.

Bước 6: Decision (5 phút)
 Chair công bố kết quả.
 Nêu conditions (nếu có).
 Assign action items.
```

#### 3.4 ARB Scoring Sheet Template

```markdown
# ARB SCORING SHEET

**Request ID:** ARR-2026-015
**Reviewer:** [Tên / Vai trò]
**Date:** [DD/MM/YYYY]

| # | Tiêu chí | Weight | Score (1-4) | Weighted |
|---|----------|--------|-------------|----------|
| 1 | Problem Clarity & Business Justification | 15% | [ ] | |
| 2 | Solution Fitness & Architecture Quality | 25% | [ ] | |
| 3 | Alternatives Analysis | 15% | [ ] | |
| 4 | Risk Assessment & Mitigation | 15% | [ ] | |
| 5 | Standards Compliance | 15% | [ ] | |
| 6 | Implementation Plan & Feasibility | 15% | [ ] | |
| | **TOTAL** | **100%** | | **[ ]/4.0** |

**Comments / Concerns:**
[Ghi nhận concerns, conditions đề xuất]

**Recommendation:**
☐ Approved
☐ Approved with Conditions → Conditions: _______________
☐ Deferred → Need: _______________
☐ Rejected → Reason: _______________

**Signature:** _______________
```

#### 3.5 Decision Documentation Template

```markdown
# ARB DECISION RECORD

| Field | Value |
|-------|-------|
| **Decision ID** | ARB-DEC-2026-008 |
| **Request ID** | ARR-2026-015 |
| **Title** | Order Management Microservice Extraction |
| **Date** | [DD/MM/YYYY] |
| **Decision** | ☐ Approved ☐ Approved with Conditions ☐ Deferred ☐ Rejected |

## Voting Summary
| Member | Role | Score | Recommendation |
|--------|------|-------|----------------|
| [Tên] | Chief Architect | [x.x] | [Decision] |
| [Tên] | Domain Architect | [x.x] | [Decision] |
| [Tên] | Dev Lead | [x.x] | [Decision] |
| [Tên] | QA Lead | [x.x] | [Decision] |
| [Tên] | Security Architect | [x.x] | [Decision] |
| **Average** | | **[x.x]** | |

## Conditions (nếu Approved with Conditions)
| # | Condition | Owner | Deadline | Status |
|---|-----------|-------|----------|--------|
| 1 | [Ví dụ: Hoàn thành Security Threat Model] | [Tên] | [Date] | Pending |
| 2 | [Ví dụ: PoC Saga pattern trước Phase 2] | [Tên] | [Date] | Pending |
| 3 | [Ví dụ: Disaster Recovery plan] | [Tên] | [Date] | Pending |

## Key Discussion Points
1. [Summarize từ deliberation]
2. [...]

## Action Items
| # | Action | Owner | Due Date |
|---|--------|-------|----------|
| 1 | [Action] | [Tên] | [Date] |

## Next Review
- Condition check: [Date, 4 tuần sau]
- Post-implementation review: [Date, sau Phase 4]
```

---

### Lab 4: Post-Review Tracking (20 phút)

**Mục tiêu:** Xây dựng hệ thống tracking sau khi ARB ra decision.

#### 4.1 Decision Log Template

```markdown
# ARB DECISION LOG — TechViet Corp

## Overview
| Metric | Value |
|--------|-------|
| Total Decisions (YTD) | [Số] |
| Approved | [Số] ([%]) |
| Approved with Conditions | [Số] ([%]) |
| Deferred | [Số] ([%]) |
| Rejected | [Số] ([%]) |
| Avg Cycle Time | [Số] ngày |

## Decision Register

| ID | Date | Title | Submitter | Decision | Conditions | Status |
|----|------|-------|-----------|----------|------------|--------|
| ARB-DEC-2026-001 | 15/01 | API Gateway Migration | Team A | Approved | None | [OK] Implemented |
| ARB-DEC-2026-002 | 15/01 | Redis Cluster Upgrade | Team B | Approved w/ Conditions | Security review | [OK] Conditions Met |
| ARB-DEC-2026-003 | 29/01 | GraphQL Adoption | Team C | Deferred | Need PoC results | Resubmitted |
| ARB-DEC-2026-004 | 12/02 | MongoDB Introduction | Team D | Rejected | Use PostgreSQL | [Khong] Closed |
| ARB-DEC-2026-005 | 12/02 | Event Sourcing (Payments) | Team E | Approved w/ Conditions | Performance test | In Progress |
| ARB-DEC-2026-006 | 26/02 | Monorepo Migration | Platform | Approved | None | In Progress |
| ARB-DEC-2026-007 | 12/03 | gRPC for Internal APIs | Team F | Approved w/ Conditions | Backward compat | Pending |
| ARB-DEC-2026-008 | [Date] | Order Microservice | Order Team | [Decision] | [Conditions] | Pending |
```

#### 4.2 Compliance Tracking Template

```markdown
# ARCHITECTURE COMPLIANCE TRACKER

## Decision: ARB-DEC-2026-008 — Order Microservice

### Compliance Checkpoints

| # | Checkpoint | Expected Date | Actual Date | Status | Reviewer |
|---|-----------|--------------|-------------|--------|----------|
| 1 | Conditions fulfilled | +4 tuần | | | Chief Architect |
| 2 | Phase 1 architecture review | +8 tuần | | | Domain Architect |
| 3 | Security penetration test | +12 tuần | | | Security Architect |
| 4 | Performance benchmark vs target | +14 tuần | | | QA Lead |
| 5 | Post-implementation review | +18 tuần | | | Full ARB |

### Compliance Criteria
| # | Criteria | Measurement | Target | Actual | Pass? |
|---|---------|-------------|--------|--------|-------|
| 1 | API follows design guidelines | API lint tool | 0 violations | | |
| 2 | Latency meets target | APM dashboard | < 500ms avg | | |
| 3 | Availability meets SLA | Uptime monitor | 99.9% | | |
| 4 | Security controls implemented | Security scan | 0 critical | | |
| 5 | Monitoring & alerting active | Grafana check | All dashboards live | | |

### Deviation Report (nếu có)
| # | Deviation | Reason | Impact | Approved By | Expiry |
|---|----------|--------|--------|-------------|--------|
| 1 | [Mô tả] | [Lý do] | [Ảnh hưởng] | [Tên] | [Date] |
```

#### 4.3 Exception Register Template

```markdown
# ARCHITECTURE EXCEPTION REGISTER

| ID | Date | Requestor | Standard Deviated | Justification | Decision | Expiry | Status |
|----|------|-----------|-------------------|---------------|----------|--------|--------|
| EXC-001 | 15/01 | Team A | API Std: Must use REST | Legacy system chỉ support SOAP | Granted | 30/06/2026 | [OK] Active |
| EXC-002 | 20/02 | Team B | DB Std: Must use PostgreSQL | ML workload cần MongoDB | Granted | 31/12/2026 | [OK] Active |
| EXC-003 | 01/03 | Team C | Security: No PII in logs | Debug production issue | Granted | 15/03/2026 | [Khong] Expired |
| EXC-004 | [Date] | [Team] | [Standard] | [Justification] | [Decision] | [Date] | [Status] |

## Exception Policies:
- Tất cả exceptions có expiry date (tối đa 12 tháng)
- Exception review trước expiry: renew hoặc migrate to standard
- Permanent exceptions cần VP Engineering approval
- Số lượng active exceptions target: ≤ 10 toàn tổ chức
```

**Yêu cầu nộp bài Lab 4:**
- Hoàn thành Decision Log với ≥ 8 entries (bao gồm decision từ Lab 3)
- Tạo Compliance Tracker cho proposal từ Lab 2
- Tạo Exception Register với ≥ 3 exceptions (1 active, 1 expired, 1 pending)

---

## Self-Assessment — 30 câu hỏi

### Band 1: Cơ bản (Câu 1–10)

**Câu 1.** ARB stands for:
- A) Architecture Review Board
- B) Application Review Bureau
- C) Architecture Release Branch
- D) Automated Review Bot

**Đáp án: A.** ARB = Architecture Review Board — là governance body chịu trách nhiệm review và phê duyệt các quyết định kiến trúc quan trọng trong tổ chức.

---

**Câu 2.** Khi nào KHÔNG cần đưa lên ARB review?
- A) Giới thiệu công nghệ mới
- B) Bug fixes nhỏ trong team
- C) Quyết định liên quan security
- D) Thay đổi ảnh hưởng nhiều team

**Đáp án: B.** Bug fixes là operational work, không ảnh hưởng đến kiến trúc tổng thể nên không cần ARB review. ARB chỉ review significant architecture decisions.

---

**Câu 3.** "Approved with Conditions" nghĩa là:
- A) Hoàn toàn approved, tiến hành ngay
- B) Được phê duyệt nhưng phải đáp ứng một số điều kiện trước/trong khi triển khai
- C) Bị từ chối
- D) Cần thêm thông tin

**Đáp án: B.** Proposal được chấp nhận về mặt nguyên tắc, nhưng ARB đặt ra các conditions (ví dụ: phải hoàn thành security review, phải có PoC) trước khi hoặc trong quá trình triển khai.

---

**Câu 4.** ARB proposal nên bao gồm:
- A) Chỉ solution
- B) Solution và alternatives đã xem xét
- C) Chỉ timeline
- D) Chỉ code samples

**Đáp án: B.** Một ARB proposal chuyên nghiệp phải bao gồm problem statement, proposed solution, alternatives analyzed (ít nhất 2-3), risk assessment, và implementation plan. Chỉ trình bày 1 solution cho thấy submitter chưa suy nghĩ đầy đủ.

---

**Câu 5.** Vai trò nào có quyền tie-breaking vote trong ARB?
- A) Security Architect
- B) Domain Architect
- C) Chief Architect (Chair)
- D) Development Lead

**Đáp án: C.** Chief Architect, với vai trò Chair, có tie-breaking vote khi số phiếu bằng nhau. Đây là standard practice trong governance bodies.

---

**Câu 6.** Quorum tối thiểu cho ARB meeting hợp lệ thường là:
- A) 100% voting members
- B) ≥ 50% voting members
- C) ≥ 2/3 voting members (bao gồm Chair hoặc Deputy)
- D) Chỉ cần Chair present

**Đáp án: C.** Quorum thường yêu cầu ≥ 2/3 (hoặc tùy charter: 4/6) voting members present, bắt buộc có Chair hoặc authorized deputy để đảm bảo decisions có đủ representation.

---

**Câu 7.** ARB submission nên được gửi trước meeting bao lâu?
- A) 1 ngày
- B) Ít nhất 5 business days
- C) 1 giờ trước
- D) Không cần gửi trước

**Đáp án: B.** Ít nhất 5 business days để Chief Architect pre-screen và ARB members có thời gian pre-read, chuẩn bị câu hỏi. Submit sát ngày dẫn đến review chất lượng thấp.

---

**Câu 8.** ARB Decision Record cần ghi nhận những gì?
- A) Chỉ kết quả (Approved/Rejected)
- B) Kết quả, conditions, voting summary, key discussion points, action items
- C) Chỉ tên người submit
- D) Chỉ ngày tháng

**Đáp án: B.** Decision Record phải đầy đủ: kết quả vote, conditions attached, tóm tắt thảo luận, và action items. Đây là audit trail quan trọng cho governance.

---

**Câu 9.** Scribe trong ARB meeting có vai trò gì?
- A) Bỏ phiếu quyết định
- B) Trình bày proposal
- C) Ghi chép minutes, action items, decisions
- D) Phê duyệt proposal

**Đáp án: C.** Scribe là non-voting member chịu trách nhiệm ghi chép toàn bộ cuộc họp, bao gồm minutes, questions raised, action items, và final decision. Output của Scribe trở thành official record.

---

**Câu 10.** Decision outcome "Deferred" nghĩa là:
- A) Bị từ chối vĩnh viễn
- B) Cần thêm thông tin, submitter cần bổ sung và resubmit
- C) Được phê duyệt
- D) Chuyển cho team khác quyết định

**Đáp án: B.** Deferred = proposal chưa đủ thông tin để ARB ra quyết định. Submitter cần bổ sung data/analysis theo feedback của ARB rồi resubmit tại meeting tiếp theo.

---

### Band 2: Trung bình (Câu 11–20)

**Câu 11.** Anti-pattern "Rubber Stamp" trong ARB là gì?
- A) ARB reject mọi proposal
- B) ARB approve mọi proposal mà không review kỹ
- C) ARB họp quá thường xuyên
- D) ARB có quá nhiều thành viên

**Đáp án: B.** Rubber Stamp là khi ARB approve tất cả proposals mà không thực sự đánh giá kỹ lưỡng. Hậu quả: quyết định kém chất lượng, ARB mất uy tín, governance trở nên vô nghĩa. Khắc phục: enforce scoring rubric, require justification cho approve vote.

---

**Câu 12.** Anti-pattern "Bottleneck Board" xảy ra khi nào?
- A) ARB có quá ít members
- B) ARB review quá nhiều proposals, queue dài, block teams delivery
- C) ARB chỉ họp 1 lần/năm
- D) ARB không có Chair

**Đáp án: B.** Bottleneck Board xảy ra khi ARB review scope quá rộng (cả minor decisions) hoặc meeting quá infrequent, dẫn đến queue dài. Teams bị block và có thể bypass ARB. Khắc phục: tiered review (fast-track cho low-risk), delegate authority, tăng meeting frequency.

---

**Câu 13.** Technology Selection Review khác Design Review ở điểm nào?
- A) Không khác nhau
- B) Technology Selection focus vào maturity, licensing, vendor lock-in; Design Review focus vào architecture patterns và component design
- C) Technology Selection không cần ARB
- D) Design Review không cần scoring

**Đáp án: B.** Technology Selection Review đánh giá xem một công nghệ mới có nên được adopt vào tech landscape (maturity, support, cost, team skill). Design Review đánh giá thiết kế kiến trúc cụ thể cho một hệ thống (patterns, components, data flow).

---

**Câu 14.** Exception Handling Review được sử dụng khi nào?
- A) Khi ARB muốn reject proposal
- B) Khi project cần deviate từ established architecture standard
- C) Khi có bug trong production
- D) Khi team muốn thay đổi UI

**Đáp án: B.** Exception Review xem xét yêu cầu cho phép poach khỏi standard đã established (ví dụ: standard yêu cầu REST nhưng team cần SOAP cho legacy integration). Exceptions phải có justification rõ ràng và expiry date.

---

**Câu 15.** Metric "Approval Rate" target 60–80% có ý nghĩa gì?
- A) Không có ý nghĩa
- B) Quá cao (>80%) có thể là rubber stamp; quá thấp (<60%) có thể là ARB quá strict hoặc submissions kém
- C) Phải đạt 100%
- D) Chỉ cần > 50%

**Đáp án: B.** Approval rate là leading indicator cho ARB effectiveness. Rate > 80% gợi ý ARB không challenge đủ (rubber stamp). Rate < 60% gợi ý standards không thực tế hoặc submission quality thấp. 60–80% cho thấy ARB review meaningful nhưng không quá restrictive.

---

**Câu 16.** Trong ARB meeting, tại sao Presenter phải rời phòng lúc deliberation?
- A) Để tiết kiệm thời gian
- B) Để ARB members thảo luận tự do mà không bị ảnh hưởng bởi submitter, đảm bảo objectivity
- C) Vì Presenter không phải member
- D) Không cần rời phòng

**Đáp án: B.** Deliberation phase cần objectivity. Khi Presenter có mặt, members có thể ngại nêu concerns hoặc bị ảnh hưởng bởi real-time responses. Rời phòng cho phép thảo luận thẳng thắn về risks, weaknesses, và decision rationale.

---

**Câu 17.** Strangler Fig pattern trong context microservice migration là gì?
- A) Replace toàn bộ monolith cùng lúc
- B) Gradually thay thế functionality của monolith bằng microservice, redirect traffic dần dần cho đến khi monolith component bị "strangle" (không còn traffic)
- C) Chạy song song 2 hệ thống vĩnh viễn
- D) Không liên quan đến ARB

**Đáp án: B.** Strangler Fig pattern (đặt tên theo loại cây strangler fig bao quanh và dần thay thế cây chủ) cho phép gradual migration từ monolith sang microservice. Traffic được redirect dần sang service mới, giảm risk so với big-bang replacement. Đây là key discussion point trong ARB review.

---

**Câu 18.** Saga pattern giải quyết vấn đề gì trong distributed systems?
- A) Logging
- B) Distributed transactions — đảm bảo consistency across multiple services mà không cần 2PC
- C) Load balancing
- D) Caching

**Đáp án: B.** Saga pattern quản lý distributed transactions bằng cách chia thành sequence of local transactions, mỗi service thực hiện local transaction và publish event. Nếu một step fail, compensation transactions được trigger để rollback. ARB thường hỏi sâu về saga implementation.

---

**Câu 19.** ARB Charter nên được review lại với tần suất nào?
- A) Không bao giờ — một lần là đủ
- B) Mỗi 6–12 tháng, với annual retrospective và stakeholder feedback
- C) Mỗi ngày
- D) Chỉ khi có incident

**Đáp án: B.** ARB Charter là living document, cần được review định kỳ (6–12 tháng) để đảm bảo scope, membership, và process vẫn phù hợp với tổ chức đang thay đổi. Annual retrospective với stakeholder feedback giúp continuous improvement.

---

**Câu 20.** Fast-track review khác standard review ở điểm nào?
- A) Không khác
- B) Fast-track cho phép async approval bởi ≥ 3 voting members, không cần full meeting, dành cho low-risk decisions
- C) Fast-track không cần approval
- D) Fast-track chỉ dành cho Chief Architect

**Đáp án: B.** Fast-track review dành cho proposals có risk thấp, ảnh hưởng hạn chế (ví dụ: minor technology upgrade within approved category). Chỉ cần ≥ 3 voting members review async (email/Slack) và approve. Giúp ARB không trở thành bottleneck cho low-risk decisions.

---

### Band 3: Nâng cao (Câu 21–30)

**Câu 21.** Làm thế nào để tích hợp ARB vào Agile/Scrum environment mà không block delivery?
- A) Bỏ ARB trong Agile
- B) Lightweight ARB: tiered reviews, async fast-track, embed architects trong teams, review ở sprint boundaries thay vì waterfall gates
- C) Chuyển từ Agile về Waterfall
- D) ARB chỉ họp cuối project

**Đáp án: B.** Trong Agile, ARB cần adapt: (1) Tiered reviews — chỉ full review cho high-impact decisions; (2) Async fast-track cho routine decisions; (3) Embed domain architects trong Agile teams để catch issues early; (4) Review tại sprint boundaries hoặc PI planning (SAFe). Mục tiêu: governance without bottleneck.

---

**Câu 22.** Trong Enterprise có nhiều ARBs (domain-level), escalation process hoạt động thế nào?

- A) Mỗi ARB hoàn toàn độc lập
- B) Domain ARB → Enterprise ARB cho cross-domain decisions; Enterprise ARB set enterprise standards, domain ARBs set domain-specific standards
- C) Chỉ có 1 ARB duy nhất
- D) Không cần escalation

**Đáp án: B.** Enterprise thường có tiered ARB structure: Domain ARBs (ví dụ: Backend ARB, Data ARB, Cloud ARB) handle domain-specific decisions. Cross-domain decisions và enterprise-wide standards escalate lên Enterprise ARB. Enterprise ARB gồm Chief Architect + Domain ARB Chairs.

---

**Câu 23.** Compliance tracking sau ARB decision quan trọng vì sao?
- A) Không quan trọng
- B) Đảm bảo decisions thực sự được implement đúng approved architecture, phát hiện deviations sớm, maintain governance integrity
- C) Chỉ là paperwork
- D) Chỉ cần cho audit

**Đáp án: B.** Nếu không tracking, ARB decisions trở thành "paper tiger" — approved architecture bị implement khác đi mà không ai biết. Compliance tracking: (1) Verify conditions fulfilled on time; (2) Post-implementation review so sánh actual vs approved; (3) Detect unauthorized deviations; (4) Feed back vào ARB metrics.

---

**Câu 24.** Security Architect có VETO quyền trong ARB cho security-critical issues. Tại sao đây là practice phổ biến?
- A) Vì security quan trọng hơn tất cả
- B) Vì security vulnerabilities có thể gây catastrophic damage (data breach, legal liability), và majority vote có thể overlook security risks do pressure to deliver
- C) Vì Security Architect là người lương cao nhất
- D) Không nên có VETO quyền

**Đáp án: B.** Security breaches có thể gây thiệt hại lớn (financial, reputation, legal). Majority vote mechanism có thể bị influence bởi delivery pressure ("chúng ta sẽ fix security sau"). VETO quyền đảm bảo security concerns không bị outvoted. Tuy nhiên, VETO nên đi kèm clear justification và escalation path.

---

**Câu 25.** Exception Register có expiry date cho mỗi exception. Tại sao?
- A) Chỉ là admin requirement
- B) Để prevent exceptions từ việc trở thành permanent deviations, buộc teams plan migration path back to standard
- C) Không cần expiry
- D) Để giảm paperwork

**Đáp án: B.** Exceptions không có expiry sẽ tích tụ, dần dần standards trở nên vô nghĩa. Expiry date buộc teams: (1) Lên migration plan trở về standard; (2) Renew exception với justification nếu vẫn cần; (3) Accept rằng exception là technical debt cần trả. Target: ≤ 10 active exceptions toàn org.

---

**Câu 26.** ARB tooling nên bao gồm những gì?
- A) Chỉ email
- B) Proposal tracking system (JIRA/similar), decision repository (Confluence/wiki), template library, metrics dashboard, notification workflow
- C) Chỉ spreadsheet
- D) Không cần tool

**Đáp án: B.** Effective ARB cần tooling: (1) **Proposal tracking:** Submit, status, assignment (JIRA workflow); (2) **Decision repository:** Searchable archive of all decisions (Confluence/wiki); (3) **Template library:** Standardized templates giảm friction; (4) **Metrics dashboard:** Real-time tracking (cycle time, approval rate); (5) **Notifications:** Auto-notify submitters, reviewers, stakeholders.

---

**Câu 27.** Khi ARB reject một proposal, best practice là gì?
- A) Chỉ nói "rejected"
- B) Cung cấp clear rationale, specific feedback, alternative suggestions, và offer guidance cho resubmission
- C) Không cần giải thích
- D) Escalate ngay lên management

**Đáp án: B.** Rejection phải constructive: (1) Clear rationale — tại sao reject (ví dụ: unacceptable security risk); (2) Specific feedback — những gì cần thay đổi; (3) Alternative suggestions — "instead of X, consider Y"; (4) Resubmission guidance — "if you address A, B, C, welcome to resubmit". ARB mục đích là guide, không chỉ gatekeep.

---

**Câu 28.** ARB effectiveness measurement nên sử dụng leading hay lagging indicators?
- A) Chỉ leading indicators
- B) Chỉ lagging indicators
- C) Cả hai: leading (submission quality, cycle time, pre-read completion) và lagging (compliance rate, decision reversal rate, post-implementation issues)
- D) Không cần measurement

**Đáp án: C.** Leading indicators (cycle time, submission quality score, pre-read rate) giúp predict và prevent problems. Lagging indicators (compliance rate, reversal rate, stakeholder satisfaction) confirm effectiveness. Combination cung cấp holistic view: leading indicators cho early warning, lagging indicators cho outcome verification.

---

**Câu 29.** Trong remote/distributed teams, ARB meeting cần adjust như thế nào?
- A) Không cần adjust
- B) Async pre-read bắt buộc, video call với recording, structured time-boxed agenda, digital scoring tools, written deliberation option, timezone-friendly scheduling
- C) Chỉ dùng email
- D) Bỏ ARB khi remote

**Đáp án: B.** Remote ARB cần: (1) Async pre-read bắt buộc (members gửi câu hỏi trước); (2) Video call với recording cho transparency; (3) Time-boxed agenda nghiêm ngặt hơn; (4) Digital scoring (Google Forms, Miro); (5) Written deliberation option cho members ở timezone khác; (6) Kết quả publish rộng rãi.

---

**Câu 30.** Một tổ chức mới bắt đầu implement ARB. Thứ tự ưu tiên nào hợp lý nhất?
- A) Ngay lập tức review mọi decision
- B) (1) Draft Charter → (2) Xác định membership → (3) Tạo templates → (4) Pilot với 2-3 proposals → (5) Gather feedback → (6) Refine process → (7) Full rollout
- C) Chỉ cần có Chief Architect là đủ
- D) Copy charter từ tổ chức khác

**Đáp án: B.** Implement ARB nên incremental: (1) Draft Charter với stakeholder input; (2) Form initial membership (mix seniority); (3) Create submission templates và scoring rubric; (4) Pilot với 2-3 real proposals, learn từ experience; (5) Gather feedback từ submitters và members; (6) Refine process based on learnings; (7) Full rollout với executive sponsorship. Avoid big-bang approach.

---

## Extend Labs (10 bài)

### EL1: Full ARB Lifecycle Simulation ***

**Mục tiêu:** Thực hiện complete ARB lifecycle từ charter creation đến post-implementation review.

**Yêu cầu:**
- Tạo ARB Charter cho tổ chức giả định (300 engineers, 20 teams, 3 domains)
- Submit 3 proposals (1 design review, 1 technology selection, 1 exception)
- Conduct 3 ARB meetings (role-play)
- Track decisions, compliance, exceptions
- Produce quarterly ARB metrics report

---

### EL2: Multi-domain ARB Governance ****

**Mục tiêu:** Thiết kế tiered ARB structure cho enterprise lớn.

**Yêu cầu:**
- Thiết kế 3 Domain ARBs (Backend, Data, Cloud) + 1 Enterprise ARB
- Xác định escalation criteria
- Tạo governance matrix (decision rights per level)
- Simulate cross-domain proposal escalation
- Document coordination mechanism giữa các ARBs

---

### EL3: ARB in Agile/SAFe Context ***

**Mục tiêu:** Thiết kế lightweight ARB phù hợp với Agile delivery.

**Yêu cầu:**
- Map ARB activities vào SAFe PI Planning cycle
- Thiết kế fast-track process cho low-risk decisions
- Tạo decision matrix: team-level vs ARB-level
- Integrate ARB decisions vào sprint planning
- Measure impact on team velocity

---

### EL4: ARB Metrics Dashboard ***

**Mục tiêu:** Xây dựng comprehensive ARB metrics dashboard.

**Yêu cầu:**
- Xác định 10+ KPIs cho ARB effectiveness
- Tạo mockup dashboard (có thể dùng Excel/Google Sheets)
- Phân tích sample data (20+ decisions) để tìm trends
- Đề xuất improvement actions dựa trên data
- Tạo monthly reporting template

---

### EL5: Technology Radar via ARB ***

**Mục tiêu:** Xây dựng Technology Radar quản lý bởi ARB.

**Yêu cầu:**
- Tạo Technology Radar template (Adopt / Trial / Assess / Hold)
- Populate với 20+ technologies
- Xác định process: technology entry → radar placement
- Link ARB Technology Selection Reviews với Radar updates
- Publish Radar report (quarterly)

---

### EL6: ARB Decision Quality Analysis ****

**Mục tiêu:** Phân tích chất lượng ARB decisions bằng retrospective.

**Yêu cầu:**
- Review 10 historical ARB decisions (fictional)
- Assess: decision vẫn đúng sau 12 tháng?
- Identify patterns: tại sao một số decisions failed
- Propose improvements cho decision-making process
- Tạo "Decision Quality Scorecard"

---

### EL7: Remote-First ARB Process **

**Mục tiêu:** Thiết kế ARB process cho fully remote organization.

**Yêu cầu:**
- Design async review workflow (tools: Confluence, JIRA, Slack, Loom)
- Tạo video proposal template (5-minute Loom recording)
- Design async voting mechanism
- Address timezone challenges (teams ở 3 continents)
- Compare sync vs async effectiveness

---

### EL8: ARB Onboarding Program ***

**Mục tiêu:** Tạo training program cho new ARB members và submitters.

**Yêu cầu:**
- Tạo ARB Member Onboarding Guide (roles, responsibilities, scoring)
- Tạo Submitter Guide (how to write proposals, common mistakes)
- Design mock ARB exercise cho training
- Tạo FAQ document (20+ questions)
- Develop mentoring program: experienced member + new member

---

### EL9: ARB Automation & Tooling ****

**Mục tiêu:** Thiết kế automated ARB workflow.

**Yêu cầu:**
- Design JIRA workflow: Submit → Pre-screen → Schedule → Review → Decision → Track
- Tạo automated notifications (Slack/Email integration)
- Design self-service pre-check tool (submitter tự validate proposal completeness)
- Metrics auto-collection và dashboard
- Integration với ADR repository (auto-generate ADR từ decision)

---

### EL10: ARB Maturity Model *****

**Mục tiêu:** Phát triển ARB Maturity Model để assess và improve ARB.

**Yêu cầu:**
- Define 5 maturity levels (Initial → Repeatable → Defined → Managed → Optimizing)
- Xác định criteria cho mỗi level (process, people, tools, metrics)
- Assess sample organization tại mỗi level
- Tạo improvement roadmap: level N → level N+1
- Benchmark với industry best practices (TOGAF, Gartner)

---

## Deliverables Checklist

| # | Deliverable | Lab | Format | Bắt buộc |
|---|------------|-----|--------|----------|
| 1 | ARB Charter hoàn chỉnh | Lab 1 | Markdown document | [OK] |
| 2 | Architecture Review Request (filled) | Lab 2 | Markdown document | [OK] |
| 3 | Completeness Self-check | Lab 2 | Checklist (10 items [OK]/[Khong]) | [OK] |
| 4 | ARB Session minutes (Scribe notes) | Lab 3 | Markdown document | [OK] |
| 5 | Scoring Sheets (mỗi voting member 1 sheet) | Lab 3 | Template filled | [OK] |
| 6 | Decision Record | Lab 3 | Template filled | [OK] |
| 7 | Decision Log (≥ 8 entries) | Lab 4 | Markdown table | [OK] |
| 8 | Compliance Tracker | Lab 4 | Template filled | [OK] |
| 9 | Exception Register (≥ 3 entries) | Lab 4 | Markdown table | [OK] |
| 10 | Self-Assessment answers (30 câu) | Self-Assessment | Written answers | [OK] |

---

## Lỗi Thường Gặp

| # | Lỗi | Mô tả | Hậu quả | Cách khắc phục |
|---|-----|-------|---------|----------------|
| 1 | **Proposal quá sơ sài** | Chỉ có 1 trang, thiếu alternatives, không có data | ARB defer, waste meeting time | Sử dụng template + completeness checklist |
| 2 | **Chỉ trình bày 1 option** | Không phân tích alternatives | ARB nghi ngờ confirmation bias | Luôn phân tích ≥ 3 alternatives với pros/cons |
| 3 | **Thiếu risk assessment** | Không nêu risks hoặc chỉ list risk mà không có mitigation | Decision thiếu cơ sở | Identify ≥ 5 risks với likelihood, impact, mitigation |
| 4 | **Data không có evidence** | Claims "performance sẽ tăng 10x" mà không có benchmark | Mất credibility | Cung cấp data, benchmarks, references |
| 5 | **Scope quá lớn** | Proposal cố gắng thay đổi quá nhiều thứ cùng lúc | ARB khó evaluate, reject do risk | Chia thành phases, submit từng phase |
| 6 | **Bỏ qua Standards Compliance** | Không check existing standards trước khi submit | Reject vì vi phạm standards | Tự check standards compliance trước submit |
| 7 | **ARB meeting không có Scribe** | Không ai ghi chép, decisions mất | Không có audit trail, disputes | Luôn assign Scribe trước meeting |
| 8 | **Không track conditions** | Approved with Conditions nhưng không ai follow up | Conditions bị quên, governance fail | Assign owner + deadline cho mỗi condition |
| 9 | **ARB thành implementation review** | ARB review code/implementation thay vì architecture | Waste time, scope creep | Focus on architecture decisions, not code |
| 10 | **Không có appeals process** | Submitter bất mãn, không có kênh escalate | Morale thấp, bypass ARB | Document clear appeals process trong Charter |

---

## Rubric Chấm điểm (100 điểm)

| # | Tiêu chí | Điểm tối đa | Mô tả chi tiết |
|---|----------|-------------|-----------------|
| 1 | **ARB Charter** (Lab 1) | **20** | |
| 1a | Mission & Scope rõ ràng | 5 | Mission statement compelling; scope có in/out boundaries rõ |
| 1b | Membership đầy đủ với roles | 5 | ≥ 6 roles, có voting/non-voting, nhiệm kỳ, quorum |
| 1c | Decision process chi tiết | 5 | Voting mechanism, tie-break, VETO, outcomes defined |
| 1d | Meeting cadence & appeals | 5 | Regular + fast-track + emergency; appeals process rõ |
| 2 | **Architecture Review Request** (Lab 2) | **25** | |
| 2a | Problem Statement có evidence | 5 | Pain points với data/metrics, business impact quantified |
| 2b | Solution architecture rõ ràng | 8 | Diagram + explanation, key design decisions |
| 2c | Alternatives analysis (≥ 3) | 5 | Pros/cons cho mỗi, rationale cho selection |
| 2d | Risk assessment + mitigation | 4 | ≥ 5 risks, likelihood/impact matrix, mitigation plans |
| 2e | Implementation plan realistic | 3 | Phased timeline, resource estimate, dependencies |
| 3 | **ARB Session Simulation** (Lab 3) | **30** | |
| 3a | Presentation quality | 8 | Clear, structured, compelling, time-managed |
| 3b | Q&A engagement | 8 | Relevant questions from all roles; thoughtful answers |
| 3c | Scoring sheets completed | 7 | All criteria scored, comments provided, justified |
| 3d | Decision Record complete | 7 | Voting summary, conditions, action items, key points |
| 4 | **Post-Review Tracking** (Lab 4) | **15** | |
| 4a | Decision Log (≥ 8 entries) | 5 | Diverse decisions, accurate statuses |
| 4b | Compliance Tracker | 5 | Checkpoints, criteria, measurement plan |
| 4c | Exception Register (≥ 3) | 5 | Active + expired entries, expiry dates, policies |
| 5 | **Self-Assessment** | **10** | |
| 5a | 30 câu trả lời đầy đủ | 10 | Correct answers với explanation, không chỉ chọn đáp án |
| | **TỔNG** | **100** | |

**Thang điểm:**

| Điểm | Xếp loại | Mô tả |
|------|---------|-------|
| 90–100 | Xuất sắc (A) | Hoàn thành xuất sắc tất cả deliverables, thể hiện deep understanding |
| 80–89 | Giỏi (B) | Hoàn thành tốt, có minor gaps |
| 70–79 | Khá (C) | Đạt yêu cầu cơ bản, một số phần chưa sâu |
| 60–69 | Trung bình (D) | Thiếu nhiều phần, cần cải thiện |
| < 60 | Chưa đạt (F) | Không hoàn thành deliverables chính |

---

## Tài liệu Tham khảo

1. **TOGAF 10** — Chapter on Architecture Governance, Architecture Board
2. **ISO/IEC 42010:2022** — Systems and Software Engineering — Architecture Description
3. **ISO/IEC 42030** — Architecture Evaluation
4. **Greefhorst, D. & Proper, E.** — *Architecture Principles*, Springer
5. [Architecture Decision Records (ADR)](https://adr.github.io/) — ADR GitHub
6. **ThoughtWorks Technology Radar** — [thoughtworks.com/radar](https://www.thoughtworks.com/radar)
7. **CMU SEI** — Architecture Tradeoff Analysis Method (ATAM)
8. **Gartner** — IT Governance Frameworks
9. **Richards, M. & Ford, N.** — *Fundamentals of Software Architecture*, O'Reilly (Chapter 20: Architecture Governance)
10. **ĐH Bách Khoa Hà Nội** — IT4995 Kiến trúc Phần mềm
