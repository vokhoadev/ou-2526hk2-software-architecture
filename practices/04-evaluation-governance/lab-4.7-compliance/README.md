# Lab 4.7: Architecture Compliance & Standards

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu trước** | Hoàn thành Lab 4.1 (Architecture Evaluation Methods), Lab 4.2 (Quality Attributes Analysis) |
| **Công cụ** | Java 11+ / .NET 6+, IDE (IntelliJ / VS Code), Maven / NuGet |
| **Chủ đề chính** | Compliance Checking, ArchUnit / NetArchTest, Fitness Functions, ADR, ARB |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Định nghĩa và giải thích** khái niệm Architecture Compliance, phân biệt với regulatory compliance, và mô tả vai trò của compliance trong vòng đời phần mềm
2. **Xây dựng** compliance checklist ánh xạ từ yêu cầu kiến trúc đến quyết định thiết kế (architecture decisions), sử dụng ADR làm bằng chứng tuân thủ
3. **Viết và chạy** automated architecture rules bằng ArchUnit (Java) hoặc NetArchTest (.NET) để kiểm tra tự động các ràng buộc kiến trúc
4. **Thiết kế** fitness functions để liên tục xác minh các architecture constraints trong CI/CD pipeline
5. **Mô phỏng** quy trình Architecture Review Board (ARB) với vai trò, checklist và governance workflow hoàn chỉnh

---

## Phân bổ Thời gian

| Giai đoạn | Nội dung | Thời lượng |
|-----------|----------|------------|
| **Lý thuyết** | Architecture Compliance, ISO/IEC 42010, Compliance methods | 35 phút |
| **Lab 1** | Compliance Checklist — ánh xạ requirements → decisions | 30 phút |
| **Lab 2** | Automated Compliance với ArchUnit / NetArchTest | 40 phút |
| **Lab 3** | Fitness Functions — viết automated tests cho constraints | 30 phút |
| **Lab 4** | Architecture Review Board Simulation (role-play) | 25 phút |
| **Self-Assessment** | Trả lời câu hỏi tự đánh giá | 10 phút |
| **Tổng kết & Review** | Thảo luận, nộp deliverables | 10 phút |
| **Tổng cộng** | | **3 giờ** |

---

## Lý thuyết

### 1. Architecture Compliance là gì?

**Architecture Compliance** là mức độ mà hiện thực hóa (implementation) của hệ thống tuân thủ đúng với kiến trúc đã được thiết kế và phê duyệt. Nói cách khác, đó là việc đảm bảo rằng code thực tế phản ánh đúng các quyết định kiến trúc đã được đưa ra.

```
┌──────────────────────────────────────────────────────────────────┐
│ ARCHITECTURE COMPLIANCE SPECTRUM │
│ │
│ Designed Implemented Compliant? │
│ Architecture ──→ Source Code ──→ x hoặc X │
│ │
│ ┌─────────┐ ┌──────────┐ ┌────────────────────┐ │
│ │ Layered │────│ Code có │────│ Layer rules OK? │ │
│ │ Style │ │ packages │ │ Dependency rules? │ │
│ └─────────┘ └──────────┘ └────────────────────┘ │
│ │
│ ┌─────────┐ ┌──────────┐ ┌────────────────────┐ │
│ │ Domain │────│ Modules │────│ Domain isolation? │ │
│ │ Model │ │ & APIs │ │ No cyclic deps? │ │
│ └─────────┘ └──────────┘ └────────────────────┘ │
└──────────────────────────────────────────────────────────────────┘
```

**Phân biệt quan trọng:**

| Khái niệm | Phạm vi | Ví dụ |
|------------|---------|-------|
| **Architecture Compliance** | Tuân thủ kiến trúc nội bộ | Layer dependencies, naming conventions |
| **Regulatory Compliance** | Tuân thủ quy định pháp lý | GDPR, PCI DSS, HIPAA |
| **Standards Compliance** | Tuân thủ tiêu chuẩn kỹ thuật | ISO/IEC 42010, ISO 27001 |

### 2. ISO/IEC 42010 — Architecture Description

ISO/IEC 42010 là tiêu chuẩn quốc tế về mô tả kiến trúc phần mềm. Tiêu chuẩn này định nghĩa:

- **Architecture Description (AD)**: tài liệu mô tả kiến trúc
- **Stakeholder**: bên liên quan có quan tâm đến hệ thống
- **Concern**: mối quan tâm của stakeholder (performance, security, maintainability...)
- **Viewpoint**: góc nhìn để address một tập concerns
- **View**: thể hiện cụ thể của architecture từ một viewpoint
- **Architecture Decision**: quyết định kiến trúc có ảnh hưởng đến cấu trúc hệ thống

```
┌─────────────────────────────────────────────────────────────┐
│ ISO/IEC 42010 Framework │
│ │
│ System ──has── Architecture │
│ │ │
│ described by │
│ ▼ │
│ Architecture Description │
│ / | \ │
│ Viewpoint Decision Rationale │
│ │ │ │ │
│ View ADR Record Why & Trade-offs │
│ │ │
│ Addresses Concern ── Stakeholder │
└─────────────────────────────────────────────────────────────┘
```

### 3. Compliance Checking Methods

#### 3.1 Manual Review

| Phương pháp | Mô tả | Ưu điểm | Nhược điểm |
|-------------|--------|----------|------------|
| **Peer Review** | Đánh giá chéo giữa architects | Phát hiện sai sót logic | Tốn thời gian, chủ quan |
| **Architecture Walkthrough** | Duyệt qua từng view với stakeholders | Toàn diện | Khó lặp lại thường xuyên |
| **Checklist-based Review** | Sử dụng danh sách kiểm tra có cấu trúc | Nhất quán, có thể lặp lại | Có thể bỏ sót điều không có trong checklist |

#### 3.2 Automated Tools

| Tool | Ngôn ngữ | Chức năng chính |
|------|----------|-----------------|
| **ArchUnit** | Java | Kiểm tra dependency rules, layer rules, naming conventions |
| **NetArchTest** | .NET / C# | Tương tự ArchUnit cho hệ sinh thái .NET |
| **Dependency-Check** | Multi | Phát hiện vulnerable dependencies |
| **SonarQube** | Multi | Code quality + architecture metrics |
| **Structure101** | Java | Dependency visualization & enforcement |

#### 3.3 Fitness Functions

Fitness function là automated test liên tục kiểm tra một đặc tính kiến trúc (architecture characteristic). Chúng chạy trong CI/CD pipeline để đảm bảo mỗi thay đổi không vi phạm constraints.

```
┌───────────────────────────────────────────────────────────────┐
│ FITNESS FUNCTION CATEGORIES │
│ │
│ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ │
│ │ Structural │ │ Operational │ │ Process │ │
│ │ │ │ │ │ │ │
│ │ - Layer deps │ │ - Latency │ │ - Code │ │
│ │ - Cycles │ │ - Throughput │ │ coverage │ │
│ │ - Coupling │ │ - Uptime │ │ - Review │ │
│ │ - Naming │ │ - Error rate │ │ approval │ │
│ └──────────────┘ └──────────────┘ └──────────────┘ │
│ │
│ Execution: CI/CD Pipeline, mỗi commit │
│ Result: Pass x / Fail X → block merge nếu fail │
└───────────────────────────────────────────────────────────────┘
```

### 4. Architecture Decision Records (ADR) — Bằng chứng Compliance

ADR ghi lại các quyết định kiến trúc quan trọng. Mỗi ADR là bằng chứng cho thấy quyết định đã được cân nhắc kỹ lưỡng, có rationale rõ ràng.

**Template ADR chuẩn (Michael Nygard format):**

```markdown
# ADR-{NNN}: {Tiêu đề quyết định}

## Status
Proposed | Accepted | Deprecated | Superseded by ADR-XXX

## Context
Mô tả bối cảnh, vấn đề cần giải quyết, các forces tác động.

## Decision
Quyết định được đưa ra. Viết dạng khẳng định: "Chúng tôi sẽ..."

## Consequences
- Positive: lợi ích đạt được
- Negative: trade-off phải chấp nhận
- Neutral: ảnh hưởng trung tính

## Compliance
- [ ] Reviewed by Architecture Review Board
- [ ] Fitness function created
- [ ] Automated test implemented
```

**Ví dụ cụ thể:**

```markdown
# ADR-005: Sử dụng Layered Architecture cho Order Service

## Status
Accepted

## Context
Order Service cần tách biệt business logic khỏi infrastructure concerns.
Team có kinh nghiệm với layered pattern. Cần đảm bảo testability.

## Decision
Sử dụng 4-layer architecture:
- Presentation Layer (Controllers)
- Application Layer (Services)
- Domain Layer (Entities, Value Objects)
- Infrastructure Layer (Repositories, External APIs)

Dependency rule: layers chỉ được phụ thuộc vào layer bên dưới.
Domain Layer không phụ thuộc vào bất kỳ layer nào khác.

## Consequences
- Positive: Tách biệt rõ ràng, dễ test, dễ maintain
- Negative: Có thể verbose hơn so với simple CRUD
- Neutral: Team cần tuân thủ strict dependency rules

## Compliance
- [x] Reviewed by Architecture Review Board (2024-01-15)
- [x] ArchUnit tests for layer dependencies created
- [x] CI/CD pipeline enforces rules on every PR
```

### 5. Governance Process

Architecture Governance là tập hợp các quy trình, cấu trúc tổ chức và công cụ đảm bảo rằng các quyết định kiến trúc được tuân thủ xuyên suốt vòng đời phần mềm.

```
┌──────────────────────────────────────────────────────────────┐
│ ARCHITECTURE GOVERNANCE PROCESS │
│ │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────┐ │
│ │ Propose │───│ Review │───│ Approve │───│ Monitor│ │
│ │ Change │ │ by ARB │ │ or Reject│ │ & Audit│ │
│ └──────────┘ └──────────┘ └──────────┘ └────────┘ │
│ │ │ │ │ │
│ ADR Draft Checklist Decision Log Fitness │
│ Impact Anal. Review Updated ADR Functions │
│ Scoring Communicated Dashboards │
└──────────────────────────────────────────────────────────────┘
```

**Governance workflow chi tiết:**

1. **Propose**: Developer/Architect đề xuất thay đổi kiến trúc, viết ADR draft
2. **Impact Analysis**: Đánh giá ảnh hưởng đến các hệ thống liên quan
3. **ARB Review**: Architecture Review Board đánh giá đề xuất
4. **Decision**: Approve / Reject / Request Changes
5. **Implementation**: Thực hiện thay đổi theo quyết định đã phê duyệt
6. **Verification**: Fitness functions + automated tests xác minh compliance
7. **Monitor**: Liên tục theo dõi, audit định kỳ

### 6. Architecture Review Board (ARB)

ARB là nhóm chịu trách nhiệm đánh giá và phê duyệt các quyết định kiến trúc quan trọng.

**Thành phần ARB điển hình:**

| Vai trò | Trách nhiệm | Số lượng |
|---------|-------------|----------|
| **Chief Architect** (Chair) | Điều hành cuộc họp, quyết định cuối cùng | 1 |
| **Domain Architect** | Đại diện cho domain expertise | 1-2 |
| **Tech Lead** | Đánh giá tính khả thi kỹ thuật | 1-2 |
| **Security Architect** | Đánh giá rủi ro bảo mật | 1 |
| **QA Lead** | Đánh giá testability | 1 |
| **Product Owner** (Observer) | Cung cấp context nghiệp vụ | 1 |

**ARB Review Checklist:**

```
┌─────────────────────────────────────────────────────────────┐
│ ARB REVIEW CHECKLIST │
│ │
│ □ 1. ADR đầy đủ (Context, Decision, Consequences)? │
│ □ 2. Alignment với architecture principles? │
│ □ 3. Impact analysis hoàn chỉnh? │
│ □ 4. Security review passed? │
│ □ 5. Performance impact đánh giá? │
│ □ 6. Scalability concerns addressed? │
│ □ 7. Backward compatibility đảm bảo? │
│ □ 8. Fitness functions defined? │
│ □ 9. Migration plan (nếu cần)? │
│ □ 10. Stakeholders đã được thông báo? │
│ │
│ Score: ___/10 Decision: Approve / Reject / Revise │
└─────────────────────────────────────────────────────────────┘
```

### 7. Compliance Metrics & KPIs

| Metric | Mô tả | Target | Cách đo |
|--------|--------|--------|---------|
| **Compliance Rate** | % architecture rules được tuân thủ | ≥ 95% | ArchUnit/NetArchTest reports |
| **ADR Coverage** | % quyết định quan trọng có ADR | 100% | Manual audit |
| **Fitness Function Pass Rate** | % fitness functions pass trong CI | ≥ 98% | CI/CD dashboard |
| **Architecture Debt Ratio** | % violations / total rules | ≤ 5% | Automated scanning |
| **Review Cycle Time** | Thời gian trung bình để ARB review | ≤ 5 ngày | Process tracking |
| **Deviation Count** | Số lần vi phạm kiến trúc/tháng | Trending ↓ | Monthly report |
| **Mean Time to Remediate** | Thời gian sửa violation | ≤ 2 sprints | Issue tracking |

---

## Step-by-step Labs

### Lab 1: Tạo Compliance Checklist (30 phút)

**Mục tiêu**: Xây dựng compliance checklist ánh xạ yêu cầu kiến trúc đến quyết định thiết kế.

**Scenario**: Hệ thống **Order Management System** sử dụng Layered Architecture với các yêu cầu sau:
- Tách biệt presentation, business logic, data access
- Domain layer không phụ thuộc infrastructure
- Mọi external call phải qua adapter pattern
- Logging tập trung, không dùng `System.out.println`
- Naming conventions: Controllers kết thúc bằng `Controller`, Services bằng `Service`

#### Bước 1: Liệt kê Architecture Principles

Điền vào bảng sau:

| # | Architecture Principle | Mô tả | Nguồn gốc |
|---|----------------------|-------|------------|
| AP-1 | Separation of Concerns | Mỗi layer có trách nhiệm riêng biệt | Clean Architecture |
| AP-2 | Dependency Inversion | High-level modules không phụ thuộc low-level | SOLID Principles |
| AP-3 | Infrastructure Isolation | Domain không biết về infrastructure | Hexagonal Architecture |
| AP-4 | Centralized Logging | Sử dụng logging framework thống nhất | Operational Excellence |
| AP-5 | Consistent Naming | Tuân thủ naming conventions đã thống nhất | Team Convention |

#### Bước 2: Ánh xạ Principles → Architecture Decisions

Hoàn thành bảng:

| Principle | Architecture Decision | ADR # | Compliance Method |
|-----------|----------------------|-------|-------------------|
| AP-1 | 4-layer architecture (Presentation → Application → Domain → Infrastructure) | ADR-001 | ArchUnit layer test |
| AP-2 | Sử dụng interfaces cho cross-layer communication | ADR-002 | ArchUnit dependency test |
| AP-3 | Domain entities không import infrastructure packages | ADR-003 | ArchUnit package test |
| AP-4 | Sử dụng SLF4J + Logback, cấm `System.out` | ADR-004 | ArchUnit class usage test |
| AP-5 | `*Controller`, `*Service`, `*Repository` naming | ADR-005 | ArchUnit naming test |

#### Bước 3: Tạo Compliance Checklist hoàn chỉnh

```markdown
# COMPLIANCE CHECKLIST — Order Management System
# Version: 1.0 | Date: {ngày hiện tại} | Author: {tên}

## 1. Layer Dependencies
- [ ] Controllers chỉ gọi Application Services
- [ ] Application Services chỉ gọi Domain Services hoặc Repositories
- [ ] Domain Layer không import bất kỳ package nào từ Infrastructure
- [ ] Infrastructure Layer implement interfaces được định nghĩa ở Domain

## 2. Package Structure
- [ ] com.example.order.presentation — chứa Controllers, DTOs
- [ ] com.example.order.application — chứa Application Services
- [ ] com.example.order.domain — chứa Entities, Value Objects, Domain Services
- [ ] com.example.order.infrastructure — chứa Repository Impl, API Clients

## 3. Naming Conventions
- [ ] Tất cả REST controllers kết thúc bằng "Controller"
- [ ] Tất cả application services kết thúc bằng "Service"
- [ ] Tất cả repository interfaces kết thúc bằng "Repository"
- [ ] Tất cả DTOs kết thúc bằng "Dto" hoặc "Request"/"Response"

## 4. Cross-cutting Concerns
- [ ] Logging sử dụng SLF4J, KHÔNG dùng System.out/System.err
- [ ] Exception handling tập trung qua @ControllerAdvice
- [ ] Không có circular dependencies giữa packages

## 5. ADR Coverage
- [ ] Mỗi quyết định kiến trúc quan trọng có ADR tương ứng
- [ ] ADR status được cập nhật (Proposed/Accepted/Deprecated)
- [ ] ADR có compliance section với fitness function reference

## Sign-off
- [ ] Reviewed by: __________ Date: __________
- [ ] Approved by: __________ Date: __________
```

#### Bước 4: Đánh giá Gap Analysis

Với một codebase mẫu (hoặc project của bạn), kiểm tra từng mục trong checklist và ghi nhận kết quả:

| Checklist Item | Status | Gap Description | Remediation | Priority |
|----------------|--------|-----------------|-------------|----------|
| Layer Dependencies | X FAIL | Controller gọi trực tiếp Repository | Refactor qua Service layer | High |
| Domain isolation | x PASS | — | — | — |
| Naming conventions | X FAIL | 3 classes thiếu suffix | Rename theo convention | Medium |
| Logging | X FAIL | 12 chỗ dùng System.out | Thay bằng Logger | Medium |

---

### Lab 2: Automated Compliance với ArchUnit / NetArchTest (40 phút)

**Mục tiêu**: Viết và chạy tối thiểu 10 architecture rules tự động.

#### Option A: Java — ArchUnit

**Setup Maven `pom.xml`:**

```xml
<dependency>
 <groupId>com.tngtech.archunit</groupId>
 <artifactId>archunit-junit5</artifactId>
 <version>1.2.1</version>
 <scope>test</scope>
</dependency>
```

**File test: `ArchitectureComplianceTest.java`**

```java
package com.example.order;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.lang.ArchRule;
import com.tngtech.archunit.library.Architectures;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.*;
import static com.tngtech.archunit.library.Architectures.layeredArchitecture;
import static com.tngtech.archunit.library.dependencies.SlicesRuleDefinition.slices;

class ArchitectureComplianceTest {

 private static JavaClasses classes;

 @BeforeAll
 static void setup() {
 classes = new ClassFileImporter()
 .importPackages("com.example.order");
 }

 // Rule 1: Layer dependency — Presentation chỉ access Application
 @Test
 void layerDependenciesMustBeRespected() {
 ArchRule rule = layeredArchitecture()
 .consideringAllDependencies()
 .layer("Presentation").definedBy("..presentation..")
 .layer("Application").definedBy("..application..")
 .layer("Domain").definedBy("..domain..")
 .layer("Infrastructure").definedBy("..infrastructure..")
 .whereLayer("Presentation").mayOnlyAccessLayers("Application")
 .whereLayer("Application").mayOnlyAccessLayers("Domain")
 .whereLayer("Infrastructure").mayOnlyAccessLayers("Domain")
 .whereLayer("Domain").mayNotAccessAnyLayer();

 rule.check(classes);
 }

 // Rule 2: Controllers phải nằm trong package presentation
 @Test
 void controllersMustResideInPresentationLayer() {
 ArchRule rule = classes()
 .that().haveSimpleNameEndingWith("Controller")
 .should().resideInAPackage("..presentation..");

 rule.check(classes);
 }

 // Rule 3: Services phải nằm trong package application
 @Test
 void servicesMustResideInApplicationLayer() {
 ArchRule rule = classes()
 .that().haveSimpleNameEndingWith("Service")
 .and().areNotInterfaces()
 .should().resideInAPackage("..application..");

 rule.check(classes);
 }

 // Rule 4: Repository interfaces phải nằm trong domain
 @Test
 void repositoryInterfacesMustResideInDomain() {
 ArchRule rule = classes()
 .that().haveSimpleNameEndingWith("Repository")
 .and().areInterfaces()
 .should().resideInAPackage("..domain..");

 rule.check(classes);
 }

 // Rule 5: Domain không được import infrastructure packages
 @Test
 void domainMustNotDependOnInfrastructure() {
 ArchRule rule = noClasses()
 .that().resideInAPackage("..domain..")
 .should().dependOnClassesThat()
 .resideInAPackage("..infrastructure..");

 rule.check(classes);
 }

 // Rule 6: Domain không được import Spring Framework
 @Test
 void domainMustNotUseSpringFramework() {
 ArchRule rule = noClasses()
 .that().resideInAPackage("..domain..")
 .should().dependOnClassesThat()
 .resideInAPackage("org.springframework..");

 rule.check(classes);
 }

 // Rule 7: Không dùng System.out trong production code
 @Test
 void noSystemOutUsage() {
 ArchRule rule = noClasses()
 .should().accessClassesThat()
 .belongToAnyOf(System.class)
 .as("Production code should use SLF4J, not System.out");

 rule.check(classes);
 }

 // Rule 8: Controllers phải annotated với @RestController
 @Test
 void controllersMustBeAnnotatedWithRestController() {
 ArchRule rule = classes()
 .that().haveSimpleNameEndingWith("Controller")
 .should().beAnnotatedWith(
 org.springframework.web.bind.annotation.RestController.class
 );

 rule.check(classes);
 }

 // Rule 9: Không có circular dependencies giữa packages
 @Test
 void noCircularDependenciesBetweenPackages() {
 ArchRule rule = slices()
 .matching("com.example.order.(*)..")
 .should().beFreeOfCycles();

 rule.check(classes);
 }

 // Rule 10: Entities phải có default constructor
 @Test
 void entitiesMustHaveDefaultConstructor() {
 ArchRule rule = classes()
 .that().resideInAPackage("..domain..")
 .and().haveSimpleNameNotEndingWith("Service")
 .and().haveSimpleNameNotEndingWith("Repository")
 .and().areNotInterfaces()
 .should().haveOnlyFinalFields()
 .orShould().haveModifier(
 com.tngtech.archunit.core.domain.JavaModifier.PUBLIC
 );

 rule.check(classes);
 }

 // Rule 11: DTOs phải nằm trong presentation package
 @Test
 void dtosMustResideInPresentation() {
 ArchRule rule = classes()
 .that().haveSimpleNameEndingWith("Dto")
 .or().haveSimpleNameEndingWith("Request")
 .or().haveSimpleNameEndingWith("Response")
 .should().resideInAPackage("..presentation..");

 rule.check(classes);
 }

 // Rule 12: Tất cả public methods trong Controller phải return ResponseEntity
 @Test
 void controllerMethodsMustReturnResponseEntity() {
 ArchRule rule = methods()
 .that().areDeclaredInClassesThat()
 .haveSimpleNameEndingWith("Controller")
 .and().arePublic()
 .should().haveRawReturnType(
 org.springframework.http.ResponseEntity.class
 );

 rule.check(classes);
 }
}
```

**Chạy tests:**

```bash
mvn test -Dtest=ArchitectureComplianceTest
```

#### Option B: C# — NetArchTest

**Setup NuGet:**

```bash
dotnet add package NetArchTest.Rules --version 1.3.2
```

**File test: `ArchitectureComplianceTests.cs`**

```csharp
using NetArchTest.Rules;
using Xunit;

namespace OrderManagement.Tests.Architecture
{
 public class ArchitectureComplianceTests
 {
 private const string PresentationNamespace = "OrderManagement.Presentation";
 private const string ApplicationNamespace = "OrderManagement.Application";
 private const string DomainNamespace = "OrderManagement.Domain";
 private const string InfrastructureNamespace = "OrderManagement.Infrastructure";

 // Rule 1: Domain không phụ thuộc Infrastructure
 [Fact]
 public void Domain_ShouldNot_DependOn_Infrastructure()
 {
 var result = Types.InAssembly(typeof(Domain.Order).Assembly)
 .That().ResideInNamespace(DomainNamespace)
 .ShouldNot().HaveDependencyOn(InfrastructureNamespace)
 .GetResult();

 Assert.True(result.IsSuccessful,
 "Domain layer must not depend on Infrastructure layer");
 }

 // Rule 2: Domain không phụ thuộc Presentation
 [Fact]
 public void Domain_ShouldNot_DependOn_Presentation()
 {
 var result = Types.InAssembly(typeof(Domain.Order).Assembly)
 .That().ResideInNamespace(DomainNamespace)
 .ShouldNot().HaveDependencyOn(PresentationNamespace)
 .GetResult();

 Assert.True(result.IsSuccessful);
 }

 // Rule 3: Application không phụ thuộc Presentation
 [Fact]
 public void Application_ShouldNot_DependOn_Presentation()
 {
 var result = Types.InAssembly(typeof(Application.OrderService).Assembly)
 .That().ResideInNamespace(ApplicationNamespace)
 .ShouldNot().HaveDependencyOn(PresentationNamespace)
 .GetResult();

 Assert.True(result.IsSuccessful);
 }

 // Rule 4: Controllers phải kết thúc bằng "Controller"
 [Fact]
 public void Controllers_ShouldHave_ControllerSuffix()
 {
 var result = Types.InAssembly(typeof(Presentation.OrderController).Assembly)
 .That().ResideInNamespace(PresentationNamespace)
 .And().AreClasses()
 .And().Inherit(typeof(Microsoft.AspNetCore.Mvc.ControllerBase))
 .Should().HaveNameEndingWith("Controller")
 .GetResult();

 Assert.True(result.IsSuccessful);
 }

 // Rule 5: Services phải kết thúc bằng "Service"
 [Fact]
 public void Services_ShouldHave_ServiceSuffix()
 {
 var result = Types.InAssembly(typeof(Application.OrderService).Assembly)
 .That().ResideInNamespace(ApplicationNamespace)
 .And().AreClasses()
 .Should().HaveNameEndingWith("Service")
 .GetResult();

 Assert.True(result.IsSuccessful);
 }

 // Rule 6: Repositories phải là interfaces trong Domain
 [Fact]
 public void RepositoryInterfaces_ShouldResideIn_Domain()
 {
 var result = Types.InAssembly(typeof(Domain.Order).Assembly)
 .That().HaveNameEndingWith("Repository")
 .And().AreInterfaces()
 .Should().ResideInNamespace(DomainNamespace)
 .GetResult();

 Assert.True(result.IsSuccessful);
 }

 // Rule 7: Domain classes phải sealed hoặc abstract
 [Fact]
 public void DomainClasses_ShouldBe_SealedOrAbstract()
 {
 var result = Types.InAssembly(typeof(Domain.Order).Assembly)
 .That().ResideInNamespace(DomainNamespace)
 .And().AreClasses()
 .And().AreNotAbstract()
 .Should().BeSealed()
 .GetResult();

 Assert.True(result.IsSuccessful);
 }

 // Rule 8: Không có circular dependencies
 [Fact]
 public void NoCircularDependencies_BetweenLayers()
 {
 var domainDependsOnApp = Types.InAssembly(typeof(Domain.Order).Assembly)
 .That().ResideInNamespace(DomainNamespace)
 .ShouldNot().HaveDependencyOn(ApplicationNamespace)
 .GetResult();

 Assert.True(domainDependsOnApp.IsSuccessful,
 "Circular dependency detected: Domain → Application");
 }

 // Rule 9: Infrastructure phải implement domain interfaces
 [Fact]
 public void Infrastructure_ShouldImplement_DomainInterfaces()
 {
 var result = Types.InAssembly(typeof(Infrastructure.OrderRepository).Assembly)
 .That().ResideInNamespace(InfrastructureNamespace)
 .And().HaveNameEndingWith("Repository")
 .And().AreClasses()
 .Should().ImplementInterface(typeof(Domain.IOrderRepository))
 .GetResult();

 Assert.True(result.IsSuccessful);
 }

 // Rule 10: DTOs phải nằm trong Presentation
 [Fact]
 public void Dtos_ShouldResideIn_Presentation()
 {
 var result = Types.InAssembly(typeof(Presentation.OrderController).Assembly)
 .That().HaveNameEndingWith("Dto")
 .Should().ResideInNamespace(PresentationNamespace)
 .GetResult();

 Assert.True(result.IsSuccessful);
 }
 }
}
```

**Chạy tests:**

```bash
dotnet test --filter "FullyQualifiedName~ArchitectureComplianceTests"
```

---

### Lab 3: Fitness Functions (30 phút)

**Mục tiêu**: Viết automated tests xác minh architecture constraints, chạy trong CI/CD.

#### Fitness Function 1: Component Coupling (Java)

```java
import com.tngtech.archunit.library.metrics.ArchitectureMetrics;
import com.tngtech.archunit.library.metrics.MetricsComponents;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

class CouplingFitnessTest {

 @Test
 void componentCouplingMustBeBelowThreshold() {
 JavaClasses classes = new ClassFileImporter()
 .importPackages("com.example.order");

 MetricsComponents components = MetricsComponents.fromPackages(
 classes.getPackage("com.example.order").getSubpackages()
 );

 var metrics = ArchitectureMetrics.componentDependencyMetrics(components);

 for (var component : metrics.getComponentMetrics()) {
 double instability = component.getInstability();
 assertTrue(instability <= 0.8,
 "Component " + component.getName() +
 " has instability " + instability + " (max 0.8)");
 }
 }
}
```

#### Fitness Function 2: Dependency Count Limit

```java
@Test
void eachClassShouldHaveLimitedDependencies() {
 ArchRule rule = classes()
 .that().resideInAPackage("com.example.order..")
 .should(new ArchCondition<JavaClass>("have at most 10 dependencies") {
 @Override
 public void check(JavaClass javaClass, ConditionEvents events) {
 int depCount = javaClass.getDirectDependenciesFromSelf().size();
 if (depCount > 10) {
 events.add(SimpleConditionEvent.violated(
 javaClass,
 javaClass.getName() + " has " + depCount +
 " dependencies (max 10)"));
 }
 }
 });

 rule.check(classes);
}
```

#### Fitness Function 3: API Response Time (Integration Test)

```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class PerformanceFitnessTest {

 @Autowired
 private TestRestTemplate restTemplate;

 @Test
 void apiResponseTimeMustBeBelow200ms() {
 long start = System.currentTimeMillis();
 ResponseEntity<String> response = restTemplate
 .getForEntity("/api/orders", String.class);
 long elapsed = System.currentTimeMillis() - start;

 assertEquals(200, response.getStatusCode().value());
 assertTrue(elapsed < 200,
 "API response time " + elapsed + "ms exceeds 200ms threshold");
 }
}
```

#### Fitness Function 4: Code Size per Module

```java
@Test
void moduleSizeMustBeBelowThreshold() {
 JavaClasses classes = new ClassFileImporter()
 .importPackages("com.example.order");

 Map<String, Long> packageSizes = classes.stream()
 .collect(Collectors.groupingBy(
 c -> c.getPackageName(),
 Collectors.counting()
 ));

 packageSizes.forEach((pkg, count) -> {
 assertTrue(count <= 30,
 "Package " + pkg + " has " + count +
 " classes (max 30). Consider splitting.");
 });
}
```

#### CI/CD Integration (GitHub Actions)

```yaml
name: Architecture Compliance

on: [push, pull_request]

jobs:
 architecture-check:
 runs-on: ubuntu-latest
 steps:
 - uses: actions/checkout@v4

 - name: Set up JDK 17
 uses: actions/setup-java@v4
 with:
 java-version: '17'
 distribution: 'temurin'

 - name: Run Architecture Tests
 run: mvn test -Dtest="*ComplianceTest,*FitnessTest"

 - name: Publish Test Results
 if: always()
 uses: dorny/test-reporter@v1
 with:
 name: Architecture Compliance Results
 path: target/surefire-reports/*.xml
 reporter: java-junit
```

---

### Lab 4: Architecture Review Board Simulation (25 phút)

**Mục tiêu**: Mô phỏng phiên họp ARB với role-play.

#### Scenario

Team đề xuất thay đổi: **Chuyển Order Service từ Monolith sang Microservices**.

#### Phân vai (nhóm 5-6 người)

| Vai trò | Người đảm nhận | Nhiệm vụ trong phiên |
|---------|----------------|----------------------|
| **Chief Architect** (Chair) | Sinh viên A | Điều hành, tổng kết, quyết định |
| **Proposer** (Architect) | Sinh viên B | Trình bày ADR, trả lời câu hỏi |
| **Domain Expert** | Sinh viên C | Đặt câu hỏi về domain impact |
| **Security Reviewer** | Sinh viên D | Đặt câu hỏi về security concerns |
| **QA Representative** | Sinh viên E | Đặt câu hỏi về testability |
| **Scribe** (Secretary) | Sinh viên F | Ghi chép minutes, quyết định |

#### Quy trình phiên họp (25 phút)

**Phase 1 — Presentation (7 phút)**
- Proposer trình bày ADR cho đề xuất thay đổi
- Sử dụng ADR template ở phần lý thuyết

**Phase 2 — Q&A và Challenge (10 phút)**
- Mỗi reviewer đặt ít nhất 2 câu hỏi từ perspective của mình
- Proposer trả lời hoặc ghi nhận cần bổ sung

**Phase 3 — Scoring & Decision (5 phút)**
- Mỗi reviewer chấm điểm theo checklist (1-5 mỗi mục)
- Chair tổng hợp và đưa ra quyết định

**Phase 4 — Documentation (3 phút)**
- Scribe hoàn thiện minutes
- Chair xác nhận và ký

#### ARB Scoring Template

```markdown
# ARB REVIEW SCORING SHEET
# Proposal: {tên đề xuất}
# Date: {ngày} | Reviewer: {tên}

| # | Criteria | Score (1-5) | Notes |
|---|---------------------------------------|-------------|-------|
| 1 | ADR completeness | | |
| 2 | Alignment with architecture principles| | |
| 3 | Technical feasibility | | |
| 4 | Risk assessment quality | | |
| 5 | Security considerations | | |
| 6 | Performance impact analysis | | |
| 7 | Scalability plan | | |
| 8 | Migration / rollback strategy | | |
| 9 | Testing strategy | | |
| 10| Cost-benefit analysis | | |

**Total Score: ___/50**

Decision:
- [ ] Approved (≥ 40/50)
- [ ] Approved with conditions (30-39/50)
- [ ] Request revision (20-29/50)
- [ ] Rejected (< 20/50)

Conditions / Action Items:
1. _______________
2. _______________
```

#### ARB Meeting Minutes Template

```markdown
# ARB MEETING MINUTES
# Date: {ngày} | Location: {phòng/online}

## Attendees
| Name | Role | Present |
|------|------|---------|
| | | x / X |

## Agenda
1. Review ADR-XXX: {tiêu đề}

## Discussion Summary
### Key Questions Raised:
1. [Security] ...
2. [Domain] ...
3. [QA] ...

### Proposer Responses:
1. ...
2. ...
3. ...

## Decision
- **Result**: Approved / Approved with conditions / Revise / Rejected
- **Score**: __/50
- **Conditions**: (nếu có)

## Action Items
| # | Action | Owner | Deadline |
|---|--------|-------|----------|
| | | | |

## Next Review Date: {ngày}

## Sign-off
- Chair: __________ Date: __________
- Scribe: __________ Date: __________
```

---

## Self-Assessment

### Band 1: Kiến thức Cơ bản (Câu 1-10)

**Câu 1.** Architecture Compliance là gì?
- A) Tuân thủ luật pháp quốc gia
- B) Mức độ implementation tuân thủ đúng architecture đã thiết kế
- C) Viết documentation đầy đủ
- D) Sử dụng design patterns

**Đáp án: B** — Architecture Compliance đo lường sự phù hợp giữa code thực tế và kiến trúc đã được phê duyệt. Nó không phải là regulatory compliance (A) hay documentation (C).

---

**Câu 2.** ISO/IEC 42010 định nghĩa điều gì?
- A) Quy trình phát triển phần mềm
- B) Tiêu chuẩn bảo mật thông tin
- C) Tiêu chuẩn mô tả kiến trúc phần mềm (Architecture Description)
- D) Tiêu chuẩn testing

**Đáp án: C** — ISO/IEC 42010 là tiêu chuẩn quốc tế về Architecture Description, định nghĩa các khái niệm như viewpoint, view, concern, stakeholder trong bối cảnh kiến trúc.

---

**Câu 3.** ADR là viết tắt của gì?
- A) Architecture Design Review
- B) Architecture Decision Record
- C) Application Deployment Report
- D) Automated Documentation Repository

**Đáp án: B** — ADR (Architecture Decision Record) ghi lại các quyết định kiến trúc quan trọng cùng context, rationale và consequences.

---

**Câu 4.** Mục đích chính của ArchUnit là gì?
- A) Tạo UML diagrams tự động
- B) Kiểm tra architecture rules bằng unit tests
- C) Deploy ứng dụng lên cloud
- D) Monitor performance production

**Đáp án: B** — ArchUnit là thư viện Java cho phép viết architecture rules dưới dạng unit tests, tự động kiểm tra dependency rules, naming conventions, layer constraints.

---

**Câu 5.** Fitness function trong kiến trúc phần mềm là gì?
- A) Hàm tính toán chi phí phần mềm
- B) Automated test kiểm tra liên tục một đặc tính kiến trúc
- C) Function để optimize database queries
- D) Hàm đánh giá hiệu suất nhân viên

**Đáp án: B** — Fitness function (theo Neal Ford et al.) là automated, objective test liên tục đánh giá một architecture characteristic. Chúng chạy trong CI/CD pipeline.

---

**Câu 6.** Architecture Review Board (ARB) bao gồm những ai?
- A) Chỉ developers
- B) Chỉ managers
- C) Architects, tech leads, security experts, QA representatives
- D) Chỉ khách hàng

**Đáp án: C** — ARB là nhóm đa chức năng bao gồm Chief Architect, Domain Architects, Tech Leads, Security Architect, QA Lead để đánh giá toàn diện quyết định kiến trúc.

---

**Câu 7.** Compliance Rate được tính như thế nào?
- A) Số dòng code / tổng effort
- B) % architecture rules được tuân thủ / tổng số rules
- C) Số bugs / tổng features
- D) Thời gian deploy / tổng thời gian

**Đáp án: B** — Compliance Rate = (Số rules passed / Tổng số rules) x 100%. Target thường là ≥ 95%.

---

**Câu 8.** Trong ADR, phần "Consequences" ghi lại điều gì?
- A) Lịch sử thay đổi code
- B) Kết quả positive, negative và neutral của quyết định
- C) Danh sách lỗi đã fix
- D) Chi phí dự án

**Đáp án: B** — Consequences ghi nhận cả lợi ích (positive), trade-off phải chấp nhận (negative) và ảnh hưởng trung tính (neutral) của một quyết định kiến trúc.

---

**Câu 9.** Manual review có nhược điểm gì so với automated checking?
- A) Quá nhanh để phát hiện lỗi
- B) Tốn thời gian, chủ quan, khó lặp lại thường xuyên
- C) Không cần con người tham gia
- D) Chỉ hoạt động với Java

**Đáp án: B** — Manual review tốn thời gian, kết quả phụ thuộc vào kinh nghiệm người review (chủ quan), và khó thực hiện thường xuyên trên mỗi commit như automated tools.

---

**Câu 10.** Trong layered architecture, "Domain layer may not access any layer" nghĩa là gì?
- A) Domain layer không tồn tại
- B) Domain layer không được phụ thuộc vào bất kỳ layer nào khác
- C) Không ai được truy cập Domain layer
- D) Domain layer chỉ chứa interfaces

**Đáp án: B** — Đây là nguyên tắc Domain Independence: Domain layer chứa core business logic và không được import/depend vào Presentation, Application hay Infrastructure.

---

### Band 2: Vận dụng (Câu 11-20)

**Câu 11.** Khi một Controller gọi trực tiếp Repository (bỏ qua Service layer), ArchUnit rule nào sẽ fail?
- A) Naming convention rule
- B) Layer dependency rule
- C) Circular dependency rule
- D) Package structure rule

**Đáp án: B** — Layer dependency rule quy định Presentation layer (chứa Controller) chỉ được access Application layer. Gọi trực tiếp Repository (Infrastructure) vi phạm layer boundaries.

---

**Câu 12.** ArchUnit rule `noClasses().that().resideInAPackage("..domain..").should().dependOnClassesThat().resideInAPackage("..infrastructure..")` kiểm tra điều gì?
- A) Domain không được import Infrastructure classes
- B) Infrastructure không được import Domain classes
- C) Tất cả classes phải nằm trong domain
- D) Domain phải có ít nhất 1 class

**Đáp án: A** — Rule này đảm bảo không có class nào trong domain package được phụ thuộc vào (depend on) bất kỳ class nào trong infrastructure package, thực thi Dependency Inversion Principle.

---

**Câu 13.** Fitness function nào phù hợp nhất để kiểm tra constraint "API response time < 200ms"?
- A) ArchUnit structural test
- B) Integration test đo thời gian response
- C) Code coverage test
- D) Manual review

**Đáp án: B** — Đây là operational fitness function, cần gọi API thực tế và đo thời gian response. ArchUnit chỉ kiểm tra cấu trúc code tĩnh (static analysis), không đo runtime metrics.

---

**Câu 14.** Khi ARB quyết định "Approved with conditions", điều gì xảy ra tiếp theo?
- A) Dự án bị hủy
- B) Implementation tiến hành nhưng phải đáp ứng conditions trước deadline
- C) Phải submit lại proposal mới hoàn toàn
- D) Không cần làm gì thêm

**Đáp án: B** — "Approved with conditions" cho phép tiến hành implementation nhưng team phải hoàn thành các conditions (ví dụ: bổ sung security review, thêm fitness functions) trong thời hạn được thống nhất.

---

**Câu 15.** NetArchTest tương đương với ArchUnit ở điểm nào?
- A) Cả hai đều dùng cho Java
- B) Cả hai đều kiểm tra architecture rules bằng tests, nhưng cho hệ sinh thái khác nhau
- C) Cả hai đều là monitoring tools
- D) Cả hai đều tạo documentation

**Đáp án: B** — ArchUnit dùng cho Java, NetArchTest dùng cho .NET/C#. Cả hai đều cho phép viết architecture rules dưới dạng automated tests, kiểm tra dependencies, naming, layers.

---

**Câu 16.** Tại sao cần chạy compliance checks trong CI/CD pipeline?
- A) Để tăng tốc deployment
- B) Để phát hiện vi phạm kiến trúc sớm, trên mỗi commit/PR, trước khi merge
- C) Để giảm chi phí server
- D) Để thay thế hoàn toàn manual review

**Đáp án: B** — CI/CD integration đảm bảo mỗi thay đổi code được kiểm tra tự động. Vi phạm kiến trúc bị phát hiện ngay khi code được push, ngăn chặn architectural drift trước khi merge vào main branch.

---

**Câu 17.** ADR status "Superseded by ADR-XXX" có nghĩa là gì?
- A) ADR đã bị xóa
- B) ADR đã được thay thế bởi quyết định mới (ADR-XXX)
- C) ADR đang chờ review
- D) ADR bị reject

**Đáp án: B** — "Superseded" nghĩa là quyết định cũ vẫn được lưu giữ (để tham khảo lịch sử) nhưng đã bị thay thế bởi quyết định mới trong ADR-XXX. Đây là cách duy trì traceability.

---

**Câu 18.** "Architecture Debt Ratio ≤ 5%" nghĩa là gì?
- A) Chỉ 5% budget cho architecture
- B) Tối đa 5% architecture rules bị vi phạm so với tổng số rules
- C) Team chỉ có 5% thời gian cho architecture
- D) 5% code phải được viết lại

**Đáp án: B** — Architecture Debt Ratio đo lường tỷ lệ violations / total rules. Target ≤ 5% có nghĩa là tối đa 5% rules có thể tạm thời bị vi phạm (thường kèm theo remediation plan).

---

**Câu 19.** Khi viết fitness function cho "no circular dependencies", loại test nào phù hợp?
- A) Performance test
- B) Structural test sử dụng ArchUnit `slices().should().beFreeOfCycles()`
- C) Security test
- D) User acceptance test

**Đáp án: B** — Circular dependency là vấn đề cấu trúc (structural), kiểm tra được bằng static analysis. ArchUnit cung cấp API `slices().matching(...).should().beFreeOfCycles()` chuyên cho mục đích này.

---

**Câu 20.** Trong ARB scoring, proposal được score 35/50 sẽ nhận quyết định gì?
- A) Approved
- B) Approved with conditions
- C) Request revision
- D) Rejected

**Đáp án: B** — Theo thang điểm: ≥ 40 = Approved, 30-39 = Approved with conditions, 20-29 = Request revision, < 20 = Rejected. Score 35 rơi vào khoảng "Approved with conditions".

---

### Band 3: Phân tích & Đánh giá (Câu 21-30)

**Câu 21.** Một team phát hiện rằng 40% ArchUnit rules đang fail. Chiến lược nào hợp lý nhất?
- A) Xóa hết rules đang fail
- B) Ưu tiên fix high-severity violations trước, tạo technical debt backlog cho phần còn lại
- C) Bỏ qua và tiếp tục phát triển features
- D) Viết lại toàn bộ hệ thống

**Đáp án: B** — Khi tỷ lệ violation cao, cần pragmatic approach: phân loại severity, fix critical violations trước (security, core layer rules), tạo backlog có timeline cho remaining items. Xóa rules (A) mất ý nghĩa compliance. Viết lại (D) không thực tế.

---

**Câu 22.** So sánh ArchUnit (static analysis) và runtime fitness functions. Khi nào cần kết hợp cả hai?
- A) Không bao giờ cần kết hợp, chọn một là đủ
- B) Khi cần kiểm tra cả structural constraints (dependencies, naming) và operational constraints (performance, availability)
- C) Chỉ khi dự án lớn hơn 100 classes
- D) Chỉ khi khách hàng yêu cầu

**Đáp án: B** — ArchUnit kiểm tra cấu trúc tĩnh (compile-time), runtime fitness functions kiểm tra hành vi (runtime). Hệ thống toàn diện cần cả hai: ArchUnit đảm bảo đúng cấu trúc, runtime tests đảm bảo đáp ứng NFRs (performance, reliability).

---

**Câu 23.** Một ADR được viết 2 năm trước cho monolith architecture. Team muốn chuyển sang microservices. Cách xử lý ADR cũ?
- A) Xóa ADR cũ
- B) Giữ ADR cũ, đánh dấu "Superseded by ADR-XXX" và tạo ADR mới cho microservices decision
- C) Sửa đổi ADR cũ thành microservices
- D) Bỏ qua, không cần ADR cho quyết định mới

**Đáp án: B** — ADR là immutable records (không sửa nội dung gốc). Đánh dấu status "Superseded by ADR-XXX", tạo ADR mới ghi rõ context tại sao chuyển đổi, liên kết với ADR cũ. Điều này bảo toàn decision history.

---

**Câu 24.** Governance process quá nặng nề (mỗi thay đổi nhỏ cần ARB approval) gây ra vấn đề gì?
- A) Code quality tăng vọt
- B) Bottleneck trong development, giảm velocity, developer frustration
- C) Không có vấn đề gì
- D) Security tốt hơn

**Đáp án: B** — Over-governance tạo bottleneck, làm chậm delivery. Cần cân bằng: chỉ yêu cầu ARB review cho significant architectural changes, dùng lightweight process (peer review, automated checks) cho thay đổi nhỏ. Governance nên enable chứ không phải block.

---

**Câu 25.** Compliance metrics cho thấy "Fitness Function Pass Rate = 85%". Đây là dấu hiệu gì?
- A) Hệ thống hoạt động tốt
- B) Architecture erosion đang xảy ra, cần investigation và remediation
- C) Cần thêm nhiều fitness functions hơn
- D) Team nên bỏ fitness functions

**Đáp án: B** — Target pass rate thường là ≥ 98%. 85% cho thấy 15% constraints đang bị vi phạm — dấu hiệu rõ ràng của architecture erosion. Cần phân tích root cause: rules quá strict? Implementation drift? Thiếu enforcement?

---

**Câu 26.** Team muốn enforce "mỗi microservice không quá 500 lines of business logic". Đây là loại fitness function gì và implement ra sao?
- A) Operational fitness function, đo bằng monitoring tools
- B) Structural fitness function, đo bằng static analysis (đếm LOC trong domain layer)
- C) Process fitness function, đo bằng code review
- D) Không thể automate được

**Đáp án: B** — Đây là structural constraint, có thể automate bằng cách đếm LOC trong domain package/namespace. Implement bằng custom ArchUnit condition hoặc script đơn giản chạy trong CI pipeline.

---

**Câu 27.** ISO/IEC 42010 yêu cầu "architecture description must address stakeholder concerns". Trong thực tế, đây nghĩa là gì?
- A) Viết documentation dài nhất có thể
- B) Mỗi viewpoint/view phải map đến ít nhất một concern từ identified stakeholders
- C) Chỉ cần hỏi ý kiến project manager
- D) Sử dụng nhiều UML diagrams nhất có thể

**Đáp án: B** — ISO/IEC 42010 yêu cầu traceability: mỗi stakeholder concern phải được address bởi ít nhất một view (thông qua viewpoint). Architecture description không đầy đủ nếu có concern chưa được address.

---

**Câu 28.** Automated compliance checking phát hiện rằng một class trong Domain layer import `javax.persistence.Entity` (JPA annotation). Đánh giá violation này.
- A) Không phải violation vì JPA cần thiết
- B) Violation nghiêm trọng — Domain layer đang coupled với persistence framework, vi phạm Domain Independence
- C) Violation nhẹ, có thể bỏ qua
- D) Không liên quan đến architecture compliance

**Đáp án: B** — Domain layer theo Clean Architecture / Hexagonal Architecture không được phụ thuộc vào framework/infrastructure. JPA annotation (`@Entity`) tạo coupling giữa domain model và persistence framework. Giải pháp: tách JPA entities (infrastructure) khỏi domain entities, hoặc dùng mapping layer.

---

**Câu 29.** Một tổ chức lớn có 20 teams. Làm thế nào để scale architecture compliance hiệu quả?
- A) Mỗi team tự quyết định rules riêng, không cần thống nhất
- B) Tạo shared compliance library (common ArchUnit rules), cho phép teams extend với domain-specific rules, CI/CD enforcement
- C) Chỉ cần 1 architect review toàn bộ code
- D) Dùng manual review cho tất cả

**Đáp án: B** — Scalable compliance cần: (1) Shared rule library cho org-wide standards, (2) Extension points cho team-specific rules, (3) Automated enforcement qua CI/CD, (4) Centralized dashboard cho visibility. Approach này vừa nhất quán vừa linh hoạt.

---

**Câu 30.** Phân tích trade-off: "Strict compliance enforcement (block merge on any violation)" vs "Advisory compliance (warn but allow merge)". Khi nào chọn phương án nào?
- A) Luôn chọn strict vì an toàn hơn
- B) Luôn chọn advisory vì không cản trở developers
- C) Strict cho critical rules (security, core layers), advisory cho non-critical rules (naming, style) — kết hợp cả hai tùy severity
- D) Không có sự khác biệt giữa hai phương án

**Đáp án: C** — Cần tiếp cận phân tầng (tiered enforcement): Critical rules (layer violations, security constraints) nên blocking — vi phạm không được merge. Non-critical rules (naming conventions, preferred patterns) nên advisory — cảnh báo nhưng không block, để tránh over-governance. Kết hợp cả hai cho cân bằng giữa compliance và developer productivity.

---

## Extend Labs (EL1-EL10)

### EL1: Multi-module Compliance
```
Mục tiêu: Viết ArchUnit rules cho dự án multi-module Maven/Gradle
- Định nghĩa allowed dependencies giữa modules
- Enforce API boundaries (module chỉ expose qua public API package)
- Tạo compliance report tổng hợp
Deliverable: Compliance test suite + report
Độ khó: **
```

### EL2: ADR Repository
```
Mục tiêu: Xây dựng hệ thống quản lý ADR hoàn chỉnh
- Tạo 5 ADRs cho một hệ thống e-commerce
- Link ADRs với compliance rules
- Viết script kiểm tra ADR completeness
Deliverable: ADR collection + validation script
Độ khó: **
```

### EL3: Custom ArchUnit Conditions
```
Mục tiêu: Viết custom ArchCondition cho business-specific rules
- Rule: Services không quá 200 LOC
- Rule: Public methods phải có JavaDoc
- Rule: Exception classes phải extend BaseException
Deliverable: 5 custom conditions + tests
Độ khó: ***
```

### EL4: Fitness Function Dashboard
```
Mục tiêu: Xây dựng dashboard hiển thị compliance metrics
- Tích hợp test results từ CI/CD
- Hiển thị trend charts (compliance rate over time)
- Alert khi compliance rate < threshold
Deliverable: Dashboard prototype + data pipeline
Độ khó: ***
```

### EL5: Cross-team Compliance
```
Mục tiêu: Thiết kế shared compliance library cho organization
- Định nghĩa org-wide rules vs team-specific rules
- Tạo Maven/NuGet package chứa shared rules
- Viết documentation cho rule extension
Deliverable: Shared library + usage guide
Độ khó: ***
```

### EL6: Compliance as Code Pipeline
```
Mục tiêu: Tích hợp đầy đủ compliance vào CI/CD
- GitHub Actions / GitLab CI configuration
- Gate: block merge khi critical rules fail
- Generate compliance report artifact
- Slack/Teams notification khi violation detected
Deliverable: CI/CD config + notification setup
Độ khó: ***
```

### EL7: Architecture Erosion Detection
```
Mục tiêu: Phát hiện và đo lường architecture erosion theo thời gian
- Đo coupling metrics mỗi sprint
- So sánh planned vs actual architecture
- Tạo erosion heatmap
Deliverable: Erosion analysis report + visualization
Độ khó: ****
```

### EL8: Regulatory Compliance Mapping
```
Mục tiêu: Ánh xạ regulatory requirements (GDPR/PCI DSS) vào architecture controls
- Tạo compliance matrix: regulation → control → test
- Viết automated tests cho mỗi control
- Tạo audit evidence package
Deliverable: Compliance matrix + automated evidence
Độ khó: ****
```

### EL9: ARB Process Design
```
Mục tiêu: Thiết kế quy trình ARB đầy đủ cho tổ chức
- Viết ARB charter document
- Thiết kế review workflow (Jira/Confluence template)
- Định nghĩa escalation process
- Tạo decision log template
Deliverable: ARB charter + workflow + templates
Độ khó: ****
```

### EL10: Architecture Compliance Maturity Assessment
```
Mục tiêu: Đánh giá mức độ trưởng thành compliance của một tổ chức
- Xây dựng maturity model 5 levels
 (L1: Ad-hoc, L2: Defined, L3: Measured, L4: Managed, L5: Optimized)
- Tạo assessment questionnaire (30 câu)
- Đề xuất roadmap cải thiện
Deliverable: Maturity model + assessment tool + roadmap
Độ khó: *****
```

---

## Deliverables

Checklist các sản phẩm cần nộp:

- [ ] **Compliance Checklist** (Lab 1) — Bảng ánh xạ principles → decisions → compliance methods
- [ ] **Gap Analysis Report** (Lab 1) — Bảng đánh giá gap với remediation plan
- [ ] **ArchUnit / NetArchTest Suite** (Lab 2) — Tối thiểu 10 architecture rules, tất cả pass
- [ ] **Fitness Function Tests** (Lab 3) — Tối thiểu 3 fitness functions (structural + operational)
- [ ] **CI/CD Configuration** (Lab 3) — GitHub Actions / GitLab CI file chạy compliance tests
- [ ] **ADR Collection** (Lab 1-3) — Tối thiểu 2 ADRs hoàn chỉnh theo template
- [ ] **ARB Meeting Minutes** (Lab 4) — Minutes hoàn chỉnh với scoring, decision, action items
- [ ] **ARB Scoring Sheets** (Lab 4) — Mỗi reviewer 1 sheet, có điểm và nhận xét
- [ ] **Self-Assessment** — Hoàn thành 30 câu hỏi, ghi nhận điểm số

---

## Lỗi Thường Gặp

| # | Lỗi | Mô tả | Cách sửa |
|---|------|--------|----------|
| 1 | **Rules quá strict từ đầu** | Enforce 100% compliance ngay khi mới áp dụng, gây quá nhiều failures | Bắt đầu với advisory mode, tăng dần strictness. Ưu tiên critical rules trước |
| 2 | **Không có baseline** | Áp dụng rules mà không biết hiện trạng, không thể đo improvement | Chạy compliance scan lần đầu để thiết lập baseline trước khi enforce |
| 3 | **ADR thiếu Context** | ADR chỉ ghi Decision mà không giải thích Context và Alternatives | Luôn ghi rõ bối cảnh, các phương án đã cân nhắc, và lý do chọn phương án hiện tại |
| 4 | **Fitness functions không chạy trong CI** | Viết tests nhưng không tích hợp vào CI/CD pipeline | Thêm test execution vào CI config, đảm bảo chạy trên mỗi PR |
| 5 | **ARB review chỉ hình thức** | ARB meeting không có structured evaluation, chỉ "rubber stamp" | Sử dụng scoring template, yêu cầu mỗi reviewer đặt ít nhất 2 câu hỏi cụ thể |
| 6 | **Nhầm lẫn Architecture vs Regulatory compliance** | Dùng ArchUnit để kiểm tra GDPR, PCI DSS | Phân biệt rõ: ArchUnit cho structural rules, separate tools cho regulatory. ADR có thể liên kết cả hai |
| 7 | **Bỏ qua non-critical violations** | Tích lũy nhiều advisory warnings mà không remediate | Đặt threshold (ví dụ: max 20 warnings), review advisory violations hàng sprint |
| 8 | **Không update ADR khi architecture thay đổi** | ADR trở nên outdated, mất giá trị compliance evidence | Đưa ADR review vào Definition of Done, update status khi có thay đổi liên quan |
| 9 | **Layer bypass cho "performance"** | Developer bypass layer rules với lý do performance mà không có ADR | Yêu cầu ADR cho mọi exception, đánh giá trong ARB, tạo explicit allowlist trong rules |
| 10 | **Thiếu compliance metrics tracking** | Không đo lường, không biết compliance đang cải thiện hay xấu đi | Setup dashboard, track metrics hàng tuần/sprint, review trend trong retrospective |

---

## Rubric Chấm điểm

| Tiêu chí | Điểm tối đa | Mô tả chi tiết |
|----------|-------------|-----------------|
| **Compliance Checklist & Gap Analysis** | 20 | Checklist đầy đủ (10đ), gap analysis có remediation plan (10đ) |
| **Automated Architecture Rules** | 25 | 10+ rules viết đúng (15đ), tất cả pass hoặc có giải thích cho failures (5đ), code quality (5đ) |
| **Fitness Functions** | 20 | ≥3 fitness functions (10đ), CI/CD integration (5đ), documentation (5đ) |
| **ARB Simulation** | 15 | Tham gia đầy đủ vai trò (5đ), scoring sheet hoàn chỉnh (5đ), meeting minutes (5đ) |
| **ADR Quality** | 10 | ≥2 ADRs đầy đủ sections (5đ), compliance section có fitness function reference (5đ) |
| **Self-Assessment** | 10 | Hoàn thành 30 câu (5đ), phân tích sai lầm và rút kinh nghiệm (5đ) |
| **Tổng** | **100** | |

**Thang đánh giá:**

| Mức | Điểm | Mô tả |
|-----|------|-------|
| Xuất sắc | 90-100 | Hoàn thành tất cả, code chạy đúng, analysis sâu sắc |
| Giỏi | 80-89 | Hoàn thành hầu hết, vài thiếu sót nhỏ |
| Khá | 65-79 | Hoàn thành các phần cơ bản, thiếu phần nâng cao |
| Trung bình | 50-64 | Hoàn thành tối thiểu, thiếu nhiều phần |
| Chưa đạt | < 50 | Không hoàn thành yêu cầu tối thiểu |

---

## Tài liệu Tham khảo

1. **ISO/IEC 42010:2022** — Systems and software engineering — Architecture description
2. **Neal Ford, Rebecca Parsons, Patrick Kua** — *Building Evolutionary Architectures*, O'Reilly (2nd Edition)
3. **Michael Nygard** — *Documenting Architecture Decisions* (ADR format), [cognitect.com/blog](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
4. **ArchUnit Documentation** — [archunit.org](https://www.archunit.org/)
5. **NetArchTest** — [github.com/BenMorris/NetArchTest](https://github.com/BenMorris/NetArchTest)
6. **TOGAF Architecture Governance** — The Open Group Architecture Framework, Chapter 50
7. **Len Bass, Paul Clements, Rick Kazman** — *Software Architecture in Practice*, 4th Edition, Addison-Wesley
