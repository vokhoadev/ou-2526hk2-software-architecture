# Lab 2.1: Layered Architecture

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **CLO** | CLO2, CLO3 |
| **Công nghệ** | Spring Boot hoặc Django |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu cấu trúc Layered Architecture
2. Phân biệt trách nhiệm của từng layer
3. Triển khai ứng dụng với layered structure
4. Áp dụng best practices cho layer communication

---

## Phần 1: Lý thuyết (30 phút)

### 1.1 Layered Architecture là gì?

Layered Architecture (N-tier) tổ chức code thành các tầng (layers) với trách nhiệm riêng biệt.

```
┌─────────────────────────────────────────┐
│ Presentation Layer │
│ (Controllers, Views, DTOs) │
├─────────────────────────────────────────┤
│ Business Logic Layer │
│ (Services, Domain Logic) │
├─────────────────────────────────────────┤
│ Data Access Layer │
│ (Repositories, DAOs) │
├─────────────────────────────────────────┤
│ Database Layer │
│ (Tables, Stored Procedures) │
└─────────────────────────────────────────┘
```

### 1.2 Layer Responsibilities

| Layer | Trách nhiệm | Ví dụ |
|-------|-------------|-------|
| **Presentation** | Handle HTTP requests, render views | Controllers, REST endpoints |
| **Business Logic** | Business rules, validation | Services, Domain models |
| **Data Access** | Database operations | Repositories, ORMs |
| **Database** | Data persistence | PostgreSQL, MySQL |

### 1.3 Rules of Layered Architecture

1. **Top-down dependency**: Layer trên chỉ gọi layer dưới
2. **No skip-layer calls**: Không bỏ qua layer (trừ open layers)
3. **Single responsibility**: Mỗi layer có 1 trách nhiệm
4. **Encapsulation**: Layer che giấu implementation details

### 1.4 Ưu nhược điểm

**Ưu điểm:**
- Separation of concerns
- Easy to understand
- Testable (mock layer dưới)
- Team organization

**Nhược điểm:**
- Potential performance overhead
- Can become "lasagna architecture"
- All changes go through all layers
- Difficult to scale independently

---

## Phần 2: Hands-on Spring Boot (90 phút)

### Project Setup

```bash
# Tạo project Spring Boot
curl https://start.spring.io/starter.zip \
 -d type=maven-project \
 -d language=java \
 -d bootVersion=3.2.0 \
 -d baseDir=layered-demo \
 -d groupId=com.example \
 -d artifactId=layered-demo \
 -d name=layered-demo \
 -d dependencies=web,data-jpa,h2,lombok,validation \
 -o layered-demo.zip

unzip layered-demo.zip
cd layered-demo
```

### Project Structure

```
src/main/java/com/example/layereddemo/
├── LayeredDemoApplication.java
├── presentation/
│ ├── controller/
│ │ └── ProductController.java
│ └── dto/
│ ├── ProductRequest.java
│ └── ProductResponse.java
├── business/
│ ├── service/
│ │ ├── ProductService.java
│ │ └── ProductServiceImpl.java
│ └── exception/
│ └── ProductNotFoundException.java
├── data/
│ ├── entity/
│ │ └── Product.java
│ └── repository/
│ └── ProductRepository.java
└── config/
 └── AppConfig.java
```

### Bài tập 2.1: Implement Product CRUD

**Step 1: Entity (Data Layer)**

```java
// data/entity/Product.java
@Entity
@Table(name = "products")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
 @Id
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 private Long id;

 @Column(nullable = false)
 private String name;

 @Column(nullable = false)
 private String description;

 @Column(nullable = false)
 private BigDecimal price;

 private Integer quantity;

 @Column(name = "created_at")
 private LocalDateTime createdAt;
}
```

**Step 2: Repository (Data Layer)**

```java
// data/repository/ProductRepository.java
@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
 List<Product> findByNameContaining(String name);
 List<Product> findByPriceLessThan(BigDecimal price);
}
```

**Step 3: DTOs (Presentation Layer)**

```java
// presentation/dto/ProductRequest.java
@Data
public class ProductRequest {
 @NotBlank
 private String name;

 private String description;

 @NotNull
 @Positive
 private BigDecimal price;

 @Min(0)
 private Integer quantity;
}

// presentation/dto/ProductResponse.java
@Data
@Builder
public class ProductResponse {
 private Long id;
 private String name;
 private String description;
 private BigDecimal price;
 private Integer quantity;
 private LocalDateTime createdAt;

 public static ProductResponse from(Product product) {
 return ProductResponse.builder()
 .id(product.getId())
 .name(product.getName())
 .description(product.getDescription())
 .price(product.getPrice())
 .quantity(product.getQuantity())
 .createdAt(product.getCreatedAt())
 .build();
 }
}
```

**Step 4: Service (Business Layer)**

```java
// business/service/ProductService.java
public interface ProductService {
 ProductResponse createProduct(ProductRequest request);
 ProductResponse getProduct(Long id);
 List<ProductResponse> getAllProducts();
 ProductResponse updateProduct(Long id, ProductRequest request);
 void deleteProduct(Long id);
}

// business/service/ProductServiceImpl.java
@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
 private final ProductRepository productRepository;

 @Override
 public ProductResponse createProduct(ProductRequest request) {
 Product product = new Product();
 product.setName(request.getName());
 product.setDescription(request.getDescription());
 product.setPrice(request.getPrice());
 product.setQuantity(request.getQuantity());
 product.setCreatedAt(LocalDateTime.now());

 Product saved = productRepository.save(product);
 return ProductResponse.from(saved);
 }

 @Override
 public ProductResponse getProduct(Long id) {
 Product product = productRepository.findById(id)
 .orElseThrow(() -> new ProductNotFoundException(id));
 return ProductResponse.from(product);
 }

 // Implement other methods...
}
```

**Step 5: Controller (Presentation Layer)**

```java
// presentation/controller/ProductController.java
@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {
 private final ProductService productService;

 @PostMapping
 public ResponseEntity<ProductResponse> createProduct(
 @Valid @RequestBody ProductRequest request) {
 ProductResponse response = productService.createProduct(request);
 return ResponseEntity.status(HttpStatus.CREATED).body(response);
 }

 @GetMapping("/{id}")
 public ResponseEntity<ProductResponse> getProduct(@PathVariable Long id) {
 return ResponseEntity.ok(productService.getProduct(id));
 }

 @GetMapping
 public ResponseEntity<List<ProductResponse>> getAllProducts() {
 return ResponseEntity.ok(productService.getAllProducts());
 }

 @PutMapping("/{id}")
 public ResponseEntity<ProductResponse> updateProduct(
 @PathVariable Long id,
 @Valid @RequestBody ProductRequest request) {
 return ResponseEntity.ok(productService.updateProduct(id, request));
 }

 @DeleteMapping("/{id}")
 public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
 productService.deleteProduct(id);
 return ResponseEntity.noContent().build();
 }
}
```

---

## Phần 3: Testing (30 phút)

### Unit Test for Service Layer

```java
@ExtendWith(MockitoExtension.class)
class ProductServiceImplTest {

 @Mock
 private ProductRepository productRepository;

 @InjectMocks
 private ProductServiceImpl productService;

 @Test
 void createProduct_shouldReturnCreatedProduct() {
 // Given
 ProductRequest request = new ProductRequest();
 request.setName("Test Product");
 request.setPrice(BigDecimal.valueOf(99.99));

 Product savedProduct = new Product();
 savedProduct.setId(1L);
 savedProduct.setName("Test Product");

 when(productRepository.save(any())).thenReturn(savedProduct);

 // When
 ProductResponse response = productService.createProduct(request);

 // Then
 assertNotNull(response);
 assertEquals(1L, response.getId());
 verify(productRepository).save(any());
 }
}
```

---

## Phần 4: Bài tập Mở rộng (30 phút)

### Bài tập 4.1: Add Category Management

Thêm Category với relationship:
- Category có nhiều Products
- Product thuộc 1 Category

### Bài tập 4.2: Add Business Rules

Thêm validation trong service layer:
- Không cho phép xóa product đã có orders
- Giá phải > 0
- Quantity không được âm

---

## Self-Assessment (30 câu)

### Cơ bản (1-10)

1. Layered Architecture là gì?
2. Có mấy layers trong N-tier architecture?
3. Presentation Layer làm gì?
4. Business Logic Layer chứa gì?
5. Data Access Layer có nhiệm vụ gì?
6. DTO (Data Transfer Object) là gì?
7. Repository Pattern dùng để làm gì?
8. Tại sao cần tách layers?
9. Dependency direction trong layered architecture?
10. Layer nào xử lý HTTP requests?

### Trung bình (11-20)

11. Tại sao cần DTOs thay vì return Entities trực tiếp?
12. Layer nào nên chứa validation logic?
13. Lazy loading ảnh hưởng gì trong layered architecture?
14. Cross-cutting concerns (logging, security) đặt ở đâu?
15. Open layer vs Closed layer khác nhau thế nào?
16. Làm sao test từng layer độc lập?
17. Transaction management đặt ở layer nào?
18. Exception handling strategy trong layered architecture?
19. Dependency Injection trong layered architecture?
20. Circular dependencies giữa layers - cách fix?

### Nâng cao (21-30)

21. Layered vs Clean Architecture - khác nhau thế nào?
22. Layered architecture có scale được không?
23. Anti-patterns trong layered architecture?
24. Anemic Domain Model là gì?
25. Domain-Driven Design với layered architecture?
26. Microservices có dùng layered architecture không?
27. Performance issues trong layered architecture?
28. Khi nào KHÔNG nên dùng layered architecture?
29. Làm sao migrate từ layered sang hexagonal?
30. Vertical slicing vs Horizontal layering?

**Đáp án gợi ý:**
- 10: Presentation Layer (Controllers)
- 11: Security, không expose DB schema, flexibility
- 22: Có, nhưng cần cẩn thận với shared database

---

## Extend Labs (10 bài)

### EL1: Enterprise CRUD Application
```
Mục tiêu: Complete layered app
- 5 entities với relationships
- Full CRUD operations
- Validation, Error handling
Độ khó: ***
```

### EL2: Multi-module Maven/Gradle
```
Mục tiêu: Module separation
- Separate JAR per layer
- Enforce dependencies
- Build automation
Độ khó: ***
```

### EL3: Add Caching Layer
```
Mục tiêu: Caching strategy
- Redis cache
- Cache invalidation
- Performance comparison
Độ khó: ***
```

### EL4: Add Authentication
```
Mục tiêu: Security layer
- JWT authentication
- Role-based access
- Security testing
Độ khó: ***
```

### EL5: API Versioning
```
Mục tiêu: API evolution
- V1 vs V2 endpoints
- Backward compatibility
- Deprecation strategy
Độ khó: ***
```

### EL6: Database Migration
```
Mục tiêu: DB evolution
- Flyway/Liquibase
- Schema versioning
- Rollback strategy
Độ khó: ***
```

### EL7: Integration Testing
```
Mục tiêu: Test all layers
- Testcontainers
- API tests
- Database tests
Độ khó: ***
```

### EL8: Monitoring & Logging
```
Mục tiêu: Observability
- Structured logging
- Metrics per layer
- Distributed tracing
Độ khó: ***
```

### EL9: Performance Optimization
```
Mục tiêu: Optimize layers
- N+1 query problem
- Batch operations
- Connection pooling
Độ khó: ****
```

### EL10: Migrate to Hexagonal
```
Mục tiêu: Architecture evolution
- Identify ports/adapters
- Refactor step by step
- Compare testability
Độ khó: *****
```

---

## Deliverables

1. [ ] Working Spring Boot application với layered structure
2. [ ] CRUD operations cho Product
3. [ ] Unit tests cho Service layer
4. [ ] Category management (mở rộng)

---

## Tiếp theo

Chuyển đến: `lab-2.2-mvc/`

---

## Phân bổ Thời gian Chi tiết

| Phần | Hoạt động | Thời gian |
|------|-----------|-----------|
| **Phần 1** | Lý thuyết Layered Architecture | 30 phút |
| **Phần 2** | Hands-on Spring Boot | 90 phút |
| **Phần 3** | Testing | 30 phút |
| **Phần 4** | Bài tập mở rộng | 30 phút |
| **Tổng** | | **3 giờ** |

---

## Lời giải Mẫu

### Cấu trúc Folder chuẩn

```
src/main/java/com/example/
├── presentation/ # Controllers, DTOs
│ ├── controller/
│ └── dto/
├── business/ # Services, Domain Logic
│ ├── service/
│ └── domain/
├── data/ # Repositories, Entities
│ ├── repository/
│ └── entity/
└── config/ # Configuration
```

### Ví dụ Service Layer

```java
@Service
public class OrderService {
 private final OrderRepository orderRepository;

 // Chỉ inject Repository, không inject Controller
 public OrderService(OrderRepository orderRepository) {
 this.orderRepository = orderRepository;
 }

 public Order createOrder(CreateOrderRequest request) {
 // Business logic ở đây
 Order order = new Order(request.getItems());
 return orderRepository.save(order);
 }
}
```

---

## Các Lỗi Thường Gặp

| Lỗi | Biểu hiện | Cách sửa |
|-----|-----------|----------|
| **Layer skip** | Controller gọi thẳng Repository | Luôn qua Service layer |
| **Circular dependency** | Service A inject Service B và ngược lại | Tách thành service nhỏ hơn |
| **Business logic trong Controller** | Validation, calculation trong Controller | Chuyển vào Service |
| **Entity leak** | Trả Entity trực tiếp từ API | Dùng DTO |
| **Quá nhiều layers** | 7-8 layers không cần thiết | Giữ 3-4 layers cơ bản |

---

## Tiêu chí Chấm điểm

| Tiêu chí | Điểm |
|----------|------|
| Cấu trúc folder đúng chuẩn | 20 |
| Layer separation rõ ràng | 25 |
| Không có business logic trong Controller | 15 |
| Sử dụng DTO đúng cách | 15 |
| Unit tests cho Service layer | 15 |
| Code clean, readable | 10 |
| **Tổng** | **100** |

---

## Nguồn Tham khảo Học thuật

### Đại học Quốc tế
- **MIT** 6.170 - Layered Design
- **CMU** 17-214 - Software Design Patterns
- **Stanford** CS 108 - Object-Oriented Systems Design

### Đại học Việt Nam
- **ĐH Bách Khoa TP.HCM** CO3001 - Software Engineering
- **ĐH FPT** SWD391 - Software Architecture
- **ĐH Bách Khoa Hà Nội** IT3180 - Software Development

### Papers & Books
- "Patterns of Enterprise Application Architecture" - Martin Fowler
- "Clean Architecture" - Robert C. Martin
- "Domain-Driven Design" - Eric Evans
