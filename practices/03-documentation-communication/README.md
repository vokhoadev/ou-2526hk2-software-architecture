# 03 - Documentation & Communication (Tài liệu hóa)

## Tổng quan

Level 3 tập trung vào kỹ năng tài liệu hóa kiến trúc và giao tiếp với stakeholders - kỹ năng quan trọng của Software Architect.

## Thông tin

| Thông tin | Giá trị |
|-----------|---------|
| **Level** | 3 - Intermediate |
| **Số Labs** | 7 |
| **Thời lượng** | 20 giờ |
| **CLO đạt được** | CLO4 |

## Danh sách Labs

| Lab | Tên | Thời lượng | Công cụ |
|-----|-----|-----------|---------|
| 3.1 | UML Diagrams | 2h | PlantUML, StarUML |
| 3.2 | C4 Model Complete | 4h | Structurizr, C4-PlantUML |
| 3.3 | Architecture Decision Records (ADR) | 2h | MADR, adr-tools |
| 3.4 | arc42 Documentation | 4h | arc42 template |
| 3.5 | Mermaid Diagrams as Code | 2h | Mermaid, GitHub |
| 3.6 | API Documentation | 3h | OpenAPI/Swagger, Postman |
| 3.7 | Architecture Presentation | 3h | PowerPoint, Miro |

## Mục tiêu Học tập

1. **Vẽ diagrams** sử dụng UML và C4 Model
2. **Viết ADRs** để record architecture decisions
3. **Tạo documentation** theo arc42 template
4. **Document APIs** với OpenAPI/Swagger
5. **Present architecture** cho stakeholders

## Documentation Tools Matrix

| Tool | Use Case | Format |
|------|----------|--------|
| **PlantUML** | Technical diagrams | Text-based |
| **Mermaid** | GitHub/Markdown diagrams | Text-based |
| **Structurizr** | C4 Model | DSL |
| **Draw.io** | General diagrams | Visual |
| **Swagger** | API documentation | OpenAPI |

## Prerequisite

- Hoàn thành Level 1 & 2
- Hiểu biết về UML cơ bản
- VS Code với PlantUML extension

## Why Documentation Matters

> "Architecture documentation is NOT optional. It's the difference between architecture knowledge and tribal knowledge." - Simon Brown

**Benefits:**
- Knowledge sharing
- Onboarding new team members
- Communication với stakeholders
- Audit và compliance
- Decision history

## Documentation Anti-patterns

| Anti-pattern | Vấn đề | Giải pháp |
|--------------|--------|-----------|
| Big Upfront | Quá chi tiết, nhanh outdated | Just-in-time |
| No Documentation | Knowledge loss | Essential docs |
| Outdated Docs | Misleading | Living documentation |
| Too Technical | Stakeholders không hiểu | Multiple audiences |
