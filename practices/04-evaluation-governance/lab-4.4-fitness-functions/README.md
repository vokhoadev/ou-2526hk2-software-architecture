# Lab 4.4: Architecture Fitness Functions

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 4 giờ |
| **Độ khó** | Advanced |
| **CLO** | CLO1, CLO2, CLO3 |
| **Công nghệ** | ArchUnit (Java), ts-arch (TypeScript) |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu Fitness Functions và evolutionary architecture
2. Implement architecture tests với ArchUnit
3. Create fitness functions cho layered architecture
4. Integrate vào CI/CD pipeline

---

## Phần 1: Fitness Functions Concept (30 phút)

### 1.1 What is a Fitness Function?

> "An architectural fitness function provides an **objective measure** of how close an architecture is to achieving an architectural goal." - Neal Ford

### 1.2 Types of Fitness Functions

| Type | Description | Example |
|------|-------------|---------|
| **Atomic** | Measures single dimension | Cyclomatic complexity |
| **Holistic** | Measures multiple dimensions | Deployment readiness |
| **Triggered** | Runs on specific events | On commit, on deploy |
| **Continuous** | Always running | Performance monitoring |

### 1.3 What to Measure

```
┌─────────────────────────────────────────────────────────────────┐
│ Fitness Function Categories │
├─────────────────────────────────────────────────────────────────┤
│ Structural │ Operational │ Process │
│ ─────────────────── │ ─────────────────── │ ───────────────── │
│ - Layer dependencies│ - Response time │ - Test coverage │
│ - Coupling metrics │ - Error rate │ - Code review │
│ - Cyclomatic │ - Throughput │ - Documentation │
│ complexity │ - Availability │ - Security scan │
│ - Package cycles │ - Resource usage │ │
└─────────────────────────────────────────────────────────────────┘
```

---

## Phần 2: ArchUnit for Java (90 phút)

### 2.1 Setup

```xml
<!-- pom.xml -->
<dependency>
 <groupId>com.tngtech.archunit</groupId>
 <artifactId>archunit-junit5</artifactId>
 <version>1.2.0</version>
 <scope>test</scope>
</dependency>
```

### 2.2 Layered Architecture Rules

```java
// src/test/java/com/example/ArchitectureTest.java
package com.example;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.lang.ArchRule;
import com.tngtech.archunit.library.Architectures;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.*;
import static com.tngtech.archunit.library.Architectures.layeredArchitecture;

public class ArchitectureTest {

 private static JavaClasses classes;

 @BeforeAll
 static void setup() {
 classes = new ClassFileImporter()
 .importPackages("com.example");
 }

 // Fitness Function 1: Layered Architecture
 @Test
 void layeredArchitectureShouldBeRespected() {
 ArchRule rule = layeredArchitecture()
 .consideringAllDependencies()
 .layer("Controller").definedBy("..controller..")
 .layer("Service").definedBy("..service..")
 .layer("Repository").definedBy("..repository..")
 .layer("Domain").definedBy("..domain..")

 .whereLayer("Controller").mayNotBeAccessedByAnyLayer()
 .whereLayer("Service").mayOnlyBeAccessedByLayers("Controller")
 .whereLayer("Repository").mayOnlyBeAccessedByLayers("Service")
 .whereLayer("Domain").mayBeAccessedByAnyLayer();

 rule.check(classes);
 }

 // Fitness Function 2: No Cycles
 @Test
 void packagesShouldBeFreeOfCycles() {
 ArchRule rule = slices()
 .matching("com.example.(*)..")
 .should().beFreeOfCycles();

 rule.check(classes);
 }

 // Fitness Function 3: Controllers naming convention
 @Test
 void controllersShouldBeNamedCorrectly() {
 ArchRule rule = classes()
 .that().resideInAPackage("..controller..")
 .should().haveSimpleNameEndingWith("Controller");

 rule.check(classes);
 }

 // Fitness Function 4: Controllers should be annotated
 @Test
 void controllersShouldBeAnnotated() {
 ArchRule rule = classes()
 .that().resideInAPackage("..controller..")
 .should().beAnnotatedWith(RestController.class)
 .orShould().beAnnotatedWith(Controller.class);

 rule.check(classes);
 }

 // Fitness Function 5: Services should not access Controllers
 @Test
 void servicesShouldNotAccessControllers() {
 ArchRule rule = noClasses()
 .that().resideInAPackage("..service..")
 .should().accessClassesThat()
 .resideInAPackage("..controller..");

 rule.check(classes);
 }

 // Fitness Function 6: Repository interfaces
 @Test
 void repositoriesShouldBeInterfaces() {
 ArchRule rule = classes()
 .that().resideInAPackage("..repository..")
 .and().haveSimpleNameEndingWith("Repository")
 .should().beInterfaces();

 rule.check(classes);
 }

 // Fitness Function 7: No field injection
 @Test
 void shouldNotUseFieldInjection() {
 ArchRule rule = noFields()
 .should().beAnnotatedWith(Autowired.class)
 .because("Use constructor injection instead");

 rule.check(classes);
 }

 // Fitness Function 8: Domain should not depend on infrastructure
 @Test
 void domainShouldNotDependOnInfrastructure() {
 ArchRule rule = noClasses()
 .that().resideInAPackage("..domain..")
 .should().dependOnClassesThat()
 .resideInAnyPackage(
 "..controller..",
 "..repository..",
 "..config..",
 "org.springframework.."
 );

 rule.check(classes);
 }
}
```

### 2.3 Hexagonal Architecture Rules

```java
// HexagonalArchitectureTest.java
@Test
void hexagonalArchitectureShouldBeRespected() {
 ArchRule rule = layeredArchitecture()
 .consideringAllDependencies()

 // Define layers
 .layer("Domain").definedBy("..domain..")
 .layer("Application").definedBy("..application..")
 .layer("Infrastructure").definedBy("..infrastructure..")
 .layer("Adapters").definedBy("..adapters..")

 // Domain is the core - depends on nothing
 .whereLayer("Domain").mayOnlyBeAccessedByLayers(
 "Application", "Infrastructure", "Adapters"
 )

 // Application uses Domain
 .whereLayer("Application").mayOnlyBeAccessedByLayers(
 "Infrastructure", "Adapters"
 )

 // Infrastructure and Adapters are outer layers
 .whereLayer("Infrastructure").mayNotBeAccessedByAnyLayer()
 .whereLayer("Adapters").mayNotBeAccessedByAnyLayer();

 rule.check(classes);
}

@Test
void portsShouldBeInterfaces() {
 ArchRule rule = classes()
 .that().resideInAPackage("..ports..")
 .should().beInterfaces();

 rule.check(classes);
}

@Test
void adaptersShouldImplementPorts() {
 ArchRule rule = classes()
 .that().resideInAPackage("..adapters..")
 .and().areNotInterfaces()
 .should().implement(
 classes().that().resideInAPackage("..ports..")
 );

 rule.check(classes);
}
```

---

## Phần 3: TypeScript Architecture Tests (45 phút)

### 3.1 Setup with ts-arch

```bash
npm install --save-dev @ts-arch/ts-arch
```

### 3.2 Architecture Tests

```typescript
// src/__tests__/architecture.test.ts
import { filesOfProject } from '@ts-arch/ts-arch';

describe('Architecture Fitness Functions', () => {
 let files: ReturnType<typeof filesOfProject>;

 beforeAll(() => {
 files = filesOfProject('./tsconfig.json');
 });

 // Fitness Function 1: Layer Dependencies
 it('controllers should not import from adapters', async () => {
 const rule = files
 .inFolder('src/controllers')
 .shouldNot()
 .dependOnFiles()
 .inFolder('src/adapters');

 await expect(rule).toPassAsync();
 });

 // Fitness Function 2: Domain Independence
 it('domain should not depend on infrastructure', async () => {
 const rule = files
 .inFolder('src/domain')
 .shouldNot()
 .dependOnFiles()
 .inFolder('src/infrastructure');

 await expect(rule).toPassAsync();
 });

 // Fitness Function 3: Naming Conventions
 it('controllers should end with Controller', async () => {
 const rule = files
 .inFolder('src/controllers')
 .should()
 .matchPattern('.*Controller\\.ts$');

 await expect(rule).toPassAsync();
 });

 // Fitness Function 4: Services use repositories
 it('services should depend on repository interfaces', async () => {
 const rule = files
 .inFolder('src/services')
 .should()
 .dependOnFiles()
 .inFolder('src/ports');

 await expect(rule).toPassAsync();
 });
});
```

---

## Phần 4: CI/CD Integration (30 phút)

### 4.1 GitHub Actions

```yaml
# .github/workflows/architecture.yml
name: Architecture Fitness Functions

on:
 push:
 branches: [main, develop]
 pull_request:
 branches: [main]

jobs:
 architecture-tests:
 runs-on: ubuntu-latest

 steps:
 - uses: actions/checkout@v4

 - name: Set up JDK 17
 uses: actions/setup-java@v4
 with:
 java-version: '17'
 distribution: 'temurin'

 - name: Run Architecture Tests
 run: mvn test -Dtest=*ArchitectureTest

 - name: Upload Results
 uses: actions/upload-artifact@v4
 if: always()
 with:
 name: architecture-test-results
 path: target/surefire-reports/
```

### 4.2 Pre-commit Hook

```bash
#!/bin/sh
# .git/hooks/pre-commit

echo "Running architecture fitness functions..."
mvn test -Dtest=*ArchitectureTest -q

if [ $? -ne 0 ]; then
 echo "[Khong] Architecture rules violated!"
 echo "Fix violations before committing."
 exit 1
fi

echo "[OK] Architecture rules passed!"
```

---

## Phần 5: Custom Fitness Functions (30 phút)

### 5.1 Complexity Metrics

```java
// ComplexityFitnessTest.java
@Test
void methodsShouldNotBeToComplex() {
 ArchRule rule = methods()
 .should(new ArchCondition<JavaMethod>("have complexity < 10") {
 @Override
 public void check(JavaMethod method, ConditionEvents events) {
 int complexity = calculateCyclomaticComplexity(method);
 if (complexity > 10) {
 events.add(SimpleConditionEvent.violated(
 method,
 String.format("%s has complexity %d (max 10)",
 method.getFullName(), complexity)
 ));
 }
 }
 });

 rule.check(classes);
}
```

### 5.2 Dependency Metrics

```java
@Test
void classesShouldNotHaveTooManyDependencies() {
 ArchRule rule = classes()
 .should(new ArchCondition<JavaClass>("have < 10 dependencies") {
 @Override
 public void check(JavaClass javaClass, ConditionEvents events) {
 int deps = javaClass.getDirectDependenciesFromSelf().size();
 if (deps > 10) {
 events.add(SimpleConditionEvent.violated(
 javaClass,
 String.format("%s has %d dependencies (max 10)",
 javaClass.getName(), deps)
 ));
 }
 }
 });

 rule.check(classes);
}
```

---

## Self-Assessment (30 câu)

### Cơ bản (1-10)

1. Fitness Function là gì?
2. Tại sao cần Fitness Functions?
3. Atomic fitness function là gì?
4. Holistic fitness function là gì?
5. ArchUnit là gì?
6. ts-arch là gì?
7. Architecture test là gì?
8. Layer dependency rules?
9. Naming convention rules?
10. Package structure rules?

### Trung bình (11-20)

11. Atomic vs Holistic khác nhau thế nào?
12. Triggered vs Continuous fitness functions?
13. Static vs Dynamic fitness functions?
14. Domain-specific fitness functions?
15. Cyclomatic complexity checks?
16. Coupling metrics?
17. CI/CD integration?
18. Fitness function evolution?
19. Multiple fitness functions?
20. Fitness function reporting?

### Nâng cao (21-30)

21. Evolutionary architecture là gì?
22. Fitness functions với microservices?
23. Cross-service fitness functions?
24. Performance fitness functions?
25. Security fitness functions?
26. Cost fitness functions?
27. Custom metrics?
28. Fitness function testing?
29. Fitness function maintenance?
30. Organization-wide fitness functions?

**Đáp án gợi ý:**
- 1: Mechanism đánh giá architecture characteristics
- 3: Test single architecture characteristic
- 21: Architecture that supports guided, incremental change

---

## Extend Labs (10 bài)

### EL1: Complete ArchUnit Suite
```
Mục tiêu: Comprehensive tests
- Layer tests
- Naming tests
- Dependency tests
Độ khó: ***
```

### EL2: Hexagonal Architecture Tests
```
Mục tiêu: Ports & Adapters
- Domain isolation
- Dependency direction
- Port contracts
Độ khó: ****
```

### EL3: TypeScript Architecture Tests
```
Mục tiêu: Frontend testing
- ts-arch setup
- Component rules
- Import rules
Độ khó: ***
```

### EL4: Performance Fitness
```
Mục tiêu: Performance gates
- Response time
- Throughput
- Resource usage
Độ khó: ****
```

### EL5: Security Fitness
```
Mục tiêu: Security gates
- Dependency vulnerabilities
- Code patterns
- OWASP compliance
Độ khó: ****
```

### EL6: Microservices Fitness
```
Mục tiêu: Distributed systems
- Service contracts
- API compatibility
- Independence tests
Độ khó: *****
```

### EL7: Custom Metrics
```
Mục tiêu: Domain-specific
- Business rules tests
- Domain constraints
- Custom validators
Độ khó: ****
```

### EL8: CI/CD Pipeline
```
Mục tiêu: Automation
- GitHub Actions
- Quality gates
- Trend tracking
Độ khó: ***
```

### EL9: Fitness Dashboard
```
Mục tiêu: Visualization
- Metrics aggregation
- Trend charts
- Alerts
Độ khó: ****
```

### EL10: Evolutionary Metrics
```
Mục tiêu: Long-term
- Trend analysis
- Degradation detection
- Improvement tracking
Độ khó: ****
```

---

## Deliverables

1. [ ] ArchUnit setup và basic tests
2. [ ] Layered architecture rules
3. [ ] Hexagonal architecture rules (if applicable)
4. [ ] Custom complexity metrics
5. [ ] CI/CD integration

---

## Tài liệu Tham khảo

1. ArchUnit: https://www.archunit.org/
2. Building Evolutionary Architectures - Neal Ford
3. ts-arch: https://github.com/ts-arch/ts-arch

---

## Tiếp theo

Chuyển đến: `lab-4.5-technical-debt/`

---

## Phân bổ Thời gian: Lý thuyết 40', Workshop 80', Report 40', Review 20' = 3 giờ

## Lời giải Mẫu
- ATAM evaluation workshop
- Architecture fitness functions
- Technical debt assessment

## Các Lỗi Thường Gặp
| Lỗi | Cách sửa |
|-----|----------|
| Subjective evaluation | Use structured methods (ATAM) |
| No stakeholder input | Include all stakeholders |
| Missing documentation | Document findings properly |

## Chấm điểm: Method application 35, Analysis 25, Recommendations 25, Presentation 15 = 100

## Tham khảo: CMU SEI ATAM, ISO/IEC 42030, TOGAF, ĐH Bách Khoa IT4995
