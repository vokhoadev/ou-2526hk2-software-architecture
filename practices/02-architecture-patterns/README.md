# 02 - Architecture Patterns (Mẫu Kiến trúc)

## Tổng quan

Level 2 tập trung vào các mẫu kiến trúc phần mềm phổ biến, từ cổ điển đến hiện đại.

## Thông tin

| Thông tin | Giá trị |
|-----------|---------|
| **Level** | 2 - Intermediate |
| **Số Labs** | 8 |
| **Thời lượng** | 28 giờ |
| **CLO đạt được** | CLO2, CLO3, CLO6 |

## Danh sách Labs

| Lab | Tên | Thời lượng | Công nghệ |
|-----|-----|-----------|-----------|
| 2.1 | Layered Architecture | 3h | Spring Boot, Django |
| 2.2 | MVC Pattern | 3h | ASP.NET Core, Rails |
| 2.3 | Client-Server RESTful | 3h | Express.js, FastAPI |
| 2.4 | Event-Driven Architecture | 4h | Apache Kafka, RabbitMQ |
| 2.5 | Hexagonal Architecture | 4h | Java, TypeScript |
| 2.6 | Clean Architecture | 4h | .NET, NestJS |
| 2.7 | CQRS Pattern | 4h | Event Store, PostgreSQL |
| 2.8 | Strangler Fig Pattern | 3h | Kong, Nginx |

## Mục tiêu Học tập

Sau khi hoàn thành Level 2, sinh viên có thể:

1. **Nhận biết** các mẫu kiến trúc trong hệ thống thực tế
2. **Phân tích** ưu nhược điểm của từng pattern
3. **Thiết kế** kiến trúc sử dụng pattern phù hợp
4. **Triển khai** các patterns trong code

## Pattern Categories

### Structural Patterns (Cấu trúc)
- Layered Architecture (2.1)
- Hexagonal Architecture (2.5)
- Clean Architecture (2.6)

### Communication Patterns (Giao tiếp)
- Client-Server (2.3)
- Event-Driven (2.4)

### Separation Patterns (Phân tách)
- MVC (2.2)
- CQRS (2.7)

### Migration Patterns (Di chuyển)
- Strangler Fig (2.8)

## Prerequisite

- Hoàn thành Level 1: Foundations
- Kiến thức lập trình OOP
- Hiểu biết về REST APIs

## Lộ trình

```
Lab 2.1 (Layered) → Lab 2.2 (MVC) → Lab 2.3 (Client-Server)
 ↓
Lab 2.4 (Event-Driven)
 ↓
Lab 2.5 (Hexagonal) → Lab 2.6 (Clean)
 ↓
Lab 2.7 (CQRS) → Lab 2.8 (Strangler Fig)
```

## Pattern Selection Guide

| Khi nào | Pattern |
|---------|---------|
| CRUD đơn giản | Layered |
| Web app với UI | MVC |
| APIs | Client-Server |
| High throughput, loose coupling | Event-Driven |
| Testability, độc lập framework | Hexagonal |
| Complex domain logic | Clean Architecture |
| Read/Write khác biệt | CQRS |
| Migrate từ monolith | Strangler Fig |
