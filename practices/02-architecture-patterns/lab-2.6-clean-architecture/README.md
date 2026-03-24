# Lab 2.6: Clean Architecture

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 4 giờ |
| **Độ khó** | Advanced |
| **CLO** | CLO2, CLO3, CLO6 |
| **Công nghệ** | .NET Core hoặc NestJS |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu Clean Architecture và The Dependency Rule
2. Phân biệt các layers: Entities, Use Cases, Interface Adapters, Frameworks
3. Triển khai ứng dụng theo Clean Architecture
4. So sánh với Hexagonal Architecture

---

## Phần 1: Clean Architecture Theory (45 phút)

### 1.1 Overview

**Clean Architecture** do Robert C. Martin (Uncle Bob) đề xuất (2012), kết hợp các ý tưởng từ Hexagonal, Onion, và các architectures khác.

```
┌─────────────────────────────────────────────────────────────────────┐
│ Frameworks & Drivers │
│ (Web, UI, DB, Devices, External) │
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ Interface Adapters │ │
│ │ (Controllers, Gateways, Presenters) │ │
│ │ ┌─────────────────────────────────────────────────────┐ │ │
│ │ │ Application Business Rules │ │ │
│ │ │ (Use Cases) │ │ │
│ │ │ ┌─────────────────────────────────────────────┐ │ │ │
│ │ │ │ Enterprise Business Rules │ │ │ │
│ │ │ │ (Entities) │ │ │ │
│ │ │ │ │ │ │ │
│ │ │ │ ┌─────────────────────────────────┐ │ │ │ │
│ │ │ │ │ ENTITIES │ │ │ │ │
│ │ │ │ │ (Business Objects + Rules) │ │ │ │ │
│ │ │ │ └─────────────────────────────────┘ │ │ │ │
│ │ │ └─────────────────────────────────────────────┘ │ │ │
│ │ └─────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────┘
```

### 1.2 The Four Layers

| Layer | Contains | Changes When |
|-------|----------|--------------|
| **Entities** | Enterprise business rules | Business rules change |
| **Use Cases** | Application business rules | App functionality changes |
| **Interface Adapters** | Controllers, Presenters, Gateways | External interface changes |
| **Frameworks & Drivers** | Web, DB, UI frameworks | Technology changes |

### 1.3 The Dependency Rule

> **Source code dependencies must point only inward, toward higher-level policies.**

```
Frameworks → Interface Adapters → Use Cases → Entities
 │ │ │ │
 └──────────────┴────────────────┴───depends on
```

### 1.4 Crossing Boundaries

Khi inner layer cần gọi outer layer (e.g., Use Case cần Repository):

```
┌─────────────────┐ ┌─────────────────┐
│ Use Case │ │ Repository │
│ │ │ (Outer Layer) │
│ ┌───────────┐ │ │ │
│ │ Interface │─┼─────────┼─ Implements │
│ │ (Output │ │ │ │
│ │ Port) │ │ │ │
│ └───────────┘ │ │ │
│ ▲ │ │ │
│ │ │ │ │
│ Uses │ │ │ │
│ │ │ │ │
└────────┼────────┘ └─────────────────┘
 │
 Dependency Inversion!
```

---

## Phần 2: Hands-on với NestJS (120 phút)

### 2.1 Project Setup

```bash
# Install NestJS CLI
npm install -g @nestjs/cli

# Create project
nest new clean-architecture-demo --strict

cd clean-architecture-demo

# Install additional packages
npm install @nestjs/typeorm typeorm uuid class-validator class-transformer
```

### 2.2 Project Structure

```
src/
├── domain/ # Layer 1: Entities
│ ├── entities/
│ │ └── user.entity.ts
│ ├── repositories/
│ │ └── user.repository.interface.ts
│ └── value-objects/
│ └── email.value-object.ts
│
├── application/ # Layer 2: Use Cases
│ ├── use-cases/
│ │ ├── create-user/
│ │ │ ├── create-user.use-case.ts
│ │ │ ├── create-user.dto.ts
│ │ │ └── create-user.spec.ts
│ │ └── get-user/
│ │ └── get-user.use-case.ts
│ └── ports/
│ └── user.repository.port.ts
│
├── infrastructure/ # Layer 3 & 4: Adapters & Frameworks
│ ├── controllers/
│ │ └── user.controller.ts
│ ├── persistence/
│ │ ├── typeorm/
│ │ │ ├── user.typeorm-entity.ts
│ │ │ └── user.typeorm-repository.ts
│ │ └── in-memory/
│ │ └── user.in-memory-repository.ts
│ └── modules/
│ └── user.module.ts
│
├── app.module.ts
└── main.ts
```

### 2.3 Domain Layer - Entities

```typescript
// src/domain/value-objects/email.value-object.ts
export class Email {
 private readonly value: string;

 private constructor(email: string) {
 this.value = email;
 }

 static create(email: string): Email {
 const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
 if (!emailRegex.test(email)) {
 throw new Error('Invalid email format');
 }
 return new Email(email.toLowerCase());
 }

 getValue(): string {
 return this.value;
 }

 equals(other: Email): boolean {
 return this.value === other.value;
 }
}
```

```typescript
// src/domain/entities/user.entity.ts
import { Email } from '../value-objects/email.value-object';

export interface UserProps {
 id: string;
 name: string;
 email: Email;
 createdAt: Date;
 updatedAt: Date;
}

export class User {
 private props: UserProps;

 private constructor(props: UserProps) {
 this.props = props;
 }

 static create(props: Omit<UserProps, 'createdAt' | 'updatedAt'>): User {
 return new User({
 ...props,
 createdAt: new Date(),
 updatedAt: new Date()
 });
 }

 static reconstitute(props: UserProps): User {
 return new User(props);
 }

 get id(): string {
 return this.props.id;
 }

 get name(): string {
 return this.props.name;
 }

 get email(): Email {
 return this.props.email;
 }

 get createdAt(): Date {
 return this.props.createdAt;
 }

 get updatedAt(): Date {
 return this.props.updatedAt;
 }

 changeName(newName: string): void {
 if (!newName || newName.trim().length < 2) {
 throw new Error('Name must be at least 2 characters');
 }
 this.props.name = newName.trim();
 this.props.updatedAt = new Date();
 }

 changeEmail(newEmail: Email): void {
 this.props.email = newEmail;
 this.props.updatedAt = new Date();
 }

 toJSON() {
 return {
 id: this.id,
 name: this.name,
 email: this.email.getValue(),
 createdAt: this.createdAt,
 updatedAt: this.updatedAt
 };
 }
}
```

### 2.4 Application Layer - Ports & Use Cases

```typescript
// src/application/ports/user.repository.port.ts
import { User } from '../../domain/entities/user.entity';

export interface UserRepositoryPort {
 save(user: User): Promise<void>;
 findById(id: string): Promise<User | null>;
 findByEmail(email: string): Promise<User | null>;
 findAll(): Promise<User[]>;
 delete(id: string): Promise<void>;
}

export const USER_REPOSITORY = Symbol('USER_REPOSITORY');
```

```typescript
// src/application/use-cases/create-user/create-user.dto.ts
import { IsEmail, IsString, MinLength } from 'class-validator';

export class CreateUserInputDto {
 @IsString()
 @MinLength(2)
 name: string;

 @IsEmail()
 email: string;
}

export class CreateUserOutputDto {
 id: string;
 name: string;
 email: string;
 createdAt: Date;
}
```

```typescript
// src/application/use-cases/create-user/create-user.use-case.ts
import { Inject, Injectable } from '@nestjs/common';
import { v4 as uuidv4 } from 'uuid';
import { User } from '../../../domain/entities/user.entity';
import { Email } from '../../../domain/value-objects/email.value-object';
import { UserRepositoryPort, USER_REPOSITORY } from '../../ports/user.repository.port';
import { CreateUserInputDto, CreateUserOutputDto } from './create-user.dto';

@Injectable()
export class CreateUserUseCase {
 constructor(
 @Inject(USER_REPOSITORY)
 private readonly userRepository: UserRepositoryPort
 ) {}

 async execute(input: CreateUserInputDto): Promise<CreateUserOutputDto> {
 // Check if email already exists
 const existingUser = await this.userRepository.findByEmail(input.email);
 if (existingUser) {
 throw new Error('Email already registered');
 }

 // Create domain entity
 const email = Email.create(input.email);
 const user = User.create({
 id: uuidv4(),
 name: input.name,
 email
 });

 // Persist
 await this.userRepository.save(user);

 // Return output DTO
 return {
 id: user.id,
 name: user.name,
 email: user.email.getValue(),
 createdAt: user.createdAt
 };
 }
}
```

```typescript
// src/application/use-cases/get-user/get-user.use-case.ts
import { Inject, Injectable } from '@nestjs/common';
import { UserRepositoryPort, USER_REPOSITORY } from '../../ports/user.repository.port';

export interface GetUserOutputDto {
 id: string;
 name: string;
 email: string;
 createdAt: Date;
 updatedAt: Date;
}

@Injectable()
export class GetUserUseCase {
 constructor(
 @Inject(USER_REPOSITORY)
 private readonly userRepository: UserRepositoryPort
 ) {}

 async execute(userId: string): Promise<GetUserOutputDto | null> {
 const user = await this.userRepository.findById(userId);

 if (!user) {
 return null;
 }

 return {
 id: user.id,
 name: user.name,
 email: user.email.getValue(),
 createdAt: user.createdAt,
 updatedAt: user.updatedAt
 };
 }

 async executeAll(): Promise<GetUserOutputDto[]> {
 const users = await this.userRepository.findAll();
 return users.map(user => ({
 id: user.id,
 name: user.name,
 email: user.email.getValue(),
 createdAt: user.createdAt,
 updatedAt: user.updatedAt
 }));
 }
}
```

### 2.5 Infrastructure Layer - Repository Implementation

```typescript
// src/infrastructure/persistence/in-memory/user.in-memory-repository.ts
import { Injectable } from '@nestjs/common';
import { UserRepositoryPort } from '../../../application/ports/user.repository.port';
import { User } from '../../../domain/entities/user.entity';

@Injectable()
export class UserInMemoryRepository implements UserRepositoryPort {
 private users: Map<string, User> = new Map();

 async save(user: User): Promise<void> {
 this.users.set(user.id, user);
 }

 async findById(id: string): Promise<User | null> {
 return this.users.get(id) || null;
 }

 async findByEmail(email: string): Promise<User | null> {
 for (const user of this.users.values()) {
 if (user.email.getValue() === email.toLowerCase()) {
 return user;
 }
 }
 return null;
 }

 async findAll(): Promise<User[]> {
 return Array.from(this.users.values());
 }

 async delete(id: string): Promise<void> {
 this.users.delete(id);
 }
}
```

### 2.6 Infrastructure Layer - Controller

```typescript
// src/infrastructure/controllers/user.controller.ts
import {
 Controller,
 Get,
 Post,
 Body,
 Param,
 HttpException,
 HttpStatus,
 ValidationPipe
} from '@nestjs/common';
import { CreateUserUseCase } from '../../application/use-cases/create-user/create-user.use-case';
import { CreateUserInputDto } from '../../application/use-cases/create-user/create-user.dto';
import { GetUserUseCase } from '../../application/use-cases/get-user/get-user.use-case';

@Controller('users')
export class UserController {
 constructor(
 private readonly createUserUseCase: CreateUserUseCase,
 private readonly getUserUseCase: GetUserUseCase
 ) {}

 @Post()
 async create(@Body(ValidationPipe) input: CreateUserInputDto) {
 try {
 return await this.createUserUseCase.execute(input);
 } catch (error: any) {
 throw new HttpException(error.message, HttpStatus.BAD_REQUEST);
 }
 }

 @Get()
 async findAll() {
 return await this.getUserUseCase.executeAll();
 }

 @Get(':id')
 async findOne(@Param('id') id: string) {
 const user = await this.getUserUseCase.execute(id);
 if (!user) {
 throw new HttpException('User not found', HttpStatus.NOT_FOUND);
 }
 return user;
 }
}
```

### 2.7 Module Configuration

```typescript
// src/infrastructure/modules/user.module.ts
import { Module } from '@nestjs/common';
import { UserController } from '../controllers/user.controller';
import { CreateUserUseCase } from '../../application/use-cases/create-user/create-user.use-case';
import { GetUserUseCase } from '../../application/use-cases/get-user/get-user.use-case';
import { UserInMemoryRepository } from '../persistence/in-memory/user.in-memory-repository';
import { USER_REPOSITORY } from '../../application/ports/user.repository.port';

@Module({
 controllers: [UserController],
 providers: [
 CreateUserUseCase,
 GetUserUseCase,
 {
 provide: USER_REPOSITORY,
 useClass: UserInMemoryRepository
 }
 ]
})
export class UserModule {}
```

```typescript
// src/app.module.ts
import { Module } from '@nestjs/common';
import { UserModule } from './infrastructure/modules/user.module';

@Module({
 imports: [UserModule]
})
export class AppModule {}
```

---

## Phần 3: Clean vs Hexagonal Architecture (30 phút)

### 3.1 Comparison

| Aspect | Clean Architecture | Hexagonal |
|--------|-------------------|-----------|
| **Layers** | 4 concentric circles | Hexagon with ports/adapters |
| **Terminology** | Entities, Use Cases | Domain, Ports, Adapters |
| **Focus** | Independence of frameworks | Testability, flexibility |
| **Origin** | Robert C. Martin (2012) | Alistair Cockburn (2005) |
| **Naming** | More specific | More generic |

### 3.2 Key Differences

- **Clean Architecture** explicitly defines 4 layers
- **Hexagonal** focuses on the concept of ports and adapters
- Both enforce the **Dependency Rule**
- Both achieve similar goals: separation of concerns, testability

---

## Self-Assessment (30 câu)

### Cơ bản (1-10)

1. Clean Architecture là gì?
2. Ai đề xuất Clean Architecture?
3. Clean Architecture có bao nhiêu layers?
4. Entities layer chứa gì?
5. Use Cases layer làm gì?
6. Interface Adapters layer làm gì?
7. Frameworks & Drivers layer chứa gì?
8. The Dependency Rule nói gì?
9. Tại sao cần Value Objects?
10. Domain logic ở layer nào?

### Trung bình (11-20)

11. Input Port vs Output Port?
12. Presenter trong Clean Architecture?
13. Repository interface ở layer nào?
14. DTOs dùng ở đâu?
15. Validation logic ở layer nào?
16. Transaction management ở đâu?
17. Làm sao test Use Cases?
18. Dependency Injection trong Clean?
19. Factory pattern trong Clean?
20. Error handling strategy?

### Nâng cao (21-30)

21. Clean vs Hexagonal vs Onion?
22. Clean Architecture với DDD?
23. Clean với Event Sourcing?
24. Clean với Microservices?
25. Performance overhead của Clean?
26. Khi nào KHÔNG nên dùng Clean?
27. Package structure cho Clean?
28. Modular Clean Architecture?
29. Clean Architecture anti-patterns?
30. Migration từ legacy sang Clean?

**Đáp án gợi ý:**
- 1: Architecture pattern tách business logic khỏi frameworks
- 2: Robert C. Martin (Uncle Bob) năm 2012
- 3: 4 layers (Entities, Use Cases, Interface Adapters, Frameworks)

---

## Extend Labs (10 bài)

### EL1: E-Commerce Use Cases
```
Mục tiêu: Business logic
- Order processing
- Inventory management
- Payment handling
Độ khó: ****
```

### EL2: Multiple Adapters
```
Mục tiêu: Flexibility
- REST adapter
- GraphQL adapter
- CLI adapter
Độ khó: ****
```

### EL3: Event-Driven Clean
```
Mục tiêu: Async processing
- Domain events
- Event handlers
- Eventual consistency
Độ khó: ****
```

### EL4: Testing Strategy
```
Mục tiêu: Full test coverage
- Unit tests
- Integration tests
- E2E tests
Độ khó: ***
```

### EL5: Multi-module Project
```
Mục tiêu: Large-scale
- Separate modules
- Shared kernel
- Module boundaries
Độ khó: ****
```

### EL6: CQRS trong Clean
```
Mục tiêu: Read/Write separation
- Command use cases
- Query use cases
- Optimized models
Độ khó: *****
```

### EL7: External Services
```
Mục tiêu: Third-party integration
- Payment gateway
- Email service
- Cache service
Độ khó: ***
```

### EL8: Security Layer
```
Mục tiêu: Cross-cutting
- Authentication
- Authorization
- Audit logging
Độ khó: ****
```

### EL9: API Versioning
```
Mục tiêu: Evolution
- V1 vs V2
- Backward compatibility
- Deprecation
Độ khó: ***
```

### EL10: Migrate Legacy
```
Mục tiêu: Real-world
- Identify boundaries
- Gradual migration
- Strangler fig
Độ khó: *****
```

---

## Deliverables

1. [ ] Domain entities với value objects
2. [ ] Use cases với input/output DTOs
3. [ ] Repository port và implementation
4. [ ] Controller adapter
5. [ ] NestJS module configuration
6. [ ] Unit tests cho use cases

---

## Tiếp theo

Chuyển đến: `lab-2.7-cqrs/`

---

## Phân bổ Thời gian: Lý thuyết 40', Implementation 80', Testing 30', Review 30' = 3 giờ

## Lời giải Mẫu
- Entities: Business objects
- Use Cases: Application business rules
- Interface Adapters: Controllers, Presenters
- Frameworks: DB, Web, External

## Các Lỗi Thường Gặp
| Lỗi | Cách sửa |
|-----|----------|
| Dependency violation | Inner layers không depend outer |
| Use case quá lớn | Tách nhỏ theo feature |
| Skip layers | Tuân thủ dependency rule |

## Chấm điểm: Dependency rule 35, Use cases 25, Entities 20, Testing 20 = 100

## Tham khảo: Robert C. Martin, MIT 6.170, Georgia Tech CS 6310
