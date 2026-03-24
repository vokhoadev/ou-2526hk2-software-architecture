# Lab 3.7: Architecture Presentation & Communication Skills

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu trước** | Hoàn thành Lab 3.1–3.6 |
| **Công cụ** | PowerPoint / Google Slides / Marp, C4 PlantUML, Monitoring dashboard (Grafana) |
| **Kết quả** | Slide deck, pitch script, live demo recording |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Phân tích đối tượng** (audience analysis) và điều chỉnh nội dung architecture cho executives, developers, operations
2. **Xây dựng slide deck** chuyên nghiệp sử dụng C4 diagrams, ADR summaries và trade-off matrices
3. **Trình bày quyết định kiến trúc** (architecture decision pitch) thuyết phục trong 5 phút, kèm xử lý Q&A
4. **Demo hệ thống thực** (live architecture demo) với monitoring dashboard và request tracing
5. **Áp dụng kỹ thuật storytelling** (Situation–Complication–Resolution) để biến technical content thành câu chuyện hấp dẫn

---

## Phân bổ Thời gian

| Thứ tự | Hoạt động | Thời lượng | Ghi chú |
|:------:|-----------|:----------:|---------|
| 1 | Lý thuyết: Communication challenges & audience analysis | 20 phút | Giảng + thảo luận |
| 2 | Lý thuyết: Presentation structure & visual storytelling | 20 phút | Giảng + ví dụ |
| 3 | Lab 1 — Audience Analysis Workshop | 25 phút | Nhóm 3 người |
| 4 | Lab 2 — Create Architecture Presentation (10-slide deck) | 40 phút | Cá nhân / cặp |
| 5 | Lab 3 — Architecture Decision Pitch (5 phút + Q&A) | 30 phút | Trình bày trước lớp |
| 6 | Lab 4 — Live Architecture Demo | 25 phút | Demo + dashboard |
| 7 | Self-Assessment Quiz | 10 phút | 30 câu |
| 8 | Review & Wrap-up | 10 phút | Feedback & rubric |
| | **Tổng** | **180 phút (3h)** | |

---

## Lý thuyết

### 1. Architecture Communication Challenges

Trình bày kiến trúc phần mềm là một trong những kỹ năng khó nhất vì:

| Thách thức | Mô tả | Hậu quả nếu không giải quyết |
|------------|--------|-------------------------------|
| **Abstraction gap** | Kiến trúc là khái niệm trừu tượng, khó "nhìn thấy" | Stakeholder không hiểu, từ chối đầu tư |
| **Multi-audience** | Mỗi nhóm quan tâm khía cạnh khác nhau | Thông điệp bị loãng, mất thời gian |
| **Complexity overload** | Hệ thống phức tạp dễ gây choáng ngợp | Người nghe mất tập trung sau 5 phút |
| **Decision justification** | Phải giải thích "tại sao" chứ không chỉ "cái gì" | Quyết định bị challenge mà không có đủ lý lẽ |
| **Living nature** | Kiến trúc thay đổi liên tục | Tài liệu và slide nhanh chóng outdated |

**Nguyên tắc vàng:** *"If you can't explain it simply, you don't understand it well enough."* — Albert Einstein

### 2. Audience Analysis

Trước mỗi buổi trình bày, hãy trả lời 4 câu hỏi: **Who – Why – What – How**

| Câu hỏi | Ý nghĩa |
|----------|----------|
| **Who** là ai? | Xác định vai trò, kiến thức nền, mối quan tâm |
| **Why** họ cần nghe? | Xác định business goal hoặc technical goal |
| **What** cần nhớ? | Xác định 1–3 key takeaways |
| **How** trình bày? | Chọn format: slide, demo, whiteboard, document |

#### 2.1 Executives / C-Level

```
┌─────────────────────────────────────────────────────────────────┐
│ EXECUTIVE AUDIENCE │
│ │
│ Care about: Business value, ROI, competitive advantage │
│ Language: Non-technical, business terminology │
│ Detail level: High-level, strategic │
│ Time tolerance: 5–10 phút MAX │
│ Diagrams: Context diagram (C4 Level 1), simple boxes │
│ Questions likely: "What's the cost?", "What's the risk?", │
│ "When can we ship?" │
│ │
│ Template message: │
│ "Giải pháp X giúp giảm chi phí vận hành 30% và tăng tốc │
│ release cycle từ 4 tuần xuống 1 tuần." │
└─────────────────────────────────────────────────────────────────┘
```

#### 2.2 Developers / Engineering Team

```
┌─────────────────────────────────────────────────────────────────┐
│ DEVELOPER AUDIENCE │
│ │
│ Care about: Implementation details, DX, trade-offs │
│ Language: Technical, code-level │
│ Detail level: Detailed (Component & Code level) │
│ Time tolerance: 15–30 phút, có thể deep dive │
│ Diagrams: C4 Level 2–3, sequence diagrams, ERD │
│ Questions likely: "Why not use Y?", "How does it scale?", │
│ "Show me the code" │
│ │
│ Template message: │
│ "Chúng ta sẽ dùng event-driven architecture với Kafka vì │
│ decoupling services, hỗ trợ replay, và throughput 100K msg/s" │
└─────────────────────────────────────────────────────────────────┘
```

#### 2.3 Operations / DevOps / SRE

```
┌─────────────────────────────────────────────────────────────────┐
│ OPERATIONS AUDIENCE │
│ │
│ Care about: Reliability, deployment, monitoring, SLA │
│ Language: Technical, infra-focused │
│ Detail level: Deployment diagrams, failure modes │
│ Time tolerance: 10–20 phút │
│ Diagrams: Deployment diagram, network topology, runbook│
│ Questions likely: "What's the blast radius?", "How to rollback?│
│ "What metrics to monitor?" │
│ │
│ Template message: │
│ "Mỗi service deploy independent, canary rollout 5% → 25% → 100│
│ với auto-rollback khi error rate > 1%." │
└─────────────────────────────────────────────────────────────────┘
```

### 3. Presentation Structure — Situation-Complication-Resolution (SCR)

SCR là framework storytelling mạnh mẽ từ McKinsey, áp dụng tuyệt vời cho architecture presentations:

```
┌───────────────────────────────────────────────────────────────────┐
│ SCR FRAMEWORK │
│ │
│ ┌─────────────┐ ┌────────────────┐ ┌──────────────────┐ │
│ │ SITUATION │───>│ COMPLICATION │───>│ RESOLUTION │ │
│ │ │ │ │ │ │ │
│ │ "Hiện tại │ │ "Tuy nhiên, │ │ "Do đó, chúng │ │
│ │ hệ thống │ │ chúng ta đang │ │ ta đề xuất │ │
│ │ đang chạy │ │ gặp vấn đề..."│ │ giải pháp..." │ │
│ │ như thế │ │ │ │ │ │
│ │ này..." │ │ │ │ │ │
│ └─────────────┘ └────────────────┘ └──────────────────┘ │
│ │
│ Ví dụ: │
│ S: "Hệ thống monolith hiện tại phục vụ 10K users/ngày" │
│ C: "Nhưng deploy mất 4h, 1 bug ảnh hưởng toàn bộ, scale khó" │
│ R: "Tách thành 5 microservices, deploy independent, scale riêng" │
└───────────────────────────────────────────────────────────────────┘
```

### 4. Visual Storytelling

#### 4.1 Progressive Disclosure

Không bao giờ show toàn bộ kiến trúc trong 1 slide. Thay vào đó, build up từng bước:

```
Slide 1: [Context Diagram] — "Đây là hệ thống của chúng ta"
Slide 2: [Zoom vào 1 component] — "Bên trong Order Service..."
Slide 3: [Sequence diagram] — "Khi user đặt hàng, flow như sau..."
Slide 4: [Deployment diagram] — "Và đây là cách deploy..."
```

#### 4.2 Diagram Best Practices cho Presentations

| Nguyên tắc | Mô tả | Ví dụ |
|------------|--------|-------|
| **One idea per slide** | Mỗi diagram truyền tải 1 ý chính | Không nhồi C4 Level 1 + Level 2 cùng slide |
| **Consistent shapes** | Cùng loại = cùng hình dạng | Rectangle = service, cylinder = database |
| **Max 5 colors** | Quá nhiều màu gây rối | Blue = internal, Gray = external, Red = critical path |
| **Animate carefully** | Hiện từng phần theo trình tự | Flow arrows xuất hiện theo thứ tự xử lý |
| **Large font** | Slide phải đọc được từ cuối phòng | Min 18pt cho body, 24pt cho titles |
| **Label everything** | Mỗi box, arrow đều có nhãn | "REST API", "async event", "gRPC" |

#### 4.3 Color Palette Recommendations

```
┌────────────────────────────────────────────────────────┐
│ RECOMMENDED COLOR PALETTE │
│ │
│ #4A90D9 — Internal services, components │
│ #7CB342 — Success paths, healthy states │
│ #FFA726 — Warnings, attention needed │
│ #E53935 — Errors, critical paths, failures │
│ #9E9E9E — External systems, third-party │
│ #7E57C2 — New/proposed components (highlight) │
│ │
│ [Khong] Tránh: Neon colors, gradient overuse, >6 colors │
│ [Khong] Tránh: Color as sole differentiator (accessibility) │
└────────────────────────────────────────────────────────┘
```

### 5. C4 Model trong Presentations

C4 Model cung cấp 4 levels zoom phù hợp với từng audience:

| C4 Level | Audience phù hợp | Nội dung | Khi nào dùng |
|----------|-------------------|----------|--------------|
| **Level 1 — Context** | Executives, PM | System + external actors | Mở đầu, tổng quan |
| **Level 2 — Container** | Dev leads, Architects | Services, databases, message queues | Thảo luận kiến trúc |
| **Level 3 — Component** | Developers | Classes, modules bên trong 1 container | Deep dive kỹ thuật |
| **Level 4 — Code** | Developers (rare) | Class diagrams, code structure | Code review, onboarding |

**Nguyên tắc trong presentation:** Bắt đầu Level 1, chỉ zoom vào Level 2–3 khi audience yêu cầu hoặc khi cần giải thích specific decision.

### 6. Architecture Decision Presentation

Khi trình bày một quyết định kiến trúc (ADR), cấu trúc khuyến nghị:

```
┌─────────────────────────────────────────────────────────────────┐
│ ARCHITECTURE DECISION PRESENTATION │
│ │
│ 1. CONTEXT (1–2 phút) │
│ - Business driver: Tại sao vấn đề này quan trọng? │
│ - Technical context: Hệ thống hiện tại như thế nào? │
│ │
│ 2. DECISION (2–3 phút) │
│ - Quyết định: "Chúng ta sẽ dùng X" │
│ - Lý do chính: 2–3 arguments mạnh nhất │
│ - Diagram minh họa │
│ │
│ 3. ALTERNATIVES (1–2 phút) │
│ - Option A vs B vs C (comparison matrix) │
│ - Tại sao loại bỏ A và C │
│ │
│ 4. TRADE-OFFS (1–2 phút) │
│ - Pros vs Cons table │
│ - Cái gì chúng ta "trả giá" (what we give up) │
│ - Mitigations cho các risks │
│ │
│ 5. NEXT STEPS (1 phút) │
│ - Timeline, milestones │
│ - Resources cần thiết │
│ - Ask: Cần gì từ audience? │
└─────────────────────────────────────────────────────────────────┘
```

### 7. Demo vs Slides — Khi nào dùng gì?

| Tiêu chí | Slides | Live Demo |
|----------|--------|-----------|
| **Khi nào** | Trình bày concept, quyết định, kế hoạch | Show hệ thống thực, chứng minh feasibility |
| **Ưu điểm** | Kiểm soát narrative, polished | Convincing, thực tế, interactive |
| **Nhược điểm** | Có thể abstract, boring | Rủi ro fail, mất thời gian |
| **Audience** | Executives, mixed audience | Developers, technical reviewers |
| **Backup plan** | N/A | Luôn có recorded demo backup |

**Pro tip:** Kết hợp cả hai — dùng slides cho context & decision, chuyển sang live demo để chứng minh.

### 8. Elevator Pitch cho Architecture

Elevator pitch = trình bày ý tưởng kiến trúc trong 30–60 giây (thời gian đi thang máy).

**Template:**

```
"Hệ thống [TÊN] hiện tại gặp vấn đề [VẤN ĐỀ].
Chúng tôi đề xuất [GIẢI PHÁP] sử dụng [CÔNG NGHỆ].
Điều này sẽ giúp [LỢI ÍCH 1] và [LỢI ÍCH 2],
với chi phí [CHI PHÍ/EFFORT] trong [TIMELINE]."
```

**Ví dụ:**

> "Hệ thống e-commerce của chúng ta đang mất 3% đơn hàng do timeout khi flash sale. Chúng tôi đề xuất tách Order Service thành microservice riêng với event-driven queue bằng Kafka. Điều này sẽ tăng throughput 10x và giảm order loss xuống 0.01%, với effort 2 sprints cho team 3 người."

---

## Step-by-step Labs

### Lab 1: Audience Analysis Workshop (25 phút)

**Mục tiêu:** Phân tích 3 nhóm audience và tailor cùng một kiến trúc cho từng nhóm.

**Scenario:** Bạn là architect đề xuất chuyển hệ thống e-commerce từ monolith sang microservices.

#### Bước 1 — Xác định 3 audiences (5 phút)

Điền bảng Audience Profile cho từng nhóm:

```markdown
## Audience Profile

### Audience 1: CTO / VP Engineering
- **Role:** CTO
- **Technical level:** High-level technical
- **Primary concern:** Cost, timeline, risk
- **Key question:** "Tốn bao nhiêu? Bao lâu xong? Rủi ro gì?"
- **Success metric:** Approve budget + timeline
- **Time available:** 5 phút

### Audience 2: Backend Development Team (5 developers)
- **Role:** Senior & Junior developers
- **Technical level:** Deep technical
- **Primary concern:** How to implement, DX, learning curve
- **Key question:** "Codebase thay đổi thế nào? Stack gì? Test sao?"
- **Success metric:** Team buy-in + clear implementation plan
- **Time available:** 20 phút

### Audience 3: DevOps / SRE Team (2 engineers)
- **Role:** DevOps Engineer
- **Technical level:** Infra-focused technical
- **Primary concern:** Deployment, monitoring, incidents
- **Key question:** "Deploy thế nào? Monitor gì? Rollback ra sao?"
- **Success metric:** Deployment plan approved
- **Time available:** 15 phút
```

#### Bước 2 — Tailor key messages (10 phút)

Viết **cùng một kiến trúc** nhưng khác thông điệp cho 3 audiences:

| | CTO | Dev Team | DevOps |
|--|-----|----------|--------|
| **Opening** | "Monolith đang giới hạn tốc độ release, ảnh hưởng revenue" | "Monolith codebase 200K LOC, build 45 phút, conflict liên tục" | "Mỗi deploy phải downtime 2h, rollback mất 4h" |
| **Key diagram** | C4 Context (Level 1) | C4 Container + Component (Level 2–3) | Deployment diagram + infra topology |
| **Trade-off focus** | Cost vs. long-term savings | Complexity vs. independence | Operational overhead vs. resilience |
| **Call to action** | "Approve budget 6 tháng, team 5 người" | "Review RFC, feedback trong 1 tuần" | "Validate deployment plan, setup CI/CD" |

#### Bước 3 — Peer review (10 phút)

Trao đổi bảng với bạn cùng nhóm. Review theo checklist:

- [ ] Message phù hợp với audience concern?
- [ ] Diagram level đúng?
- [ ] Không dùng jargon sai audience?
- [ ] Call to action rõ ràng?

---

### Lab 2: Create Architecture Presentation — 10-Slide Deck (40 phút)

**Mục tiêu:** Tạo slide deck 10 slides hoàn chỉnh cho việc trình bày kiến trúc microservices e-commerce.

#### Slide Outline Template

```
┌──────────────────────────────────────────────────────────────────┐
│ SLIDE 1: Title Slide │
│ ─────────────────── │
│ - Tên dự án: "E-Commerce Microservices Migration" │
│ - Presenter name + role │
│ - Date │
│ - Company/Team logo │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 2: Agenda / Outline │
│ ──────────────────────── │
│ - 5–6 bullet points tương ứng các phần sẽ trình bày │
│ - Estimated time cho mỗi phần │
│ - "Questions are welcome at any time" │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 3: Context — The Problem (SCR: Situation + Complication) │
│ ────────────────────────────────────────────────────────────── │
│ - Situation: "Hệ thống monolith, 50K DAU, 3 năm tuổi" │
│ - Complication: 3 pain points với data/metrics │
│ - Deploy time: 4 giờ → business impact │
│ - Coupling: 1 bug → toàn hệ thống down │
│ - Scale: Không thể scale từng phần │
│ - Visual: Simple "before" diagram showing monolith │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 4: C4 Context Diagram (Level 1) │
│ ───────────────────────────────────── │
│ - System boundary rõ ràng │
│ - External actors: Customer, Admin, Payment Gateway, Shipping │
│ - Chú thích mỗi interaction arrow │
│ - Legend ở góc dưới │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 5: Proposed Architecture — C4 Container Diagram (Level 2) │
│ ──────────────────────────────────────────────────────────── │
│ - 5 microservices: User, Product, Order, Payment, Notification │
│ - Databases riêng cho mỗi service │
│ - Message broker (Kafka/RabbitMQ) ở giữa │
│ - API Gateway phía trước │
│ - Color coding: blue = service, gray = infra, green = external │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 6: Key Architecture Decisions (ADR Summary) │
│ ───────────────────────────────────────────────── │
│ - Decision 1: Event-driven communication (not sync REST) │
│ - Decision 2: Database per service (not shared DB) │
│ - Decision 3: API Gateway pattern (not direct client-service) │
│ - Mỗi decision: 1 dòng lý do + 1 dòng trade-off │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 7: Trade-off Analysis │
│ ─────────────────────── │
│ - Comparison matrix: Monolith vs Microservices │
│ | Criteria | Monolith | Microservices | │
│ |----------------|----------|---------------| │
│ | Deploy speed | 4h | 15 min | │
│ | Fault isolation| No | Yes | │
│ | Complexity | Low | High | │
│ | Team autonomy | Low | High | │
│ - Highlight: "Chấp nhận tăng complexity để được X, Y, Z" │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 8: Migration Strategy & Timeline │
│ ────────────────────────────────────── │
│ - Phased approach (Strangler Fig pattern) │
│ - Phase 1 (Month 1–2): Extract User Service │
│ - Phase 2 (Month 3–4): Extract Order + Payment │
│ - Phase 3 (Month 5–6): Extract Product + Notification │
│ - Visual: Gantt-style timeline hoặc roadmap │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 9: Risks & Mitigations │
│ ──────────────────────── │
│ - Risk 1: Data consistency → Mitigation: Saga pattern │
│ - Risk 2: Network failures → Mitigation: Circuit breaker │
│ - Risk 3: Operational complexity → Mitigation: K8s + observability│
│ - Risk 4: Team learning curve → Mitigation: Training + mentoring│
│ - Visual: Risk matrix (likelihood x impact) │
├──────────────────────────────────────────────────────────────────┤
│ SLIDE 10: Summary & Call to Action │
│ ────────────────────────────── │
│ - Recap 3 key points │
│ - Clear ask: "Approve Phase 1 budget, start Month 1" │
│ - Next steps: RFC review deadline, POC timeline │
│ - Q&A invitation │
│ - Contact info │
└──────────────────────────────────────────────────────────────────┘
```

#### Hướng dẫn thực hiện

1. **Chọn tool:** Google Slides (recommended), PowerPoint, hoặc Marp (markdown-based)
2. **Design rules:**
 - Font: Sans-serif (Inter, Roboto, Segoe UI), min 18pt body
 - Max 6 bullet points / slide
 - Max 1 diagram / slide
 - White background hoặc dark theme nhất quán
3. **C4 diagrams:** Export từ PlantUML hoặc Structurizr, paste vào slide
4. **Thời lượng trình bày:** 8–10 phút (≈1 phút/slide)

#### Deliverable

File slide deck (`.pptx`, `.pdf`, hoặc `.md` nếu dùng Marp) với 10 slides theo outline trên.

---

### Lab 3: Architecture Decision Pitch — 5 phút + Q&A (30 phút)

**Mục tiêu:** Trình bày và bảo vệ một quyết định công nghệ trong 5 phút, sau đó xử lý Q&A giả lập.

#### Scenario

Bạn cần thuyết phục team chọn **Kafka** thay vì **RabbitMQ** cho hệ thống event-driven e-commerce.

#### Pitch Script Template (5 phút)

```
PHÚT 1 — HOOK & CONTEXT
─────────────────────────
"Tuần trước, hệ thống mất 500 đơn hàng trong 2 giờ vì
Order Service gọi sync tới Payment Service bị timeout.
Chúng ta cần một message broker đáng tin cậy.
Hôm nay tôi sẽ giải thích tại sao Kafka là lựa chọn đúng."

PHÚT 2 — COMPARISON
────────────────────
[Show comparison table]

| Criteria | Kafka | RabbitMQ |
|---------------------|----------------|------------------|
| Throughput | 100K+ msg/s | 20K msg/s |
| Message retention | Configurable | Until consumed |
| Replay capability | Yes | No |
| Ordering guarantee | Per partition | Per queue |
| Learning curve | Steeper | Easier |
| Operational cost | Higher | Lower |

PHÚT 3 — WHY KAFKA
───────────────────
"3 lý do chính:
1. Replay: Khi deploy service mới, cần replay events → chỉ Kafka
2. Throughput: Flash sale cần 50K orders/phút → Kafka handles
3. Event sourcing: Future roadmap cần event store → Kafka native"

PHÚT 4 — TRADE-OFFS & MITIGATIONS
──────────────────────────────────
"Kafka phức tạp hơn, nhưng:
- Learning curve → Team training 2 tuần, có Kafka expert mentor
- Ops overhead → Dùng managed Kafka (Confluent Cloud / AWS MSK)
- Cost → $500/month managed, ROI trong 3 tháng"

PHÚT 5 — NEXT STEPS & ASK
──────────────────────────
"Đề xuất:
- Sprint 1: POC với Order → Payment flow trên Kafka
- Sprint 2: Migrate 2 critical flows
- Cần: Team approve, budget cho managed Kafka
Câu hỏi?"
```

#### Q&A Simulation — Bank câu hỏi

Instructor hoặc peer đóng vai stakeholder, chọn 3–5 câu từ bank:

| # | Câu hỏi | Loại | Gợi ý trả lời |
|---|---------|------|----------------|
| 1 | "RabbitMQ dễ hơn, tại sao không chọn?" | Challenge | Giải thích replay + throughput requirement |
| 2 | "Kafka mất message không?" | Technical | At-least-once delivery, idempotent consumers |
| 3 | "Chi phí hàng tháng bao nhiêu?" | Business | $500 managed, so sánh với cost of lost orders |
| 4 | "Team chưa ai biết Kafka, training thế nào?" | Concern | 2-week plan, pair programming, sandbox env |
| 5 | "Nếu Kafka cluster down thì sao?" | Risk | Multi-AZ, replication factor 3, fallback plan |
| 6 | "Có thể pilot trước không?" | Scope | POC Sprint 1, measure trước khi commit |
| 7 | "Microservices đã đủ phức tạp, thêm Kafka?" | Push-back | Kafka giảm coupling, net simplification |

#### Khi không biết câu trả lời

```
[OK] "Câu hỏi hay. Tôi chưa có data chính xác, nhưng sẽ research và
 trả lời bằng email trước thứ 6."

[OK] "Đó là concern valid. Tôi sẽ thêm vào risk register và evaluate
 trong POC sprint."

[Khong] KHÔNG: Bịa số liệu, phớt lờ câu hỏi, tỏ ra defensive
```

---

### Lab 4: Live Architecture Demo (25 phút)

**Mục tiêu:** Trình bày hệ thống đang chạy với monitoring dashboard, trace một request end-to-end.

#### Setup (5 phút)

Chuẩn bị sẵn các thành phần:

```
┌────────────────────────────────────────────────────────────┐
│ DEMO ENVIRONMENT │
│ │
│ Terminal 1: Docker Compose (all services running) │
│ Terminal 2: curl/httpie (gửi requests) │
│ Browser Tab 1: Grafana dashboard (metrics) │
│ Browser Tab 2: Jaeger UI (distributed tracing) │
│ Browser Tab 3: Application UI (e-commerce frontend) │
│ │
│ Backup: Pre-recorded demo video (5 phút) │
└────────────────────────────────────────────────────────────┘
```

#### Demo Script (15 phút)

```
PART 1 — SYSTEM OVERVIEW (3 phút)
──────────────────────────────────
1. Show running containers:
 $ docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

2. Show Grafana dashboard:
 - Service health: All green [OK]
 - Request rate: ~100 req/s
 - Error rate: < 0.1%
 - P99 latency: < 200ms

PART 2 — TRACE A REQUEST (5 phút)
──────────────────────────────────
1. Tạo đơn hàng qua API:
 $ curl -X POST http://localhost:8080/api/orders \
 -H "Content-Type: application/json" \
 -d '{"userId": "123", "items": [{"productId": "A1", "qty": 2}]}'

2. Show request flow trên Jaeger:
 → API Gateway → Order Service → Product Service (check stock)
 → Payment Service (charge)
 → Notification Service (email)

3. Chỉ ra latency breakdown:
 - Total: 180ms
 - Order validation: 20ms
 - Stock check: 45ms
 - Payment: 90ms (bottleneck — giải thích tại sao)
 - Notification: async (không blocking)

PART 3 — FAILURE SCENARIO (5 phút)
───────────────────────────────────
1. Simulate failure:
 $ docker stop payment-service

2. Gửi lại request → Show circuit breaker activate
3. Show Grafana: Error rate spike, alert firing
4. Restart service:
 $ docker start payment-service
5. Show recovery: Circuit breaker half-open → closed
6. Show pending orders processed from queue

PART 4 — WRAP UP (2 phút)
──────────────────────────
- Tóm tắt: "Chúng ta vừa thấy system resilience thực tế"
- Trở lại slides cho Q&A
```

#### Demo Tips

| Tip | Mô tả |
|-----|--------|
| **Pre-warm** | Chạy demo 1 lần trước buổi present để đảm bảo services khởi động xong |
| **Big fonts** | Terminal font size ≥ 16pt, zoom browser 125–150% |
| **Narrate** | Giải thích từng bước trước khi thực hiện |
| **Backup** | Nếu demo fail, chuyển sang recorded video |
| **Timing** | Practice demo 3 lần, đo thời gian |

---

## Self-Assessment — 30 câu hỏi

### Band 1: Cơ bản (câu 1–10)

**Câu 1.** Khi trình bày kiến trúc cho executives, nên tập trung vào:
- A) Chi tiết implementation code
- B) Business value và ROI
- C) Database schema design
- D) API endpoint documentation

**Đáp án: B** — Executives quan tâm đến giá trị kinh doanh, chi phí, timeline, và rủi ro. Không cần chi tiết kỹ thuật.

---

**Câu 2.** Số lượng màu tối đa khuyến nghị trong architecture diagram là:
- A) 2
- B) 4–5
- C) 10
- D) Không giới hạn

**Đáp án: B** — 4–5 màu là đủ để phân biệt các loại thành phần mà không gây rối mắt. Quá nhiều màu làm giảm khả năng đọc diagram.

---

**Câu 3.** Khi không biết câu trả lời cho một câu hỏi, nên:
- A) Bịa một câu trả lời có vẻ hợp lý
- B) Thừa nhận và đề nghị follow-up sau
- C) Phớt lờ câu hỏi
- D) Chuyển sang topic khác

**Đáp án: B** — Thừa nhận trung thực xây dựng credibility. Hứa follow-up cụ thể (ngày, hình thức) để thể hiện professionalism.

---

**Câu 4.** SCR trong presentation framework là viết tắt của:
- A) Summary – Conclusion – Recommendation
- B) Situation – Complication – Resolution
- C) Scope – Context – Result
- D) Story – Conflict – Resolution

**Đáp án: B** — Situation–Complication–Resolution là framework từ McKinsey, giúp cấu trúc câu chuyện logic: mô tả hiện trạng, nêu vấn đề, đề xuất giải pháp.

---

**Câu 5.** C4 Model Level 1 (Context Diagram) phù hợp nhất cho audience nào?
- A) Junior developers
- B) Database administrators
- C) Executives và stakeholders
- D) QA testers

**Đáp án: C** — Context Diagram ở mức cao nhất, chỉ show hệ thống và các external actors/systems. Phù hợp cho người cần nhìn big picture.

---

**Câu 6.** Elevator pitch cho architecture nên dài bao lâu?
- A) 5–10 phút
- B) 30–60 giây
- C) 15–20 phút
- D) 1–2 giây

**Đáp án: B** — Elevator pitch là trình bày ngắn gọn cốt lõi trong 30–60 giây, đủ cho "một chuyến đi thang máy" để truyền tải ý chính.

---

**Câu 7.** Nguyên tắc "one idea per slide" có nghĩa là:
- A) Chỉ viết 1 từ trên mỗi slide
- B) Mỗi slide truyền tải 1 ý chính rõ ràng
- C) Chỉ dùng 1 màu trên mỗi slide
- D) Chỉ cho phép 1 diagram trong toàn bộ presentation

**Đáp án: B** — Mỗi slide nên focus vào 1 concept chính để audience dễ follow. Không nhồi nhiều ý vào cùng một slide.

---

**Câu 8.** Progressive disclosure trong visual storytelling là:
- A) Xóa thông tin dần dần
- B) Hiển thị từng phần kiến trúc theo trình tự, build up complexity
- C) Dùng font size giảm dần
- D) Ẩn tất cả diagrams

**Đáp án: B** — Progressive disclosure giúp audience tiêu hóa thông tin từng bước, tránh overwhelm bằng toàn bộ complexity cùng lúc.

---

**Câu 9.** Font size tối thiểu cho body text trong presentation slide là:
- A) 8pt
- B) 12pt
- C) 18pt
- D) 36pt

**Đáp án: C** — 18pt là minimum để đọc được từ cuối phòng họp. Title nên ≥ 24pt.

---

**Câu 10.** Backup plan cho live demo nên là:
- A) Không cần backup, tự tin vào hệ thống
- B) Pre-recorded demo video
- C) Bỏ qua phần demo
- D) Chuyển sang trình bày code trên IDE

**Đáp án: B** — Luôn chuẩn bị recorded video backup. Live demo có rủi ro fail (network, service crash), video đảm bảo bạn vẫn demo được.

---

### Band 2: Trung bình (câu 11–20)

**Câu 11.** Khi developers challenge "Tại sao không dùng Y thay vì X?", chiến thuật tốt nhất là:
- A) Phản bác ngay lập tức
- B) Thừa nhận Y là option valid, giải thích trade-off và tại sao X phù hợp hơn trong context
- C) Nói "Tôi là architect, tôi quyết định"
- D) Hứa sẽ đổi sang Y

**Đáp án: B** — Acknowledge alternative trước, sau đó giải thích trade-off trong specific context của dự án. Đây là cách xây dựng consensus thay vì authority.

---

**Câu 12.** Trong C4 Container Diagram, "container" có nghĩa là:
- A) Docker container
- B) Một ứng dụng hoặc data store chạy riêng biệt
- C) Một class trong code
- D) Một physical server

**Đáp án: B** — Trong C4 Model, "container" là separately deployable unit: web app, API service, database, message queue — KHÔNG phải Docker container.

---

**Câu 13.** Comparison matrix trong decision presentation giúp:
- A) Làm slide đẹp hơn
- B) So sánh khách quan các options dựa trên cùng criteria
- C) Che giấu nhược điểm
- D) Tăng số lượng slides

**Đáp án: B** — Matrix giúp so sánh structured, transparent, cho phép audience tự đánh giá thay vì chỉ nghe presenter nói "X tốt hơn Y".

---

**Câu 14.** Khi trình bày cho mixed audience (executives + developers cùng phòng), nên:
- A) Chỉ trình bày cho executives, developers tự tìm hiểu
- B) Bắt đầu high-level cho executives, có phần appendix/deep dive cho developers
- C) Trình bày toàn bộ technical details
- D) Tổ chức 2 buổi riêng (không present)

**Đáp án: B** — Layered approach: Main presentation ở high-level, kèm appendix slides hoặc "parking lot" cho deep dive questions.

---

**Câu 15.** Strangler Fig pattern trong migration strategy là:
- A) Viết lại toàn bộ hệ thống cùng lúc
- B) Dần dần thay thế từng phần của monolith bằng microservices
- C) Chạy 2 hệ thống song song vĩnh viễn
- D) Tắt hệ thống cũ ngay lập tức

**Đáp án: B** — Strangler Fig dần dần route traffic sang service mới, giảm rủi ro big-bang migration. Monolith "co lại" dần cho đến khi được thay thế hoàn toàn.

---

**Câu 16.** Circuit breaker trong demo failure scenario giúp minh họa:
- A) Code quality
- B) System resilience — hệ thống tự protect khi dependency fail
- C) Database optimization
- D) UI design

**Đáp án: B** — Circuit breaker ngăn cascade failure bằng cách "ngắt mạch" khi downstream service không healthy, cho phép graceful degradation.

---

**Câu 17.** Risk matrix trong architecture presentation dùng 2 trục:
- A) Cost x Timeline
- B) Likelihood x Impact
- C) Size x Color
- D) Priority x Effort

**Đáp án: B** — Risk matrix đánh giá risks theo xác suất xảy ra (likelihood) và mức ảnh hưởng (impact) để prioritize mitigation.

---

**Câu 18.** Khi demo live hệ thống, terminal font size nên ≥:
- A) 8pt
- B) 12pt
- C) 16pt
- D) 6pt

**Đáp án: C** — ≥ 16pt đảm bảo audience đọc được output. Kết hợp zoom browser 125–150% cho dashboard.

---

**Câu 19.** ADR Summary trong slide nên chứa:
- A) Toàn bộ ADR document (5–10 trang)
- B) Decision title + lý do chính + trade-off (mỗi decision 2–3 dòng)
- C) Chỉ title, không cần giải thích
- D) Code implementation

**Đáp án: B** — Slide là summary, không phải document. Mỗi decision cần đủ context để audience hiểu "why" nhưng không quá dài.

---

**Câu 20.** "Narrate before execute" trong demo có nghĩa là:
- A) Đọc to code trước khi chạy
- B) Giải thích bạn sẽ làm gì trước khi thực hiện thao tác
- C) Viết script trước khi demo
- D) Record narration riêng

**Đáp án: B** — Nói "Bây giờ tôi sẽ tắt Payment Service để simulate failure" TRƯỚC khi chạy `docker stop`. Giúp audience biết expect gì.

---

### Band 3: Nâng cao (câu 21–30)

**Câu 21.** Trong presentation cho Architecture Review Board (ARB), element nào QUAN TRỌNG NHẤT?
- A) Slide animations đẹp
- B) Alternatives considered + reasoning for rejection
- C) Company logo
- D) Speaker bio

**Đáp án: B** — ARB đánh giá chất lượng quyết định dựa trên việc bạn đã consider đầy đủ alternatives và có reasoning sound cho selection.

---

**Câu 22.** Khi audience hỏi "This seems over-engineered", cách phản hồi tốt nhất là:
- A) "Không, bạn không hiểu"
- B) Acknowledge concern, giải thích requirements dẫn đến complexity, chỉ ra cost of under-engineering
- C) Đồng ý và bỏ design
- D) Bỏ qua comment

**Đáp án: B** — Validate concern trước ("Tôi hiểu concern của bạn về complexity"), sau đó giải thích requirements cụ thể (scale, reliability) và risk nếu simple hơn.

---

**Câu 23.** Khi trình bày distributed tracing (Jaeger), insight nào gây ấn tượng nhất với audience?
- A) Số lượng spans
- B) Latency breakdown cho thấy bottleneck rõ ràng
- C) Màu sắc của trace
- D) Số lượng services

**Đáp án: B** — Latency breakdown giúp audience "nhìn thấy" performance issue cụ thể (vd: Payment 90ms = 50% total time), tạo "aha moment".

---

**Câu 24.** Sự khác biệt giữa "presenting architecture" và "defending architecture" là:
- A) Không khác biệt
- B) Presenting = truyền tải thông tin; Defending = bảo vệ quyết định trước challenges
- C) Presenting dùng slides, Defending dùng whiteboard
- D) Presenting cho executives, Defending cho developers

**Đáp án: B** — Presenting là proactive communication; Defending là reactive — bạn phải anticipate objections, chuẩn bị evidence, và maintain composure under pressure.

---

**Câu 25.** Khi flash sale scenario cần 50K orders/phút, data point nào thuyết phục nhất trong pitch?
- A) "Kafka nhanh hơn RabbitMQ"
- B) "Benchmark: Kafka xử lý 100K msg/s trên cluster 3 nodes, vs RabbitMQ 20K msg/s"
- C) "Kafka phổ biến hơn"
- D) "Tôi thích Kafka"

**Đáp án: B** — Specific benchmark với numbers cụ thể và điều kiện rõ ràng thuyết phục hơn statements chung chung. Data > opinions.

---

**Câu 26.** Phased migration approach có ưu điểm gì so với big-bang migration khi trình bày cho executives?
- A) Dễ vẽ diagram hơn
- B) Giảm risk (fail 1 phase không mất toàn bộ), deliver value sớm hơn, dễ cancel nếu cần
- C) Mất nhiều thời gian hơn nên có thêm slides
- D) Executives thích timeline dài

**Đáp án: B** — Executives value risk mitigation. Phased approach cho phép "fail fast, fail small", deliver incremental value, và có exit points nếu cần thay đổi strategy.

---

**Câu 27.** Trong architecture presentation, "call to action" nên:
- A) Vague: "Mọi người nghĩ sao?"
- B) Specific: "Approve budget $50K cho Phase 1, kick-off tuần sau"
- C) Absent — không cần CTA
- D) Implicit — audience tự hiểu

**Đáp án: B** — CTA phải specific và actionable. Audience rời phòng biết chính xác cần làm gì, ai làm, khi nào.

---

**Câu 28.** Event sourcing trong Kafka pitch là argument mạnh vì:
- A) Buzzword gây ấn tượng
- B) Kafka native hỗ trợ event log immutable, phù hợp audit trail và rebuild state — RabbitMQ không có capability này
- C) Event sourcing không quan trọng
- D) Mọi message broker đều hỗ trợ event sourcing

**Đáp án: B** — Kafka log-based architecture tự nhiên phù hợp event sourcing: replay events, rebuild state, audit compliance. Đây là differentiator rõ ràng vs traditional message queues.

---

**Câu 29.** Khi monitor dashboard trong demo cho thấy P99 latency spike, narrative tốt nhất là:
- A) Bỏ qua, giả vờ không thấy
- B) "Đây là ví dụ thực tế — P99 spike cho thấy 1% requests bị ảnh hưởng. Dashboard alert chúng ta investigate root cause"
- C) Tắt dashboard
- D) Giải thích P99 là lỗi Grafana

**Đáp án: B** — Biến "sự cố" thành teachable moment cho thấy observability thực sự hoạt động. Transparency builds credibility hơn là che giấu issues.

---

**Câu 30.** Yếu tố nào phân biệt một architecture presentation "xuất sắc" so với "tốt"?
- A) Nhiều slide animations
- B) Storytelling coherent + data-backed decisions + confident Q&A handling + clear CTA
- C) Slide template đắt tiền
- D) Nhiều hơn 50 slides

**Đáp án: B** — Presentation xuất sắc kết hợp 4 yếu tố: narrative mạch lạc (storytelling), quyết định có data hỗ trợ, tự tin xử lý câu hỏi, và kết thúc với CTA rõ ràng.

---

## Extend Labs (10 bài)

### EL1: Executive Board Presentation ***

```
Mục tiêu: Trình bày architecture cho Board of Directors
Yêu cầu:
 - Tạo 5-slide deck hoàn toàn non-technical
 - Focus: ROI, competitive advantage, risk summary
 - Include: Cost-benefit analysis (1-year projection)
 - Practice: Trình bày trong 5 phút, peer đóng vai CEO đặt câu hỏi
Deliverable: Slide deck (.pdf) + 1-page executive summary
```

### EL2: Technical Architecture Review ***

```
Mục tiêu: Deep dive cho development team
Yêu cầu:
 - 15-slide deck với C4 Level 2–3 diagrams
 - Include: Sequence diagrams cho 3 key flows
 - Include: Code snippets cho critical patterns (circuit breaker, retry)
 - Discuss: Trade-offs table với weighted scoring
Deliverable: Slide deck + code examples repository
```

### EL3: Architecture Review Board (ARB) Presentation ****

```
Mục tiêu: Present formal architecture decision cho review board
Yêu cầu:
 - Follow ADR format: Context, Decision, Alternatives, Consequences
 - Prepare 3 alternatives với detailed comparison matrix
 - Risk analysis với quantified impact
 - Compliance check (security, scalability, maintainability)
 - Simulate: 3 board members challenge từ perspectives khác nhau
Deliverable: ARB presentation + written ADR document
```

### EL4: Remote/Virtual Presentation **

```
Mục tiêu: Master virtual presentation skills
Yêu cầu:
 - Setup: Camera, lighting, background, mic check
 - Engagement: Polls, chat interaction, breakout rooms
 - Screen sharing: Clean desktop, correct window, annotation tools
 - Record: Full session với OBS hoặc Zoom recording
 - Review: Self-critique recording (body language, pace, filler words)
Deliverable: Recorded presentation (15 phút) + self-critique notes
```

### EL5: Live Demo Mastery ***

```
Mục tiêu: Flawless live system demonstration
Yêu cầu:
 - Prepare demo environment (Docker Compose / K8s)
 - Script 3 scenarios: Happy path, failure, recovery
 - Practice "narrate before execute" technique
 - Create backup plan: recorded video, screenshots, prepared outputs
 - Time: Demo exactly 10 phút (±30 seconds)
Deliverable: Demo script + backup video + environment setup guide
```

### EL6: Multi-Audience Adaptation ****

```
Mục tiêu: Same architecture, 4 different presentations
Yêu cầu:
 - Version 1: Executive (3 slides, 3 phút)
 - Version 2: Product Manager (5 slides, 5 phút)
 - Version 3: Developer (10 slides, 15 phút)
 - Version 4: Operations (7 slides, 10 phút)
 - Peer review: Mỗi version reviewed bởi người đóng vai audience đó
Deliverable: 4 slide decks + audience profile matrix
```

### EL7: Hostile Q&A Practice ***

```
Mục tiêu: Handle challenging và hostile questions
Yêu cầu:
 - Partner chuẩn bị 10 "hostile" questions (over-engineering, cost, risk)
 - Practice techniques: Bridge, Acknowledge-Answer-Redirect, "Parking lot"
 - Record Q&A sessions
 - Peer feedback: Score mỗi answer (1–5) trên: composure, accuracy, clarity
Deliverable: Q&A recording + peer score sheet
```

### EL8: Visual Design Workshop ***

```
Mục tiêu: Create publication-quality architecture slides
Yêu cầu:
 - Redesign Lab 2 slides theo professional template
 - Apply: Consistent color palette, typography hierarchy, white space
 - C4 diagrams: Export high-resolution, consistent style
 - Before/After: Show original vs redesigned slides
 - Tools: Figma, Canva, hoặc PowerPoint Designer
Deliverable: Before/After slide comparison + design style guide
```

### EL9: Persuasion & Stakeholder Buy-in ****

```
Mục tiêu: Convince resistant stakeholders
Yêu cầu:
 - Scenario: CTO ưa thích giữ monolith, bạn propose microservices
 - Apply: Cialdini's persuasion principles (reciprocity, social proof, authority)
 - Build: Coalition — identify allies, address blockers
 - Strategy: Progressive buy-in (POC → pilot → full rollout)
 - Role-play: Full 15-phút session với instructor as resistant CTO
Deliverable: Persuasion strategy document + role-play recording
```

### EL10: Presentation Portfolio ***

```
Mục tiêu: Build career-ready presentation portfolio
Yêu cầu:
 - Compile: Best slides từ Lab 2 + Extend Labs
 - Record: 2 polished presentations (executive + technical)
 - Feedback loop: Get feedback từ 3 peers, iterate
 - Self-improvement plan: Identify 3 areas to improve + practice schedule
 - Portfolio format: PDF + video links + GitHub repo
Deliverable: Portfolio document + 2 recorded presentations + improvement plan
```

---

## Deliverables Checklist

| # | Deliverable | Lab | Format | Bắt buộc |
|---|------------|-----|--------|----------|
| 1 | Audience Analysis Matrix (3 audiences) | Lab 1 | Markdown / Word | [OK] |
| 2 | Tailored key messages (3 versions) | Lab 1 | Markdown / Word | [OK] |
| 3 | 10-Slide Architecture Deck | Lab 2 | PPTX / PDF / Marp | [OK] |
| 4 | C4 diagrams (Level 1 + Level 2) | Lab 2 | PNG / SVG embedded | [OK] |
| 5 | 5-minute Pitch Script | Lab 3 | Markdown / Word | [OK] |
| 6 | Q&A Response Notes | Lab 3 | Markdown | [OK] |
| 7 | Live Demo Script | Lab 4 | Markdown | [OK] |
| 8 | Demo Backup Video | Lab 4 | MP4 (≤ 5 phút) | [OK] |
| 9 | Self-Assessment Answers (30 câu) | Quiz | Viết tay / Digital | [OK] |
| 10 | Peer Review Feedback (given + received) | Lab 1, 3 | Form / Notes | [OK] |

---

## Lỗi Thường Gặp

| # | Lỗi | Hậu quả | Cách sửa |
|---|------|---------|----------|
| 1 | **Quá nhiều chi tiết kỹ thuật cho executives** | Audience mất tập trung, không approve | Dùng C4 Level 1, focus business value |
| 2 | **Quá sơ sài cho developers** | Team không đủ thông tin implement | Thêm C4 Level 2–3, code examples, ADRs |
| 3 | **Không có backup plan cho demo** | Demo fail → mất credibility | Luôn có recorded video + screenshots |
| 4 | **Slides quá nhiều text (wall of text)** | Audience đọc slide thay vì nghe bạn | Max 6 bullets/slide, dùng diagrams |
| 5 | **Không có Call to Action** | Audience rời phòng không biết next step | Kết thúc với specific, actionable CTA |
| 6 | **Bịa data khi không biết answer** | Mất trust, bị phát hiện sau | Thừa nhận + hứa follow-up cụ thể |
| 7 | **Font quá nhỏ** | Audience cuối phòng không đọc được | Min 18pt body, 24pt title, 16pt terminal |
| 8 | **Diagram không có legend** | Audience đoán ý nghĩa shapes/colors | Luôn có legend ở góc dưới mỗi diagram |
| 9 | **Không practice timing** | Vượt giờ hoặc kết thúc sớm, bỏ sót nội dung | Practice ≥ 3 lần, dùng timer |
| 10 | **Defensive khi bị challenge** | Mất rapport, audience oppose thay vì collaborate | Acknowledge concern trước, explain trade-off |

---

## Rubric Chấm điểm (100 điểm)

| Tiêu chí | Mô tả chi tiết | Điểm |
|----------|----------------|:----:|
| **Audience Analysis** | Xác định đúng 3 audiences, tailor messages phù hợp, diagram level đúng, CTA phù hợp từng nhóm | **10** |
| **Slide Deck Quality** | 10 slides đầy đủ theo outline, professional design, consistent style, readable fonts | **15** |
| **C4 Diagrams** | Đúng notation C4, đúng level cho audience, có legend, labels rõ ràng, aesthetics tốt | **10** |
| **ADR Presentation** | Decisions rõ ràng, có alternatives + reasoning, trade-offs transparent | **10** |
| **Pitch Delivery** | Đúng 5 phút (±30s), confident, clear voice, eye contact, logical flow | **10** |
| **Q&A Handling** | Trả lời đúng ≥3 câu, composure tốt, acknowledge + answer + redirect | **10** |
| **Live Demo** | Hệ thống chạy, trace request thành công, failure scenario demo, narrate trước khi execute | **10** |
| **Visual Design** | Color palette nhất quán, typography hierarchy, white space, no wall-of-text | **5** |
| **Storytelling (SCR)** | Có Situation-Complication-Resolution rõ ràng, narrative mạch lạc | **5** |
| **Trade-off Analysis** | Comparison matrix có criteria rõ, balanced (không chỉ show pros), honest about cons | **5** |
| **Self-Assessment** | Hoàn thành 30 câu, đáp án chính xác ≥80% | **5** |
| **Peer Review** | Tham gia review bạn + nhận feedback, có improvement notes | **5** |
| **Tổng** | | **100** |

**Thang điểm:**

| Mức | Điểm | Mô tả |
|-----|:-----:|-------|
| Xuất sắc | 90–100 | Presentation chuyên nghiệp, Q&A confident, demo flawless |
| Tốt | 75–89 | Đầy đủ nội dung, trình bày rõ ràng, minor issues |
| Đạt | 60–74 | Hoàn thành cơ bản nhưng thiếu depth hoặc polish |
| Chưa đạt | < 60 | Thiếu deliverables, trình bày không rõ ràng, không handle Q&A |

---

## Tài liệu Tham khảo

1. **Nancy Duarte** — *"slide:ology"* — Visual communication principles
2. **Garr Reynolds** — *"Presentation Zen"* — Simplicity in slides
3. **Barbara Minto** — *"The Pyramid Principle"* — SCR framework, structured thinking
4. **Simon Brown** — [C4 Model](https://c4model.com/) — Architecture visualization
5. **arc42** — [arc42.org](https://arc42.org/) — Architecture documentation template
6. **IEEE 42010** — Systems and Software Engineering — Architecture Description
7. **Robert Cialdini** — *"Influence: The Psychology of Persuasion"* — Stakeholder buy-in
8. **CMU SEI** — Software Architecture in Practice (Bass, Clements, Kazman)
