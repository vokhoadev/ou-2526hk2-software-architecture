# Lab 2.2: MVC Pattern (Model-View-Controller)

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **CLO** | CLO2, CLO3 |
| **Công nghệ** | ASP.NET Core MVC hoặc Express.js |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Hiểu MVC pattern và các thành phần
2. Phân biệt trách nhiệm của Model, View, Controller
3. Triển khai ứng dụng web với MVC
4. So sánh MVC với các patterns khác (MVP, MVVM)

---

## Phần 1: Lý thuyết MVC (30 phút)

### 1.1 MVC là gì?

**MVC (Model-View-Controller)** là pattern phân tách ứng dụng thành 3 thành phần chính:

```
┌─────────────────────────────────────────────────────────────┐
│ USER │
└─────────────────────────────────────────────────────────────┘
 │
 ▼
┌─────────────────────────────────────────────────────────────┐
│ CONTROLLER │
│ │
│ - Nhận input từ user │
│ - Xử lý requests │
│ - Điều phối Model và View │
└─────────────────────────────────────────────────────────────┘
 │ │
 ▼ ▼
┌─────────────────────────┐ ┌─────────────────────────────┐
│ MODEL │ │ VIEW │
│ │ │ │
│ - Business logic │ │ - Presentation logic │
│ - Data access │──│ - UI rendering │
│ - Validation │ │ - Display data │
└─────────────────────────┘ └─────────────────────────────┘
```

### 1.2 Trách nhiệm của từng thành phần

| Component | Responsibilities | Examples |
|-----------|-----------------|----------|
| **Model** | Business logic, data, validation | User, Product, Order classes |
| **View** | UI rendering, display data | HTML templates, React components |
| **Controller** | Handle requests, coordinate M&V | UserController, ProductController |

### 1.3 Luồng xử lý trong MVC

```
1. User gửi Request (GET /products/1)
 │
 ▼
2. Controller nhận request
 └── ProductController.Show(id: 1)
 │
 ▼
3. Controller gọi Model
 └── Product.Find(1)
 │
 ▼
4. Model trả về data
 └── { id: 1, name: "iPhone", price: 999 }
 │
 ▼
5. Controller chọn View và truyền data
 └── render("products/show", product)
 │
 ▼
6. View render HTML
 └── <h1>iPhone</h1><p>$999</p>
 │
 ▼
7. Response trả về cho User
```

### 1.4 Ưu nhược điểm MVC

**Ưu điểm:**
- Separation of concerns
- Parallel development (frontend/backend)
- Easy to test (mock components)
- Reusable components
- SEO friendly (server-side rendering)

**Nhược điểm:**
- Controller có thể trở nên "fat"
- Tight coupling giữa View và Model
- Complexity cho small applications
- Learning curve

---

## Phần 2: Hands-on với Express.js MVC (90 phút)

### 2.1 Project Setup

```bash
# Tạo project
mkdir mvc-demo && cd mvc-demo
npm init -y

# Install dependencies
npm install express ejs body-parser method-override

# Tạo cấu trúc thư mục
mkdir -p {models,views/{products,layouts},controllers,routes,public/{css,js}}

# Tạo file chính
touch app.js
```

### 2.2 Project Structure

```
mvc-demo/
├── app.js # Entry point
├── package.json
├── models/
│ └── Product.js # Product model
├── views/
│ ├── layouts/
│ │ └── main.ejs # Layout template
│ └── products/
│ ├── index.ejs # List products
│ ├── show.ejs # Show single product
│ ├── new.ejs # Create form
│ └── edit.ejs # Edit form
├── controllers/
│ └── productController.js
├── routes/
│ └── productRoutes.js
└── public/
 └── css/
 └── style.css
```

### 2.3 Implement Model

```javascript
// models/Product.js
class Product {
 // In-memory storage (replace with database in production)
 static products = [
 { id: 1, name: 'iPhone 15', price: 999, description: 'Latest iPhone', stock: 100 },
 { id: 2, name: 'MacBook Pro', price: 1999, description: '14-inch M3', stock: 50 },
 { id: 3, name: 'AirPods Pro', price: 249, description: 'Wireless earbuds', stock: 200 }
 ];

 static nextId = 4;

 // Find all products
 static findAll() {
 return this.products;
 }

 // Find by ID
 static findById(id) {
 return this.products.find(p => p.id === parseInt(id));
 }

 // Create new product
 static create(data) {
 const product = {
 id: this.nextId++,
 name: data.name,
 price: parseFloat(data.price),
 description: data.description || '',
 stock: parseInt(data.stock) || 0,
 createdAt: new Date()
 };
 this.products.push(product);
 return product;
 }

 // Update product
 static update(id, data) {
 const index = this.products.findIndex(p => p.id === parseInt(id));
 if (index === -1) return null;

 this.products[index] = {
 ...this.products[index],
 name: data.name || this.products[index].name,
 price: data.price ? parseFloat(data.price) : this.products[index].price,
 description: data.description || this.products[index].description,
 stock: data.stock ? parseInt(data.stock) : this.products[index].stock,
 updatedAt: new Date()
 };
 return this.products[index];
 }

 // Delete product
 static delete(id) {
 const index = this.products.findIndex(p => p.id === parseInt(id));
 if (index === -1) return false;
 this.products.splice(index, 1);
 return true;
 }

 // Validation
 static validate(data) {
 const errors = [];
 if (!data.name || data.name.trim().length < 2) {
 errors.push('Name must be at least 2 characters');
 }
 if (!data.price || isNaN(data.price) || parseFloat(data.price) <= 0) {
 errors.push('Price must be a positive number');
 }
 return errors;
 }
}

module.exports = Product;
```

### 2.4 Implement Controller

```javascript
// controllers/productController.js
const Product = require('../models/Product');

const productController = {
 // GET /products - List all products
 index: (req, res) => {
 const products = Product.findAll();
 res.render('products/index', {
 title: 'Products',
 products
 });
 },

 // GET /products/:id - Show single product
 show: (req, res) => {
 const product = Product.findById(req.params.id);
 if (!product) {
 return res.status(404).render('error', {
 message: 'Product not found'
 });
 }
 res.render('products/show', {
 title: product.name,
 product
 });
 },

 // GET /products/new - Show create form
 new: (req, res) => {
 res.render('products/new', {
 title: 'New Product',
 product: {},
 errors: []
 });
 },

 // POST /products - Create product
 create: (req, res) => {
 const errors = Product.validate(req.body);

 if (errors.length > 0) {
 return res.render('products/new', {
 title: 'New Product',
 product: req.body,
 errors
 });
 }

 const product = Product.create(req.body);
 res.redirect(`/products/${product.id}`);
 },

 // GET /products/:id/edit - Show edit form
 edit: (req, res) => {
 const product = Product.findById(req.params.id);
 if (!product) {
 return res.status(404).render('error', {
 message: 'Product not found'
 });
 }
 res.render('products/edit', {
 title: `Edit ${product.name}`,
 product,
 errors: []
 });
 },

 // PUT /products/:id - Update product
 update: (req, res) => {
 const errors = Product.validate(req.body);

 if (errors.length > 0) {
 return res.render('products/edit', {
 title: 'Edit Product',
 product: { id: req.params.id, ...req.body },
 errors
 });
 }

 const product = Product.update(req.params.id, req.body);
 if (!product) {
 return res.status(404).render('error', {
 message: 'Product not found'
 });
 }
 res.redirect(`/products/${product.id}`);
 },

 // DELETE /products/:id - Delete product
 destroy: (req, res) => {
 const result = Product.delete(req.params.id);
 if (!result) {
 return res.status(404).render('error', {
 message: 'Product not found'
 });
 }
 res.redirect('/products');
 }
};

module.exports = productController;
```

### 2.5 Implement Routes

```javascript
// routes/productRoutes.js
const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');

// RESTful routes
router.get('/', productController.index); // List
router.get('/new', productController.new); // New form
router.post('/', productController.create); // Create
router.get('/:id', productController.show); // Show
router.get('/:id/edit', productController.edit); // Edit form
router.put('/:id', productController.update); // Update
router.delete('/:id', productController.destroy); // Delete

module.exports = router;
```

### 2.6 Implement Views

```html
<!-- views/layouts/main.ejs -->
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title><%= title %> | MVC Demo</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
 <style>
 body { padding-top: 60px; }
 .navbar-brand { font-weight: bold; }
 </style>
</head>
<body>
 <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
 <div class="container">
 <a class="navbar-brand" href="/">MVC Demo</a>
 <ul class="navbar-nav">
 <li class="nav-item">
 <a class="nav-link" href="/products">Products</a>
 </li>
 </ul>
 </div>
 </nav>

 <div class="container">
 <%- body %>
 </div>

 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

```html
<!-- views/products/index.ejs -->
<div class="d-flex justify-content-between align-items-center mb-4">
 <h1>Products</h1>
 <a href="/products/new" class="btn btn-primary">+ New Product</a>
</div>

<div class="row">
 <% products.forEach(product => { %>
 <div class="col-md-4 mb-4">
 <div class="card">
 <div class="card-body">
 <h5 class="card-title"><%= product.name %></h5>
 <p class="card-text text-muted"><%= product.description %></p>
 <p class="card-text">
 <strong>$<%= product.price.toFixed(2) %></strong>
 <span class="badge bg-secondary ms-2">Stock: <%= product.stock %></span>
 </p>
 <a href="/products/<%= product.id %>" class="btn btn-outline-primary btn-sm">View</a>
 <a href="/products/<%= product.id %>/edit" class="btn btn-outline-secondary btn-sm">Edit</a>
 </div>
 </div>
 </div>
 <% }); %>
</div>
```

```html
<!-- views/products/show.ejs -->
<nav aria-label="breadcrumb">
 <ol class="breadcrumb">
 <li class="breadcrumb-item"><a href="/products">Products</a></li>
 <li class="breadcrumb-item active"><%= product.name %></li>
 </ol>
</nav>

<div class="card">
 <div class="card-header d-flex justify-content-between">
 <h2><%= product.name %></h2>
 <div>
 <a href="/products/<%= product.id %>/edit" class="btn btn-warning">Edit</a>
 <form action="/products/<%= product.id %>?_method=DELETE" method="POST" class="d-inline">
 <button type="submit" class="btn btn-danger"
 onclick="return confirm('Are you sure?')">Delete</button>
 </form>
 </div>
 </div>
 <div class="card-body">
 <p class="lead"><%= product.description %></p>
 <hr>
 <dl class="row">
 <dt class="col-sm-3">Price</dt>
 <dd class="col-sm-9">$<%= product.price.toFixed(2) %></dd>

 <dt class="col-sm-3">Stock</dt>
 <dd class="col-sm-9"><%= product.stock %> units</dd>

 <dt class="col-sm-3">ID</dt>
 <dd class="col-sm-9">#<%= product.id %></dd>
 </dl>
 </div>
</div>

<a href="/products" class="btn btn-secondary mt-3">&larr; Back to Products</a>
```

```html
<!-- views/products/new.ejs -->
<h1>New Product</h1>

<% if (errors.length > 0) { %>
<div class="alert alert-danger">
 <ul class="mb-0">
 <% errors.forEach(error => { %>
 <li><%= error %></li>
 <% }); %>
 </ul>
</div>
<% } %>

<form action="/products" method="POST" class="needs-validation">
 <div class="mb-3">
 <label for="name" class="form-label">Product Name *</label>
 <input type="text" class="form-control" id="name" name="name"
 value="<%= product.name || '' %>" required>
 </div>

 <div class="mb-3">
 <label for="price" class="form-label">Price *</label>
 <div class="input-group">
 <span class="input-group-text">$</span>
 <input type="number" step="0.01" class="form-control" id="price" name="price"
 value="<%= product.price || '' %>" required>
 </div>
 </div>

 <div class="mb-3">
 <label for="description" class="form-label">Description</label>
 <textarea class="form-control" id="description" name="description" rows="3"><%= product.description || '' %></textarea>
 </div>

 <div class="mb-3">
 <label for="stock" class="form-label">Stock</label>
 <input type="number" class="form-control" id="stock" name="stock"
 value="<%= product.stock || 0 %>">
 </div>

 <button type="submit" class="btn btn-primary">Create Product</button>
 <a href="/products" class="btn btn-secondary">Cancel</a>
</form>
```

```html
<!-- views/products/edit.ejs -->
<h1>Edit Product</h1>

<% if (errors.length > 0) { %>
<div class="alert alert-danger">
 <ul class="mb-0">
 <% errors.forEach(error => { %>
 <li><%= error %></li>
 <% }); %>
 </ul>
</div>
<% } %>

<form action="/products/<%= product.id %>?_method=PUT" method="POST">
 <div class="mb-3">
 <label for="name" class="form-label">Product Name *</label>
 <input type="text" class="form-control" id="name" name="name"
 value="<%= product.name %>" required>
 </div>

 <div class="mb-3">
 <label for="price" class="form-label">Price *</label>
 <div class="input-group">
 <span class="input-group-text">$</span>
 <input type="number" step="0.01" class="form-control" id="price" name="price"
 value="<%= product.price %>" required>
 </div>
 </div>

 <div class="mb-3">
 <label for="description" class="form-label">Description</label>
 <textarea class="form-control" id="description" name="description" rows="3"><%= product.description %></textarea>
 </div>

 <div class="mb-3">
 <label for="stock" class="form-label">Stock</label>
 <input type="number" class="form-control" id="stock" name="stock"
 value="<%= product.stock %>">
 </div>

 <button type="submit" class="btn btn-warning">Update Product</button>
 <a href="/products/<%= product.id %>" class="btn btn-secondary">Cancel</a>
</form>
```

### 2.7 Main Application

```javascript
// app.js
const express = require('express');
const bodyParser = require('body-parser');
const methodOverride = require('method-override');
const path = require('path');
const expressLayouts = require('express-ejs-layouts');

const productRoutes = require('./routes/productRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// View engine setup
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride('_method'));
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.get('/', (req, res) => res.redirect('/products'));
app.use('/products', productRoutes);

// 404 handler
app.use((req, res) => {
 res.status(404).render('error', {
 title: 'Not Found',
 message: 'Page not found'
 });
});

// Start server
app.listen(PORT, () => {
 console.log(` MVC Demo running at http://localhost:${PORT}`);
});
```

---

## Phần 3: MVC Variants (30 phút)

### 3.1 MVC vs MVP vs MVVM

| Pattern | View-Model Interaction | Use Case |
|---------|----------------------|----------|
| **MVC** | View observes Model directly | Web apps (Rails, Django) |
| **MVP** | Presenter mediates all | Android, Windows Forms |
| **MVVM** | Two-way data binding | WPF, Vue.js, Angular |

### 3.2 MVP (Model-View-Presenter)

```
┌────────────┐ ┌────────────┐ ┌────────────┐
│ View │───│ Presenter │───│ Model │
│ │ │ │ │ │
│ (Passive) │ │ (All logic)│ │ (Data) │
└────────────┘ └────────────┘ └────────────┘
```

### 3.3 MVVM (Model-View-ViewModel)

```
┌────────────┐ ┌────────────┐ ┌────────────┐
│ View │══│ ViewModel │───│ Model │
│ │ │ │ │ │
│ (Binding) │ │ (State) │ │ (Data) │
└────────────┘ └────────────┘ └────────────┘
 ║
 ╚═══ Two-way data binding
```

---

## Phần 4: Bài tập Mở rộng (30 phút)

### Bài tập 4.1: Add Category

Thêm Category model với relationship:
- Product belongs to Category
- Category has many Products

### Bài tập 4.2: Add Search

Thêm search functionality:
- Search by product name
- Filter by price range
- Sort by name/price

### Bài tập 4.3: Add API

Tạo JSON API endpoints:
- GET /api/products
- GET /api/products/:id
- POST /api/products

---

## Self-Assessment

### Quiz

1. MVC gồm những thành phần nào?
 - a) Model, View, Controller
 - b) Module, View, Component
 - c) Model, Variable, Controller
 - d) Manager, View, Controller

2. Controller có trách nhiệm:
 - a) Render HTML
 - b) Store data
 - c) Handle requests và coordinate M&V
 - d) Validate input

3. Trong Express.js MVC, route definitions thường đặt ở:
 - a) Model
 - b) View
 - c) Controller
 - d) Routes folder

4. MVP khác MVC ở điểm:
 - a) View giao tiếp trực tiếp với Model
 - b) Presenter mediates tất cả
 - c) Không có Controller
 - d) Không có View

5. Two-way data binding là đặc điểm của:
 - a) MVC
 - b) MVP
 - c) MVVM
 - d) Tất cả

**Đáp án**: 1-a, 2-c, 3-d, 4-b, 5-c

### Câu 6-30 (Trung bình → Nâng cao)

6. View có được gọi trực tiếp Model không trong MVC?
7. Controller có chứa business logic không?
8. Fat Controller là anti-pattern gì?
9. Thin Controller principle là gì?
10. MVC trong Web vs Desktop khác nhau thế nào?
11. RESTful routing trong MVC?
12. Middleware trong MVC framework là gì?
13. ViewModels khác Models thế nào?
14. Partial views dùng khi nào?
15. Layout/Master pages trong MVC?
16. Form validation ở đâu (client vs server)?
17. CSRF protection trong MVC?
18. Session management trong MVC?
19. Caching strategies trong MVC?
20. Error handling và error pages?
21. MVVM khác MVC thế nào?
22. MVP khác MVC thế nào?
23. MVC có phù hợp cho SPA không?
24. MVC với microservices?
25. Testing strategies cho MVC?
26. Dependency Injection trong Controllers?
27. Action filters trong ASP.NET MVC?
28. Route constraints và route templates?
29. Content negotiation trong MVC?
30. MVC best practices cho enterprise apps?

**Đáp án gợi ý:**
- 6: Có, View có thể observe Model (Observer pattern)
- 21: MVVM có two-way binding, ViewModel thay Controller
- 23: Không lý tưởng, nên dùng API + SPA frameworks

---

## Extend Labs (10 bài)

### EL1: Full CRUD với Authentication
```
Mục tiêu: Complete MVC app
- User registration/login
- Session management
- Role-based access
Độ khó: ***
```

### EL2: RESTful API với MVC
```
Mục tiêu: API design
- JSON responses
- Content negotiation
- API versioning
Độ khó: ***
```

### EL3: Real-time với WebSocket
```
Mục tiêu: Real-time features
- Socket.io integration
- Live updates
- Chat feature
Độ khó: ***
```

### EL4: File Upload/Download
```
Mục tiêu: File handling
- Image upload
- File storage
- Thumbnail generation
Độ khó: **
```

### EL5: Search và Pagination
```
Mục tiêu: Data handling
- Full-text search
- Pagination
- Sorting/Filtering
Độ khó: **
```

### EL6: Internationalization
```
Mục tiêu: i18n support
- Multiple languages
- Date/currency formats
- RTL support
Độ khó: ***
```

### EL7: Admin Dashboard
```
Mục tiêu: Admin interface
- CRUD for all entities
- Charts/Reports
- Audit logging
Độ khó: ***
```

### EL8: E-commerce Cart
```
Mục tiêu: Shopping cart
- Add/remove items
- Checkout flow
- Order history
Độ khó: ****
```

### EL9: Blog với CMS
```
Mục tiêu: Content management
- Rich text editor
- Categories/Tags
- Comments
Độ khó: ***
```

### EL10: Multi-tenant SaaS
```
Mục tiêu: SaaS architecture
- Tenant isolation
- Custom domains
- Subscription management
Độ khó: *****
```

---

## Deliverables

1. [ ] Express.js MVC application với CRUD
2. [ ] Model với validation
3. [ ] Controller với error handling
4. [ ] Views với EJS templates
5. [ ] RESTful routes

---

## Tài liệu Tham khảo

1. Express.js Documentation: https://expressjs.com/
2. EJS Template Engine: https://ejs.co/
3. Martin Fowler - GUI Architectures: https://martinfowler.com/eaaDev/uiArchs.html

---

## Tiếp theo

Chuyển đến: `lab-2.3-client-server/`

---

## Phân bổ Thời gian Chi tiết

| Phần | Hoạt động | Thời gian |
|------|-----------|-----------|
| **Phần 1** | Lý thuyết MVC | 30 phút |
| **Phần 2** | Hands-on Implementation | 90 phút |
| **Phần 3** | Testing & Review | 30 phút |
| **Phần 4** | Bài tập mở rộng | 30 phút |
| **Tổng** | | **3 giờ** |

---

## Lời giải Mẫu

### MVC Flow chuẩn

```
User Request → Controller → Model → Controller → View → Response
 │ │ │ │ │
 │ (handle) (business) (prepare) (render)
```

### Ví dụ Controller chuẩn

```java
@Controller
public class ProductController {
 private final ProductService productService;

 @GetMapping("/products")
 public String listProducts(Model model) {
 // Controller chỉ điều phối, không có logic
 List<Product> products = productService.findAll();
 model.addAttribute("products", products);
 return "product/list"; // View name
 }
}
```

---

## Các Lỗi Thường Gặp

| Lỗi | Biểu hiện | Cách sửa |
|-----|-----------|----------|
| **Fat Controller** | Logic trong Controller | Chuyển vào Service |
| **View logic trong Model** | Formatting trong entity | Dùng ViewModels/DTOs |
| **Controller gọi View trực tiếp** | Bypass Model | Tuân thủ MVC flow |
| **Shared state** | Controller có state | Stateless controllers |

---

## Tiêu chí Chấm điểm

| Tiêu chí | Điểm |
|----------|------|
| MVC separation rõ ràng | 30 |
| Controller không có business logic | 25 |
| View chỉ render, không có logic | 20 |
| Model có validation | 15 |
| Code organization | 10 |
| **Tổng** | **100** |

---

## Nguồn Tham khảo Học thuật

### Đại học Quốc tế
- **Stanford** CS 142 - Web Applications (MVC pattern)
- **MIT** 6.170 - Software Studio
- **UC Berkeley** CS 169 - Software Engineering

### Đại học Việt Nam
- **ĐH Bách Khoa TP.HCM** CO3001 - MVC Pattern
- **ĐH FPT** SWD391 - Web Architecture
- **RMIT Vietnam** COSC2430 - Web Programming
