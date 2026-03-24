# Lab 1.2: Phân tích Đánh đổi trong Kiến trúc (Tradeoff Analysis)

## Thông tin Lab

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | ** Beginner |
| **Yêu cầu trước** | Hoàn thành Lab 1.1 |
| **Công cụ** | Bảng tính (Excel/Google Sheets), draw.io |

## Mục tiêu Học tập

Sau khi hoàn thành lab này, bạn có thể:

1. **Hiểu rõ** vì sao đánh đổi là điều không thể tránh trong thiết kế kiến trúc
2. **Nhận diện** các đánh đổi phổ biến giữa các thuộc tính chất lượng
3. **Sử dụng** framework để phân tích và ghi chép các đánh đổi
4. **Ra quyết định** có căn cứ dựa trên phân tích đánh đổi

---

## Phân bổ Thời gian Chi tiết

| Phần | Hoạt động | Thời gian | Ghi chú |
|------|-----------|-----------|---------|
| **Phần 1** | Lý thuyết về Tradeoffs | 40 phút | Đọc + thảo luận |
| | - 1.1 Vì sao cần phân tích đánh đổi? | 10 phút | |
| | - 1.2 Các đánh đổi phổ biến | 10 phút | |
| | - 1.3 Định lý CAP | 10 phút | |
| | - 1.4 Framework phân tích | 10 phút | |
| **Phần 2** | Ma trận Đánh đổi | 15 phút | Học cách đọc/tạo |
| **Phần 3** | Bài tập Thực hành | 90 phút | 4 bài tập |
| | - Bài 1: Xác định Tradeoffs | 20 phút | |
| | - Bài 2: Decision Matrix | 30 phút | |
| | - Bài 3: CAP Theorem | 20 phút | |
| | - Bài 4: Case Study Flash Sale | 20 phút | |
| **Phần 4** | Viết ADR (Document) | 15 phút | Template + thực hành |
| **Phần 5** | Tự đánh giá | 20 phút | 30 câu hỏi |
| **Tổng** | | **3 giờ** | |

---

## Phần 1: Lý thuyết

### 1.1 Vì sao cần Phân tích Đánh đổi?

> [Goi y] **Câu nói kinh điển:** "Không có giải pháp hoàn hảo. Chỉ có đánh đổi." — Thomas Sowell

Trong thiết kế kiến trúc phần mềm, bạn **KHÔNG THỂ** tối ưu tất cả mọi thứ cùng lúc. Khi cải thiện một thuộc tính, bạn thường phải hy sinh thuộc tính khác.

**Ví dụ thực tế:**

| Muốn tăng | Phải chấp nhận giảm | Lý do |
|-----------|---------------------|-------|
| **Bảo mật** | Tốc độ | Mã hóa, xác thực tốn thời gian xử lý |
| **Độ sẵn sàng** | Chi phí | Cần máy chủ dự phòng, backup |
| **Linh hoạt** | Đơn giản | Nhiều tùy chọn = nhiều code phức tạp |
| **Hiệu năng** | Dễ bảo trì | Code tối ưu thường khó đọc, khó sửa |

### 1.2 Các Đánh đổi Phổ biến

| Cặp đánh đổi | Giải thích | Ví dụ thực tế |
|--------------|------------|---------------|
| **Performance Security** | Mã hóa/xác thực làm chậm hệ thống | HTTPS chậm hơn HTTP 10-20% |
| **Consistency Availability** | Định lý CAP (xem phần 1.3) | Ngân hàng vs Mạng xã hội |
| **Scalability Simplicity** | Hệ thống phân tán phức tạp hơn | Monolith vs Microservices |
| **Maintainability Performance** | Code sạch có thể chậm hơn code tối ưu | Clean Code vs Optimized Code |
| **Flexibility Complexity** | Nhiều tính năng = nhiều phức tạp | CMS đa năng vs Blog đơn giản |
| **Cost Quality** | Chất lượng cao thường đắt đỏ | Junior dev vs Senior dev |

### 1.3 Định lý CAP (CAP Theorem)

**CAP Theorem** phát biểu rằng trong hệ thống phân tán, bạn **chỉ có thể đảm bảo 2 trong 3** thuộc tính:

```
 Consistency (Nhất quán)
 /\
 / \
 / CA \
 /______\
 /\ /\
 / CP\ /AP \
 /____\/______\
Availability Partition
(Sẵn sàng) Tolerance
 (Chịu lỗi mạng)
```

| Loại | Ý nghĩa | Ví dụ hệ thống |
|------|---------|----------------|
| **CA** | Nhất quán + Sẵn sàng (không chịu lỗi mạng) | PostgreSQL đơn lẻ (không phân tán) |
| **CP** | Nhất quán + Chịu lỗi (hy sinh sẵn sàng) | MongoDB, HBase, Redis Cluster |
| **AP** | Sẵn sàng + Chịu lỗi (hy sinh nhất quán) | Cassandra, DynamoDB, CouchDB |

**Khi nào chọn CP?** → Dữ liệu quan trọng, không được sai (ngân hàng, kho hàng)
**Khi nào chọn AP?** → Cần hoạt động liên tục, chấp nhận dữ liệu cũ (mạng xã hội, analytics)

### 1.4 Framework Phân tích Đánh đổi

Quy trình 5 bước để phân tích đánh đổi:

```
Bước 1: Liệt kê các Quality Attributes liên quan
 ↓
Bước 2: Xác định các cặp đánh đổi tiềm năng
 ↓
Bước 3: Đánh giá mức độ ảnh hưởng (Cao/Trung bình/Thấp)
 ↓
Bước 4: Đối chiếu với ưu tiên kinh doanh
 ↓
Bước 5: Ghi chép quyết định (viết ADR)
```

---

## Phần 2: Ma trận Đánh đổi (Tradeoff Matrix)

### Cách đọc Ma trận Đánh đổi

Ma trận này cho thấy mối quan hệ giữa các Quality Attributes khi cải thiện từng cái:

| | Performance | Security | Scalability | Maintainability | Cost |
|--|-------------|----------|-------------|-----------------|------|
| **Performance** | — | v Đánh đổi | ^ Hỗ trợ | v Đánh đổi | ^ Đánh đổi |
| **Security** | v Đánh đổi | — | -> Trung lập | v Đánh đổi | ^ Đánh đổi |
| **Scalability** | ^ Hỗ trợ | -> Trung lập | — | v Đánh đổi | ^ Đánh đổi |
| **Maintainability** | v Đánh đổi | v Đánh đổi | v Đánh đổi | — | v Đánh đổi |
| **Cost** | ^ Đánh đổi | ^ Đánh đổi | ^ Đánh đổi | v Đánh đổi | — |

**Cách đọc:**
- ^ **Hỗ trợ (Synergy)**: Cải thiện cái này giúp cái kia tốt hơn
- v **Đánh đổi (Trade)**: Cải thiện cái này làm cái kia xấu đi
- -> **Trung lập (Neutral)**: Không ảnh hưởng nhiều

---

## Phần 3: Bài tập Thực hành

### Bài tập 1: Xác định Đánh đổi (20 phút)

Với mỗi tình huống, hãy xác định **3 cặp đánh đổi quan trọng nhất**:

**Tình huống A: Sàn Giao dịch Chứng khoán**
- Yêu cầu: Độ trễ cực thấp (<1ms), thông lượng cao
- Ràng buộc: Ngân sách hạn chế, team nhỏ

| # | Cặp đánh đổi | Bạn sẽ ưu tiên bên nào? | Lý do |
|---|--------------|-------------------------|-------|
| 1 | Performance ___ | | |
| 2 | ___ Cost | | |
| 3 | ___ Maintainability | | |

**Tình huống B: Hệ thống Hồ sơ Y tế**
- Yêu cầu: Tuân thủ quy định bảo mật, hoạt động 24/7
- Ràng buộc: Phải tích hợp với hệ thống cũ

| # | Cặp đánh đổi | Bạn sẽ ưu tiên bên nào? | Lý do |
|---|--------------|-------------------------|-------|
| 1 | Security ___ | | |
| 2 | Availability ___ | | |
| 3 | ___ Interoperability | | |

---

### Bài tập 2: Ma trận Quyết định có Trọng số (30 phút)

**Tình huống:** Sàn thương mại điện tử cần chọn chiến lược database

**Các lựa chọn:**
- **A**: PostgreSQL đơn lẻ (đơn giản, nhất quán)
- **B**: PostgreSQL + Redis cache (nhanh hơn, phức tạp hơn)
- **C**: PostgreSQL cluster phân tán (mở rộng tốt, đắt)

**Bước 1:** Điền điểm từ 1-5 cho mỗi tiêu chí (5 = tốt nhất)

| Tiêu chí | Trọng số | Option A | Option B | Option C |
|----------|----------|----------|----------|----------|
| Performance (Hiệu năng) | 0.25 | ? | ? | ? |
| Scalability (Mở rộng) | 0.20 | ? | ? | ? |
| Simplicity (Đơn giản) | 0.20 | ? | ? | ? |
| Cost (Chi phí thấp) | 0.20 | ? | ? | ? |
| Consistency (Nhất quán) | 0.15 | ? | ? | ? |
| **Tổng điểm** | **1.00** | ? | ? | ? |

**Bước 2:** Tính điểm tổng = Σ (Điểm x Trọng số)

**Bước 3:** Đưa ra khuyến nghị và giải thích lý do

---

### Bài tập 3: Áp dụng Định lý CAP (20 phút)

Với mỗi use case, chọn **CP** hoặc **AP** và giải thích:

| Use Case | CP hay AP? | Lý do |
|----------|------------|-------|
| Chuyển tiền ngân hàng | | |
| News feed Facebook | | |
| Giỏ hàng online | | |
| Quản lý tồn kho | | |
| Session đăng nhập | | |
| Dữ liệu analytics | | |
| Đặt vé máy bay | | |
| Chat realtime | | |

---

### Bài tập 4: Phân tích Case Study - Flash Sale Shopee (20 phút)

**Bối cảnh Flash Sale:**
- Hơn 10,000 requests/giây
- Lượng truy cập gấp 100 lần bình thường
- Thời gian giới hạn (1-2 giờ)

**Các quyết định cần đưa ra:**

**Quyết định 1: Độ chính xác tồn kho vs Hiệu năng**
- Option A: Kiểm tra tồn kho realtime (chính xác nhưng chậm)
- Option B: Dùng số tồn kho gần đúng + bù trừ sau (nhanh nhưng có thể oversell)

→ Bạn chọn: ___ | Lý do: ___

**Quyết định 2: Trải nghiệm người dùng vs Ổn định hệ thống**
- Option A: Xếp hàng công bằng theo thứ tự (công bằng nhưng chờ lâu)
- Option B: Cho vào ngẫu nhiên (nhanh nhưng không công bằng)

→ Bạn chọn: ___ | Lý do: ___

**Quyết định 3: Tính năng đầy đủ vs Độ tin cậy**
- Option A: Giữ đầy đủ quy trình checkout (nhiều tính năng, dễ lỗi)
- Option B: Rút gọn checkout còn tối thiểu (ít tính năng, ổn định hơn)

→ Bạn chọn: ___ | Lý do: ___

---

## Lời giải Mẫu (Sample Solutions)

### Đáp án Bài tập 1

**Tình huống A: Sàn Giao dịch Chứng khoán**

| # | Cặp đánh đổi | Ưu tiên | Lý do |
|---|--------------|---------|-------|
| 1 | Performance Security | Performance | Giao dịch chứng khoán cần <1ms, bảo mật có thể làm ở tầng network |
| 2 | Performance Cost | Performance | Dù đắt nhưng latency thấp = lợi thế cạnh tranh |
| 3 | Performance Maintainability | Performance | Code tối ưu khó đọc nhưng chấp nhận được |

**Tình huống B: Hệ thống Hồ sơ Y tế**

| # | Cặp đánh đổi | Ưu tiên | Lý do |
|---|--------------|---------|-------|
| 1 | Security Usability | Security | Dữ liệu bệnh nhân phải được bảo vệ tối đa |
| 2 | Availability Cost | Availability | Bệnh viện cần 24/7, đầu tư máy chủ dự phòng |
| 3 | Modernization Interoperability | Interoperability | Phải tích hợp được với hệ thống cũ |

---

### Đáp án Bài tập 2: Ma trận Quyết định

| Tiêu chí | Trọng số | Option A | Option B | Option C |
|----------|----------|----------|----------|----------|
| Performance | 0.25 | 2 (0.50) | 4 (1.00) | 4 (1.00) |
| Scalability | 0.20 | 1 (0.20) | 3 (0.60) | 5 (1.00) |
| Simplicity | 0.20 | 5 (1.00) | 3 (0.60) | 2 (0.40) |
| Cost | 0.20 | 5 (1.00) | 3 (0.60) | 1 (0.20) |
| Consistency | 0.15 | 5 (0.75) | 4 (0.60) | 4 (0.60) |
| **Tổng** | **1.00** | **3.45** | **3.40** | **3.20** |

**Khuyến nghị:** Chọn **Option A** nếu dự án mới bắt đầu, traffic thấp. Chọn **Option B** khi cần cân bằng. Chọn **Option C** nếu dự kiến scale lớn.

> [Goi y] **Lưu ý:** Kết quả phụ thuộc vào trọng số. Nếu ưu tiên Scalability hơn, Option C sẽ thắng.

---

### Đáp án Bài tập 3: CAP Theorem

| Use Case | CP hay AP? | Lý do |
|----------|------------|-------|
| Chuyển tiền ngân hàng | **CP** | Số dư phải chính xác, không được sai |
| News feed Facebook | **AP** | Chấp nhận feed cũ vài giây, miễn là luôn hoạt động |
| Giỏ hàng online | **AP** | Giỏ hàng có thể đồng bộ sau, không cần realtime |
| Quản lý tồn kho | **CP** | Tồn kho phải chính xác để tránh oversell |
| Session đăng nhập | **AP** | Có thể cho đăng nhập lại nếu session mất |
| Dữ liệu analytics | **AP** | Dữ liệu lịch sử, chấp nhận eventual consistency |
| Đặt vé máy bay | **CP** | Ghế ngồi phải chính xác, không được double booking |
| Chat realtime | **AP** | Tin nhắn có thể delay vài giây, miễn là không mất |

---

### Đáp án Bài tập 4: Flash Sale

| Quyết định | Chọn | Lý do |
|------------|------|-------|
| **1. Tồn kho** | Option B | Flash sale cần nhanh, oversell có thể hoàn tiền sau |
| **2. Xếp hàng** | Option A | Công bằng quan trọng với khách hàng, tránh khiếu nại |
| **3. Checkout** | Option B | Trong flash sale, đơn giản = ổn định = ít lỗi |

---

## Phần 4: Ghi chép Quyết định (ADR)

### Template ADR cho Tradeoffs

```markdown
# ADR-001: Chọn chiến lược Database cho Flash Sale

## Bối cảnh
Hệ thống cần xử lý 10,000 requests/giây trong Flash Sale.
Database hiện tại (PostgreSQL đơn) không đáp ứng được.

## Các yếu tố quyết định
- Performance: RẤT CAO (ưu tiên #1)
- Cost: TRUNG BÌNH (có ngân sách)
- Complexity: Chấp nhận được
- Time-to-market: 2 tháng

## Các lựa chọn đã xem xét
1. Tối ưu PostgreSQL hiện tại
2. Thêm Redis cache
3. Chuyển sang PostgreSQL cluster

## Quyết định
Chọn **Option 2: PostgreSQL + Redis**, vì:
- Cải thiện 10x read performance với chi phí hợp lý
- Team có kinh nghiệm với Redis
- Có thể triển khai trong 3 tuần

## Hệ quả tích cực
- Read latency giảm từ 50ms → 5ms
- Giảm tải cho database chính

## Hệ quả tiêu cực (Đánh đổi)
- Thêm complexity (cache invalidation)
- Có thể có stale data trong vài giây

## Biện pháp giảm thiểu rủi ro
- Áp dụng TTL 60s cho cache
- Implement cache-aside pattern
- Monitor cache hit rate
```

---

## Các Lỗi Thường Gặp

### Lỗi khi Phân tích Đánh đổi

| # | Lỗi | [Khong] Sai | [OK] Đúng |
|---|-----|-------|--------|
| 1 | **Muốn tất cả** | "Cần cả nhanh, rẻ, và bảo mật cao" | "Ưu tiên bảo mật, chấp nhận chậm hơn 20%" |
| 2 | **Không lượng hóa** | "Performance quan trọng" | "Response time < 200ms với 99% requests" |
| 3 | **Bỏ qua context** | "Microservices tốt hơn Monolith" | "Với team 3 người, Monolith phù hợp hơn" |
| 4 | **Không document** | Quyết định bằng miệng | Viết ADR, lưu vào repo |
| 5 | **Copy máy móc** | "Netflix dùng Cassandra, ta cũng dùng" | Phân tích xem Cassandra có phù hợp không |

### Lỗi khi Áp dụng CAP Theorem

| Lỗi | Giải thích |
|-----|------------|
| **Nghĩ CAP áp dụng mọi lúc** | CAP chỉ áp dụng khi có **network partition** |
| **Bỏ qua PACELC** | Khi không có partition, vẫn có tradeoff Latency vs Consistency |
| **Chọn sai loại** | Banking cần CP, không phải AP |

---

## Tiêu chí Chấm điểm (Grading Rubric)

### Tổng quan

| Bài tập | Điểm tối đa | Trọng số |
|---------|-------------|----------|
| Bài 1: Xác định Tradeoffs | 20 điểm | 20% |
| Bài 2: Decision Matrix | 30 điểm | 30% |
| Bài 3: CAP Theorem | 20 điểm | 20% |
| Bài 4: Case Study + ADR | 30 điểm | 30% |
| **Tổng** | **100 điểm** | **100%** |

### Rubric Chi tiết

**Bài 1: Xác định Tradeoffs (20 điểm)**

| Tiêu chí | Xuất sắc (20) | Tốt (16) | Đạt (12) | Chưa đạt (<12) |
|----------|---------------|----------|----------|----------------|
| Xác định đúng cặp | 6/6 cặp đúng | 4-5 đúng | 3 đúng | <3 đúng |
| Giải thích hợp lý | Cụ thể, có số liệu | Hợp lý | Chung chung | Không giải thích |

**Bài 2: Decision Matrix (30 điểm)**

| Tiêu chí | Điểm |
|----------|------|
| Điền điểm hợp lý (có căn cứ) | 10 |
| Tính toán đúng | 10 |
| Khuyến nghị có lý | 10 |

**Bài 3: CAP Theorem (20 điểm)**

| Tiêu chí | Điểm |
|----------|------|
| Chọn đúng CP/AP | 2 điểm x 8 = 16 |
| Giải thích đúng | 4 điểm bonus |

**Bài 4: Case Study + ADR (30 điểm)**

| Tiêu chí | Điểm |
|----------|------|
| 3 quyết định có lý | 15 |
| ADR đầy đủ thành phần | 10 |
| Mitigation strategies | 5 |

---

## Tự đánh giá (30 câu)

### Mức cơ bản (Câu 1-10)

1. Tradeoff trong kiến trúc phần mềm là gì?
2. Vì sao không thể tối ưu tất cả Quality Attributes cùng lúc?
3. Kể 3 cặp đánh đổi phổ biến nhất?
4. CAP Theorem nói gì về hệ thống phân tán?
5. CP là gì? Cho ví dụ hệ thống CP?
6. AP là gì? Cho ví dụ hệ thống AP?
7. Khi nào cần viết ADR (Architecture Decision Record)?
8. Ma trận đánh đổi dùng để làm gì?
9. Trọng số trong Decision Matrix có ý nghĩa gì?
10. Performance và Security thường đánh đổi như thế nào?

### Mức trung bình (Câu 11-20)

11. Giải thích PACELC theorem (mở rộng của CAP)?
12. Eventual Consistency khác Strong Consistency thế nào?
13. Khi nào nên chọn Monolith thay vì Microservices?
14. Build vs Buy - những yếu tố nào cần cân nhắc?
15. Caching tạo ra những tradeoffs nào?
16. Sync vs Async communication - khi nào dùng loại nào?
17. Read Replica ảnh hưởng CAP thế nào?
18. Sharding tạo ra những tradeoffs nào?
19. Làm sao thuyết phục stakeholder về tradeoffs?
20. Technical Debt là một dạng tradeoff như thế nào?

### Mức nâng cao (Câu 21-30)

21. Reversible vs Irreversible decisions - ảnh hưởng tradeoff analysis?
22. Premature optimization là gì? Liên quan tradeoffs thế nào?
23. YAGNI principle giúp tránh tradeoffs nào?
24. Time-to-Market vs Quality - cân bằng thế nào?
25. Serverless vs Containers - tradeoffs chính?
26. Monorepo vs Polyrepo - khi nào chọn cái nào?
27. Feature flags tạo technical debt như thế nào?
28. Multi-region architecture có những tradeoffs gì?
29. Cost optimization ảnh hưởng Quality Attributes nào?
30. Làm sao đo lường impact của tradeoff decisions?

**Gợi ý đáp án:**
- **Câu 4**: Trong hệ thống phân tán, chỉ có thể đảm bảo 2 trong 3: Consistency, Availability, Partition Tolerance
- **Câu 11**: PACELC = Khi có Partition chọn A/C, Else (không có Partition) chọn Latency/Consistency
- **Câu 22**: Tối ưu quá sớm = đánh đổi Maintainability cho Performance chưa cần thiết

---

## Bài tập Mở rộng (10 bài)

### EL1: Phân tích Kiến trúc E-Commerce
```
Đề bài: Phân tích tradeoffs của Shopee hoặc Lazada
- Xác định 10 quyết định kiến trúc quan trọng
- Viết ADR cho mỗi quyết định
- So sánh với Tiki/Sendo
Độ khó: ***
```

### EL2: So sánh Database
```
Đề bài: Tạo Decision Matrix cho 5 loại database
- PostgreSQL, MySQL, MongoDB, Cassandra, Redis
- Đánh giá theo 6 tiêu chí
- Đưa ra khuyến nghị cho 3 use cases
Độ khó: ***
```

### EL3: So sánh Cloud Provider
```
Đề bài: AWS vs Azure vs GCP
- Chi phí cho cùng workload
- Tính năng khác biệt
- Vendor lock-in analysis
Độ khó: ***
```

### EL4: Chọn Message Queue
```
Đề bài: Kafka vs RabbitMQ vs SQS
- Latency vs Throughput
- Ordering guarantees
- Cost analysis
Độ khó: ***
```

### EL5: Migration Monolith → Microservices
```
Đề bài: Lập kế hoạch migration
- Strangler Fig pattern
- Risk assessment
- Rollback strategy
Độ khó: ****
```

### EL6: Security vs User Experience
```
Đề bài: Cân bằng bảo mật và trải nghiệm
- MFA implementation options
- Password policies
- Session management tradeoffs
Độ khó: ***
```

### EL7: Tối ưu Performance
```
Đề bài: Caching strategies analysis
- CDN selection
- Cache invalidation patterns
- Cost vs Speed optimization
Độ khó: ***
```

### EL8: Build vs Buy
```
Đề bài: Phân tích xây dựng vs mua sẵn
- Auth: Okta vs tự xây
- Payment: Stripe vs tự xây
- TCO (Total Cost of Ownership) analysis
Độ khó: ****
```

### EL9: Lượng hóa Technical Debt
```
Đề bài: Đo lường và quản lý nợ kỹ thuật
- Công cụ đo technical debt
- Prioritize việc trả nợ
- Business impact analysis
Độ khó: ****
```

### EL10: Kiến trúc Multi-Region
```
Đề bài: Thiết kế hệ thống toàn cầu
- Latency vs Consistency tradeoffs
- Data residency requirements
- Disaster recovery strategy
Độ khó: *****
```

---

## Bài nộp

| # | Sản phẩm | Bài tập | Hình thức |
|---|----------|---------|-----------|
| 1 | Bảng tradeoffs cho 2 tình huống | Bài 1 | File Word/PDF |
| 2 | Decision Matrix có tính toán | Bài 2 | File Excel |
| 3 | Bảng CAP analysis | Bài 3 | File Word/PDF |
| 4 | ADR cho Flash Sale case | Bài 4 | File Markdown |

---

## Tài liệu Tham khảo

1. **Bass, Clements, Kazman** - "Software Architecture in Practice" - Chương về Tradeoffs
2. **Mark Richards, Neal Ford** - "Fundamentals of Software Architecture" - Chương 2
3. **Eric Brewer** - CAP Theorem Paper (2000)
4. [ADR GitHub](https://adr.github.io/) - Architecture Decision Records

---

## Nguồn Tham khảo Học thuật

### Đại học Quốc tế

#### CMU (Carnegie Mellon University)
| Tài liệu | Link | Nội dung |
|----------|------|----------|
| **ATAM Method** | [SEI](https://resources.sei.cmu.edu/library/asset-view.cfm?assetid=5177) | Phương pháp phân tích tradeoff chuẩn |
| **Quality Attribute Workshops** | [SEI](https://resources.sei.cmu.edu/library/) | QAW methodology |

#### MIT
| Tài liệu | Link | Nội dung |
|----------|------|----------|
| **6.033 Computer Systems** | [MIT OCW](https://ocw.mit.edu/courses/6-033-computer-system-engineering-spring-2018/) | System tradeoffs |
| **6.824 Distributed Systems** | [MIT](https://pdos.csail.mit.edu/6.824/) | CAP, consistency |

#### Stanford & Berkeley
| Tài liệu | Link | Nội dung |
|----------|------|----------|
| **CS 349D Cloud Computing** | Stanford | CAP, distributed tradeoffs |
| **Eric Brewer's Research** | [Berkeley](https://people.eecs.berkeley.edu/~brewer/) | CAP theorem gốc |

### (VN) Đại học Việt Nam

| Trường | Môn học | Nội dung liên quan |
|--------|---------|---------------------|
| **ĐH Bách Khoa TP.HCM** | CO4027 - Kiến trúc PM | ATAM, tradeoff analysis |
| **ĐH Bách Khoa Hà Nội** | IT4995 - Kiến trúc PM | Decision making |
| **ĐH FPT** | SWD391 - Software Architecture | Trade-off workshops |
| **VNU-UET** | INT3105 - Thiết kế PM | Quality tradeoffs |

### Papers quan trọng

| Paper | Tác giả | Năm | Đóng góp |
|-------|---------|-----|----------|
| "CAP Theorem" | Eric Brewer | 2000 | Định lý nền tảng |
| "CAP Twelve Years Later" | Eric Brewer | 2012 | Cập nhật và làm rõ |
| "ATAM Method" | Kazman, Klein | 2000 | Phương pháp đánh giá |
| "PACELC Theorem" | Daniel Abadi | 2012 | Mở rộng CAP |

### Khóa học Online

| Platform | Khóa học | Focus |
|----------|----------|-------|
| **Coursera** | Software Architecture - U of Alberta | Decision making |
| **Udacity** | Software Architecture & Design | Tradeoff analysis |
| **O'Reilly** | Fundamentals of SA (Live) | Practical tradeoffs |

---

## Tiếp theo

Chuyển đến: `lab-1.3-architecture-principles/`
