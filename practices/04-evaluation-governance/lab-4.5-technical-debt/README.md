# Lab 4.5: Technical Debt Management

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu trước** | Lab 4.1 (Architecture Evaluation), Lab 4.4 (Governance Frameworks) |
| **Công cụ** | SonarQube, SonarScanner CLI, IDE (VS Code / IntelliJ) |
| **Ngôn ngữ minh họa** | Java, Python, JavaScript/TypeScript |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Identify & Classify** — Nhận diện và phân loại các dạng technical debt (architecture debt, design debt, code debt, test debt, documentation debt) sử dụng Technical Debt Quadrant của Martin Fowler
2. **Measure** — Đo lường technical debt bằng SQALE method và SonarQube, tính toán Technical Debt Ratio (TDR), hiểu các metrics như Remediation Cost, Interest Rate
3. **Prioritize** — Xây dựng Technical Debt Backlog, tính ROI cho từng debt item, sắp xếp ưu tiên trả nợ dựa trên business impact và effort
4. **Plan Paydown** — Thiết kế chiến lược trả nợ kỹ thuật (Boy Scout Rule, Dedicated Sprint, Refactoring Budget, Strangler Fig Pattern) và theo dõi debt reduction metrics qua các sprint
5. **Communicate** — Trình bày technical debt cho stakeholders phi kỹ thuật bằng ngôn ngữ business, sử dụng analogy tài chính, dashboard và ROI projections

---

## Phân bổ Thời gian

| Hoạt động | Thời lượng | Nội dung chi tiết |
|-----------|------------|-------------------|
| Lý thuyết & Discussion | 40 phút | Technical debt metaphor, quadrant, types, measuring, strategies |
| Lab 1: Debt Identification | 30 phút | SonarQube analysis, interpret results |
| Lab 2: Debt Classification | 25 phút | Categorize findings theo debt taxonomy |
| Lab 3: Debt Prioritization | 30 phút | ROI calculation, debt backlog ranking |
| Lab 4: Debt Paydown Plan | 25 phút | Sprint plan, reduction metrics |
| Self-Assessment | 20 phút | 30 câu hỏi trắc nghiệm & tự luận |
| Tổng kết & Review | 10 phút | Peer review, Q&A |
| **Tổng** | **180 phút (3 giờ)** | |

---

## Lý thuyết

### 1. Technical Debt Metaphor — Ward Cunningham (1992)

> *"Shipping first-time code is like going into debt. A little debt speeds development so long as it is paid back promptly with refactoring. The danger occurs when the debt is not repaid. Every minute spent on code that is not quite right for the programming task of the moment counts as interest on that debt."*
> — **Ward Cunningham**, OOPSLA 1992

Technical debt là ẩn dụ tài chính mô tả chi phí ngầm phát sinh khi đội phát triển chọn giải pháp nhanh nhưng không tối ưu, thay vì giải pháp tốt hơn nhưng tốn thời gian hơn.

```
┌──────────────────────────────────────────────────────────────────┐
│ TECHNICAL DEBT METAPHOR │
│ │
│ Quick & Dirty Solution ──── Short-term Velocity Gain │
│ │ │
│ ▼ │
│ Accumulated Debt (Principal) │
│ │ │
│ ▼ │
│ Interest = extra effort on every future change │
│ │ │
│ ▼ │
│ Compounding: debt breeds more debt over time │
│ │ │
│ ▼ │
│ Bankruptcy = system too costly to change ── Rewrite │
│ │
└──────────────────────────────────────────────────────────────────┘
```

**Các thành phần chính:**

| Khái niệm tài chính | Tương đương kỹ thuật |
|----------------------|----------------------|
| **Principal** (gốc) | Effort cần để sửa debt item (remediation cost) |
| **Interest** (lãi) | Extra effort phải trả mỗi sprint vì sống chung với debt |
| **Interest Rate** | Tốc độ tích lũy interest (hours/sprint) |
| **Bankruptcy** | Hệ thống quá nặng nợ, phải viết lại từ đầu |
| **Credit Rating** | SQALE rating (A–E) phản ánh sức khỏe codebase |

### 2. Technical Debt Quadrant (Martin Fowler)

Martin Fowler mở rộng ý tưởng của Cunningham thành **4 góc phần tư** dựa trên 2 trục: **Deliberate vs Inadvertent** và **Reckless vs Prudent**.

```
 Reckless Prudent
 ┌──────────────────────────┬──────────────────────────┐
 │ │ │
 │ "We don't have time │ "We must ship now and │
 Deliberate │ for design" │ deal with consequences │
 │ │ — we know the risks" │
 │ → Worst type: biết sai │ → Chấp nhận được nếu │
 │ mà vẫn làm, không │ có plan trả nợ rõ │
 │ có plan trả nợ │ ràng (documented) │
 │ │ │
 ├──────────────────────────┼──────────────────────────┤
 │ │ │
 │ "What's layering?" │ "Now we know how we │
 Inadvertent │ │ should have done it" │
 │ → Do thiếu kiến thức, │ → Tự nhiên phát sinh │
 │ cần training & │ khi team học hỏi, │
 │ mentoring │ là phần tất yếu của │
 │ │ phát triển phần mềm │
 │ │ │
 └──────────────────────────┴──────────────────────────┘
```

**Chiến lược xử lý theo quadrant:**

| Quadrant | Chiến lược |
|----------|-----------|
| Deliberate-Reckless | Ngăn chặn bằng code review, quality gates |
| Deliberate-Prudent | Chấp nhận + track trong Debt Register + plan trả nợ |
| Inadvertent-Reckless | Training, pair programming, mentoring |
| Inadvertent-Prudent | Continuous refactoring, retrospective |

### 3. Architecture Debt vs Code Debt

| Tiêu chí | Architecture Debt | Code Debt |
|-----------|-------------------|-----------|
| **Phạm vi** | System-wide, cross-cutting | Localized, within modules |
| **Ví dụ** | Monolith thay vì Microservices, thiếu caching layer, wrong database choice | Code duplication, god class, hardcoded values, missing tests |
| **Chi phí sửa** | Rất cao (weeks–months) | Thấp–trung bình (hours–days) |
| **Interest rate** | Cao — ảnh hưởng mọi feature mới | Trung bình — ảnh hưởng module cụ thể |
| **Phát hiện** | Architecture review, ATAM, dependency analysis | SonarQube, linters, code review |
| **Rủi ro nếu bỏ qua** | System rewrite, inability to scale | Bugs, slow development, developer frustration |

**Taxonomy đầy đủ các loại Technical Debt:**

| Loại Debt | Mô tả | Ví dụ cụ thể |
|-----------|--------|---------------|
| **Architecture Debt** | Sai lầm trong thiết kế kiến trúc tổng thể | Monolith 500K LOC, missing message queue |
| **Design Debt** | Vi phạm design principles (SOLID, DRY) | God class, circular dependency, tight coupling |
| **Code Debt** | Code quality kém, code smells | Duplicate code, magic numbers, dead code |
| **Test Debt** | Thiếu hoặc yếu test coverage | < 50% coverage, no integration tests |
| **Documentation Debt** | Tài liệu thiếu hoặc lỗi thời | No API docs, outdated README |
| **Infrastructure Debt** | Hạ tầng cũ, thiếu automation | No CI/CD, manual deployments, outdated OS |
| **Dependency Debt** | Thư viện/framework lỗi thời | Framework 3 major versions behind |
| **Process Debt** | Quy trình phát triển chưa tối ưu | No code review, no branching strategy |

### 4. Đo lường Technical Debt

#### 4.1 SQALE Method

**SQALE** (Software Quality Assessment based on Lifecycle Expectations) là phương pháp chuẩn hóa đo lường technical debt.

```
Technical Debt Ratio (TDR) = Remediation Cost / Development Cost x 100%

Ví dụ:
 Remediation Cost = 200 person-hours
 Development Cost = 2000 person-hours
 TDR = 200 / 2000 x 100% = 10%
```

**SQALE Rating Scale:**

| Rating | TDR Range | Ý nghĩa |
|--------|-----------|----------|
| **A** | < 5% | Excellent — debt được kiểm soát tốt |
| **B** | 5% – 10% | Good — cần chú ý một số vùng |
| **C** | 10% – 20% | Moderate — cần lên plan trả nợ |
| **D** | 20% – 50% | Poor — debt đang cản trở phát triển |
| **E** | > 50% | Critical — cần hành động ngay lập tức |

#### 4.2 SonarQube — Công cụ đo lường

SonarQube cung cấp các metrics tự động:

| Metric | Mô tả | Ngưỡng khuyến nghị |
|--------|--------|---------------------|
| **Bugs** | Lỗi tiềm ẩn trong code | 0 (zero bugs policy) |
| **Vulnerabilities** | Lỗ hổng bảo mật | 0 critical/blocker |
| **Code Smells** | Code cần refactor | < 1% of total LOC |
| **Coverage** | Test coverage % | ≥ 80% |
| **Duplications** | Code trùng lặp % | < 3% |
| **Complexity** | Cyclomatic complexity trung bình | < 10 per method |
| **Technical Debt** | Estimated remediation time | SQALE Rating ≥ A |
| **Debt Ratio** | TDR % | < 5% |

#### 4.3 Công thức tính toán quan trọng

```
┌─────────────────────────────────────────────────────────────────┐
│ DEBT METRICS FORMULAS │
│ │
│ 1. Technical Debt Ratio (TDR): │
│ TDR = Remediation_Cost / Development_Cost x 100% │
│ │
│ 2. Interest Rate (IR): │
│ IR = Extra_Effort_Per_Sprint / Sprint_Capacity x 100% │
│ │
│ 3. Break-even Point (BEP): │
│ BEP = Fix_Cost / Monthly_Interest_Saved │
│ (đơn vị: months) │
│ │
│ 4. ROI of Debt Repayment (12 months): │
│ ROI = (Monthly_Savings x 12 - Fix_Cost) / Fix_Cost x 100% │
│ │
│ 5. Debt Velocity: │
│ DV = New_Debt_Added - Debt_Removed (per sprint) │
│ Target: DV ≤ 0 (trả nợ nhanh hơn tạo nợ) │
│ │
│ 6. Priority Score: │
│ PS = (Business_Impact x Interest_Rate) / Fix_Effort │
│ Sắp xếp giảm dần → ưu tiên cao nhất trả trước │
│ │
└─────────────────────────────────────────────────────────────────┘
```

### 5. Tác động của Technical Debt lên Velocity

```
Velocity
 ▲
 │ ████████
 │ ████████ ██████
 │ ████████ ██████ █████
 │ ████████ ██████ █████ ████
 │ ████████ ██████ █████ ████ ███
 │ ████████ ██████ █████ ████ ███ ██ ← Velocity giảm dần
 │ ████████ ██████ █████ ████ ███ ██ █
 └─────────────────────────────────────────── Sprint
 S1 S2 S3 S4 S5 S6 S7

 Debt tích lũy → Interest tăng → Capacity cho feature mới giảm
 Sprint 1: 90% capacity cho features, 10% cho debt interest
 Sprint 7: 40% capacity cho features, 60% cho debt interest
```

### 6. Chiến lược trả nợ kỹ thuật (Debt Paydown Strategies)

| Chiến lược | Mô tả | Khi nào dùng | Ưu/Nhược điểm |
|------------|--------|--------------|----------------|
| **Boy Scout Rule** | "Always leave the code better than you found it" — clean up small debts khi touch code | Liên tục, mọi sprint | [OK] Zero overhead, dần dần cải thiện. [Khong] Chậm, không xử lý được debt lớn |
| **Refactoring Budget (20% Rule)** | Dành 20% capacity mỗi sprint cho debt repayment | Khi debt ở mức trung bình (C rating) | [OK] Bền vững, dự đoán được. [Khong] Có thể không đủ cho debt nghiêm trọng |
| **Dedicated Debt Sprint** | 1 sprint hoàn toàn dành cho trả nợ (mỗi quý) | Khi debt tích lũy nhiều, cần reset | [OK] Tác động lớn, team focus. [Khong] Không deliver feature, stakeholder có thể phản đối |
| **Strangler Fig Pattern** | Dần thay thế hệ thống cũ bằng hệ thống mới, module by module | Legacy system migration | [OK] Giảm rủi ro, incremental. [Khong] Kéo dài, complexity quản lý 2 hệ thống |
| **Tech Debt Tax** | Mỗi feature mới phải bao gồm effort fix related debt | Khi muốn gắn debt vào delivery flow | [OK] Tự nhiên, không cần negotiation riêng. [Khong] Feature delivery chậm hơn |

### 7. Communicating Debt to Stakeholders

**Nguyên tắc giao tiếp:**
- Dùng **ngôn ngữ business**, không dùng thuật ngữ kỹ thuật
- Sử dụng **analogy tài chính**: "Mỗi tháng chúng ta đang trả lãi 80 person-hours vì technical debt, tương đương $12,000/tháng"
- Trình bày **ROI**: "Đầu tư 200 hours fix = tiết kiệm 960 hours/năm"
- Dùng **visual dashboard**: trend charts, SQALE rating over time

**Template slide cho executives:**

```
Slide 1: "Tại sao delivery chậm lại?"
 → Biểu đồ velocity giảm qua 6 sprints
 → Nguyên nhân: Technical debt tích lũy

Slide 2: "Chi phí ẩn hàng tháng"
 → Bảng: Debt item | Monthly cost (hours & $)
 → Tổng: $X/tháng đang mất vì debt

Slide 3: "Kế hoạch đề xuất"
 → Top 5 debt items theo ROI
 → Timeline 3 tháng
 → Expected velocity improvement: +30%

Slide 4: "Yêu cầu nguồn lực"
 → X sprint-capacity cho debt reduction
 → Break-even: Y tháng
 → 12-month savings: $Z
```

---

## Step-by-step Labs

### Lab 1: Debt Identification — SonarQube Analysis (30 phút)

**Mục tiêu:** Sử dụng SonarQube để phân tích code và nhận diện technical debt trong một sample project.

#### Bước 1: Cài đặt và khởi động SonarQube

```bash
# Cách 1: Docker (khuyến nghị)
docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community

# Chờ SonarQube khởi động (~2 phút)
# Truy cập http://localhost:9000
# Login mặc định: admin / admin
```

#### Bước 2: Tạo sample project có chứa technical debt

Tạo file `ecommerce-legacy/src/OrderService.java`:

```java
// Sample project với nhiều technical debt cố ý
public class OrderService {

 // DEBT: Hardcoded database connection
 private String dbUrl = "jdbc:mysql://192.168.1.100:3306/prod_db";
 private String dbUser = "root";
 private String dbPass = "password123";

 // DEBT: God method — quá nhiều responsibility
 public String processOrder(String customerId, String items,
 String payment, String address) {
 // DEBT: SQL injection vulnerability
 String sql = "SELECT * FROM customers WHERE id = '" + customerId + "'";

 // DEBT: No null checks
 String[] itemList = items.split(",");

 double total = 0;
 // DEBT: Magic numbers
 for (String item : itemList) {
 double price = getPrice(item);
 if (price > 100) {
 total += price * 0.9; // DEBT: Magic number — discount 10%?
 } else {
 total += price * 0.95; // DEBT: Magic number — discount 5%?
 }
 }

 // DEBT: Tax hardcoded
 total = total * 1.08;

 // DEBT: Copy-pasted email logic (duplicated in 3 classes)
 try {
 // send email
 String smtpHost = "smtp.company.com"; // DEBT: Hardcoded
 // ... 50 lines of email sending code ...
 } catch (Exception e) {
 // DEBT: Swallowing exception
 }

 // DEBT: No logging
 // DEBT: No transaction management
 // DEBT: No input validation

 return "OK"; // DEBT: No proper response object
 }

 // DEBT: Empty method — not implemented
 public void cancelOrder(String orderId) {
 // TODO: implement later
 }

 // DEBT: No unit tests for this class
}
```

#### Bước 3: Chạy SonarScanner

```bash
# Cài SonarScanner CLI
# macOS
brew install sonar-scanner

# Hoặc tải từ https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/

# Tạo file sonar-project.properties trong thư mục project
cat > sonar-project.properties << 'PROPS'
sonar.projectKey=ecommerce-legacy
sonar.projectName=E-Commerce Legacy System
sonar.projectVersion=1.0
sonar.sources=src
sonar.sourceEncoding=UTF-8
sonar.host.url=http://localhost:9000
sonar.token=YOUR_TOKEN_HERE
PROPS

# Chạy scan
sonar-scanner
```

#### Bước 4: Đọc và phân tích kết quả

Truy cập SonarQube Dashboard tại `http://localhost:9000/dashboard?id=ecommerce-legacy`

**Bảng ghi nhận kết quả:**

| Metric | Giá trị đo được | Ngưỡng | Đạt/Không đạt |
|--------|-----------------|--------|----------------|
| Bugs | ___ | 0 | |
| Vulnerabilities | ___ | 0 | |
| Code Smells | ___ | < 10 | |
| Coverage | ___ % | ≥ 80% | |
| Duplications | ___ % | < 3% | |
| SQALE Rating | ___ | A | |
| Technical Debt | ___ hours | < 4h | |
| Security Hotspots | ___ | 0 | |

**Câu hỏi phân tích:**
1. SonarQube phát hiện bao nhiêu issues? Phân loại theo severity (Blocker, Critical, Major, Minor, Info)?
2. Debt Ratio (TDR) là bao nhiêu %? Rating gì?
3. Top 3 rules bị vi phạm nhiều nhất?
4. SonarQube có bỏ sót debt nào mà bạn nhận thấy bằng mắt không?

---

### Lab 2: Debt Classification (25 phút)

**Mục tiêu:** Phân loại các findings từ Lab 1 vào taxonomy debt chuẩn.

#### Bước 1: Liệt kê tất cả debt items từ Lab 1

Sử dụng template sau:

```markdown
# Debt Classification Worksheet

## Debt Item List

| # | Debt Description | Source |
|---|------------------|--------|
| 1 | Hardcoded DB credentials | SonarQube + Manual review |
| 2 | SQL injection vulnerability | SonarQube Security |
| 3 | God method (processOrder > 50 LOC) | SonarQube Complexity |
| 4 | Magic numbers (0.9, 0.95, 1.08) | SonarQube Code Smell |
| 5 | Swallowed exception | SonarQube Bug |
| 6 | No unit tests | Coverage report |
| 7 | Empty cancelOrder method | Manual review |
| 8 | Duplicated email logic | SonarQube Duplication |
| 9 | No input validation | Manual review |
| 10 | No logging/monitoring | Manual review |
| 11 | No transaction management | Manual review |
| 12 | Monolithic structure (tất cả trong 1 class) | Architecture review |
```

#### Bước 2: Phân loại theo Debt Taxonomy

| # | Debt Item | Category | Quadrant | Severity |
|---|-----------|----------|----------|----------|
| 1 | Hardcoded DB credentials | Infrastructure Debt | Deliberate-Reckless | Critical |
| 2 | SQL injection | Code Debt (Security) | Inadvertent-Reckless | Blocker |
| 3 | God method | Design Debt | Deliberate-Reckless | Major |
| 4 | Magic numbers | Code Debt | Inadvertent-Prudent | Minor |
| 5 | Swallowed exception | Code Debt | Deliberate-Reckless | Major |
| 6 | No unit tests | Test Debt | Deliberate-Reckless | Critical |
| 7 | Empty method | Code Debt | Deliberate-Prudent | Major |
| 8 | Duplicated email logic | Design Debt | Inadvertent-Reckless | Major |
| 9 | No input validation | Code Debt (Security) | Inadvertent-Reckless | Critical |
| 10 | No logging | Infrastructure Debt | Deliberate-Prudent | Major |
| 11 | No transaction mgmt | Design Debt | Inadvertent-Reckless | Critical |
| 12 | Monolithic structure | Architecture Debt | Deliberate-Reckless | Major |

#### Bước 3: Phân tích phân bố

```
Phân bố theo Category:
 Architecture Debt: 1 item ( 8%) ████
 Design Debt: 3 items (25%) ████████████
 Code Debt: 5 items (42%) ██████████████████
 Test Debt: 1 item ( 8%) ████
 Infrastructure Debt: 2 items (17%) ████████

Phân bố theo Quadrant:
 Deliberate-Reckless: 5 items (42%) → Cần quality gates ngay
 Deliberate-Prudent: 2 items (17%) → Track & plan
 Inadvertent-Reckless: 4 items (33%) → Cần training
 Inadvertent-Prudent: 1 item ( 8%) → Refactor khi touch

Phân bố theo Severity:
 Blocker: 1 item → Fix ngay lập tức
 Critical: 4 items → Fix trong sprint hiện tại
 Major: 6 items → Plan cho 2-3 sprints tới
 Minor: 1 item → Boy Scout Rule
```

**Nhận xét:** Code Debt chiếm tỷ lệ cao nhất → cần focus code review và linting. Deliberate-Reckless chiếm 42% → team đang cắt góc có ý thức, cần thay đổi culture.

---

### Lab 3: Debt Prioritization — ROI-based Ranking (30 phút)

**Mục tiêu:** Tạo Debt Backlog với cost-benefit analysis, tính ROI và sắp xếp ưu tiên.

#### Bước 1: Ước lượng chi phí và lợi ích

| # | Debt Item | Fix Cost (hours) | Monthly Interest (hours/month) | Risk Level |
|---|-----------|-------------------|-------------------------------|------------|
| 1 | Hardcoded DB credentials | 4 | 1 | High (security) |
| 2 | SQL injection | 8 | 2 + security risk | Critical |
| 3 | God method refactor | 16 | 4 | Medium |
| 4 | Magic numbers → config | 4 | 0.5 | Low |
| 5 | Exception handling | 6 | 3 (debugging time) | Medium |
| 6 | Add unit tests | 40 | 8 (manual testing) | High |
| 7 | Implement cancelOrder | 12 | 2 (customer complaints) | Medium |
| 8 | Extract email service | 12 | 3 (duplicate maintenance) | Medium |
| 9 | Input validation | 8 | 2 + security risk | Critical |
| 10 | Add logging | 8 | 4 (debugging time) | Medium |
| 11 | Transaction management | 16 | 4 (data corruption risk) | High |
| 12 | Break monolith (phase 1) | 80 | 6 (all changes touch same class) | High |

#### Bước 2: Tính ROI và Break-even

```
Công thức:
 Break-even (months) = Fix_Cost / Monthly_Interest
 ROI_12m (%) = (Monthly_Interest x 12 - Fix_Cost) / Fix_Cost x 100%
 Priority Score = (Risk_Weight x Monthly_Interest) / Fix_Cost
 Risk_Weight: Critical=4, High=3, Medium=2, Low=1
```

| # | Debt Item | Fix Cost | Monthly Interest | Break-even | ROI 12m | Priority Score |
|---|-----------|----------|-----------------|------------|---------|----------------|
| 2 | SQL injection | 8h | 2h | 4.0 mo | 200% | 1.00 |
| 9 | Input validation | 8h | 2h | 4.0 mo | 200% | 1.00 |
| 5 | Exception handling | 6h | 3h | 2.0 mo | 500% | 1.00 |
| 10 | Add logging | 8h | 4h | 2.0 mo | 500% | 1.00 |
| 1 | Hardcoded credentials | 4h | 1h | 4.0 mo | 200% | 0.75 |
| 6 | Add unit tests | 40h | 8h | 5.0 mo | 140% | 0.60 |
| 11 | Transaction mgmt | 16h | 4h | 4.0 mo | 200% | 0.75 |
| 3 | God method | 16h | 4h | 4.0 mo | 200% | 0.50 |
| 8 | Extract email svc | 12h | 3h | 4.0 mo | 200% | 0.50 |
| 7 | cancelOrder impl | 12h | 2h | 6.0 mo | 100% | 0.33 |
| 12 | Break monolith | 80h | 6h | 13.3 mo | -10% | 0.23 |
| 4 | Magic numbers | 4h | 0.5h | 8.0 mo | 50% | 0.13 |

#### Bước 3: Tạo Debt Backlog (sorted by Priority Score)

```markdown
# Technical Debt Backlog
# Sorted by Priority Score (descending)
# Date: [current date]

## PRIORITY 1 — Fix Immediately (Sprint hiện tại)
- [TD-002] SQL injection | 8h | ROI: 200% | SECURITY
- [TD-009] Input validation | 8h | ROI: 200% | SECURITY
- [TD-005] Exception handling | 6h | ROI: 500% | RELIABILITY
- [TD-010] Add logging | 8h | ROI: 500% | OPERABILITY
Subtotal: 30 hours

## PRIORITY 2 — Next Sprint
- [TD-001] Hardcoded credentials | 4h | ROI: 200% | SECURITY
- [TD-011] Transaction mgmt | 16h | ROI: 200% | DATA INTEGRITY
- [TD-006] Unit tests (phase 1) | 20h | ROI: 140% | QUALITY
Subtotal: 40 hours

## PRIORITY 3 — Backlog (2-3 sprints)
- [TD-003] God method refactor | 16h | ROI: 200% | MAINTAINABILITY
- [TD-008] Extract email service | 12h | ROI: 200% | REUSABILITY
- [TD-006] Unit tests (phase 2) | 20h | ROI: 140% | QUALITY
- [TD-007] cancelOrder impl | 12h | ROI: 100% | FUNCTIONALITY
Subtotal: 60 hours

## PRIORITY 4 — Long-term
- [TD-012] Break monolith | 80h | ROI: -10% (12m) | SCALABILITY
- [TD-004] Magic numbers | 4h | ROI: 50% | READABILITY
Subtotal: 84 hours

GRAND TOTAL: 214 hours
```

#### Bước 4: Technical Debt Register — Chi tiết một item

```markdown
# Technical Debt Register Entry

## TD-002: SQL Injection Vulnerability in OrderService

| Field | Value |
|-------|-------|
| **ID** | TD-002 |
| **Title** | SQL Injection Vulnerability in OrderService |
| **Category** | Code Debt (Security) |
| **Quadrant** | Inadvertent-Reckless |
| **Severity** | Blocker |
| **Priority Score** | 1.00 (highest) |
| **Fix Cost** | 8 person-hours |
| **Monthly Interest** | 2 hours + unquantified security risk |
| **Break-even** | 4 months |
| **12-month ROI** | 200% |
| **Owner** | Backend Team |
| **Created** | [date] |
| **Target Sprint** | Current sprint |
| **Status** | Open |

### Description
Method processOrder() trong OrderService.java xây dựng SQL query bằng
string concatenation trực tiếp từ user input (customerId), tạo lỗ hổng
SQL injection. Attacker có thể đọc/xóa toàn bộ database.

### Impact
- **Security**: Data breach risk — toàn bộ customer data có thể bị lộ
- **Compliance**: Vi phạm OWASP Top 10, không pass security audit
- **Business**: Potential fine, reputation damage, customer churn
- **Interest**: 2h/month cho manual security review workaround

### Proposed Solution
1. Replace string concatenation with PreparedStatement (parameterized query)
2. Add input validation layer (whitelist customer ID format)
3. Add SQL injection test cases
4. Run OWASP ZAP scan to verify fix

### Acceptance Criteria
- [ ] All SQL queries use parameterized statements
- [ ] Input validation rejects malformed customer IDs
- [ ] SQL injection test cases pass
- [ ] OWASP ZAP scan clean
```

---

### Lab 4: Debt Paydown Plan (25 phút)

**Mục tiêu:** Tạo sprint plan chi tiết để trả nợ kỹ thuật, thiết lập metrics tracking.

#### Bước 1: Sprint Plan cho 3 sprints (mỗi sprint 2 tuần, capacity 80 hours/team)

```
┌─────────────────────────────────────────────────────────────────┐
│ DEBT PAYDOWN PLAN │
│ Strategy: 20% Budget (16h/sprint for debt) │
├─────────────────────────────────────────────────────────────────┤
│ │
│ Sprint N (Current): │
│ ├── [TD-002] SQL injection fix ............... 8h │
│ └── [TD-009] Input validation ................ 8h │
│ Total debt work: 16h / 80h = 20% │
│ Expected debt reduction: -16h remediation │
│ │
│ Sprint N+1: │
│ ├── [TD-005] Exception handling .............. 6h │
│ ├── [TD-010] Logging ......................... 8h │
│ └── [TD-001] Hardcoded credentials ........... 2h (start) │
│ Total debt work: 16h / 80h = 20% │
│ Expected debt reduction: -16h remediation │
│ │
│ Sprint N+2: │
│ ├── [TD-001] Hardcoded credentials ........... 2h (finish) │
│ ├── [TD-011] Transaction management .......... 14h (start) │
│ Total debt work: 16h / 80h = 20% │
│ Expected debt reduction: -16h remediation │
│ │
└─────────────────────────────────────────────────────────────────┘
```

#### Bước 2: Debt Reduction Metrics Dashboard

```markdown
# Debt Tracking Dashboard

## Sprint-over-Sprint Metrics

| Metric | Sprint N-1 | Sprint N | Sprint N+1 | Sprint N+2 | Target |
|--------|-----------|----------|------------|------------|--------|
| Total Debt (hours) | 214h | 198h | 182h | 166h | < 50h |
| Debt Ratio (TDR) | 10.7% | 9.9% | 9.1% | 8.3% | < 5% |
| SQALE Rating | C | C | B | B | A |
| Debt Velocity | +6h | -16h | -16h | -16h | ≤ 0 |
| Interest Paid | 38h | 34h | 27h | 22h | < 10h |
| Open Blockers | 1 | 0 | 0 | 0 | 0 |
| Open Critical | 4 | 2 | 0 | 0 | 0 |
```

#### Bước 3: SonarQube Quality Gate configuration

```bash
# Tạo custom Quality Gate qua SonarQube API
curl -u admin:admin -X POST \
 "http://localhost:9000/api/qualitygates/create" \
 -d "name=Debt-Reduction-Gate"

# Thêm conditions
curl -u admin:admin -X POST \
 "http://localhost:9000/api/qualitygates/create_condition" \
 -d "gateId=2&metric=new_bugs&op=GT&error=0"

curl -u admin:admin -X POST \
 "http://localhost:9000/api/qualitygates/create_condition" \
 -d "gateId=2&metric=new_vulnerabilities&op=GT&error=0"

curl -u admin:admin -X POST \
 "http://localhost:9000/api/qualitygates/create_condition" \
 -d "gateId=2&metric=new_coverage&op=LT&error=80"

curl -u admin:admin -X POST \
 "http://localhost:9000/api/qualitygates/create_condition" \
 -d "gateId=2&metric=new_duplicated_lines_density&op=GT&error=3"

# Verify Quality Gate
curl -u admin:admin \
 "http://localhost:9000/api/qualitygates/show?name=Debt-Reduction-Gate"
```

#### Bước 4: Chạy lại SonarQube sau khi fix

```bash
# Sau khi fix TD-002 và TD-009
sonar-scanner

# So sánh kết quả trước/sau
# Dashboard → Activity tab → compare with previous analysis

# Export metrics qua API
curl -u admin:admin \
 "http://localhost:9000/api/measures/component?component=ecommerce-legacy&metricKeys=bugs,vulnerabilities,code_smells,coverage,sqale_rating,sqale_debt_ratio"
```

**Bảng so sánh trước/sau:**

| Metric | Trước fix | Sau fix Sprint N | Δ (thay đổi) |
|--------|-----------|------------------|---------------|
| Bugs | ___ | ___ | ___ |
| Vulnerabilities | ___ | ___ | ___ |
| Code Smells | ___ | ___ | ___ |
| SQALE Rating | ___ | ___ | ___ |
| Debt (hours) | ___ | ___ | ___ |

---

## Self-Assessment

### Band 1: Cơ bản (Câu 1–10)

**Câu 1.** Technical debt interest là:
- A) Tiền vay ngân hàng
- B) Effort thêm phải trả mỗi sprint vì shortcuts trước đó
- C) Lãi suất cho vay dự án
- D) Ngân sách dự án

> **Đáp án: B.** Technical debt interest là chi phí phụ (extra effort) mà team phải gánh mỗi sprint vì đang sống chung với code/design chưa tối ưu. Ví dụ: 4 hours/sprint extra debugging vì thiếu logging.

**Câu 2.** SQALE TDR = 25% tương ứng rating gì?
- A) A
- B) B
- C) C
- D) D

> **Đáp án: D.** Theo SQALE scale: A (< 5%), B (5–10%), C (10–20%), D (20–50%), E (> 50%). TDR 25% nằm trong khoảng D.

**Câu 3.** Inadvertent debt phát sinh do:
- A) Áp lực deadline
- B) Thiếu kiến thức hoặc kinh nghiệm
- C) Quyết định business có chủ đích
- D) Cắt giảm ngân sách

> **Đáp án: B.** Inadvertent (vô ý) debt xảy ra khi developer không biết cách tốt hơn — do thiếu skill, kiến thức design patterns, hoặc chưa hiểu domain đủ sâu.

**Câu 4.** Boy Scout Rule nghĩa là:
- A) Xóa code cũ
- B) Luôn để code tốt hơn lúc mình tìm thấy nó
- C) Viết thêm nhiều test
- D) Document mọi thứ

> **Đáp án: B.** Boy Scout Rule: "Always leave the campground (code) cleaner than you found it." Mỗi lần touch code, dọn dẹp nhỏ (rename, extract method, fix warning).

**Câu 5.** Cách tốt nhất để trình bày technical debt cho executives:
- A) Show code complexity metrics chi tiết
- B) Show business impact và ROI bằng ngôn ngữ tài chính
- C) Giải thích technical details sâu
- D) Blame developers trước đó

> **Đáp án: B.** Executives quan tâm đến business outcomes. Dịch debt sang ngôn ngữ họ hiểu: "Mỗi tháng mất $12,000 vì debt. Đầu tư $5,000 fix → tiết kiệm $144,000/năm."

**Câu 6.** Ward Cunningham đề xuất khái niệm Technical Debt vào năm nào?
- A) 1985
- B) 1992
- C) 2001
- D) 2008

> **Đáp án: B.** Ward Cunningham lần đầu giới thiệu metaphor "technical debt" tại hội nghị OOPSLA 1992, liên hệ decisions trong code với vay nợ tài chính.

**Câu 7.** Trong Technical Debt Quadrant, góc nào nguy hiểm nhất?
- A) Deliberate-Prudent
- B) Inadvertent-Prudent
- C) Deliberate-Reckless
- D) Inadvertent-Reckless

> **Đáp án: C.** Deliberate-Reckless = team biết đang cắt góc, biết sẽ gây hại, nhưng vẫn làm mà không có plan trả nợ. Ví dụ: "We don't have time for design."

**Câu 8.** SonarQube đo lường metric nào KHÔNG trực tiếp?
- A) Code complexity
- B) Test coverage
- C) Team morale
- D) Code duplication

> **Đáp án: C.** SonarQube là static analysis tool, đo lường code metrics tự động (complexity, coverage, duplication, bugs, vulnerabilities). Team morale là human factor, không đo bằng tool.

**Câu 9.** Architecture debt khác code debt ở điểm nào?
- A) Architecture debt luôn ít chi phí sửa hơn
- B) Architecture debt ảnh hưởng system-wide, chi phí sửa cao hơn
- C) Code debt nguy hiểm hơn architecture debt
- D) Không có sự khác biệt

> **Đáp án: B.** Architecture debt (sai database choice, wrong decomposition) ảnh hưởng toàn hệ thống, fix tốn weeks-months. Code debt (duplicate code, naming) chỉ ảnh hưởng cục bộ, fix tốn hours-days.

**Câu 10.** Ngưỡng Cyclomatic Complexity khuyến nghị cho mỗi method là:
- A) < 5
- B) < 10
- C) < 50
- D) < 100

> **Đáp án: B.** Cyclomatic complexity < 10 per method là ngưỡng phổ biến. 10–20 là moderate risk, > 20 cần refactor (extract method, decompose conditional).

### Band 2: Trung bình (Câu 11–20)

**Câu 11.** Technical Debt Ratio (TDR) được tính bằng công thức nào?
- A) Development Cost / Remediation Cost
- B) Remediation Cost / Development Cost x 100%
- C) Remediation Cost x Interest Rate
- D) Total Bugs / Total LOC

> **Đáp án: B.** TDR = Remediation Cost / Development Cost x 100%. Ví dụ: 200h remediation / 2000h development = 10% (Rating B).

**Câu 12.** Break-even point của một debt item có Fix Cost = 40h và Monthly Savings = 8h là:
- A) 3 tháng
- B) 5 tháng
- C) 8 tháng
- D) 12 tháng

> **Đáp án: B.** Break-even = Fix Cost / Monthly Savings = 40 / 8 = 5 tháng. Sau 5 tháng, team bắt đầu "lãi" 8h/tháng.

**Câu 13.** Strangler Fig Pattern dùng khi nào?
- A) Khi cần viết lại hệ thống từ đầu
- B) Khi muốn thay thế dần hệ thống cũ bằng hệ thống mới
- C) Khi cần thêm unit tests
- D) Khi cần fix bugs cấp tốc

> **Đáp án: B.** Strangler Fig Pattern (Martin Fowler): dần thay thế legacy system module-by-module, hệ thống cũ và mới chạy song song cho đến khi hệ thống cũ bị "siết" hoàn toàn.

**Câu 14.** "Refactoring Budget 20%" nghĩa là:
- A) 20% ngân sách cho testing
- B) 20% sprint capacity dành riêng cho technical debt repayment
- C) 20% code cần viết lại
- D) 20% team members làm refactoring

> **Đáp án: B.** Dành 20% capacity mỗi sprint cho debt repayment. Trong sprint 2 tuần (80h capacity), 16h dùng cho fix debt. Đây là chiến lược bền vững, dễ negotiate với stakeholders.

**Câu 15.** Debt Velocity = +10h/sprint nghĩa là:
- A) Team trả được 10h debt mỗi sprint
- B) Team tạo thêm 10h debt mới mỗi sprint (nhanh hơn trả)
- C) Team maintain 10h debt ổn định
- D) Sprint duration tăng 10h

> **Đáp án: B.** Debt Velocity = New Debt Added − Debt Removed. Dương (+) = đang tạo nợ nhanh hơn trả → tình hình xấu đi. Mục tiêu: DV ≤ 0.

**Câu 16.** SonarQube Quality Gate dùng để làm gì?
- A) Quản lý user access
- B) Tự động fail build nếu code không đạt ngưỡng chất lượng
- C) Generate documentation
- D) Deploy code lên production

> **Đáp án: B.** Quality Gate là tập hợp conditions (coverage ≥ 80%, 0 new bugs, etc.). Nếu code mới không pass → build fail → ngăn thêm debt mới vào codebase.

**Câu 17.** Để tính ROI 12 tháng cho debt repayment, công thức nào đúng?
- A) ROI = Fix Cost / Monthly Savings
- B) ROI = (Monthly Savings x 12 − Fix Cost) / Fix Cost x 100%
- C) ROI = Monthly Savings x 12
- D) ROI = Fix Cost x 12

> **Đáp án: B.** ROI 12m = (Monthly Savings x 12 − Fix Cost) / Fix Cost x 100%. Ví dụ: Monthly Savings = 8h, Fix Cost = 40h → ROI = (96 − 40)/40 x 100% = 140%.

**Câu 18.** Interest on debt là gì?
- A) Tiền lãi ngân hàng cho dự án
- B) Chi phí ongoing phải trả mỗi sprint vì sống chung với debt
- C) Số bugs mới phát sinh
- D) Thời gian build code

> **Đáp án: B.** Interest = ongoing cost khi team phải workaround, debug thêm, hoặc làm chậm hơn vì debt. Ví dụ: thiếu automated tests → 8h/sprint manual testing = interest.

**Câu 19.** Principal on debt là gì?
- A) Project Manager
- B) Effort cần để fix/remediate debt item
- C) Số lượng developers
- D) Budget của dự án

> **Đáp án: B.** Principal = remediation cost, tức effort (person-hours) cần bỏ ra để sửa hoàn toàn debt item. Tương tự "gốc" trong nợ tài chính.

**Câu 20.** Khi nào nên dùng "Dedicated Debt Sprint"?
- A) Mỗi sprint đều dành cho debt
- B) Khi debt tích lũy nhiều, cần focused effort (thường mỗi quý)
- C) Khi không có feature nào cần làm
- D) Chỉ khi có budget riêng cho debt

> **Đáp án: B.** Dedicated Debt Sprint (thường 1 sprint/quý) = toàn team focus fix debt. Dùng khi debt đã tích lũy quá nhiều mà 20% budget không đủ xử lý.

### Band 3: Nâng cao (Câu 21–30)

**Câu 21.** Technical Debt Register bao gồm những thông tin gì?

> **Đáp án:** Technical Debt Register là tài liệu tracking tất cả debt items, mỗi entry gồm: ID, Title, Category (arch/design/code/test/doc/infra), Quadrant (deliberate/inadvertent x reckless/prudent), Severity, Fix Cost (hours), Monthly Interest (hours), Break-even Point, ROI, Owner (team/person), Status (Open/In Progress/Resolved), Created Date, Target Sprint, Description, Impact Analysis, Proposed Solution, Acceptance Criteria.

**Câu 22.** Giải thích quy trình debt prioritization 4 bước.

> **Đáp án:** (1) **Inventory** — liệt kê tất cả debt items từ SonarQube + manual review + retrospective. (2) **Estimate** — ước lượng Fix Cost và Monthly Interest cho mỗi item. (3) **Score** — tính Priority Score = (Business Impact x Interest Rate) / Fix Effort, kết hợp risk level. (4) **Rank & Plan** — sắp xếp giảm dần theo Priority Score, nhóm thành Priority tiers (P1: fix now, P2: next sprint, P3: backlog, P4: long-term), và lên sprint plan.

**Câu 23.** Cho ví dụ tính ROI cho 3 debt items. Item A: Fix=20h, Savings=5h/mo. Item B: Fix=60h, Savings=10h/mo. Item C: Fix=10h, Savings=1h/mo. Nên ưu tiên item nào?

> **Đáp án:** Tính ROI 12 tháng: Item A: ROI = (5x12 − 20)/20 = 200%, BEP = 4 mo. Item B: ROI = (10x12 − 60)/60 = 100%, BEP = 6 mo. Item C: ROI = (1x12 − 10)/10 = 20%, BEP = 10 mo. Ưu tiên: A > B > C. Item A có ROI cao nhất và break-even nhanh nhất. Tuy nhiên nếu Item B liên quan security/compliance thì cần xét thêm risk factor.

**Câu 24.** Làm sao communicate debt cho executives không có background kỹ thuật?

> **Đáp án:** Sử dụng 4 kỹ thuật: (1) **Financial analogy** — "Technical debt giống khoản vay: mỗi tháng trả lãi $12,000 dưới dạng productivity loss." (2) **Visual dashboard** — trend charts showing velocity decline, debt accumulation. (3) **ROI projection** — "Invest $5,000 now → save $60,000/year." (4) **Risk framing** — "Security debt = 40% chance data breach = $2M potential fine." Tuyệt đối tránh dùng thuật ngữ kỹ thuật (cyclomatic complexity, code smells, etc.).

**Câu 25.** Technical debt trong CI/CD pipeline biểu hiện như thế nào?

> **Đáp án:** Biểu hiện: (1) Build time quá lâu (> 30 phút) vì test suite chậm hoặc thiếu caching. (2) Flaky tests — tests pass/fail ngẫu nhiên, team bắt đầu ignore failures. (3) No automated deployment — vẫn deploy manual, dễ lỗi. (4) Thiếu environment parity — dev/staging/prod khác nhau → "works on my machine." (5) No rollback mechanism — khi deploy fail phải fix forward. (6) Thiếu security scanning trong pipeline.

**Câu 26.** Giải thích automated debt detection và các tool phổ biến.

> **Đáp án:** Automated debt detection là quá trình tự động phát hiện debt bằng static analysis tools trong CI/CD pipeline. Các tool: **SonarQube** — comprehensive (bugs, vulnerabilities, code smells, coverage, duplication). **ESLint/Pylint/Checkstyle** — linting rules. **Dependency-Check (OWASP)** — outdated/vulnerable dependencies. **Architecture unit tests (ArchUnit, NetArchTest)** — enforce architecture rules. **JDepend/Structure101** — dependency analysis. **Code Climate** — maintainability metrics. Nên integrate vào CI pipeline, fail build khi vượt ngưỡng.

**Câu 27.** Liệt kê 5 chiến lược phòng ngừa debt (prevention).

> **Đáp án:** (1) **Quality Gates** — SonarQube gates trong CI, block merge nếu không pass. (2) **Code Review bắt buộc** — ít nhất 2 reviewers, checklist bao gồm debt assessment. (3) **Architecture Decision Records (ADR)** — document mọi architecture decision, rationale, và known tradeoffs. (4) **Definition of Done mở rộng** — DoD bao gồm: tests, documentation, no new debt, code review passed. (5) **Technical Debt Retrospective** — dành 15 phút mỗi sprint retro để review debt trends, celebrate debt reduction.

**Câu 28.** Debt culture trong team ảnh hưởng thế nào đến chất lượng phần mềm?

> **Đáp án:** Debt culture quyết định thái độ team đối với chất lượng code. **Negative culture**: "Ship fast, fix never" → debt snowball, velocity crash, developer burnout, high turnover. **Positive culture**: team tự hào về code quality, Boy Scout Rule là thói quen, debt là agenda item trong sprint planning. Để xây dựng positive debt culture: (1) Leadership phải prioritize quality. (2) Reward refactoring, không chỉ feature delivery. (3) Make debt visible — dashboard trên wall. (4) No blame cho legacy debt — focus forward.

**Câu 29.** Debt governance framework bao gồm những gì?

> **Đáp án:** Debt Governance Framework gồm: (1) **Policy** — rules về acceptable debt levels (max TDR 10%, mandatory Quality Gate). (2) **Process** — debt identification cycle (quarterly architecture review, continuous SonarQube), debt approval process (deliberate debt phải có approval + debt register entry). (3) **Roles** — Debt Owner (mỗi debt item), Debt Champion (track overall debt health), Architecture Board (approve/deny architecture debt). (4) **Metrics** — KPIs tracked (TDR, Debt Velocity, Interest Rate, SQALE Rating). (5) **Review** — monthly debt review meeting, quarterly deep assessment.

**Câu 30.** Zero-debt policy có khả thi không? Phân tích ưu nhược điểm.

> **Đáp án:** Zero-debt policy (không chấp nhận bất kỳ technical debt nào) là **không khả thi** trong thực tế vì: **Nhược điểm**: (1) Inadvertent-Prudent debt là tất yếu — team luôn học thêm và nhận ra cách làm tốt hơn. (2) Time-to-market quá chậm — over-engineering mọi thứ. (3) Opportunity cost — hoàn hảo hóa code trong khi market window đóng lại. (4) Phản tác dụng — team giấu debt thay vì report vì sợ bị phạt. **Chiến lược thực tế hơn**: chấp nhận debt ở mức kiểm soát được (TDR < 5%, SQALE A), track mọi deliberate debt, có budget trả nợ đều đặn, quality gates ngăn debt mới quá ngưỡng.

---

## Extend Labs (10 bài)

### EL1: SonarQube Deep Dive ***

**Mục tiêu:** Thành thạo cấu hình và sử dụng SonarQube cho debt management.

**Yêu cầu:**
1. Setup SonarQube server (Docker) và SonarScanner CLI
2. Tạo custom Quality Profile với rules phù hợp cho Java/Python
3. Cấu hình Quality Gate: zero new bugs, zero new vulnerabilities, coverage ≥ 80%, duplication < 3%
4. Scan ít nhất 3 projects khác nhau, so sánh kết quả
5. Thiết lập SonarQube webhook → CI/CD pipeline (Jenkins/GitHub Actions)
6. Export report và phân tích trend qua 3+ analysis

**Deliverable:** Báo cáo so sánh 3 projects với screenshots, Quality Gate config, CI integration script.

### EL2: Enterprise Debt Register System ***

**Mục tiêu:** Xây dựng hệ thống tracking debt cho team/tổ chức.

**Yêu cầu:**
1. Thiết kế Debt Register template chuẩn (spreadsheet hoặc Jira custom fields)
2. Tạo register cho ≥ 10 debt items với đầy đủ metadata
3. Implement prioritization matrix (Priority Score calculation)
4. Tạo monthly review process (agenda, attendees, decision log)
5. Track debt trends qua 3 review cycles (có thể mô phỏng)

**Deliverable:** Debt Register file, prioritization matrix, review process document, trend report.

### EL3: Debt ROI Business Case ***

**Mục tiêu:** Xây dựng business case thuyết phục cho debt repayment investment.

**Yêu cầu:**
1. Chọn 5 debt items thực tế (hoặc realistic scenario)
2. Tính chi tiết: Fix Cost, Monthly Interest, Break-even, 12-month ROI, 24-month ROI
3. Tạo sensitivity analysis: best case / expected case / worst case
4. So sánh NPV (Net Present Value) của fix vs không fix
5. Tạo executive presentation (5 slides max)

**Deliverable:** ROI analysis spreadsheet, sensitivity analysis, executive slides.

### EL4: Architecture Debt Assessment ****

**Mục tiêu:** Đánh giá architecture debt cho hệ thống thực tế.

**Yêu cầu:**
1. Chọn một open-source project (hoặc project cá nhân) có architecture issues
2. Vẽ current architecture diagram (component, dependency, data flow)
3. Identify architecture debts: coupling, cohesion, missing layers, wrong patterns
4. Sử dụng dependency analysis tool (JDepend, Structure101, hoặc manual)
5. Đề xuất target architecture và migration plan (Strangler Fig)
6. Ước lượng effort và timeline

**Deliverable:** Architecture diagrams (as-is, to-be), debt assessment report, migration plan.

### EL5: Technical Debt Dashboard ***

**Mục tiêu:** Tạo dashboard trực quan cho debt visibility.

**Yêu cầu:**
1. Thu thập metrics từ SonarQube API (hoặc mock data)
2. Tạo dashboard hiển thị: TDR trend, SQALE rating, Debt Velocity, Interest trend
3. Implement alerts: TDR > 10%, Debt Velocity > 0 liên tục 3 sprints
4. Sử dụng tool: Grafana, Google Sheets, hoặc custom HTML/JS
5. Dashboard phải auto-refresh từ data source

**Deliverable:** Working dashboard, data source configuration, alert rules document.

### EL6: Debt Reduction Sprint Simulation ***

**Mục tiêu:** Lên kế hoạch và mô phỏng một Dedicated Debt Sprint.

**Yêu cầu:**
1. Chọn scenario: team 5 người, sprint 2 tuần, 400h capacity
2. Từ debt backlog, chọn items cho debt sprint (theo Priority Score)
3. Phân công task cho team members
4. Mô phỏng execution: before/after metrics
5. Tính impact: velocity improvement dự kiến ở sprint tiếp theo
6. Tạo sprint report và retrospective notes

**Deliverable:** Sprint plan, task assignments, before/after metrics, sprint report.

### EL7: Executive Communication Workshop ***

**Mục tiêu:** Thực hành trình bày technical debt cho non-technical stakeholders.

**Yêu cầu:**
1. Tạo presentation (max 10 slides) cho board of directors
2. Sử dụng financial analogies (mortgage, credit card debt, maintenance budget)
3. Include: current state, trends, risks, proposed plan, resource request, expected ROI
4. Peer review: partner đóng vai executive, đặt câu hỏi khó
5. Revise dựa trên feedback

**Deliverable:** Slide deck, Q&A preparation document, revision notes.

### EL8: Debt Prevention Framework ***

**Mục tiêu:** Thiết kế framework ngăn ngừa debt cho team.

**Yêu cầu:**
1. Thiết kế Definition of Done mở rộng (bao gồm debt criteria)
2. Tạo code review checklist có debt assessment
3. Cấu hình automated quality gates (SonarQube + CI/CD)
4. Thiết kế Architecture Decision Record (ADR) template
5. Tạo debt awareness training materials (30 phút onboarding)

**Deliverable:** DoD document, review checklist, CI config, ADR template, training slides.

### EL9: Legacy System Debt Assessment ****

**Mục tiêu:** Đánh giá và lên plan cho legacy system có debt nghiêm trọng.

**Yêu cầu:**
1. Chọn scenario: legacy system 10+ years, 500K LOC, no tests, outdated framework
2. Tạo comprehensive debt inventory (architecture, design, code, test, infra, dependency)
3. Estimate total remediation cost và ongoing interest
4. Đánh giá: modernize vs rebuild decision matrix
5. Nếu modernize: tạo phased plan (6–12 tháng) với milestones
6. Risk assessment và mitigation plan

**Deliverable:** Debt inventory, cost analysis, decision matrix, modernization plan, risk register.

### EL10: Organizational Debt Governance ****

**Mục tiêu:** Thiết kế debt governance cho toàn tổ chức (multi-team).

**Yêu cầu:**
1. Thiết kế Debt Policy: acceptable debt levels, approval process, escalation
2. Định nghĩa roles: Debt Champion, Architecture Board, Team Lead responsibilities
3. Tạo governance process: quarterly assessment, monthly tracking, weekly updates
4. Thiết kế cross-team debt dashboard (aggregate metrics)
5. Tạo incentive/accountability mechanisms (debt budget per team, gamification)
6. Pilot plan: rollout governance cho 3 teams trong 1 quý

**Deliverable:** Governance policy document, RACI matrix, process flowcharts, dashboard design, pilot plan.

---

## Deliverables Checklist

| # | Deliverable | Lab | Trọng số |
|---|-------------|-----|----------|
| 1 | ☐ Bảng kết quả SonarQube analysis (metrics table) | Lab 1 | 15% |
| 2 | ☐ Debt Classification Worksheet (12+ items phân loại đầy đủ) | Lab 2 | 15% |
| 3 | ☐ Phân tích phân bố debt (by category, quadrant, severity) | Lab 2 | 10% |
| 4 | ☐ ROI Calculation Table (tất cả debt items) | Lab 3 | 15% |
| 5 | ☐ Technical Debt Backlog (sorted by Priority Score) | Lab 3 | 10% |
| 6 | ☐ Technical Debt Register Entry (1 item chi tiết đầy đủ) | Lab 3 | 10% |
| 7 | ☐ Sprint Paydown Plan (3 sprints) | Lab 4 | 10% |
| 8 | ☐ Debt Reduction Metrics Dashboard (before/after comparison) | Lab 4 | 10% |
| 9 | ☐ Self-Assessment hoàn thành (30 câu) | SA | 5% |
| **Tổng** | | | **100%** |

---

## Lỗi Thường Gặp

| # | Lỗi | Nguyên nhân | Cách khắc phục |
|---|------|-------------|----------------|
| 1 | Không phân biệt được architecture debt và code debt | Thiếu hiểu biết về scope và impact | Architecture debt = system-wide, high fix cost. Code debt = localized, lower fix cost. Dùng taxonomy table để phân loại |
| 2 | Ước lượng Fix Cost quá thấp (underestimate) | Optimism bias, quên tính thời gian test & review | Sử dụng historical data, nhân hệ số 1.5–2x cho lần đầu estimate. Include testing, code review, documentation time |
| 3 | Tính ROI mà quên tính risk/opportunity cost | Chỉ focus vào hours saved | Thêm Risk Weight vào Priority Score. Security debt có risk cost tiềm ẩn rất cao (data breach = $millions) |
| 4 | Trình bày debt bằng thuật ngữ kỹ thuật cho executives | Không biết audience | Dịch sang business language: hours → dollars, complexity → development speed, bugs → customer impact |
| 5 | Không track debt metrics qua thời gian | Thiếu process, thiếu tools | Setup SonarQube + dashboard, review metrics mỗi sprint retro, track Debt Velocity trend |
| 6 | Cố fix tất cả debt cùng lúc ("Big Bang") | Thiếu kiên nhẫn, muốn quick win | Ưu tiên theo ROI, dùng 20% budget strategy, incremental improvement. Big Bang rất rủi ro |
| 7 | Tạo debt register nhưng không review/update | "Write and forget" | Schedule monthly debt review meeting, assign Debt Champion role, integrate vào sprint planning |
| 8 | Confuse SonarQube issues với technical debt | Nghĩ SonarQube issues = toàn bộ debt | SonarQube chỉ detect code-level debt. Architecture debt, process debt, dependency debt cần manual assessment |
| 9 | Không tính interest rate cho debt items | Không hiểu financial metaphor | Mỗi debt item hỏi: "Mỗi sprint team mất bao nhiêu giờ vì sống chung với debt này?" → đó là interest |
| 10 | Zero-debt mindset — reject mọi shortcut | Over-engineering, slow delivery | Deliberate-Prudent debt là acceptable. Quan trọng là track, plan trả nợ, và kiểm soát TDR < 5% |

---

## Rubric Chấm điểm

| Tiêu chí | Điểm tối đa | Mô tả chi tiết |
|----------|-------------|-----------------|
| **1. Debt Identification (SonarQube)** | **20 điểm** | |
| - Chạy SonarQube scan thành công | 5 | Có kết quả scan, screenshot dashboard |
| - Ghi nhận đầy đủ metrics (≥ 6 metrics) | 5 | Bugs, vulnerabilities, code smells, coverage, duplication, SQALE rating |
| - Phân tích kết quả đúng (severity, trends) | 5 | Nhận xét đúng ý nghĩa từng metric |
| - Nhận diện debt mà SonarQube bỏ sót | 5 | Phát hiện architecture/design debt bằng manual review |
| **2. Debt Classification** | **20 điểm** | |
| - Liệt kê ≥ 10 debt items | 5 | Đầy đủ, không trùng lặp |
| - Phân loại đúng category (arch/design/code/test/infra) | 5 | ≥ 80% phân loại chính xác |
| - Xác định đúng quadrant | 5 | Deliberate/Inadvertent x Reckless/Prudent |
| - Phân tích phân bố có insight | 5 | Biểu đồ phân bố, nhận xét xu hướng, đề xuất action |
| **3. Debt Prioritization & ROI** | **25 điểm** | |
| - Ước lượng Fix Cost hợp lý | 5 | Có rationale, không quá lạc quan |
| - Tính Monthly Interest chính xác | 5 | Giải thích nguồn gốc interest |
| - Áp dụng đúng công thức (BEP, ROI, Priority Score) | 5 | Tính toán không sai |
| - Sắp xếp ưu tiên hợp lý | 5 | Kết hợp ROI + risk, giải thích decision |
| - Debt Register entry đầy đủ | 5 | Tất cả fields, description, impact, solution, acceptance criteria |
| **4. Debt Paydown Plan** | **20 điểm** | |
| - Sprint plan 3 sprints khả thi | 5 | Phân bổ đúng capacity (20%), task mapping |
| - Metrics tracking table | 5 | ≥ 5 metrics, values hợp lý |
| - Before/after comparison | 5 | Có dữ liệu so sánh, thấy improvement |
| - Quality Gate configuration | 5 | Conditions hợp lý, giải thích rationale |
| **5. Presentation & Communication** | **15 điểm** | |
| - Sử dụng ngôn ngữ business (không jargon) | 5 | Executives có thể hiểu |
| - ROI projection rõ ràng | 5 | Số liệu cụ thể, timeline, expected outcome |
| - Visual presentation (charts/dashboard) | 5 | Trực quan, dễ đọc |
| **Tổng** | **100 điểm** | |

**Thang điểm:**

| Điểm | Xếp loại | Mô tả |
|------|----------|--------|
| 90–100 | A (Xuất sắc) | Phân tích sâu, ROI tính toán chính xác, plan khả thi, communication xuất sắc |
| 80–89 | B (Giỏi) | Đầy đủ các phần, tính toán đúng, một vài thiếu sót nhỏ |
| 70–79 | C (Khá) | Hoàn thành các yêu cầu cơ bản, thiếu depth ở analysis hoặc communication |
| 60–69 | D (Trung bình) | Thiếu một số phần, tính toán có sai sót, plan chưa khả thi |
| < 60 | F (Chưa đạt) | Thiếu nhiều phần, không demonstrate understanding về technical debt management |

---

## Tài liệu Tham khảo

1. **Ward Cunningham** — "The WyCash Portfolio Management System" (OOPSLA 1992) — Original technical debt metaphor
2. **Martin Fowler** — "Technical Debt Quadrant" (2009) — https://martinfowler.com/bliki/TechnicalDebtQuadrant.html
3. **SonarQube Documentation** — https://docs.sonarqube.org/
4. **SQALE Method** — http://www.sqale.org/ — Software Quality Assessment based on Lifecycle Expectations
5. **Steve McConnell** — "Technical Debt" (2007) — Classification of debt types
6. **Philippe Kruchten et al.** — "Technical Debt: From Metaphor to Theory and Practice" (IEEE Software, 2012)
7. **Bill Curtis et al.** — "Estimating the Principal of an Application's Technical Debt" (IEEE Software, 2012)
