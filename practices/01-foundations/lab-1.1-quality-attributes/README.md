# Lab 1.1: Quality Attributes Workshop

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Beginner |
| **CLO** | CLO1, CLO2 |
| **Công cụ** | Miro, FigJam, hoặc giấy/bút |

## Mục tiêu

Sau khi hoàn thành lab này, bạn có thể:
1. Liệt kê và giải thích các Quality Attributes phổ biến
2. Phân loại Quality Attributes theo categories
3. Xác định Quality Attributes cho một hệ thống cụ thể
4. Viết Quality Attribute Scenarios (QAS)

---

## Phân bổ Thời gian Chi tiết

| Phần | Hoạt động | Thời gian | Ghi chú |
|------|-----------|-----------|---------|
| **Phần 1** | Lý thuyết Quality Attributes | 45 phút | Đọc + thảo luận |
| | - 1.1 Khái niệm QAs | 15 phút | |
| | - 1.2 Operational vs Structural | 15 phút | |
| | - 1.3 Quality Attribute Scenarios | 15 phút | |
| **Phần 2** | Thực hành xác định QAs | 60 phút | Làm bài tập |
| | - Bài tập 2.1: Phân loại | 15 phút | Cá nhân |
| | - Bài tập 2.2: Case Study | 20 phút | Cá nhân/Nhóm |
| | - Bài tập 2.3: Viết QAS | 25 phút | Cá nhân |
| **Phần 3** | Workshop Activity | 60 phút | Nhóm 3-5 người |
| | - Step 1: Brainstorm | 15 phút | |
| | - Step 2: Categorize | 10 phút | |
| | - Step 3: Dot Voting | 10 phút | |
| | - Step 4: Stack Rank | 15 phút | |
| | - Step 5: Define Scenarios | 10 phút | |
| **Phần 4** | Case Studies thực tế | 30 phút | Đọc + phân tích |
| **Tổng** | | **3 giờ 15 phút** | Buffer 15 phút |

---

## Phần 1: Lý thuyết (45 phút)

### 1.1 Quality Attributes là gì?

**Quality Attributes (QAs)** - hay còn gọi là **Thuộc tính chất lượng** - là các yêu cầu phi chức năng định nghĩa chất lượng tổng thể của hệ thống phần mềm.

> [Goi y] **Phân biệt đơn giản:**
> - **Functional Requirements** (Yêu cầu chức năng): Hệ thống làm được **những gì**? *(VD: Đăng nhập, thanh toán, tìm kiếm)*
> - **Quality Attributes** (Thuộc tính chất lượng): Hệ thống làm **tốt đến mức nào**? *(VD: Nhanh, ổn định, bảo mật)*

### 1.2 Phân loại Quality Attributes

#### Operational QAs (Thuộc tính vận hành)
Đây là các thuộc tính đo được khi hệ thống **đang hoạt động** (runtime). Người dùng cuối có thể cảm nhận trực tiếp:

| QA | Ý nghĩa | Ví dụ cụ thể |
|----|--------|--------------|
| **Performance** | Hệ thống phản hồi nhanh như thế nào? | Trang load dưới 200ms |
| **Availability** | Hệ thống hoạt động liên tục ra sao? | Uptime 99.9% (downtime < 9 giờ/năm) |
| **Scalability** | Hệ thống chịu tải tốt không? | Xử lý được gấp 10 lần traffic bình thường |
| **Reliability** | Hệ thống có đáng tin cậy không? | Chạy ổn định > 720 giờ không lỗi |
| **Security** | Hệ thống có an toàn không? | Không có lỗ hổng bảo mật nghiêm trọng |

#### Structural QAs (Thuộc tính cấu trúc)
Đây là các thuộc tính đo được trong **quá trình phát triển** (design-time). Chủ yếu ảnh hưởng đến đội ngũ kỹ thuật:

| QA | Ý nghĩa | Ví dụ cụ thể |
|----|--------|--------------|
| **Maintainability** | Code có dễ bảo trì không? | Sửa bug trong vòng 4 giờ |
| **Testability** | Code có dễ viết test không? | Độ phủ test > 80% |
| **Modifiability** | Thêm tính năng mới có dễ không? | Thay đổi chỉ ảnh hưởng < 10 files |
| **Portability** | Có chạy được trên nhiều nền tảng? | Deploy được lên AWS, Azure, GCP |
| **Reusability** | Có tái sử dụng được code không? | 60% components dùng chung |

### 1.3 Quality Attribute Scenarios (QAS) - Kịch bản chất lượng

**QAS** là cách mô tả yêu cầu chất lượng một cách **cụ thể và đo lường được**. Thay vì nói chung chung "hệ thống phải nhanh", ta viết thành một kịch bản rõ ràng.

Một QAS hoàn chỉnh gồm **6 thành phần**:

```
┌─────────────────────────────────────────────────────────────┐
│ Quality Attribute Scenario (QAS) │
├──────────────┬──────────────────────────────────────────────┤
│ Source │ Ai gây ra sự kiện? (User, Hacker, Hệ thống) │
│ Stimulus │ Điều gì xảy ra? (Request, Tấn công, Lỗi) │
│ Artifact │ Thành phần nào bị ảnh hưởng? (Service nào?) │
│ Environment │ Hoàn cảnh lúc đó? (Giờ cao điểm, Bình thường)│
│ Response │ Hệ thống xử lý ra sao? (Trả kết quả, Chặn) │
│ Measure │ Đo bằng con số gì? (< 500ms, 99.9% uptime) │
└──────────────┴──────────────────────────────────────────────┘
```

**Ví dụ - Performance QAS:**
- **Source**: User
- **Stimulus**: Request product search
- **Artifact**: Search service
- **Environment**: Normal operation, 1000 concurrent users
- **Response**: Return search results
- **Measure**: Within 500ms, 99th percentile

---

## Phần 2: Thực hành (60 phút)

### Bài tập 2.1: Phân loại Quality Attributes (15 phút)

**Yêu cầu**: Hãy xếp các QAs dưới đây vào đúng nhóm Operational hoặc Structural:

1. Testability
2. Availability
3. Performance
4. Maintainability
5. Security
6. Scalability
7. Portability
8. Reliability

**Điền vào bảng:**

| Operational | Structural |
|-------------|------------|
| ? | ? |

---

### Bài tập 2.2: Tình huống thực tế - Sàn E-Commerce (20 phút)

**Tình huống**: Bạn là Solution Architect được giao thiết kế hệ thống cho một sàn thương mại điện tử với các yêu cầu:
- Phục vụ **100.000 người dùng cùng lúc** vào giờ cao điểm
- Xử lý **thanh toán online** (ví điện tử, thẻ ngân hàng)
- Quản lý **1 triệu sản phẩm** trong catalog
- Tổ chức **Flash Sale** định kỳ hàng tháng

**Yêu cầu**: Chọn ra 5 Quality Attributes quan trọng nhất và giải thích lý do tại sao.

**Template:**

| Thứ tự | Quality Attribute | Lý do quan trọng |
|--------|-------------------|------------------|
| 1 | ? | ? |
| 2 | ? | ? |
| 3 | ? | ? |
| 4 | ? | ? |
| 5 | ? | ? |

---

### Bài tập 2.3: Viết kịch bản QAS (25 phút)

**Yêu cầu**: Dựa trên tình huống E-Commerce ở trên, viết 3 kịch bản QAS đầy đủ 6 thành phần.

**Template QAS 1 - Performance:**
```
Source: _____________________
Stimulus: _____________________
Artifact: _____________________
Environment: _____________________
Response: _____________________
Measure: _____________________
```

**Template QAS 2 - Availability:**
```
Source: _____________________
Stimulus: _____________________
Artifact: _____________________
Environment: _____________________
Response: _____________________
Measure: _____________________
```

**Template QAS 3 - Security:**
```
Source: _____________________
Stimulus: _____________________
Artifact: _____________________
Environment: _____________________
Response: _____________________
Measure: _____________________
```

---

## Lời giải Mẫu (Sample Solutions)

### Đáp án Bài tập 2.1: Phân loại Quality Attributes

| Operational (Runtime) | Structural (Design-time) |
|-----------------------|--------------------------|
| Availability | Testability |
| Performance | Maintainability |
| Security | Portability |
| Scalability | |
| Reliability | |

**Cách phân biệt dễ nhớ:**
- **Operational QAs**: Người dùng cảm nhận được *(hệ thống chậm, bị sập, bị hack)*
- **Structural QAs**: Chỉ developer/team kỹ thuật biết *(code khó đọc, khó test, khó sửa)*

> **Lưu ý**: Security là trường hợp đặc biệt - thuộc **cả hai loại**:
> - Lỗ hổng trong code → Structural (phát hiện khi review code)
> - Bị tấn công thực tế → Operational (xảy ra khi hệ thống đang chạy)

---

### Đáp án Bài tập 2.2: Top 5 QAs cho E-Commerce

| Thứ tự | Quality Attribute | Lý do quan trọng |
|--------|-------------------|------------------|
| 1 | **Scalability** | Flash sale cần handle 100K users đồng thời, traffic spike 10x |
| 2 | **Performance** | Checkout phải nhanh (<3s), search phải responsive (<500ms) |
| 3 | **Availability** | Downtime = mất doanh thu, đặc biệt trong flash sale |
| 4 | **Security** | Payment processing cần PCI-DSS compliance, protect user data |
| 5 | **Reliability** | Order processing không được mất data, transactions consistent |

**Phân tích thêm:**

```
┌─────────────────────────────────────────────────────────────────┐
│ E-Commerce QA Priority Matrix │
├──────────────────┬────────────────┬─────────────────────────────┤
│ QA │ Impact Level │ Risk if Not Met │
├──────────────────┼────────────────┼─────────────────────────────┤
│ Scalability │ Critical │ Site crash during sale │
│ Performance │ Critical │ Cart abandonment 7%/second │
│ Availability │ Critical │ Revenue loss $5K/minute │
│ Security │ Critical │ Data breach, legal issues │
│ Reliability │ High │ Order loss, refunds │
│ Maintainability │ Medium │ Slow feature delivery │
└──────────────────┴────────────────┴─────────────────────────────┘
```

---

### Đáp án Bài tập 2.3: Quality Attribute Scenarios

**QAS 1 - Performance:**
```
Source: End user (customer)
Stimulus: Search for "iPhone 15" during flash sale
Artifact: Search Service, Product Catalog
Environment: Peak load (100,000 concurrent users), Flash sale event
Response: Return top 20 relevant products with images and prices
Measure: Response time < 500ms at 99th percentile
 Throughput: 10,000 searches/second
```

**QAS 2 - Availability:**
```
Source: System failure (database node crash)
Stimulus: Primary database node becomes unavailable
Artifact: Order Processing Service, Database cluster
Environment: Normal operation with 50,000 active sessions
Response: Failover to replica node, continue processing orders
Measure: Failover time < 30 seconds
 Zero data loss
 99.9% availability (8.76 hours downtime/year max)
```

**QAS 3 - Security:**
```
Source: Malicious actor (external attacker)
Stimulus: SQL injection attempt on login form
Artifact: Authentication Service, User Database
Environment: Production environment, public-facing
Response: Block attack, log incident, alert security team
Measure: Zero successful injections
 Attack detected < 100ms
 Incident logged with full details
 Security team alerted < 1 minute
```

**QAS Bonus - Scalability:**
```
Source: Marketing team (internal)
Stimulus: Announce flash sale starting in 5 minutes
Artifact: All frontend services, API Gateway, Order Service
Environment: Normal load transitioning to 10x spike
Response: Auto-scale resources, maintain performance
Measure: Scale from 10 to 100 instances in < 2 minutes
 No degradation in response time during scaling
 Cost increase proportional to load
```

---

## Phần 3: Workshop Activity (60 phút)

### Workshop: Xác định ưu tiên Quality Attributes

**Mục tiêu**: Thực hành điều phối một buổi họp xác định QAs quan trọng nhất cho dự án

**Chuẩn bị:**
- Miro board hoặc FigJam (làm online)
- Giấy note, bảng trắng (làm offline)
- Đồng hồ bấm giờ

**Quy trình 5 bước:**

#### Bước 1: Thu thập ý tưởng (15 phút)
- Mỗi người viết ra tất cả QAs mà họ nghĩ là quan trọng
- Giai đoạn này **không tranh luận**, chỉ ghi nhận
- Mỗi QA viết vào 1 sticky note riêng

#### Bước 2: Phân nhóm (10 phút)
- Gom các QAs giống nhau lại
- Phân thành 2 nhóm: Operational và Structural
- Loại bỏ những ý trùng lặp

#### Bước 3: Bình chọn (10 phút)
- Mỗi thành viên có **5 phiếu bầu**
- Dán phiếu vào QAs mà mình cho là quan trọng nhất
- Tối đa 2 phiếu cho cùng 1 QA

#### Bước 4: Xếp hạng (15 phút)
- Đếm phiếu, xếp top 5 QAs được vote nhiều nhất
- Nếu có QA bằng điểm → thảo luận để chọn

#### Bước 5: Viết kịch bản (10 phút)
- Viết QAS cho 3 QAs quan trọng nhất
- Đảm bảo đủ 6 thành phần

---

## Phần 4: Case Studies từ Thực tế (30 phút)

### Case Study 1: Netflix
**Context**: Video streaming platform, 200M+ subscribers

**Top QAs:**
1. **Availability** (99.99% uptime)
2. **Performance** (start streaming < 2s)
3. **Scalability** (handle traffic spikes)
4. **Reliability** (no buffering)

**Architectural Decisions:**
- Microservices architecture
- Global CDN
- Chaos engineering (Chaos Monkey)

### Case Study 2: Shopee/Tiki (Vietnam)
**Context**: E-commerce platform, flash sales

**Top QAs:**
1. **Scalability** (handle 10x traffic in flash sale)
2. **Performance** (checkout < 3s)
3. **Availability** (no downtime during sale)
4. **Security** (payment protection)

**Architectural Decisions:**
- Event-driven architecture
- Caching layers
- Queue-based order processing

---

## Các Lỗi Thường Gặp (Cần Tránh)

### Lỗi khi Xác định Quality Attributes

| # | Lỗi | [Khong] Sai | [OK] Đúng |
|---|-----|-------|--------|
| 1 | **Nhầm với chức năng** | "Phải có chức năng đăng nhập" | "Đăng nhập xong trong 2 giây" |
| 2 | **Nói chung chung** | "Hệ thống phải nhanh" | "Trang load dưới 200ms với 99% requests" |
| 3 | **Không có số liệu** | "Độ sẵn sàng cao" | "Uptime 99.9% (dừng tối đa 9 giờ/năm)" |
| 4 | **Ưu tiên hết tất cả** | "10 QAs đều quan trọng như nhau" | "Chọn 3-5 QAs quan trọng nhất, có đánh đổi" |
| 5 | **Thiếu ngữ cảnh** | "Xử lý dưới 100ms" | "Xử lý dưới 100ms khi có 10.000 người dùng" |

### Lỗi khi Viết QAS

| # | Lỗi | [Khong] Sai | [OK] Đúng |
|---|-----|-------|--------|
| 1 | **Viết thiếu** | Chỉ có 2-3 thành phần | Viết đủ cả 6 thành phần |
| 2 | **Hoàn cảnh mơ hồ** | "Hoạt động bình thường" | "Giờ cao điểm, 100K users, Black Friday" |
| 3 | **Không đo được** | "Phản hồi nhanh" | "Dưới 500ms với 99% requests" |
| 4 | **Phi thực tế** | "1 tỷ request/giây" | Dựa trên traffic thực tế của dự án |
| 5 | **Quá chung** | "Hệ thống" | "Service Xử lý Đơn hàng" |

### Lỗi khi Xếp thứ tự ưu tiên

```
[Khong] SAI: Quyết định theo cảm tính
 "Security quan trọng nhất vì mọi người đều nói vậy"

[OK] ĐÚNG: Quyết định dựa trên tác động kinh doanh
 "Security là số 1 vì chúng ta xử lý thanh toán.
 Nếu bị lộ dữ liệu → phạt $10 triệu + mất uy tín"
```

```
[Khong] SAI: Muốn tất cả đều hoàn hảo
 "Vừa phải nhanh nhất VÀ bảo mật nhất"

[OK] ĐÚNG: Chấp nhận đánh đổi hợp lý
 "Chấp nhận chậm thêm 50ms để mã hóa dữ liệu,
 đổi lại đạt chuẩn bảo mật PCI-DSS"
```

### Lỗi phân loại thường gặp

| QA | [Khong] Hay nhầm | [OK] Giải thích đúng |
|----|------------|-------------------|
| **Security** | Chỉ là Operational | Thuộc **cả hai**: lỗ hổng code (Structural) + bị tấn công (Operational) |
| **Testability** | Là Operational | Là **Structural** - chỉ biết khi viết code, không phải khi chạy |
| **Maintainability** | Không biết xếp | Là **Structural** - đo bằng độ phức tạp code, tài liệu, cấu trúc |

---

## Grading Rubric - Tiêu chí Chấm điểm

### Tổng quan

| Bài tập | Điểm tối đa | Trọng số |
|---------|-------------|----------|
| Bài tập 2.1: Phân loại QAs | 10 điểm | 15% |
| Bài tập 2.2: Top 5 QAs | 30 điểm | 35% |
| Bài tập 2.3: Viết QAS | 40 điểm | 40% |
| Workshop participation | 10 điểm | 10% |
| **Tổng** | **90 điểm** | **100%** |

---

### Rubric Chi tiết: Bài tập 2.1 - Phân loại QAs (10 điểm)

| Tiêu chí | Xuất sắc (10) | Tốt (8) | Đạt (6) | Chưa đạt (<6) |
|----------|---------------|---------|---------|---------------|
| **Độ chính xác** | 8/8 đúng | 6-7/8 đúng | 4-5/8 đúng | <4/8 đúng |
| **Giải thích** | Có giải thích rõ ràng | Giải thích cơ bản | Không giải thích | N/A |

---

### Rubric Chi tiết: Bài tập 2.2 - Top 5 QAs (30 điểm)

| Tiêu chí | Điểm | Xuất sắc | Tốt | Đạt | Chưa đạt |
|----------|------|----------|-----|-----|----------|
| **Lựa chọn QAs phù hợp** | 10 | 5/5 QAs relevant | 4/5 relevant | 3/5 relevant | <3/5 |
| **Thứ tự ưu tiên hợp lý** | 10 | Có logic rõ ràng, trade-off | Logic cơ bản | Thiếu logic | Không có logic |
| **Lý do giải thích** | 10 | Specific, measurable, business-driven | General but valid | Vague | Missing |

**Điểm thưởng (+5):**
- Có so sánh với industry benchmarks
- Mention trade-offs giữa các QAs
- Cite sources (Netflix, Amazon, etc.)

---

### Rubric Chi tiết: Bài tập 2.3 - Viết QAS (40 điểm)

**Mỗi QAS: 13.33 điểm (tổng 3 QAS = 40 điểm)**

| Thành phần | Điểm | Tiêu chí đạt điểm tối đa |
|------------|------|--------------------------|
| **Source** | 2 | Specific, realistic (User, System, Attacker) |
| **Stimulus** | 2 | Concrete event/condition, measurable |
| **Artifact** | 2 | Specific component/service, not "the system" |
| **Environment** | 2 | Detailed context (load, time, conditions) |
| **Response** | 2 | Clear system behavior description |
| **Measure** | 3 | Quantifiable, testable, with percentile |

**Điểm trừ:**
- Thiếu 1 thành phần: -2 điểm
- Measure không đo được: -2 điểm
- Copy y nguyên ví dụ: -5 điểm

---

### Rubric: Workshop Participation (10 điểm)

| Tiêu chí | Điểm | Mô tả |
|----------|------|-------|
| **Tham gia brainstorm** | 3 | Đóng góp ≥ 3 ideas |
| **Thảo luận constructive** | 3 | Có ý kiến, không chỉ đồng ý |
| **Hoàn thành đúng thời gian** | 2 | Theo timeline |
| **Teamwork** | 2 | Hỗ trợ team members |

---

### Thang điểm Tổng kết

| Điểm | Xếp loại | Mô tả |
|------|----------|-------|
| 90-100 | A+ | Xuất sắc, vượt expectations |
| 80-89 | A | Tốt, hiểu sâu concepts |
| 70-79 | B | Khá, nắm được kiến thức cơ bản |
| 60-69 | C | Đạt, cần cải thiện |
| <60 | F | Chưa đạt, cần học lại |

---

## Tự đánh giá (30 câu)

### Mức cơ bản (Câu 1-10)

1. Quality Attribute (Thuộc tính chất lượng) là gì? Cho ví dụ.
2. Phân biệt giữa yêu cầu chức năng và thuộc tính chất lượng?
3. Kể tên 5 Quality Attributes thường gặp nhất trong dự án thực tế?
4. Performance đo bằng những chỉ số nào? (response time, throughput,...)
5. Availability là gì? Tính thế nào? (VD: 99.9% nghĩa là gì?)
6. Có mấy loại Scalability? Khác nhau thế nào?
7. Security gồm những mảng nào? (CIA triad là gì?)
8. Maintainability quan trọng với ai? Đo bằng gì?
9. Vì sao Testability ảnh hưởng đến chất lượng sản phẩm?
10. Reliability và Availability khác nhau chỗ nào?

### Mức trung bình (Câu 11-20)

11. QAS (Quality Attribute Scenario) có bao nhiêu thành phần? Kể tên?
12. "Stimulus" trong QAS nghĩa là gì? Cho 3 ví dụ?
13. "Response" và "Response Measure" khác nhau chỗ nào?
14. Làm sao phân biệt Operational QAs và Structural QAs?
15. Khi nào cần quan tâm đến Portability? Cho ví dụ thực tế.
16. Dự án nào cần ưu tiên Modifiability? Vì sao?
17. Trong cuộc họp, làm sao thuyết phục team chọn đúng QAs ưu tiên?
18. Nếu phải chọn giữa Performance và Security, bạn cân nhắc gì?
19. Tiêu chuẩn ISO/IEC 25010 nói gì về Quality Attributes?
20. Architectural Tactics là gì? Cho 2 ví dụ cho Performance?

### Mức nâng cao (Câu 21-30)

21. Có những cách nào đo Maintainability? (code metrics, time-to-fix,...)
22. Elasticity và Scalability khác nhau thế nào? Cho ví dụ?
23. Fault Tolerance và High Availability - cái nào quan trọng hơn với ngân hàng?
24. "Defense in Depth" trong Security nghĩa là gì? Áp dụng thế nào?
25. Technical Debt (nợ kỹ thuật) ảnh hưởng đến QAs nào nhiều nhất?
26. Chaos Engineering (VD: Chaos Monkey của Netflix) kiểm tra QA nào?
27. Observability gồm những thành phần gì? (logs, metrics, traces)
28. SLA, SLO, SLI - giải thích sự khác biệt và cho ví dụ?
29. Khi deadline gấp, làm sao cân bằng giữa "ship nhanh" và "đảm bảo chất lượng"?
30. Architecture Fitness Functions là gì? Tự động hóa kiểm tra QAs thế nào?

**Gợi ý đáp án:**
- **Câu 1**: Thuộc tính mô tả hệ thống hoạt động **tốt như thế nào**, không phải làm được **gì**
- **Câu 11**: 6 thành phần - Source, Stimulus, Artifact, Environment, Response, Measure
- **Câu 22**: Elasticity = tự động co giãn theo tải; Scalability = khả năng mở rộng khi cần
- **Câu 28**: SLA = cam kết với khách hàng; SLO = mục tiêu nội bộ; SLI = số liệu đo thực tế

---

## Bài tập Mở rộng (10 bài)

### EL1: Phân tích QA cho sàn E-Commerce
```
Đề bài: Phân tích hệ thống Shopee hoặc Lazada
- Xác định 10 QAs quan trọng nhất
- Viết 5 QAS cho tình huống Flash Sale 12.12
- So sánh với Tiki/Sendo
Độ khó: **
```

### EL2: Hệ thống Ngân hàng
```
Đề bài: Thiết kế QAs cho ứng dụng Mobile Banking
- Yêu cầu bảo mật (PCI-DSS compliance)
- Độ sẵn sàng 99.99% (downtime < 53 phút/năm)
- Xử lý giao dịch chính xác 100%
Độ khó: ***
```

### EL3: Hệ thống Y tế
```
Đề bài: QAs cho hệ thống quản lý bệnh viện
- Tuân thủ quy định bảo mật dữ liệu bệnh nhân
- Độ tin cậy cao (không được mất dữ liệu)
- Ghi log đầy đủ mọi thao tác
Độ khó: ****
```

### EL4: Game Online Realtime
```
Đề bài: QAs cho game MOBA/FPS online
- Độ trễ dưới 50ms (ping thấp)
- Hỗ trợ 1 triệu người chơi đồng thời
- Đồng bộ trạng thái game chính xác
Độ khó: ****
```

### EL5: Nền tảng IoT
```
Đề bài: QAs cho hệ thống Smart Home/Smart City
- Hoạt động ổn định khi mạng yếu/mất kết nối
- Quản lý 10 triệu thiết bị
- Bảo mật thiết bị IoT
Độ khó: ****
```

### EL6: SaaS Multi-tenant
```
Đề bài: QAs cho phần mềm SaaS phục vụ nhiều công ty
- Cách ly dữ liệu giữa các khách hàng
- Hiệu năng không bị ảnh hưởng bởi khách hàng khác
- Cho phép tùy chỉnh theo từng khách hàng
Độ khó: ***
```

### EL7: Nền tảng Streaming Video
```
Đề bài: Xây dựng QAs giống Netflix/YouTube
- CDN phân phối nội dung toàn cầu
- Tự động điều chỉnh chất lượng theo băng thông
- Hoạt động 24/7 không gián đoạn
Độ khó: ****
```

### EL8: Dashboard theo dõi QA
```
Đề bài: Xây dựng bảng điều khiển giám sát chất lượng
- Định nghĩa KPI cho 5 QAs chính
- Thu thập metrics bằng Prometheus
- Hiển thị trực quan bằng Grafana
Độ khó: ***
```

### EL9: Ma trận Đánh đổi QA
```
Đề bài: Tạo công cụ hỗ trợ quyết định
- Xây dựng ma trận so sánh các QAs
- Lượng hóa mức độ đánh đổi
- Ghi chép lý do quyết định (ADR)
Độ khó: ***
```

### EL10: Đánh giá Hệ thống Cũ
```
Đề bài: Phân tích và đề xuất cải tiến hệ thống legacy
- Đánh giá hiện trạng QAs
- Xác định điểm yếu cần khắc phục
- Lập kế hoạch cải thiện theo thứ tự ưu tiên
Độ khó: ****
```

---

## Bài nộp

Sau khi hoàn thành lab, bạn cần nộp các sản phẩm sau:

| # | Sản phẩm | Bài tập | Hình thức |
|---|----------|---------|-----------|
| 1 | Bảng phân loại 8 QAs | Bài tập 2.1 | File Word/PDF |
| 2 | Top 5 QAs cho E-Commerce + Lý do | Bài tập 2.2 | File Word/PDF |
| 3 | 3 kịch bản QAS đầy đủ 6 thành phần | Bài tập 2.3 | File Word/PDF |
| 4 | Kết quả workshop (nếu làm nhóm) | Phần 3 | Ảnh chụp Miro/bảng |

---

## Tài liệu Tham khảo

1. Bass, L., Clements, P., & Kazman, R. (2021). *Software Architecture in Practice* (4th ed.). Chapter 4: Quality Attributes.
2. Richards, M., & Ford, N. (2020). *Fundamentals of Software Architecture*. Chapter 4: Architecture Characteristics Defined.
3. ISO/IEC 25010:2011 - Software Quality Model

---

## Nguồn Tham khảo Học thuật (University Resources)

### Đại học Quốc tế - Courses & Labs

#### MIT (Massachusetts Institute of Technology)
| Resource | Link | Mô tả |
|----------|------|-------|
| **6.031 Software Construction** | [MIT OCW](https://ocw.mit.edu/courses/6-031-software-construction-spring-2022/) | Quality, testing, specs |
| **6.033 Computer System Engineering** | [MIT OCW](https://ocw.mit.edu/courses/6-033-computer-system-engineering-spring-2018/) | System design, tradeoffs |
| **6.824 Distributed Systems** | [MIT](https://pdos.csail.mit.edu/6.824/) | Reliability, consistency |

#### CMU (Carnegie Mellon University)
| Resource | Link | Mô tả |
|----------|------|-------|
| **SEI Software Architecture** | [SEI](https://www.sei.cmu.edu/our-work/software-architecture/) | ATAM, Quality Attributes |
| **17-214 Principles of Software** | [CMU](https://www.cs.cmu.edu/~charlie/courses/17-214/) | Design principles |
| **Architecture Documentation** | [SEI Library](https://resources.sei.cmu.edu/library/) | Views and Beyond |

#### Stanford University
| Resource | Link | Mô tả |
|----------|------|-------|
| **CS 190 Software Design Studio** | [Stanford](https://cs.stanford.edu/) | Architecture design |
| **CS 349D Cloud Computing** | [Stanford](https://web.stanford.edu/class/cs349d/) | Scalability, availability |

#### UC Berkeley
| Resource | Link | Mô tả |
|----------|------|-------|
| **CS 169 Software Engineering** | [Berkeley](https://www2.eecs.berkeley.edu/Courses/CS169/) | SaaS architecture |
| **CS 262A Distributed Systems** | [Berkeley](https://people.eecs.berkeley.edu/~brewer/) | CAP theorem (Eric Brewer) |

#### Georgia Tech
| Resource | Link | Mô tả |
|----------|------|-------|
| **CS 6310 Software Architecture** | [GT OMSCS](https://omscs.gatech.edu/cs-6310-software-architecture-and-design) | Full SA course |
| **CS 6340 Software Analysis** | [GT](https://omscs.gatech.edu/) | Testing, quality |

#### Other International Universities
| University | Course | Focus |
|------------|--------|-------|
| **ETH Zurich** | Distributed Systems | Consistency models |
| **TU Munich** | Software Architecture | European perspective |
| **University of Waterloo** | SE 464 Architecture | Practical labs |
| **Delft University** | Software Architecture | Research-based |

---

### (VN) Đại học Việt Nam - Courses & Labs

#### ĐH Bách Khoa TP.HCM (HCMUT)
| Mã môn | Tên môn | Nội dung liên quan |
|--------|---------|---------------------|
| **CO3001** | Công nghệ phần mềm | Software engineering fundamentals |
| **CO4027** | Kiến trúc & Thiết kế phần mềm | Quality Attributes, patterns |
| **CO3017** | Phương pháp phát triển PM | SOLID, design principles |
| Website | [hcmut.edu.vn](https://www.hcmut.edu.vn/) | |

#### ĐH Bách Khoa Hà Nội (HUST)
| Mã môn | Tên môn | Nội dung liên quan |
|--------|---------|---------------------|
| **IT4995** | Kiến trúc phần mềm | Full architecture course |
| **IT3180** | Công nghệ phần mềm | SE fundamentals |
| **IT4409** | Phát triển ứng dụng web | Web architecture |
| Website | [hust.edu.vn](https://www.hust.edu.vn/) | |

#### ĐH Công nghệ - ĐHQGHN (VNU-UET)
| Mã môn | Tên môn | Nội dung liên quan |
|--------|---------|---------------------|
| **INT3105** | Thiết kế phần mềm | Design, quality |
| **INT2208** | Công nghệ phần mềm | SE basics |
| Website | [uet.vnu.edu.vn](https://uet.vnu.edu.vn/) | |

#### ĐH FPT
| Mã môn | Tên môn | Nội dung liên quan |
|--------|---------|---------------------|
| **SWD391** | Software Architecture | Full course |
| **SWP391** | Software Development Project | Applied design |
| **SWD392** | Software Design | Design patterns |
| Website | [daihoc.fpt.edu.vn](https://daihoc.fpt.edu.vn/) | |

#### ĐH RMIT Vietnam
| Mã môn | Tên môn | Nội dung liên quan |
|--------|---------|---------------------|
| **COSC2440** | Software Architecture | International curriculum |
| **COSC2430** | Web Programming | Web architecture |
| Website | [rmit.edu.vn](https://www.rmit.edu.vn/) | |

#### ĐH KHTN TP.HCM (HCMUS)
| Mã môn | Tên môn | Nội dung liên quan |
|--------|---------|---------------------|
| **CSC13007** | Thiết kế phần mềm | Software design |
| **CSC13010** | Kiến trúc phần mềm | Architecture |
| Website | [hcmus.edu.vn](https://www.hcmus.edu.vn/) | |

---

### Papers & Research (Academic Publications)

#### Foundational Papers

| Paper | Authors | Year | Source | Key Contribution |
|-------|---------|------|--------|------------------|
| "Software Architecture in Practice" | Bass, Clements, Kazman | 2003-2021 | CMU SEI | Định nghĩa QAs chuẩn |
| "Quality Attribute Workshops" | Barbacci et al. | 2003 | CMU SEI | QAW methodology |
| "ATAM: Method for Architecture Evaluation" | Kazman, Klein, Clements | 2000 | CMU SEI | Tradeoff analysis |
| "ISO/IEC 25010 Quality Model" | ISO/IEC | 2011 | ISO | International standard |

#### Research Papers

| Paper | Authors | Year | Source | Focus |
|-------|---------|------|--------|-------|
| "Towards a Theory of Software Architecture" | Perry & Wolf | 1992 | ACM | Foundation theory |
| "An Introduction to Software Architecture" | Garlan & Shaw | 1993 | CMU | Classic introduction |
| "The C4 Model for Software Architecture" | Simon Brown | 2018 | InfoQ | Modern visualization |
| "Quality Attribute Trade-Off Analysis Method" | Kazman et al. | 1998 | SEI | ATAM foundation |

#### Vietnam Research

| Paper/Thesis | Institution | Year | Topic |
|--------------|-------------|------|-------|
| Luận văn ThS về Software Architecture | HCMUT | 2020-2024 | Various SA topics |
| Nghiên cứu Quality Attributes | VNU | 2019-2024 | QA in Vietnamese context |

---

### Online Courses (MOOCs)

| Platform | Course | Instructor/University | Link |
|----------|--------|----------------------|------|
| **Coursera** | Software Architecture | University of Alberta | [Link](https://www.coursera.org/learn/software-architecture) |
| **Coursera** | Design Patterns | University of Alberta | [Link](https://www.coursera.org/learn/design-patterns) |
| **edX** | Software Construction | MIT | [Link](https://www.edx.org/course/software-construction-object-oriented-programming) |
| **Udacity** | Software Architecture & Design | Georgia Tech | [Link](https://www.udacity.com/course/software-architecture-design--ud821) |
| **Pluralsight** | Software Architecture Fundamentals | Neal Ford | [Link](https://www.pluralsight.com/) |
| **O'Reilly** | Fundamentals of Software Architecture | Richards & Ford | [Link](https://www.oreilly.com/) |

---

### Exercises & Practice Materials

#### From Universities

| Source | Type | Description | Access |
|--------|------|-------------|--------|
| MIT OCW | Problem Sets | 6.031 exercises | Free |
| CMU SEI | Case Studies | Real-world architecture cases | Free |
| Stanford | Projects | Course projects | Some public |
| Georgia Tech | Assignments | OMSCS homework | Enrolled students |

#### Online Practice

| Platform | Type | Description |
|----------|------|-------------|
| **LeetCode** | System Design | Architecture problems |
| **Educative.io** | Interactive | Grokking System Design |
| **Architecture Katas** | Workshops | O'Reilly events |
| **GitHub** | Open Source | Real architecture examples |

---

### Additional Resources

#### Official Documentation
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Azure Architecture Center](https://docs.microsoft.com/en-us/azure/architecture/)
- [Google Cloud Architecture](https://cloud.google.com/architecture)

#### Community
- [InfoQ Architecture](https://www.infoq.com/architecture-design/)
- [Martin Fowler's Blog](https://martinfowler.com/)
- [ThoughtWorks Technology Radar](https://www.thoughtworks.com/radar)

---

## Tiếp theo

Chuyển đến: `lab-1.2-tradeoff-analysis/`
