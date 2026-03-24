# Lab 3.4: arc42 Documentation Template

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 4 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu** | Hoàn thành Lab 3.1-3.3 |

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Giải thích** mục đích và cấu trúc của arc42
2. **Áp dụng** arc42 template vào dự án thực tế
3. **Viết** architecture documentation theo arc42
4. **Customize** arc42 cho nhu cầu cụ thể

---

## Phần 1: arc42 Overview

### 1.1 arc42 là gì?

**arc42** là template tiêu chuẩn cho software architecture documentation:
- Developed by Dr. Gernot Starke & Dr. Peter Hruschka
- Practical, proven structure
- Technology-agnostic
- Free và open-source

### 1.2 12 Sections của arc42

```
┌─────────────────────────────────────────────────────────────┐
│ arc42 │
│ │
│ ┌────────────────────────────────────────────────────────┐ │
│ │ 1. Introduction & Goals │ │
│ │ 2. Constraints │ │
│ │ 3. Context & Scope │ │
│ └────────────────────────────────────────────────────────┘ │
│ WHAT & WHY │
│ ───────────────────────────────────────────────────────── │
│ HOW (Big Picture) │
│ ┌────────────────────────────────────────────────────────┐ │
│ │ 4. Solution Strategy │ │
│ │ 5. Building Block View │ │
│ │ 6. Runtime View │ │
│ │ 7. Deployment View │ │
│ └────────────────────────────────────────────────────────┘ │
│ ───────────────────────────────────────────────────────── │
│ CROSSCUTTING │
│ ┌────────────────────────────────────────────────────────┐ │
│ │ 8. Crosscutting Concepts │ │
│ └────────────────────────────────────────────────────────┘ │
│ ───────────────────────────────────────────────────────── │
│ DECISIONS & QUALITY │
│ ┌────────────────────────────────────────────────────────┐ │
│ │ 9. Architecture Decisions │ │
│ │ 10. Quality Requirements │ │
│ │ 11. Risks & Technical Debt │ │
│ │ 12. Glossary │ │
│ └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

---

## Phần 2: Chi tiết từng Section

### Section 1: Introduction and Goals

**Mục đích:** Set the stage, explain the system

**Nội dung:**
- Requirements Overview
- Quality Goals (Top 3-5)
- Stakeholders

**Template:**

```markdown
## 1. Introduction and Goals

### 1.1 Requirements Overview
[Brief description of the system and its core requirements]

### 1.2 Quality Goals
| Priority | Quality Goal | Description |
|----------|--------------|-------------|
| 1 | | |
| 2 | | |
| 3 | | |

### 1.3 Stakeholders
| Role | Description | Expectations |
|------|-------------|--------------|
| | | |
```

---

### Section 2: Constraints

**Mục đích:** Document các ràng buộc ảnh hưởng đến architecture

**Categories:**
- Technical constraints
- Organizational constraints
- Conventions

**Template:**

```markdown
## 2. Constraints

### Technical Constraints
| Constraint | Description |
|------------|-------------|
| TC-1 | Must run on Linux |
| TC-2 | Must use PostgreSQL |

### Organizational Constraints
| Constraint | Description |
|------------|-------------|
| OC-1 | Team size: 5 developers |
| OC-2 | Budget: $50,000 |

### Conventions
| Convention | Description |
|------------|-------------|
| CV-1 | Code style: Airbnb |
| CV-2 | Documentation: English |
```

---

### Section 3: Context and Scope

**Mục đích:** Big picture - system boundaries

**Includes:**
- Business Context
- Technical Context

```
 ┌─────────────────┐
 User ─────────│ │────── Payment
 │ SYSTEM │
 Admin ─────────│ │────── Email
 │ │
 External ────────│ │────── Analytics
 └─────────────────┘
```

---

### Section 4: Solution Strategy

**Mục đích:** High-level approach

**Includes:**
- Technology decisions
- Architecture patterns
- Organizational decisions

**Template:**

```markdown
## 4. Solution Strategy

| Goal | Approach |
|------|----------|
| High Availability | Active-passive replication |
| Scalability | Horizontal scaling with K8s |
| Security | OAuth2 + mTLS |
| Performance | Redis caching layer |
```

---

### Section 5: Building Block View

**Mục đích:** Static decomposition at different levels

**Levels:**
- Level 1: System context
- Level 2: Containers/Services
- Level 3: Components within containers

```
Level 1: Level 2: Level 3:
┌────────┐ ┌────────┐ ┌────────┐
│ System │ → │Service │ → │Component│
└────────┘ │Service │ │Component│
 │Service │ └────────┘
 └────────┘
```

---

### Section 6: Runtime View

**Mục đích:** Dynamic behavior - how components interact

**Scenarios:**
- Happy path
- Error handling
- Edge cases

**Format:** Sequence diagrams, activity diagrams

---

### Section 7: Deployment View

**Mục đích:** Infrastructure và deployment

**Includes:**
- Infrastructure elements
- Mapping software → hardware
- Network topology

---

### Section 8: Crosscutting Concepts

**Mục đích:** Patterns và solutions áp dụng across system

**Examples:**
- Security concept
- Logging concept
- Error handling
- Data persistence
- UI/UX patterns
- Testing strategy

---

### Section 9-12: Supporting Sections

| Section | Purpose |
|---------|---------|
| **9. Decisions** | Architecture Decision Records |
| **10. Quality Requirements** | Quality scenarios, quality tree |
| **11. Risks** | Technical debt, known issues |
| **12. Glossary** | Domain terminology |

---

## Phần 3: Bài tập Thực hành

### Bài tập 1: arc42 Lite (60 phút)

Create arc42 documentation cho **Task Management App** (Trello-like):

**Scope:** Complete Sections 1-5 only

**Requirements:**
- User registration/login
- Create boards, lists, cards
- Assign members to cards
- Due dates và notifications
- Comments on cards

**Deliverables:**
1. Introduction & Goals (Section 1)
2. Constraints (Section 2)
3. Context Diagram (Section 3)
4. Solution Strategy (Section 4)
5. Building Block View Level 1 & 2 (Section 5)

### Bài tập 2: Runtime Scenarios (40 phút)

Cho hệ thống Task Management ở Bài tập 1:

Create Runtime View (Section 6) cho các scenarios:

1. **User creates a card**
2. **User moves card to another list**
3. **Card due date notification**

**Format:** Sequence diagrams

### Bài tập 3: Crosscutting Concepts (30 phút)

Define Crosscutting Concepts (Section 8) cho:

1. **Authentication & Authorization**
 - How users authenticate
 - How permissions are checked

2. **Error Handling**
 - Error format
 - Logging strategy
 - User-facing messages

3. **Caching Strategy**
 - What to cache
 - Cache invalidation

### Bài tập 4: Complete arc42 (Take-home)

Complete full arc42 documentation cho một dự án:

**Option A:** Extend Task Management from Bài tập 1-3

**Option B:** New project - **Food Delivery Platform**

**Required Sections:** All 12 sections

**Page limit:** 15-20 pages (concise!)

---

## Phần 4: arc42 Best Practices

### Do's [OK]

1. Keep it concise - quality over quantity
2. Use diagrams heavily
3. Update regularly
4. Link to detailed docs (don't duplicate)
5. Focus on "why" not just "what"

### Don'ts [Khong]

1. Don't write a novel
2. Don't include code details
3. Don't let it become stale
4. Don't skip stakeholder section
5. Don't forget glossary

### Tips

| Tip | Description |
|-----|-------------|
| **Start small** | Begin with Sections 1-5, add more later |
| **Use templates** | arc42 provides official templates |
| **Review regularly** | Schedule quarterly reviews |
| **Automate diagrams** | Use Structurizr, PlantUML |

---

## Phần 5: Tools for arc42

| Tool | Description |
|------|-------------|
| **arc42.org** | Official templates (MD, AsciiDoc, Word) |
| **Structurizr** | C4 + arc42 integration |
| **DocToolchain** | Docs-as-code with arc42 |
| **AsciiDoc** | Recommended format |

### Sample Directory Structure

```
docs/
├── arc42/
│ ├── 01-introduction.md
│ ├── 02-constraints.md
│ ├── 03-context.md
│ ├── 04-solution-strategy.md
│ ├── 05-building-blocks.md
│ ├── 06-runtime.md
│ ├── 07-deployment.md
│ ├── 08-concepts.md
│ ├── 09-decisions/
│ │ ├── adr-001-database.md
│ │ └── adr-002-caching.md
│ ├── 10-quality.md
│ ├── 11-risks.md
│ └── 12-glossary.md
├── diagrams/
│ ├── context.puml
│ ├── containers.puml
│ └── deployment.puml
└── arc42.md (combined document)
```

---

## Phần 6: Self-Assessment

### Quiz (10 phút)

1. arc42 có bao nhiêu sections?
 - A) 8
 - B) 10
 - C) 12
 - D) 15

2. Building Block View shows:
 - A) Dynamic behavior
 - B) Static decomposition
 - C) Deployment topology
 - D) Quality requirements

3. Crosscutting Concepts include:
 - A) Business requirements
 - B) User stories
 - C) Security, logging, error handling
 - D) Test cases

4. Section nào chứa Architecture Decision Records?
 - A) Section 4
 - B) Section 8
 - C) Section 9
 - D) Section 11

5. arc42 was created by:
 - A) Martin Fowler
 - B) Gernot Starke & Peter Hruschka
 - C) Simon Brown
 - D) Philippe Kruchten

### Đáp án
1. C | 2. B | 3. C | 4. C | 5. B

### Câu 6-30 (Trung bình → Nâng cao)

6. arc42 là gì?
7. arc42 có bao nhiêu sections?
8. Section 1: Introduction là gì?
9. Section 2: Constraints là gì?
10. Section 3: Context là gì?
11. Section 4: Solution Strategy là gì?
12. Section 5: Building Block View là gì?
13. Section 6: Runtime View là gì?
14. Section 7: Deployment View là gì?
15. Section 8: Crosscutting Concepts là gì?
16. Section 9: Architecture Decisions là gì?
17. Section 10: Quality Requirements là gì?
18. Section 11: Risks và Technical Debt là gì?
19. Section 12: Glossary là gì?
20. arc42 templates có những formats nào?
21. arc42 vs C4 Model?
22. arc42 vs IEEE 42010?
23. arc42 tools?
24. arc42 trong Agile?
25. arc42 maintenance?
26. arc42 best practices?
27. arc42 anti-patterns?
28. arc42 lite là gì?
29. DocToolchain là gì?
30. arc42 cho microservices?

**Đáp án gợi ý:**
- 6: Template cho architecture documentation
- 7: 12 sections
- 5: Created by Gernot Starke & Peter Hruschka

---

## Extend Labs (10 bài)

### EL1: Complete arc42
```
Mục tiêu: Full documentation
- All 12 sections
- Real project
- 20+ pages
Độ khó: ****
```

### EL2: arc42 Automation
```
Mục tiêu: Doc as code
- DocToolchain
- CI/CD generation
- Version control
Độ khó: ****
```

### EL3: Microservices arc42
```
Mục tiêu: Distributed
- Service documentation
- Integration overview
- Deployment complexity
Độ khó: ****
```

### EL4: arc42 Review
```
Mục tiêu: Quality
- Completeness check
- Consistency review
- Improvement plan
Độ khó: ***
```

### EL5: Living arc42
```
Mục tiêu: Always current
- Update process
- Automated checks
- Review schedule
Độ khó: ****
```

### EL6: arc42 Lite
```
Mục tiêu: Minimal docs
- Essential sections
- Quick start
- Incremental detail
Độ khó: **
```

### EL7: Stakeholder arc42
```
Mục tiêu: Tailored views
- Executive summary
- Technical details
- Operator guide
Độ khó: ***
```

### EL8: arc42 + ADRs
```
Mục tiêu: Decision tracking
- Integrated ADRs
- Decision history
- Traceability
Độ khó: ***
```

### EL9: arc42 Migration
```
Mục tiêu: Document existing
- Capture current state
- Fill gaps
- Improve over time
Độ khó: ****
```

### EL10: arc42 Training
```
Mục tiêu: Team capability
- Training materials
- Examples
- Templates
Độ khó: ***
```

---

## Deliverables

- [ ] arc42 Lite Sections 1-5 (Bài tập 1)
- [ ] Runtime View với 3 scenarios (Bài tập 2)
- [ ] Crosscutting Concepts document (Bài tập 3)
- [ ] Complete arc42 (Bài tập 4 - take-home)

---

## Tài liệu Tham khảo

1. [arc42 Official Website](https://arc42.org/)
2. [arc42 Templates](https://arc42.org/download)
3. **Gernot Starke** - "Effective Software Architectures"
4. [DocToolchain](https://doctoolchain.org/)

---

## Phân bổ Thời gian: Lý thuyết 30', Thực hành vẽ diagram 90', Review 30', Mở rộng 30' = 3 giờ

## Lời giải Mẫu
- Sử dụng notation chuẩn (UML, C4, ArchiMate)
- Diagram phải có legend và description
- Phù hợp với audience (technical/business)

## Các Lỗi Thường Gặp
| Lỗi | Cách sửa |
|-----|----------|
| Quá chi tiết hoặc quá sơ sài | Chọn level phù hợp |
| Không có legend | Thêm chú thích ký hiệu |
| Outdated diagrams | Living documentation |

## Chấm điểm: Đúng notation 30, Rõ ràng 25, Đầy đủ 25, Aesthetic 20 = 100

## Tham khảo: CMU SEI, C4 Model (Simon Brown), arc42, IEEE 42010, ĐH Bách Khoa
