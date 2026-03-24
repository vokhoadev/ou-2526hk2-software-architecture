# Lab 4.3: SAAM — Software Architecture Analysis Method

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu trước** | Hoàn thành Lab 4.1 (Quality Attributes), Lab 4.2 (ATAM) |
| **Phương pháp** | SAAM — scenario-based architecture evaluation |
| **Hệ thống mục tiêu** | E-Commerce Monolithic Application |
| **Công cụ** | Markdown editor, diagramming tool (draw.io / Mermaid) |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Giải thích** nguồn gốc, mục đích và quy trình 5 bước của SAAM (CMU SEI)
2. **Phát triển** các modification scenarios và usage scenarios phù hợp cho một hệ thống phần mềm
3. **Phân loại** scenarios thành Direct và Indirect, ánh xạ chúng lên các architecture components
4. **Đánh giá** indirect scenarios bằng cách ước lượng effort, xác định affected components và risk level
5. **Phân tích** scenario interaction để phát hiện coupling hotspots và viết SAAM evaluation report hoàn chỉnh

---

## Phân bổ Thời gian

| Hoạt động | Thời lượng | Mô tả |
|-----------|-----------|-------|
| Lý thuyết SAAM | 35 phút | Overview, quy trình 5 bước, so sánh SAAM vs ATAM |
| Lab 1: Develop Scenarios | 25 phút | Xây dựng 15+ modification/usage scenarios |
| Lab 2: Classify Scenarios | 25 phút | Phân loại Direct vs Indirect, mapping components |
| Lab 3: Evaluate Indirect Scenarios | 30 phút | Ước lượng effort, affected components, risk |
| Lab 4: Scenario Interaction Analysis | 35 phút | Interaction matrix, coupling, SAAM report |
| Self-Assessment | 15 phút | 30 câu hỏi tự đánh giá |
| Tổng kết & Review | 15 phút | Wrap-up, Q&A, nộp deliverables |
| **Tổng** | **180 phút (3 giờ)** | |

---

## Lý thuyết

### 1. SAAM Overview (CMU SEI)

**SAAM** (Software Architecture Analysis Method) là phương pháp đánh giá kiến trúc phần mềm đầu tiên được phát triển bởi **Software Engineering Institute (SEI)** tại **Carnegie Mellon University** vào đầu thập niên 1990, bởi nhóm nghiên cứu gồm **Rick Kazman, Len Bass, Paul Clements** và cộng sự.

**Đặc điểm chính:**

- **Scenario-based**: Sử dụng các kịch bản thực tế để đánh giá kiến trúc
- **Focus chính**: **Modifiability** — khả năng thay đổi, mở rộng hệ thống
- **Lightweight**: Đơn giản hơn ATAM, phù hợp đánh giá nhanh
- **Comparative**: Có thể so sánh nhiều architecture candidates
- **Predecessor**: Là tiền thân của ATAM — nhiều ý tưởng trong SAAM được mở rộng trong ATAM

**Khi nào sử dụng SAAM:**

| Tình huống | Lý do |
|-----------|-------|
| So sánh 2+ architecture alternatives | SAAM hỗ trợ comparative evaluation |
| Đánh giá modifiability trước khi commit | Focus vào khả năng thay đổi |
| Quick architecture review (1-2 ngày) | Nhẹ hơn ATAM |
| Early-stage development | Phù hợp khi chưa có kiến trúc chi tiết |
| Limited stakeholder availability | Không cần nhiều stakeholders như ATAM |

### 2. SAAM vs ATAM — So sánh Chi tiết

| Tiêu chí | SAAM | ATAM |
|----------|------|------|
| **Năm phát triển** | ~1993 | ~2000 |
| **Tổ chức** | CMU SEI | CMU SEI |
| **Focus** | Modifiability (chủ yếu) | Multiple quality attributes |
| **Complexity** | Đơn giản | Phức tạp hơn |
| **Thời gian** | 1-2 ngày | 2-4 ngày (2 phases) |
| **Team size** | 3-5 người | 8-15 người |
| **Stakeholder involvement** | Ít hơn | Nhiều hơn |
| **Core artifact** | Scenario classification + interaction matrix | Utility tree + tradeoff analysis |
| **Kịch bản** | Modification + usage scenarios | Quality attribute scenarios |
| **Đầu ra chính** | Scenario interaction analysis | Sensitivity/tradeoff points, risks |
| **So sánh kiến trúc** | Hỗ trợ tốt | Không focus |
| **Applicability** | Specific (modifiability) | Broad (mọi QA) |

**Mối quan hệ lịch sử:** SAAM → SAAM Founded Techniques → ATAM. ATAM kế thừa ý tưởng scenario-based analysis từ SAAM nhưng mở rộng ra nhiều quality attributes và thêm utility tree, sensitivity/tradeoff analysis.

### 3. Quy trình 5 Bước của SAAM

```
┌──────────────────────────────────────────────────────────────────────┐
│ SAAM Process — 5 Steps │
│ │
│ ┌───────────────────────────────────────────┐ │
│ │ Step 1: Develop Scenarios │ ← Stakeholders │
│ │ (modification + usage scenarios) │ │
│ └─────────────────┬─────────────────────────┘ │
│ ▼ │
│ ┌───────────────────────────────────────────┐ │
│ │ Step 2: Describe Architecture │ ← Architecture team │
│ │ (components, connectors, data flow) │ │
│ └─────────────────┬─────────────────────────┘ │
│ ▼ │
│ ┌───────────────────────────────────────────┐ │
│ │ Step 3: Classify Scenarios │ │
│ │ (direct vs indirect) │ │
│ └─────────────────┬─────────────────────────┘ │
│ ▼ │
│ ┌───────────────────────────────────────────┐ │
│ │ Step 4: Evaluate Indirect Scenarios │ │
│ │ (effort, affected components, risk) │ │
│ └─────────────────┬─────────────────────────┘ │
│ ▼ │
│ ┌───────────────────────────────────────────┐ │
│ │ Step 5: Assess Scenario Interaction │ │
│ │ (overlap matrix, coupling, report) │ │
│ └───────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────┘
```

#### Step 1: Develop Scenarios

Thu thập hai loại kịch bản từ stakeholders:

- **Modification Scenarios**: Các thay đổi có thể xảy ra trong tương lai (feature mới, thay đổi technology, integration mới)
- **Usage Scenarios**: Các tương tác hiện tại của người dùng với hệ thống (login, search, checkout)

Yêu cầu: Scenarios phải cụ thể, thực tế, có thể đo lường được. Mỗi scenario nên mô tả: **stimulus → response**.

#### Step 2: Describe Architecture

Mô tả kiến trúc hệ thống bao gồm:
- **Components**: Các module/service chính
- **Connectors**: Cách các components giao tiếp (API, message queue, shared DB)
- **Data flow**: Luồng dữ liệu giữa các components
- **Deployment view**: Cách deploy (single server, distributed)
- **Dependencies**: Phụ thuộc giữa components (tightly/loosely coupled)

#### Step 3: Classify Scenarios — Direct vs Indirect

| Loại | Định nghĩa | Ý nghĩa |
|------|-----------|---------|
| **Direct** | Scenario được hỗ trợ **trực tiếp** bởi kiến trúc hiện tại — **KHÔNG cần thay đổi** architecture | Kiến trúc đã đáp ứng tốt |
| **Indirect** | Scenario **YÊU CẦU thay đổi** kiến trúc — phải modify components, thêm components mới, hoặc thay đổi connectors | Kiến trúc chưa hỗ trợ — cần phân tích sâu |

**Quan trọng:** Indirect scenarios là trọng tâm của SAAM analysis. Càng nhiều indirect scenarios → kiến trúc càng khó modify.

#### Step 4: Evaluate Indirect Scenarios

Với mỗi indirect scenario, phân tích:
- **Affected components**: Những components nào phải thay đổi?
- **Change description**: Cần thay đổi gì cụ thể ở mỗi component?
- **Estimated effort**: Bao lâu để thực hiện thay đổi? (hours/days/weeks)
- **Risk level**: Low / Medium / High / Critical
- **Side effects**: Thay đổi này có ảnh hưởng đến chức năng khác không?

#### Step 5: Assess Scenario Interaction

Phân tích **sự chồng chéo** giữa các scenarios:
- Nếu nhiều indirect scenarios **cùng ảnh hưởng** đến một component → component đó là **hotspot**
- Hotspot = điểm yếu kiến trúc — tightly coupled, khó maintain
- Tạo **interaction matrix** để visualize overlap

### 4. Modifiability Analysis trong SAAM

**Modifiability** = khả năng thay đổi hệ thống với effort hợp lý, ít side effects.

**Các yếu tố đánh giá modifiability:**

| Yếu tố | Mô tả | Đo lường |
|---------|-------|---------|
| **Cohesion** | Components có trách nhiệm rõ ràng? | High = tốt |
| **Coupling** | Mức phụ thuộc giữa components? | Low = tốt |
| **Separation of Concerns** | Các concern có tách biệt? | Rõ ràng = tốt |
| **Information Hiding** | Implementation details có ẩn? | Ẩn = tốt |
| **Change Locality** | Thay đổi có localized? | Local = tốt |
| **Ripple Effect** | Thay đổi 1 chỗ ảnh hưởng bao xa? | Ít = tốt |

**Chỉ số SAAM cho modifiability:**
- Tỷ lệ Direct/Indirect scenarios: Càng nhiều direct → modifiability càng cao
- Số components bị ảnh hưởng trung bình per indirect scenario: Càng ít → coupling càng thấp
- Số hotspots trong interaction matrix: Càng ít → kiến trúc càng tốt

### 5. SAAM Report — Cấu trúc Báo cáo

```
SAAM EVALUATION REPORT
═══════════════════════════════════════════════
1. Executive Summary
 - Mục tiêu đánh giá
 - Kết luận tổng quan
 - Top-3 risks / recommendations

2. Architecture Description
 - Component diagram
 - Data flow
 - Technology stack

3. Scenarios Catalog
 3.1 Modification Scenarios (list)
 3.2 Usage Scenarios (list)
 3.3 Classification Summary (direct/indirect counts)

4. Indirect Scenario Evaluation
 - Affected components per scenario
 - Effort estimation
 - Risk assessment

5. Scenario Interaction Analysis
 - Interaction matrix
 - Hotspot identification
 - Coupling assessment

6. Findings & Risks
 - Architectural weaknesses
 - High-risk areas

7. Recommendations
 - Short-term fixes
 - Long-term refactoring
 - Priority ranking

8. Conclusion
 - Modifiability score
 - Architecture fitness
═══════════════════════════════════════════════
```

---

## Step-by-step Labs

### Hệ thống Mục tiêu: E-Commerce Monolithic Application

```
┌─────────────────────────────────────────────────────────────────┐
│ E-Commerce Monolith │
│ │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ │
│ │ User │ │ Product │ │ Order │ │ Payment │ │
│ │ Module │ │ Module │ │ Module │ │ Module │ │
│ │ │ │ │ │ │ │ │ │
│ │- Auth │ │- Catalog │ │- Cart │ │- Process │ │
│ │- Profile │ │- Search │ │- Checkout│ │- Refund │ │
│ │- Session │ │- Category│ │- History │ │- Gateway │ │
│ └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘ │
│ │ │ │ │ │
│ └──────────────┴──────────────┴──────────────┘ │
│ │ │
│ ┌─────────▼─────────┐ │
│ │ Shared DB │ │
│ │ (PostgreSQL) │ │
│ │ │ │
│ │ - users table │ │
│ │ - products table │ │
│ │ - orders table │ │
│ │ - payments table │ │
│ └───────────────────┘ │
│ │
│ ┌──────────────────────────────────────────────────┐ │
│ │ Notification Service │ │
│ │ (Email via SMTP - tightly coupled to modules) │ │
│ └──────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

**Technology stack:** Java/Spring Boot monolith, PostgreSQL, SMTP email, REST API, session-based auth.

---

### Lab 1: Develop Scenarios (25 phút)

**Mục tiêu:** Xây dựng ít nhất 15 modification scenarios và usage scenarios cho hệ thống E-Commerce.

#### Hướng dẫn

1. Brainstorm các thay đổi có thể xảy ra trong 1-2 năm tới
2. Nghĩ về các tính năng mới, thay đổi technology, integration bên ngoài
3. Liệt kê các use case hiện tại của hệ thống

#### Template — Scenario Description

```
┌──────────────────────────────────────────────────────┐
│ SCENARIO CARD │
│──────────────────────────────────────────────────────│
│ ID: S-XX │
│ Name: [Tên ngắn gọn] │
│ Type: [ ] Modification [ ] Usage │
│ Description: [Mô tả chi tiết stimulus → response] │
│ Source: [Stakeholder nào đề xuất] │
│ Priority: [ ] High [ ] Medium [ ] Low │
│ QA concern: [Quality attribute liên quan] │
└──────────────────────────────────────────────────────┘
```

#### Danh sách Scenarios Mẫu

**Modification Scenarios (M1–M10):**

| ID | Scenario | Mô tả | Priority |
|----|----------|--------|----------|
| M1 | Thêm PayPal payment | Tích hợp PayPal SDK bên cạnh credit card hiện tại | High |
| M2 | Thêm MoMo/ZaloPay | Tích hợp cổng thanh toán Việt Nam | High |
| M3 | Hỗ trợ multi-currency | Hiển thị giá VND, USD, EUR; convert tự động | Medium |
| M4 | Thêm product reviews & ratings | User đánh giá sản phẩm 1-5 sao + comment | Medium |
| M5 | Migrate từ PostgreSQL sang MySQL | Thay đổi database vendor | Low |
| M6 | Thêm multi-language (i18n) | Hỗ trợ Tiếng Việt, English, Japanese | Medium |
| M7 | Thêm real-time notifications | Push notification qua WebSocket thay vì email | High |
| M8 | Thêm wishlist feature | User lưu sản phẩm yêu thích | Low |
| M9 | Tích hợp shipping provider mới (GHN, GHTK) | API integration với đơn vị vận chuyển | High |
| M10 | Thêm OAuth2 login (Google, Facebook) | Đăng nhập qua third-party provider | Medium |

**Usage Scenarios (U1–U5):**

| ID | Scenario | Mô tả |
|----|----------|--------|
| U1 | User đăng nhập | User nhập email/password → hệ thống xác thực → redirect dashboard |
| U2 | User tìm kiếm sản phẩm | User nhập keyword → Product Module search → trả kết quả |
| U3 | User thêm vào giỏ hàng | User click "Add to cart" → Order Module cập nhật cart |
| U4 | User hoàn tất checkout | User confirm order → Payment Module charge → Order Module update status |
| U5 | User xem lịch sử đơn hàng | User vào profile → Order Module query → hiển thị danh sách orders |

**Bài tập:** Sinh viên bổ sung thêm ít nhất **5 modification scenarios** (M11–M15) theo gợi ý sau:
- Thay đổi UI framework (ví dụ: từ server-rendered sang SPA React)
- Thêm caching layer (Redis)
- Thêm audit logging cho tất cả transactions
- Hỗ trợ bulk import products từ CSV/Excel
- Thêm recommendation engine (sản phẩm gợi ý)

---

### Lab 2: Classify Scenarios (25 phút)

**Mục tiêu:** Phân loại mỗi scenario thành Direct hoặc Indirect. Với Indirect scenarios, xác định components bị ảnh hưởng.

#### Hướng dẫn Phân loại

- **Direct**: Kiến trúc hiện tại đã hỗ trợ, chỉ cần config/minor code change
- **Indirect**: Cần thay đổi architecture — thêm component, thay đổi connector, modify interface

#### Bảng Phân loại Scenarios

| ID | Scenario | Classification | Components ảnh hưởng | Giải thích |
|----|----------|---------------|---------------------|------------|
| M1 | Thêm PayPal payment | **Indirect** | Payment Module, Order Module, DB | Cần thêm PayPal adapter, modify payment interface |
| M2 | Thêm MoMo/ZaloPay | **Indirect** | Payment Module, Order Module, DB | Tương tự M1, thêm VN payment adapter |
| M3 | Multi-currency | **Indirect** | Product Module, Order Module, Payment Module, DB | Thêm currency conversion logic, modify price schema |
| M4 | Product reviews | **Indirect** | Product Module, User Module, DB | Thêm review sub-module, new DB tables |
| M5 | Migrate PostgreSQL → MySQL | **Indirect** | ALL modules, DB | Thay đổi toàn bộ data access layer |
| M6 | Multi-language (i18n) | **Indirect** | ALL modules (UI layer) | Thêm translation layer, modify tất cả UI templates |
| M7 | Real-time notifications | **Indirect** | Notification Service, User Module | Thay đổi từ SMTP sang WebSocket, thêm notification server |
| M8 | Wishlist feature | **Indirect** | User Module, Product Module, DB | Thêm wishlist sub-module, new DB table |
| M9 | Shipping provider mới | **Indirect** | Order Module, DB, Notification | Thêm shipping adapter, tracking integration |
| M10 | OAuth2 login | **Indirect** | User Module, DB | Thêm OAuth2 client, modify auth flow |
| U1 | User đăng nhập | **Direct** | — | Kiến trúc hiện tại hỗ trợ session-based auth |
| U2 | User tìm kiếm SP | **Direct** | — | Product Module đã có search functionality |
| U3 | User thêm giỏ hàng | **Direct** | — | Order Module đã hỗ trợ cart |
| U4 | User checkout | **Direct** | — | Payment + Order Module đã hỗ trợ |
| U5 | User xem history | **Direct** | — | Order Module đã hỗ trợ query |

#### Summary Thống kê

```
Tổng scenarios: 15
├── Direct: 5 (33%)
└── Indirect: 10 (67%)

→ Tỷ lệ Indirect cao (67%) cho thấy kiến trúc monolith
 có modifiability THẤP — khó mở rộng tính năng mới.
```

#### Bài tập: Component-Scenario Mapping Diagram

Sinh viên vẽ diagram ánh xạ từng indirect scenario lên components:

```
 User Product Order Payment DB Notif.
 Module Module Module Module Service
 M1 PayPal — — x x x —
 M2 MoMo — — x x x —
 M3 Currency — x x x x —
 M4 Reviews x x — — x —
 M5 DB Migrate x x x x x —
 M6 i18n x x x x — —
 M7 RT Notif x — — — — x
 M8 Wishlist x x — — x —
 M9 Shipping — — x — x x
 M10 OAuth2 x — — — x —
 ─────────────────────────────────────────────────────────────
 Total hits: 6 5 5 4 8 2
```

---

### Lab 3: Evaluate Indirect Scenarios (30 phút)

**Mục tiêu:** Phân tích chi tiết từng indirect scenario — ước lượng effort, xác định risk, mô tả changes cần thiết.

#### Template Đánh giá

```
╔══════════════════════════════════════════════════════════╗
║ INDIRECT SCENARIO EVALUATION ║
╠══════════════════════════════════════════════════════════╣
║ Scenario ID: ___________ ║
║ Scenario Name: ___________ ║
║ ║
║ Affected Components: ║
║ 1. [Component] — [mô tả change cụ thể] ║
║ 2. [Component] — [mô tả change cụ thể] ║
║ ║
║ New Components cần thêm: ║
║ - [Nếu cần component mới, mô tả ở đây] ║
║ ║
║ Estimated Effort: ___ person-days ║
║ Risk Level: [ ] Low [ ] Medium [ ] High ║
║ Risk Justification: ___________ ║
║ ║
║ Side Effects: ║
║ - [Ảnh hưởng đến chức năng hiện có?] ║
║ ║
║ Dependencies: ║
║ - [External libraries, APIs, services] ║
╚══════════════════════════════════════════════════════════╝
```

#### Ví dụ Đánh giá Chi tiết — 3 Scenarios

**Scenario M1: Thêm PayPal Payment**

| Hạng mục | Chi tiết |
|----------|---------|
| **Affected Components** | Payment Module (thêm PayPal adapter), Order Module (handle PayPal status), Shared DB (thêm payment_method column) |
| **New Components** | PayPalGatewayAdapter class, PayPal webhook handler |
| **Estimated Effort** | 5-7 person-days |
| **Risk Level** | Medium |
| **Risk Justification** | Payment Module hiện tại hardcode credit card logic, không có strategy/adapter pattern → phải refactor trước |
| **Side Effects** | Có thể ảnh hưởng credit card flow nếu refactor payment processing pipeline |
| **Dependencies** | PayPal REST SDK, PayPal sandbox account, SSL certificate |

**Scenario M5: Migrate PostgreSQL → MySQL**

| Hạng mục | Chi tiết |
|----------|---------|
| **Affected Components** | ALL modules (User, Product, Order, Payment) — tất cả data access code |
| **New Components** | Không có component mới, nhưng phải rewrite data access layer |
| **Estimated Effort** | 15-20 person-days |
| **Risk Level** | **High** |
| **Risk Justification** | Monolith dùng shared DB → tất cả modules phải đổi, PostgreSQL-specific SQL syntax/functions phải rewrite, data migration phức tạp |
| **Side Effects** | Downtime khi migrate data, potential data loss, tất cả integration tests phải update |
| **Dependencies** | MySQL driver, migration tools (Flyway/Liquibase), staging environment |

**Scenario M6: Multi-language (i18n)**

| Hạng mục | Chi tiết |
|----------|---------|
| **Affected Components** | ALL modules (UI layer) — User Module, Product Module, Order Module, Payment Module |
| **New Components** | Translation service/resource bundles, locale detection middleware |
| **Estimated Effort** | 10-12 person-days |
| **Risk Level** | Medium |
| **Risk Justification** | Hardcoded strings khắp nơi trong monolith, thiếu abstraction layer cho i18n. Product descriptions cần multi-language storage in DB. |
| **Side Effects** | UI layout có thể vỡ với ngôn ngữ dài hơn, search phải hỗ trợ multi-language |
| **Dependencies** | i18n library (Spring MessageSource), translation files, DB schema change cho product descriptions |

#### Bài tập

Sinh viên đánh giá **tất cả 10 indirect scenarios** (M1–M10) theo template trên. Tổng hợp kết quả vào bảng:

| ID | Scenario | Effort (days) | Risk | Số components ảnh hưởng |
|----|----------|--------------|------|------------------------|
| M1 | PayPal | 5-7 | Medium | 3 |
| M2 | MoMo/ZaloPay | 5-7 | Medium | 3 |
| M3 | Multi-currency | 8-10 | High | 4 |
| M4 | Product reviews | 4-5 | Low | 3 |
| M5 | DB Migrate | 15-20 | High | 5 |
| M6 | i18n | 10-12 | Medium | 4 |
| M7 | RT Notifications | 6-8 | Medium | 2 |
| M8 | Wishlist | 3-4 | Low | 3 |
| M9 | Shipping | 5-7 | Medium | 3 |
| M10 | OAuth2 | 4-6 | Medium | 2 |

---

### Lab 4: Scenario Interaction Analysis (35 phút)

**Mục tiêu:** Xây dựng interaction matrix, xác định coupling hotspots, và viết SAAM evaluation report.

#### 4.1 Interaction Matrix

Ma trận thể hiện scenario nào ảnh hưởng component nào (x = affected):

| Component \ Scenario | M1 | M2 | M3 | M4 | M5 | M6 | M7 | M8 | M9 | M10 | **Total** |
|----------------------|----|----|----|----|----|----|----|----|----|----|---------|
| **User Module** | — | — | — | x | x | x | x | x | — | x | **6** |
| **Product Module** | — | — | x | x | x | x | — | x | — | — | **5** |
| **Order Module** | x | x | x | — | x | x | — | — | x | — | **5** |
| **Payment Module** | x | x | x | — | x | x | — | — | — | — | **4** |
| **Shared DB** | x | x | x | x | x | — | — | x | x | x | **8** |
| **Notification Service** | — | — | — | — | — | — | x | — | x | — | **2** |

#### 4.2 Hotspot Analysis

```
Hotspot Ranking (số scenarios ảnh hưởng):
═════════════════════════════════════════
 1. Shared DB → 8/10 scenarios ★★★ CRITICAL HOTSPOT
 2. User Module → 6/10 scenarios ★★ HIGH
 3. Product Module → 5/10 scenarios ★★ HIGH
 4. Order Module → 5/10 scenarios ★★ HIGH
 5. Payment Module → 4/10 scenarios ★ MODERATE
 6. Notification Service → 2/10 scenarios LOW
```

**Phân tích Hotspot:**

1. **Shared DB (8/10)**: Gần như mọi thay đổi đều ảnh hưởng đến DB → **critical coupling issue**. Monolith shared database là bottleneck chính cho modifiability. Mỗi thay đổi schema có thể ảnh hưởng nhiều modules.

2. **User Module (6/10)**: Module này chịu trách nhiệm quá nhiều (auth, profile, session, preferences) → **vi phạm Single Responsibility**. Nhiều features mới đều cần tích hợp với user context.

3. **Product/Order Module (5/10 each)**: Core business modules bị ảnh hưởng nhiều → coupling cao giữa business logic và infrastructure.

#### 4.3 Scenario-Scenario Interaction

Ma trận thể hiện hai scenarios **cùng ảnh hưởng** bao nhiêu components chung:

| | M1 | M2 | M3 | M4 | M5 | M6 | M7 | M8 | M9 | M10 |
|---|---|---|---|---|---|---|---|---|---|---|
| **M1** | — | 3 | 3 | 1 | 3 | 2 | 0 | 1 | 2 | 1 |
| **M2** | 3 | — | 3 | 1 | 3 | 2 | 0 | 1 | 2 | 1 |
| **M3** | 3 | 3 | — | 2 | 4 | 3 | 0 | 2 | 2 | 1 |
| **M4** | 1 | 1 | 2 | — | 3 | 2 | 1 | 3 | 1 | 2 |
| **M5** | 3 | 3 | 4 | 3 | — | 4 | 1 | 3 | 3 | 2 |
| **M6** | 2 | 2 | 3 | 2 | 4 | — | 1 | 2 | 1 | 1 |
| **M7** | 0 | 0 | 0 | 1 | 1 | 1 | — | 1 | 1 | 1 |
| **M8** | 1 | 1 | 2 | 3 | 3 | 2 | 1 | — | 1 | 2 |
| **M9** | 2 | 2 | 2 | 1 | 3 | 1 | 1 | 1 | — | 1 |
| **M10**| 1 | 1 | 1 | 2 | 2 | 1 | 1 | 2 | 1 | — |

**High interaction pairs (≥ 3 shared components):**
- M5 & M6 = 4 (DB migrate i18n: cả hai ảnh hưởng gần như toàn bộ)
- M3 & M5 = 4 (Multi-currency DB migrate)
- M1 & M2 = 3 (PayPal MoMo: cùng payment concern)
- M1 & M3 = 3 (PayPal Multi-currency)
- M4 & M8 = 3 (Reviews Wishlist: cùng user-product relationship)
- M4 & M5 = 3, M5 & M8 = 3, M5 & M9 = 3 (DB migrate ảnh hưởng mọi thứ)

#### 4.4 Coupling Assessment & Recommendations

| Vấn đề | Nguyên nhân | Khuyến nghị |
|--------|------------|------------|
| Shared DB là critical hotspot | Tất cả modules dùng chung 1 DB | Tách DB per module (Database-per-Service) hoặc dùng Repository pattern |
| Payment logic hardcoded | Không có adapter/strategy pattern | Refactor sang Strategy Pattern cho payment gateways |
| User Module quá lớn | Nhiều responsibilities | Tách thành Auth Service + Profile Service |
| Tight coupling giữa modules | Direct method calls, shared state | Introduce event-driven communication hoặc API contracts |
| Không có abstraction layer | Business logic mix với infrastructure | Apply Clean Architecture / Hexagonal Architecture |

#### 4.5 SAAM Report Template

Sinh viên viết report hoàn chỉnh theo cấu trúc sau:

```markdown
# SAAM Evaluation Report — E-Commerce Monolith

## 1. Executive Summary
- Hệ thống E-Commerce Monolith được đánh giá với 15 scenarios (10 modification, 5 usage)
- 67% scenarios là indirect → modifiability THẤP
- Critical hotspot: Shared Database (8/10 scenarios)
- Khuyến nghị: Refactor sang modular architecture, tách database

## 2. Architecture Description
[Chèn component diagram ở trên]
- 4 modules chính: User, Product, Order, Payment
- 1 shared PostgreSQL database
- 1 Notification Service (SMTP)
- Communication: Direct method calls (in-process)

## 3. Scenarios Catalog
### 3.1 Direct Scenarios (5)
U1-U5: Các usage scenarios hiện tại đều được hỗ trợ

### 3.2 Indirect Scenarios (10)
M1-M10: [Bảng chi tiết từ Lab 2]

## 4. Indirect Scenario Evaluation
[Kết quả chi tiết từ Lab 3 — effort, risk, affected components]

## 5. Scenario Interaction Analysis
### 5.1 Component-Scenario Matrix
[Ma trận từ Lab 4, section 4.1]

### 5.2 Hotspot Analysis
[Ranking từ section 4.2]

### 5.3 Scenario-Scenario Interaction
[Ma trận từ section 4.3]

## 6. Findings & Risks
- RISK-1: Shared DB tạo bottleneck cho mọi thay đổi
- RISK-2: Payment Module không extensible
- RISK-3: User Module vi phạm SRP
- RISK-4: Không có event-driven mechanism

## 7. Recommendations
1. [SHORT-TERM] Apply Strategy Pattern cho Payment Module
2. [SHORT-TERM] Tách User Module thành Auth + Profile
3. [MID-TERM] Introduce Repository Pattern + DB abstraction
4. [LONG-TERM] Migrate sang modular monolith hoặc microservices

## 8. Conclusion
Kiến trúc monolith hiện tại có modifiability thấp (67% indirect scenarios).
Shared Database là critical hotspot. Cần refactoring để cải thiện.
Modifiability Score: 3.3/10
```

---

## Self-Assessment — 30 Câu hỏi

### Band 1: Cơ bản (Câu 1–10)

**Câu 1.** SAAM tập trung đánh giá quality attribute nào là chính?
- A) Performance
- B) Security
- C) Modifiability
- D) Availability

**Đáp án: C** — SAAM (Software Architecture Analysis Method) được thiết kế để đánh giá **modifiability** — khả năng thay đổi/mở rộng kiến trúc phần mềm. Đây là focus chính khi SEI phát triển SAAM.

---

**Câu 2.** SAAM được phát triển bởi tổ chức nào?
- A) Google Research
- B) Microsoft Research
- C) SEI — Carnegie Mellon University
- D) MIT CSAIL

**Đáp án: C** — SAAM được phát triển bởi **Software Engineering Institute (SEI)** tại **Carnegie Mellon University** vào đầu thập niên 1990.

---

**Câu 3.** Trong SAAM, "Direct scenario" nghĩa là gì?
- A) Scenario yêu cầu thay đổi lớn kiến trúc
- B) Scenario được hỗ trợ trực tiếp bởi kiến trúc hiện tại mà không cần thay đổi
- C) Scenario có priority cao nhất
- D) Scenario liên quan trực tiếp đến end user

**Đáp án: B** — Direct scenario là scenario mà kiến trúc hiện tại **đã hỗ trợ**, không cần thay đổi architecture. Ví dụ: "User login" khi hệ thống đã có authentication module.

---

**Câu 4.** "Indirect scenario" trong SAAM yêu cầu gì?
- A) Không cần thay đổi gì
- B) Chỉ cần cấu hình lại
- C) Yêu cầu thay đổi kiến trúc (modify components, thêm components, thay connectors)
- D) Chỉ cần thêm documentation

**Đáp án: C** — Indirect scenario yêu cầu **thay đổi kiến trúc** — phải modify existing components, thêm new components, hoặc thay đổi connectors. Đây là trọng tâm phân tích của SAAM.

---

**Câu 5.** SAAM có bao nhiêu bước chính trong quy trình?
- A) 3 bước
- B) 5 bước
- C) 7 bước
- D) 9 bước

**Đáp án: B** — SAAM có **5 bước**: (1) Develop Scenarios, (2) Describe Architecture, (3) Classify Scenarios, (4) Evaluate Indirect Scenarios, (5) Assess Scenario Interaction.

---

**Câu 6.** Bước đầu tiên trong SAAM process là gì?
- A) Describe Architecture
- B) Classify Scenarios
- C) Develop Scenarios
- D) Evaluate Indirect Scenarios

**Đáp án: C** — Bước đầu tiên là **Develop Scenarios** — thu thập modification và usage scenarios từ stakeholders. Scenarios là đầu vào chính cho toàn bộ quá trình phân tích.

---

**Câu 7.** SAAM sử dụng loại scenarios nào? (chọn 2)
- A) Performance scenarios và Security scenarios
- B) Modification scenarios và Usage scenarios
- C) Growth scenarios và Exploratory scenarios
- D) Functional scenarios và Non-functional scenarios

**Đáp án: B** — SAAM sử dụng **Modification scenarios** (thay đổi trong tương lai) và **Usage scenarios** (cách hệ thống được sử dụng hiện tại).

---

**Câu 8.** So với ATAM, SAAM có đặc điểm nào?
- A) Phức tạp hơn, cần nhiều người hơn
- B) Đơn giản hơn, focus vào modifiability
- C) Tốn nhiều thời gian hơn
- D) Cần nhiều stakeholder hơn

**Đáp án: B** — SAAM **đơn giản hơn** ATAM, focus chủ yếu vào **modifiability**. ATAM phức tạp hơn, đánh giá nhiều quality attributes, cần team lớn hơn (8-15 người so với 3-5).

---

**Câu 9.** "Scenario Interaction" trong SAAM dùng để phát hiện gì?
- A) Performance bottlenecks
- B) Security vulnerabilities
- C) Components bị ảnh hưởng bởi nhiều scenarios (coupling hotspots)
- D) User experience issues

**Đáp án: C** — Scenario Interaction phân tích **components nào bị ảnh hưởng bởi nhiều scenarios cùng lúc**. Những components đó gọi là **hotspots** — dấu hiệu của coupling cao, khó maintain.

---

**Câu 10.** Khi nào nên chọn SAAM thay vì ATAM?
- A) Khi cần đánh giá toàn diện nhiều quality attributes
- B) Khi cần so sánh nhanh các architecture alternatives về modifiability
- C) Khi có nhiều stakeholders tham gia
- D) Khi hệ thống đã production và cần đánh giá security

**Đáp án: B** — SAAM phù hợp khi cần **đánh giá nhanh, so sánh alternatives, focus vào modifiability**. ATAM phù hợp hơn khi cần đánh giá toàn diện nhiều quality attributes.

---

### Band 2: Trung bình (Câu 11–20)

**Câu 11.** Một hệ thống có 20 scenarios, trong đó 15 là indirect. Đánh giá nào đúng?
- A) Hệ thống có modifiability cao
- B) Hệ thống có modifiability thấp (75% indirect)
- C) Không đủ thông tin để đánh giá
- D) Hệ thống cần thêm usage scenarios

**Đáp án: B** — 75% indirect scenarios cho thấy kiến trúc **khó thay đổi** — hầu hết thay đổi đều cần modify architecture. Tỷ lệ indirect càng cao → modifiability càng thấp.

---

**Câu 12.** Trong interaction matrix, component X bị ảnh hưởng bởi 8/10 indirect scenarios. Điều này cho biết gì?
- A) Component X rất ổn định
- B) Component X là hotspot — coupling cao, cần refactor
- C) Component X có quality tốt
- D) Component X không quan trọng

**Đáp án: B** — Component bị ảnh hưởng bởi nhiều scenarios là **hotspot** — dấu hiệu coupling cao. Cần refactor (tách thành components nhỏ hơn, giảm responsibilities, apply abstraction).

---

**Câu 13.** "Scenario development" trong SAAM khác gì với "use case analysis" thông thường?
- A) Hoàn toàn giống nhau
- B) SAAM scenarios focus vào modification (thay đổi tương lai), không chỉ usage hiện tại
- C) SAAM scenarios chỉ về performance
- D) SAAM không cần stakeholder input

**Đáp án: B** — SAAM scenario development bao gồm cả **modification scenarios** (thay đổi tương lai) — điều mà use case analysis truyền thống thường không cover. Đây là điểm mạnh của SAAM trong đánh giá modifiability.

---

**Câu 14.** SAAM report nên bao gồm những phần nào? (chọn đáp án ĐẦY ĐỦ nhất)
- A) Chỉ cần danh sách scenarios
- B) Architecture description, scenarios, interaction matrix, risks, recommendations
- C) Chỉ cần hotspot analysis
- D) Chỉ cần effort estimation

**Đáp án: B** — SAAM report đầy đủ gồm: **Architecture description, Scenarios catalog, Classification, Indirect evaluation, Interaction matrix, Hotspot analysis, Risks, Recommendations**. Thiếu phần nào đều làm giảm giá trị đánh giá.

---

**Câu 15.** Monolith architecture thường có đặc điểm gì khi áp dụng SAAM?
- A) Ít indirect scenarios, modifiability cao
- B) Nhiều indirect scenarios, shared DB là hotspot, coupling cao
- C) Hoàn toàn không áp dụng SAAM được
- D) Tất cả scenarios đều direct

**Đáp án: B** — Monolith thường có **nhiều indirect scenarios** vì modules tightly coupled, shared database. DB thường là critical hotspot vì mọi thay đổi schema đều ảnh hưởng nhiều modules.

---

**Câu 16.** Trong SAAM, "Describe Architecture" (Step 2) cần document những gì?
- A) Chỉ cần source code
- B) Components, connectors, data flow, dependencies, deployment view
- C) Chỉ cần class diagram
- D) Chỉ cần database schema

**Đáp án: B** — Step 2 yêu cầu mô tả kiến trúc bao gồm: **Components** (modules/services), **Connectors** (cách giao tiếp), **Data flow** (luồng dữ liệu), **Dependencies** (phụ thuộc), **Deployment view** (cách deploy).

---

**Câu 17.** Hai scenarios M1 (Add PayPal) và M2 (Add MoMo) cùng ảnh hưởng 3 components chung. Phân tích nào đúng?
- A) Hai scenarios này không liên quan
- B) High interaction — cùng concern (payment), cần refactor Payment Module sang extensible pattern
- C) Cần xóa bỏ một trong hai scenarios
- D) Không cần phân tích thêm

**Đáp án: B** — High interaction (3 shared components) cho thấy hai scenarios cùng **payment concern**. Cần refactor Payment Module với **Strategy/Adapter Pattern** để dễ dàng thêm payment provider mới mà không ảnh hưởng kiến trúc.

---

**Câu 18.** SAAM có thể dùng để so sánh architectures không? Nếu có, bằng cách nào?
- A) Không, SAAM chỉ đánh giá 1 architecture
- B) Có — apply cùng bộ scenarios lên nhiều architecture candidates, so sánh tỷ lệ direct/indirect và effort
- C) Có — nhưng chỉ so sánh performance
- D) Không, chỉ ATAM mới so sánh được

**Đáp án: B** — SAAM hỗ trợ **comparative evaluation** — áp dụng cùng bộ scenarios lên nhiều architecture candidates, so sánh **tỷ lệ direct/indirect, effort estimation, hotspot count** để chọn architecture tốt nhất.

---

**Câu 19.** "Ripple effect" trong modifiability analysis là gì?
- A) Performance degradation
- B) Khi thay đổi 1 component gây ảnh hưởng lan truyền sang nhiều components khác
- C) User interface glitch
- D) Database corruption

**Đáp án: B** — Ripple effect là khi **thay đổi 1 component gây ảnh hưởng lan truyền (cascade)** sang nhiều components khác. Trong kiến trúc coupling cao, ripple effect lớn → modifiability thấp.

---

**Câu 20.** Lịch sử phát triển: SAAM → ??? → ATAM. Mối quan hệ là gì?
- A) SAAM và ATAM không liên quan
- B) ATAM thay thế hoàn toàn SAAM
- C) ATAM mở rộng ý tưởng scenario-based của SAAM, thêm utility tree và multi-QA analysis
- D) SAAM mới hơn ATAM

**Đáp án: C** — ATAM **kế thừa** ý tưởng scenario-based analysis từ SAAM, **mở rộng** bằng cách thêm utility tree, sensitivity/tradeoff points, và đánh giá **nhiều quality attributes** (không chỉ modifiability).

---

### Band 3: Nâng cao (Câu 21–30)

**Câu 21.** Áp dụng SAAM cho microservices architecture so với monolith, kết quả khác nhau thế nào?
- A) Không khác biệt
- B) Microservices có nhiều direct scenarios hơn (modifiability cao hơn), nhưng interaction analysis phức tạp hơn do distributed nature
- C) Monolith luôn tốt hơn
- D) SAAM không áp dụng cho microservices

**Đáp án: B** — Microservices thường có **nhiều direct scenarios hơn** (thay đổi isolated trong 1 service), nhưng **interaction analysis phức tạp hơn** vì cần xét cross-service communication, eventual consistency, distributed transactions. Mỗi service có DB riêng → giảm DB hotspot.

---

**Câu 22.** Một kiến trúc có 5 hotspots trong interaction matrix. Team quyết định refactor hotspot có số lượng scenario interaction cao nhất trước. Chiến lược này có hợp lý không?
- A) Hoàn toàn hợp lý — luôn fix hotspot lớn nhất trước
- B) Cần cân nhắc thêm effort, risk, business priority — không chỉ dựa trên interaction count
- C) Không hợp lý — nên fix tất cả cùng lúc
- D) Không hợp lý — nên bỏ qua hotspots

**Đáp án: B** — Cần cân nhắc **nhiều yếu tố**: interaction count, **refactoring effort**, **risk** khi thay đổi, **business priority** của scenarios liên quan. Hotspot lớn nhất có thể quá tốn kém để fix ngay, trong khi hotspot nhỏ hơn có ROI tốt hơn.

---

**Câu 23.** SAAM có những limitations gì?
- A) Không có limitations
- B) Chỉ focus modifiability, phụ thuộc vào chất lượng scenarios, effort estimation subjective, không phân tích tradeoffs giữa QAs
- C) Quá phức tạp
- D) Chỉ dùng cho monolith

**Đáp án: B** — SAAM limitations: (1) **Focus hẹp** — chủ yếu modifiability, (2) **Quality phụ thuộc scenarios** — scenarios không tốt → kết quả không tốt, (3) **Effort estimation subjective** — khác nhau tùy người đánh giá, (4) **Không phân tích tradeoffs** giữa quality attributes.

---

**Câu 24.** Làm thế nào kết hợp SAAM và ATAM trong thực tế?
- A) Không thể kết hợp
- B) Dùng SAAM đánh giá modifiability trước (lightweight), sau đó dùng ATAM đánh giá toàn diện — kết quả SAAM làm input cho ATAM scenarios
- C) Chỉ cần ATAM, bỏ SAAM
- D) Chạy song song cùng lúc

**Đáp án: B** — **Hybrid approach**: Dùng SAAM trước (nhanh, 1-2 ngày) để đánh giá modifiability. Kết quả SAAM (scenarios, hotspots) trở thành **input cho ATAM** khi cần đánh giá sâu hơn. Tiết kiệm thời gian ATAM vì đã có sẵn scenarios.

---

**Câu 25.** Trong Agile development, SAAM nên được áp dụng khi nào?
- A) Chỉ ở cuối dự án
- B) Ở Sprint 0 / Architecture Sprint, và định kỳ khi có major feature changes
- C) Mỗi Sprint
- D) Không áp dụng cho Agile

**Đáp án: B** — Trong Agile, SAAM phù hợp ở **Sprint 0 / Architecture Sprint** để đánh giá architecture ban đầu, và **định kỳ** (mỗi quarter hoặc khi có major changes) để reassess modifiability. Không cần mỗi sprint vì quá overhead.

---

**Câu 26.** Công ty A có 2 architecture candidates cho hệ thống mới. Sau SAAM evaluation: Candidate X có 40% indirect scenarios, Candidate Y có 70% indirect. Tuy nhiên, Y có total effort thấp hơn X. Chọn candidate nào?
- A) Luôn chọn X (ít indirect hơn)
- B) Luôn chọn Y (total effort thấp hơn)
- C) Cần phân tích thêm: xét risk level, hotspot distribution, và business priorities trước khi quyết định
- D) Không đủ thông tin, cần chạy ATAM

**Đáp án: C** — Tỷ lệ indirect và total effort chỉ là 2 metrics. Cần xét thêm: **risk distribution** (Y có thể có risk thấp hơn per scenario), **hotspot pattern** (X có thể có critical hotspots), **business priority** (scenarios nào quan trọng nhất). Không có metric đơn lẻ nào quyết định.

---

**Câu 27.** Tự động hóa SAAM — phần nào có thể automate, phần nào không?
- A) Toàn bộ SAAM có thể automate
- B) Scenario development cần con người; interaction matrix calculation có thể automate; effort estimation cần expert judgment
- C) Không phần nào automate được
- D) Chỉ report generation automate được

**Đáp án: B** — **Có thể automate**: Interaction matrix calculation, report generation, visualization. **Cần con người**: Scenario development (creativity, domain knowledge), classification (judgment), effort estimation (experience), risk assessment (context).

---

**Câu 28.** Lightweight SAAM (cho team nhỏ, thời gian hạn chế) nên bỏ qua bước nào?
- A) Bỏ Step 1 (Develop Scenarios)
- B) Không bỏ bước nào, nhưng giảm scope: ít scenarios hơn, focus top-priority scenarios, simplified interaction matrix
- C) Bỏ Step 5 (Scenario Interaction)
- D) Bỏ Step 2 (Describe Architecture)

**Đáp án: B** — Lightweight SAAM **không bỏ bước** nhưng **giảm scope**: ít scenarios (5-8 thay vì 15+), focus **top-priority modification scenarios**, simplified matrix. Bỏ bước nào cũng làm mất giá trị phân tích.

---

**Câu 29.** SAAM report cho thấy component "OrderService" là hotspot (ảnh hưởng bởi 7/8 scenarios). Refactoring approach nào phù hợp nhất?
- A) Rewrite toàn bộ OrderService từ đầu
- B) Tách OrderService thành sub-services nhỏ hơn theo responsibility (Order Processing, Order History, Shipping Integration), apply interface segregation
- C) Thêm caching cho OrderService
- D) Scale horizontally bằng load balancer

**Đáp án: B** — **Decomposition** — tách OrderService thành sub-services theo **Single Responsibility Principle**: Order Processing, Order History, Shipping Integration. Apply **Interface Segregation** để mỗi sub-service expose chỉ interface cần thiết. Giảm coupling, giảm hotspot impact.

---

**Câu 30.** SAAM evolution: Từ SAAM ban đầu, SEI phát triển thêm SAAM-based methods nào?
- A) Không phát triển thêm gì
- B) SAAMCS (for complex systems), ESAAMI (extended), ALPSM, rồi tiến hóa thành ATAM
- C) Chỉ phát triển ATAM
- D) SAAM không liên quan đến methods khác

**Đáp án: B** — SEI phát triển nhiều SAAM variants: **SAAMCS** (Complex Systems), **ESAAMI** (Extended SAAM for Integration), **ALPSM** (Architecture Level Prediction of Software Maintenance). Cuối cùng tích hợp và mở rộng thành **ATAM** — phương pháp toàn diện hơn.

---

## Extend Labs (10 Bài tập Mở rộng)

### EL1: Full SAAM Evaluation cho Hospital Management System

```
Mục tiêu: Áp dụng đầy đủ 5 bước SAAM cho hệ thống quản lý bệnh viện
Yêu cầu:
 - Develop ít nhất 12 scenarios (modification + usage)
 - Describe architecture (modules: Patient, Doctor, Appointment, Pharmacy, Billing)
 - Classify, evaluate, interaction analysis
 - Viết SAAM report hoàn chỉnh
Độ khó: ****
Thời gian: 3-4 giờ
```

### EL2: Legacy System SAAM — Đánh giá hệ thống cũ

```
Mục tiêu: Dùng SAAM đánh giá modifiability của legacy system (ví dụ: Banking core system 15 tuổi)
Yêu cầu:
 - Document kiến trúc hiện tại từ code/interviews
 - Phát triển 10+ modification scenarios (modernization, new regulations)
 - Identify modernization priorities dựa trên interaction analysis
 - Đề xuất migration strategy
Độ khó: ****
Thời gian: 4-5 giờ
```

### EL3: Microservices SAAM — Distributed System

```
Mục tiêu: Áp dụng SAAM cho microservices architecture
Yêu cầu:
 - Describe architecture (8+ services, API gateway, message broker)
 - Scenarios bao gồm: cross-service changes, data consistency, service decomposition
 - Phân tích cross-cutting concerns (logging, auth, monitoring)
 - So sánh modifiability với monolith equivalent
Độ khó: ****
Thời gian: 3-4 giờ
```

### EL4: Comparative SAAM — So sánh 2 Architecture Candidates

```
Mục tiêu: Dùng SAAM so sánh Layered Architecture vs Clean Architecture cho cùng hệ thống
Yêu cầu:
 - Cùng bộ 10 scenarios cho cả 2 candidates
 - Classify riêng cho từng candidate
 - So sánh: tỷ lệ direct/indirect, effort, hotspots
 - Viết decision report với recommendation
Độ khó: ****
Thời gian: 3-4 giờ
```

### EL5: Scenario Workshop Facilitation

```
Mục tiêu: Tổ chức workshop thu thập scenarios từ stakeholders
Yêu cầu:
 - Chuẩn bị agenda, materials, templates
 - Role-play: 1 facilitator, 3+ stakeholders (dev, PM, QA, ops)
 - Brainstorm, prioritize, consolidate scenarios
 - Document workshop minutes & output
Độ khó: ***
Thời gian: 2-3 giờ
```

### EL6: SAAM + ATAM Hybrid Evaluation

```
Mục tiêu: Kết hợp SAAM (modifiability) với ATAM (multi-QA)
Yêu cầu:
 - SAAM evaluation trước (modifiability focus)
 - Kết quả SAAM làm input cho ATAM utility tree
 - ATAM evaluation (performance, security, availability)
 - Unified report tổng hợp cả hai methods
Độ khó: *****
Thời gian: 5-6 giờ
```

### EL7: Interaction Matrix Visualization Tool

```
Mục tiêu: Xây dựng tool tính toán và visualize interaction matrix
Yêu cầu:
 - Input: scenarios + affected components (JSON/CSV)
 - Output: interaction matrix, hotspot ranking, heatmap
 - Technology: Python + matplotlib hoặc JavaScript + D3.js
 - Tự động generate SAAM summary statistics
Độ khó: ****
Thời gian: 4-5 giờ
```

### EL8: Continuous SAAM — Tích hợp vào CI/CD

```
Mục tiêu: Áp dụng SAAM liên tục trong Agile development
Yêu cầu:
 - Thiết kế quy trình SAAM cho Sprint 0 và quarterly review
 - Tạo scenario backlog template
 - Define metrics: modifiability trend over time
 - Integrate hotspot tracking với technical debt management
Độ khó: ****
Thời gian: 2-3 giờ
```

### EL9: SAAM cho Mobile App Architecture

```
Mục tiêu: Áp dụng SAAM cho mobile app (iOS/Android)
Yêu cầu:
 - Architecture: MVVM/Clean Architecture cho mobile
 - Scenarios: platform update, new feature, offline mode, push notifications
 - Đặc thù mobile: battery, network, screen size, OS fragmentation
 - So sánh native vs cross-platform modifiability
Độ khó: ****
Thời gian: 3-4 giờ
```

### EL10: SAAM Case Study Report — Real-world System

```
Mục tiêu: Nghiên cứu 1 bài báo/case study thực tế về SAAM
Yêu cầu:
 - Đọc paper gốc: Kazman et al. "SAAM: A Method for Analyzing the Properties
 of Software Architectures" (1994)
 - Tóm tắt methodology, results, lessons learned
 - Áp dụng cùng method cho 1 hệ thống quen thuộc (open-source project)
 - Viết comparative analysis
Độ khó: ***
Thời gian: 3-4 giờ
```

---

## Deliverables — Checklist Nộp bài

| # | Deliverable | Lab | Mô tả | Check |
|---|-------------|-----|-------|-------|
| 1 | Scenario Catalog | Lab 1 | Danh sách 15+ scenarios với đầy đủ thông tin (ID, type, description, priority) | [ ] |
| 2 | Classification Table | Lab 2 | Bảng phân loại Direct/Indirect với giải thích và component mapping | [ ] |
| 3 | Component-Scenario Mapping | Lab 2 | Diagram ánh xạ scenarios lên components | [ ] |
| 4 | Indirect Evaluation Details | Lab 3 | Đánh giá chi tiết 10 indirect scenarios (effort, risk, affected components) | [ ] |
| 5 | Summary Effort Table | Lab 3 | Bảng tổng hợp effort & risk cho tất cả indirect scenarios | [ ] |
| 6 | Interaction Matrix | Lab 4 | Ma trận Component x Scenario | [ ] |
| 7 | Hotspot Analysis | Lab 4 | Ranking hotspots với phân tích | [ ] |
| 8 | Scenario-Scenario Matrix | Lab 4 | Ma trận interaction giữa các scenarios | [ ] |
| 9 | Coupling Assessment | Lab 4 | Bảng vấn đề, nguyên nhân, khuyến nghị | [ ] |
| 10 | SAAM Report | Lab 4 | Báo cáo SAAM hoàn chỉnh theo template | [ ] |
| 11 | Self-Assessment | — | Trả lời 30 câu hỏi | [ ] |

---

## Lỗi Thường Gặp

| # | Lỗi | Hậu quả | Cách sửa |
|---|-----|---------|----------|
| 1 | Scenarios quá mơ hồ, không cụ thể | Không phân loại Direct/Indirect chính xác được | Viết scenarios dạng stimulus → response, kèm acceptance criteria |
| 2 | Nhầm lẫn Direct và Indirect | Đánh giá sai modifiability | Direct = kiến trúc đã hỗ trợ (không cần thay đổi), Indirect = cần thay đổi architecture |
| 3 | Bỏ qua usage scenarios, chỉ viết modification | Thiếu baseline đánh giá, tỷ lệ D/I bị lệch | Cần cân bằng cả modification và usage scenarios |
| 4 | Không mô tả architecture đủ chi tiết | Không mapping scenarios lên components chính xác | Document đầy đủ: components, connectors, data flow, dependencies |
| 5 | Effort estimation quá lạc quan | Đánh giá modifiability cao hơn thực tế | Dùng expert judgment, tham khảo historical data, thêm buffer 20-30% |
| 6 | Bỏ qua side effects khi evaluate indirect scenarios | Thiếu risks quan trọng | Luôn hỏi: "Thay đổi này ảnh hưởng chức năng hiện có nào?" |
| 7 | Interaction matrix không đầy đủ | Bỏ sót hotspots | Kiểm tra kỹ từng ô trong matrix, cross-verify với component mapping |
| 8 | Không phân tích scenario-scenario interaction | Thiếu coupling insights | Xây dựng ma trận scenario x scenario bên cạnh component x scenario |
| 9 | SAAM report thiếu recommendations | Report không actionable | Mỗi finding/risk phải kèm recommendation cụ thể (short/mid/long-term) |
| 10 | So sánh SAAM với ATAM không chính xác | Chọn sai method cho context | SAAM = modifiability focus, lightweight. ATAM = multi-QA, comprehensive. Hiểu rõ strengths/limitations của mỗi method |

---

## Rubric Chấm điểm (100 điểm)

| Tiêu chí | Điểm | Xuất sắc (90-100%) | Tốt (70-89%) | Trung bình (50-69%) | Chưa đạt (<50%) |
|----------|------|--------------------|--------------|--------------------|-----------------|
| **Scenario Development** | 20 | 15+ scenarios cụ thể, đa dạng, có priority & QA concern | 10-14 scenarios, phần lớn cụ thể | 5-9 scenarios, một số mơ hồ | <5 scenarios hoặc quá mơ hồ |
| **Scenario Classification** | 15 | Phân loại chính xác 100%, giải thích rõ ràng, có component mapping | Phân loại chính xác >85%, giải thích đủ | Phân loại chính xác >60%, giải thích sơ sài | Phân loại sai >40% |
| **Indirect Scenario Evaluation** | 20 | Đánh giá chi tiết tất cả indirect scenarios, effort hợp lý, risk justified | Đánh giá >80% indirect scenarios, effort reasonable | Đánh giá >50% indirect scenarios, effort thiếu justification | Thiếu nhiều evaluations |
| **Interaction Analysis** | 20 | Matrix đầy đủ, hotspot analysis sâu, scenario-scenario matrix, coupling assessment | Matrix đầy đủ, hotspot identified, coupling basic | Matrix có nhưng thiếu phân tích, hotspot sơ sài | Matrix sai hoặc thiếu nhiều |
| **SAAM Report** | 15 | Report đầy đủ 8 sections, actionable recommendations, professional format | Report đủ 6+ sections, recommendations có | Report thiếu sections, recommendations mơ hồ | Report thiếu nhiều, không actionable |
| **Presentation & Format** | 10 | Diagrams rõ ràng, tables well-formatted, professional | Diagrams có, format acceptable | Diagrams thiếu, format lộn xộn | Không có diagrams, format kém |
| **Tổng** | **100** | | | | |

---

## Tài liệu Tham khảo

1. **Kazman, R., Bass, L., Abowd, G., Webb, M.** — *"SAAM: A Method for Analyzing the Properties of Software Architectures"* (1994), Proceedings of ICSE-16
2. **Bass, L., Clements, P., Kazman, R.** — *"Software Architecture in Practice"*, 4th Edition, Addison-Wesley
3. **Clements, P., Kazman, R., Klein, M.** — *"Evaluating Software Architectures: Methods and Case Studies"*, Addison-Wesley
4. [CMU SEI — Architecture Analysis Methods](https://resources.sei.cmu.edu/)
5. [SAAM vs ATAM — SEI Technical Report](https://resources.sei.cmu.edu/library/)
