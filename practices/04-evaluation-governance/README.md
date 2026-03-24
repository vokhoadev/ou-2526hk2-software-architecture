# 04 - Evaluation & Governance (Đánh giá & Quản trị)

## Tổng quan

Level 4 tập trung vào kỹ năng đánh giá kiến trúc, fitness functions và governance.

## Thông tin

| Thông tin | Giá trị |
|-----------|---------|
| **Level** | 4 - Intermediate/Advanced |
| **Số Labs** | 8 |
| **Thời lượng** | 28 giờ |
| **CLO đạt được** | CLO1, CLO2, CLO3, CLO4 |

## Danh sách Labs

| Lab | Tên | Thời lượng | Framework/Tool |
|-----|-----|-----------|----------------|
| 4.1 | Quality Attribute Scenarios | 3h | QAS template |
| 4.2 | ATAM Workshop | 5h | ATAM methodology |
| 4.3 | SAAM Analysis | 3h | SAAM methodology |
| 4.4 | Architecture Fitness Functions | 4h | ArchUnit, JDepend |
| 4.5 | Technical Debt Assessment | 3h | SonarQube, CodeClimate |
| 4.6 | Security Architecture Review | 4h | OWASP, Threat Modeling |
| 4.7 | Compliance & Governance | 3h | ISO 27001, SOC2, GDPR |
| 4.8 | Architecture Review Board | 3h | ARB process |

## Mục tiêu Học tập

1. **Evaluate** architecture với ATAM/SAAM
2. **Define** fitness functions tự động
3. **Assess** technical debt
4. **Review** security architecture
5. **Ensure** compliance
6. **Facilitate** Architecture Review Board

## Architecture Evaluation Methods

### ATAM (Architecture Tradeoff Analysis Method)

**Mục đích**: Đánh giá architecture dựa trên quality attributes

**Steps**:
1. Present ATAM
2. Present business drivers
3. Present architecture
4. Identify architectural approaches
5. Generate quality attribute utility tree
6. Analyze architectural approaches
7. Brainstorm and prioritize scenarios
8. Analyze architectural approaches (again)
9. Present results

### SAAM (Software Architecture Analysis Method)

**Mục đích**: Đánh giá modifiability của architecture

**Steps**:
1. Develop scenarios
2. Describe architecture
3. Classify scenarios (direct/indirect)
4. Evaluate indirect scenarios
5. Reveal scenario interaction
6. Overall evaluation

## Fitness Functions

> "An architectural fitness function provides an objective measure of how close an architecture is to achieving an architectural goal." - Neal Ford

**Types**:
- **Atomic**: Single dimension (e.g., cyclomatic complexity)
- **Holistic**: Multiple dimensions (e.g., deployment readiness)
- **Triggered**: Run on specific events
- **Continuous**: Always running

**Examples**:
```java
// ArchUnit - No cycles between packages
@ArchTest
static final ArchRule no_cycles =
 slices().matching("com.example.(*)..").should().beFreeOfCycles();

// ArchUnit - Layer dependencies
@ArchTest
static final ArchRule layer_dependencies =
 layeredArchitecture()
 .layer("Controller").definedBy("..controller..")
 .layer("Service").definedBy("..service..")
 .layer("Repository").definedBy("..repository..")
 .whereLayer("Controller").mayNotBeAccessedByAnyLayer()
 .whereLayer("Service").mayOnlyBeAccessedByLayers("Controller")
 .whereLayer("Repository").mayOnlyBeAccessedByLayers("Service");
```

## Governance

### Architecture Review Board (ARB)

**Responsibilities**:
- Review architectural decisions
- Approve/reject proposals
- Ensure standards compliance
- Maintain architecture roadmap

**Composition**:
- Chief Architect (Chair)
- Domain Architects
- Tech Leads
- Security representative
- Operations representative

### Decision Process
```
Proposal → Review → Discuss → Vote → Document → Communicate
```

## Prerequisite

- Hoàn thành Level 1-3
- Kinh nghiệm thiết kế hệ thống
- Hiểu biết về security basics

## Key Standards

| Standard | Focus | Labs |
|----------|-------|------|
| **ISO 27001** | Information security | 4.7 |
| **SOC 2** | Service organization controls | 4.7 |
| **GDPR** | Data protection | 4.7 |
| **OWASP** | Web application security | 4.6 |
| **ISO/IEC 42010** | Architecture description | 4.8 |
