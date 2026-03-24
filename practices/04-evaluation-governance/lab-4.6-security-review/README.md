# Lab 4.6: Architecture Security Review

## Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate → Advanced |
| **Yêu cầu trước** | Hoàn thành Lab 4.1 (Architecture Evaluation), Lab 4.2 (Quality Attributes) |
| **Công cụ** | OWASP ZAP, OWASP Dependency-Check, SonarQube, draw.io |
| **Ngôn ngữ** | Vietnamese (mixed English technical terms) |

---

## Mục tiêu Học tập

Sau khi hoàn thành lab này, sinh viên có thể:

1. **Áp dụng** mô hình STRIDE để threat modeling cho một hệ thống phần mềm, xác định threats trên từng thành phần DFD
2. **Phân tích** OWASP Top 10 (2021) và mapping các lỗ hổng vào kiến trúc cụ thể, đề xuất biện pháp giảm thiểu
3. **Đánh giá** security quality attributes (Confidentiality, Integrity, Availability, Authentication, Authorization, Non-repudiation) trong một kiến trúc thực tế
4. **Thực hiện** security architecture review sử dụng checklist có cấu trúc cho hệ thống e-commerce mẫu
5. **Sử dụng** các công cụ security testing (OWASP ZAP, Dependency-Check, SonarQube) để phát hiện lỗ hổng tự động

---

## Phân bổ Thời gian

| Giai đoạn | Nội dung | Thời lượng |
|-----------|----------|------------|
| **Lý thuyết** | Security by Design, STRIDE, OWASP Top 10, Security QA, Tactics, Zero Trust | 40 phút |
| **Lab 1** | STRIDE Threat Modeling (DFD + identify threats + risk matrix) | 35 phút |
| **Lab 2** | OWASP Top 10 Analysis (mapping + mitigations) | 30 phút |
| **Lab 3** | Security Architecture Review (checklist review cho e-commerce) | 35 phút |
| **Lab 4** | Security Testing Tools (ZAP scan, dependency-check, SonarQube) | 25 phút |
| **Self-Assessment** | 30 câu hỏi tự đánh giá | 10 phút |
| **Tổng kết** | Review kết quả, Q&A | 5 phút |
| **Tổng** | | **3 giờ** |

---

## Phần Lý thuyết

### 1. Security by Design

Security by Design là nguyên tắc tích hợp bảo mật vào mọi giai đoạn phát triển phần mềm, thay vì "bổ sung" sau khi hoàn thành. Các nguyên tắc cốt lõi:

| Nguyên tắc | Mô tả | Ví dụ |
|-------------|--------|-------|
| **Least Privilege** | Cấp quyền tối thiểu cần thiết | Service account chỉ có READ trên bảng cần thiết |
| **Fail Secure** | Khi lỗi xảy ra, hệ thống default DENY | Nếu auth service down → từ chối request thay vì cho qua |
| **Defense in Depth** | Nhiều lớp bảo vệ chồng lên nhau | WAF + Input Validation + Parameterized Query |
| **Complete Mediation** | Kiểm tra mọi truy cập, không cache kết quả authz | Mỗi API call đều verify token + check permissions |
| **Separation of Duties** | Phân tách trách nhiệm | Developer không deploy production, DBA không code |
| **Open Design** | Bảo mật không dựa trên giấu thuật toán | Dùng AES-256, RSA chứ không tự tạo mã hóa |
| **Economy of Mechanism** | Cơ chế bảo mật đơn giản, dễ verify | Dùng một auth gateway thay vì mỗi service tự xử lý |

```
┌──────────────────────────────────────────────────────────────────┐
│ SECURITY BY DESIGN LIFECYCLE │
│ │
│ Requirements ── Design ── Implementation ── Testing ── Ops │
│ │ │ │ │ │ │
│ Security Threat Secure SAST/ Security│
│ Requirements Modeling Coding DAST Monitoring│
│ & Abuse Cases & Review Standards Pen Test & Incident│
│ Response│
└──────────────────────────────────────────────────────────────────┘
```

### 2. STRIDE Threat Model

STRIDE là mô hình phân loại mối đe dọa do Microsoft phát triển. Mỗi chữ cái đại diện cho một loại threat:

| Threat | Ý nghĩa | Thuộc tính bị vi phạm | Ví dụ cụ thể |
|--------|----------|------------------------|---------------|
| **S** — Spoofing | Mạo danh danh tính | Authentication | Kẻ tấn công giả mạo email admin, session hijacking |
| **T** — Tampering | Sửa đổi dữ liệu trái phép | Integrity | Man-in-the-middle thay đổi request body, SQL injection |
| **R** — Repudiation | Phủ nhận hành động | Non-repudiation | User phủ nhận đã thực hiện giao dịch chuyển tiền |
| **I** — Information Disclosure | Lộ thông tin nhạy cảm | Confidentiality | Database dump, error message chứa stack trace |
| **D** — Denial of Service | Từ chối dịch vụ | Availability | DDoS attack, resource exhaustion |
| **E** — Elevation of Privilege | Leo thang đặc quyền | Authorization | Normal user truy cập admin API, IDOR vulnerability |

**STRIDE áp dụng theo loại DFD element:**

| DFD Element | Ký hiệu | S | T | R | I | D | E |
|-------------|----------|---|---|---|---|---|---|
| External Entity | Hình chữ nhật | [OK] | | | | | |
| Process | Hình tròn | [OK] | [OK] | [OK] | [OK] | [OK] | [OK] |
| Data Store | Hai đường song song | | [OK] | [OK] | [OK] | [OK] | |
| Data Flow | Mũi tên | | [OK] | | [OK] | [OK] | |
| Trust Boundary | Đường nét đứt | Tất cả threats khi luồng dữ liệu đi qua |

### 3. OWASP Top 10 (2021)

| # | Tên | Mô tả | Ví dụ |
|---|-----|--------|-------|
| A01 | **Broken Access Control** | Kiểm soát truy cập bị lỗi | IDOR: `/api/users/123` → đổi thành `/api/users/456` |
| A02 | **Cryptographic Failures** | Mã hóa yếu hoặc sai | Dùng MD5 hash password, HTTP thay HTTPS |
| A03 | **Injection** | Chèn mã độc | SQL Injection: `' OR 1=1--`, XSS: `<script>alert(1)</script>` |
| A04 | **Insecure Design** | Thiết kế không an toàn từ gốc | Không có rate limiting trên forgot-password |
| A05 | **Security Misconfiguration** | Cấu hình sai | Default password, debug mode on production |
| A06 | **Vulnerable Components** | Thư viện có lỗ hổng | Log4Shell (CVE-2021-44228), struts2 RCE |
| A07 | **Identification & Auth Failures** | Xác thực yếu | Cho phép password "123456", không có MFA |
| A08 | **Software & Data Integrity Failures** | Không kiểm tra tính toàn vẹn | Auto-update không verify signature, CI/CD pipeline bị compromise |
| A09 | **Security Logging & Monitoring Failures** | Log & giám sát thiếu | Không log failed login, không alert brute-force |
| A10 | **Server-Side Request Forgery (SSRF)** | Server gửi request không kiểm soát | Fetch URL do user nhập → truy cập internal service |

### 4. Security Quality Attributes

| Quality Attribute | Định nghĩa | Metric đo lường |
|-------------------|-------------|------------------|
| **Confidentiality** | Chỉ người được phép mới truy cập dữ liệu | % data encrypted at rest & in transit |
| **Integrity** | Dữ liệu không bị thay đổi trái phép | Số lần phát hiện tampering / tổng transactions |
| **Availability** | Hệ thống hoạt động khi cần | Uptime %, MTTR (Mean Time To Recovery) |
| **Authentication** | Xác minh danh tính người dùng/hệ thống | Số auth bypass incidents, MFA adoption rate |
| **Authorization** | Kiểm tra quyền truy cập | Số privilege escalation incidents |
| **Non-repudiation** | Không thể phủ nhận hành động đã thực hiện | % transactions có audit trail, digital signature coverage |

### 5. Security Tactics

Các tactics bảo mật được chia thành 4 nhóm chính:

```
┌────────────────────────────────────────────────────────┐
│ SECURITY TACTICS │
├──────────────┬──────────────┬────────────┬─────────────┤
│ DETECT │ RESIST │ REACT │ RECOVER │
├──────────────┼──────────────┼────────────┼─────────────┤
│ Intrusion │ Authenticate │ Revoke │ Audit trail │
│ Detection │ users │ access │ restore │
│ │ │ │ │
│ Service │ Authorize │ Lock │ Identify │
│ Denial │ users │ accounts │ attacker │
│ Detection │ │ │ │
│ │ Maintain │ Inform │ Restore │
│ Message │ data conf. │ actors │ system │
│ Integrity │ │ │ │
│ Check │ Maintain │ Restrict │ Maintain │
│ │ integrity │ access │ audit log │
│ Detect │ │ │ │
│ Message │ Limit │ │ │
│ Delay │ exposure │ │ │
│ │ │ │ │
│ Detect │ Encrypt │ │ │
│ Intrusion │ data │ │ │
│ Attempts │ │ │ │
│ │ Separate │ │ │
│ │ entities │ │ │
│ │ │ │ │
│ │ Validate │ │ │
│ │ input │ │ │
└──────────────┴──────────────┴────────────┴─────────────┘
```

| Nhóm | Tactic | Mô tả |
|------|--------|--------|
| **Detect** | Intrusion Detection | IDS/IPS phát hiện tấn công mạng |
| | Service Denial Detection | Phát hiện DDoS, resource exhaustion |
| | Message Integrity Check | HMAC, digital signature trên messages |
| | Detect Message Delay | Phát hiện replay attack bằng timestamp/nonce |
| **Resist** | Authenticate Users | MFA, OAuth 2.0, certificate-based |
| | Authorize Users | RBAC, ABAC, policy engine |
| | Maintain Data Confidentiality | AES-256 encryption, TLS 1.3 |
| | Maintain Integrity | Checksums, hash verification |
| | Limit Exposure | Minimal attack surface, network segmentation |
| | Encrypt Data | At-rest (AES), in-transit (TLS), in-use (HSM) |
| | Validate Input | Whitelist validation, parameterized queries |
| **React** | Revoke Access | Disable compromised accounts/tokens |
| | Lock Account | Lock after N failed attempts |
| | Inform Actors | Alert admin team, notify affected users |
| **Recover** | Audit Trail | Immutable logs cho forensic analysis |
| | Restore System | Backup recovery, failover procedures |

### 6. Zero Trust Architecture

Zero Trust là mô hình bảo mật "Never trust, always verify" — không tin tưởng bất kỳ entity nào (kể cả bên trong mạng nội bộ).

```
┌──────────────────────────────────────────────────────────────┐
│ ZERO TRUST ARCHITECTURE │
│ │
│ ┌─────────┐ ┌──────────────┐ ┌─────────────────┐ │
│ │ User / │────│ Policy │────│ Application / │ │
│ │ Device │ │ Decision │ │ Resource │ │
│ │ │────│ Point (PDP) │────│ │ │
│ └─────────┘ └──────────────┘ └─────────────────┘ │
│ │ │ │ │
│ ▼ ▼ ▼ │
│ ┌─────────┐ ┌──────────────┐ ┌─────────────────┐ │
│ │ Identity │ │ Continuous │ │ Micro- │ │
│ │ Provider │ │ Monitoring │ │ Segmentation │ │
│ │ (IdP) │ │ & Analytics │ │ │ │
│ └─────────┘ └──────────────┘ └─────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```

| Nguyên tắc | Cách triển khai | Ví dụ |
|-------------|-----------------|-------|
| **Never trust, always verify** | Xác thực mọi request bất kể nguồn | Mọi API call đều cần JWT token hợp lệ |
| **Least privilege access** | Cấp quyền tối thiểu, just-in-time | Developer chỉ có SSH vào server khi on-call |
| **Assume breach** | Giới hạn blast radius | Mỗi microservice có network policy riêng |
| **Verify explicitly** | Kiểm tra identity + device + location + behavior | Login từ VN lúc 3AM + new device → MFA challenge |
| **Micro-segmentation** | Chia nhỏ network thành các segment | Mỗi service trong K8s namespace riêng, network policy strict |
| **Continuous validation** | Liên tục kiểm tra, không chỉ lúc login | Re-validate token mỗi 5 phút, session timeout 30 phút |

### 7. Security Review Checklist

| # | Hạng mục | Kiểm tra | Pass/Fail |
|---|----------|----------|-----------|
| 1 | **Authentication** | MFA enabled? Strong password policy? | ☐ |
| 2 | **Authorization** | RBAC/ABAC implemented? Least privilege? | ☐ |
| 3 | **Data Protection** | Encryption at rest & in transit? Key rotation? | ☐ |
| 4 | **Input Validation** | Server-side validation? Parameterized queries? | ☐ |
| 5 | **Session Management** | Token expiry? Secure cookie flags? | ☐ |
| 6 | **Error Handling** | No sensitive data in errors? Custom error pages? | ☐ |
| 7 | **Logging & Monitoring** | Security events logged? SIEM integrated? | ☐ |
| 8 | **API Security** | Rate limiting? API key rotation? OAuth 2.0? | ☐ |
| 9 | **Dependency Management** | Vulnerability scanning? Update policy? | ☐ |
| 10 | **Network Security** | Firewall rules? Network segmentation? TLS 1.3? | ☐ |
| 11 | **Secrets Management** | Vault/KMS used? No hardcoded secrets? | ☐ |
| 12 | **Backup & Recovery** | Backup encrypted? Recovery tested? RTO/RPO defined? | ☐ |
| 13 | **CI/CD Security** | Pipeline hardened? Artifact signing? | ☐ |
| 14 | **Container Security** | Base image scanned? Non-root user? Read-only FS? | ☐ |
| 15 | **Compliance** | GDPR/PCI-DSS requirements mapped? | ☐ |

---

## Step-by-step Labs

### Lab 1: STRIDE Threat Modeling (35 phút)

**Mục tiêu:** Xây dựng DFD, xác định threats theo STRIDE, tạo risk matrix

#### Bước 1.1 — Vẽ Data Flow Diagram (DFD) cho hệ thống e-commerce

```
┌──────────────────────────────────────────────────────────────────────┐
│ │
│ ┌──────────┐ ┌──────────────┐ ┌───────────────┐ │
│ │ Customer │────────│ Web App │────────│ API Gateway │ │
│ │ (Browser)│────────│ (React SPA) │────────│ (Kong/Nginx) │ │
│ └──────────┘ HTTPS └──────────────┘ HTTPS └───────┬───────┘ │
│ │ │
│ ═══════════════════ TRUST BOUNDARY 1 ═════════════════╪════════ │
│ │ │
│ ┌────────────────────────────────┼────────┐ │
│ │ ▼ │ │
│ │ ┌──────────┐ ┌──────────────────┐ │ │
│ │ │ Auth │ │ Order Service │ │ │
│ │ │ Service │ │ (Spring Boot) │ │ │
│ │ └────┬─────┘ └────────┬─────────┘ │ │
│ │ │ │ │ │
│ ══════════════════════╪═══════╪══ TRUST BOUNDARY 2 ════════════╪ │
│ │ ▼ ▼ │ │
│ │ ┌──────────┐ ┌──────────────────┐ │ │
│ │ │ User DB │ │ Order DB │ │ │
│ │ │(Postgres)│ │ (Postgres) │ │ │
│ │ └──────────┘ └──────────────────┘ │ │
│ │ │ │
│ └────────────────────────────────────────┘ │
│ │
│ ┌──────────┐ ┌──────────────────┐ │
│ │ Payment │────────│ Payment Service │ │
│ │ Gateway │────────│ (Internal) │ │
│ │(Stripe) │ HTTPS └──────────────────┘ │
│ └──────────┘ │
│ │
└──────────────────────────────────────────────────────────────────────┘
```

#### Bước 1.2 — Xác định Threats theo STRIDE cho từng element

**Template STRIDE Analysis:**

| ID | DFD Element | Threat Type | Threat Description | Likelihood (1-5) | Impact (1-5) | Risk Score | Mitigation |
|----|-------------|-------------|--------------------|--------------------|---------------|------------|------------|
| T01 | Customer → Web App | **Spoofing** | Kẻ tấn công giả mạo trang login (phishing) để lấy credentials | 4 | 5 | 20 | HTTPS + HSTS, user education, anti-phishing headers |
| T02 | Customer → Web App | **Tampering** | MITM sửa đổi request/response giữa browser và server | 3 | 4 | 12 | TLS 1.3, certificate pinning |
| T03 | Customer → Web App | **Information Disclosure** | Sniffing traffic để lấy session token | 3 | 5 | 15 | HTTPS everywhere, Secure cookie flag |
| T04 | Web App → API Gateway | **Spoofing** | Service giả mạo Web App gửi request đến API Gateway | 2 | 4 | 8 | mTLS giữa các service |
| T05 | Web App → API Gateway | **Denial of Service** | Flood requests làm quá tải API Gateway | 4 | 4 | 16 | Rate limiting, WAF, auto-scaling |
| T06 | API Gateway | **Elevation of Privilege** | Bypass authorization check trên API Gateway | 2 | 5 | 10 | Centralized auth, security testing |
| T07 | Auth Service | **Spoofing** | Brute-force attack, credential stuffing | 4 | 5 | 20 | Rate limiting, account lockout, MFA |
| T08 | Auth Service | **Repudiation** | User phủ nhận đã thực hiện login/action | 3 | 3 | 9 | Audit logging, IP logging |
| T09 | Order Service | **Tampering** | Sửa đổi giá sản phẩm trong request | 3 | 5 | 15 | Server-side price validation, integrity check |
| T10 | User DB | **Information Disclosure** | SQL injection dẫn đến dump database | 3 | 5 | 15 | Parameterized queries, WAF, least privilege DB user |
| T11 | User DB | **Tampering** | Unauthorized modification of user data | 2 | 5 | 10 | DB audit logging, access control |
| T12 | Payment Service → Stripe | **Information Disclosure** | Lộ API key của payment gateway | 2 | 5 | 10 | Vault/KMS, key rotation, env var encryption |
| T13 | Payment Service → Stripe | **Tampering** | Sửa đổi payment amount trong transit | 2 | 5 | 10 | HTTPS, request signing, idempotency key |
| T14 | Order DB | **Denial of Service** | DB connection exhaustion | 3 | 4 | 12 | Connection pooling, circuit breaker |

#### Bước 1.3 — Risk Matrix

Phân loại risk theo Likelihood x Impact:

```
 IMPACT
 1 2 3 4 5
 ┌────┬────┬────┬────┬────┐
 5 │ 5 │ 10 │ 15 │ 20 │ 25 │ LIKELIHOOD:
 ├────┼────┼────┼────┼────┤ 5 = Almost certain
L 4 │ 4 │ 8 │ 12 │ 16 │ 20 │ 4 = Likely
I ├────┼────┼────┼────┼────┤ 3 = Possible
K 3 │ 3 │ 6 │ 9 │ 12 │ 15 │ 2 = Unlikely
E ├────┼────┼────┼────┼────┤ 1 = Rare
L 2 │ 2 │ 4 │ 6 │ 8 │ 10 │
I ├────┼────┼────┼────┼────┤ RISK:
H 1 │ 1 │ 2 │ 3 │ 4 │ 5 │ 20-25 = Critical (đỏ)
O └────┴────┴────┴────┴────┘ 12-19 = High (cam)
O 6-11 = Medium (vàng)
D 1-5 = Low (xanh)
```

**Sinh viên điền kết quả phân loại:**

| Risk Level | Threat IDs | Hành động |
|------------|-----------|-----------|
| **Critical (20-25)** | T01, T07 | Xử lý ngay lập tức |
| **High (12-19)** | T02, T03, T05, T09, T10, T14 | Xử lý trong sprint tiếp theo |
| **Medium (6-11)** | T04, T06, T08, T11, T12, T13 | Lên kế hoạch xử lý |
| **Low (1-5)** | — | Monitor |

---

### Lab 2: OWASP Top 10 Analysis (30 phút)

**Mục tiêu:** Map OWASP Top 10 vào kiến trúc e-commerce, đề xuất mitigations

#### Bước 2.1 — OWASP Mapping Table

**Sinh viên phân tích và điền vào bảng sau:**

| OWASP ID | Vulnerability | Applicable Component | Hiện trạng | Mức độ rủi ro | Mitigation đề xuất |
|----------|--------------|---------------------|-----------|---------------|---------------------|
| A01 | Broken Access Control | API Gateway, Order Service | Có RBAC nhưng chưa check object-level | **High** | Implement ABAC, object-level authorization trên mỗi endpoint |
| A02 | Cryptographic Failures | User DB, Payment Service | Password dùng bcrypt, nhưng PII chưa encrypt at rest | **High** | Encrypt PII columns (AES-256-GCM), key rotation mỗi 90 ngày |
| A03 | Injection | Order Service, User DB | Dùng ORM nhưng có raw query ở report module | **Medium** | Audit tất cả raw queries, dùng parameterized queries |
| A04 | Insecure Design | Auth Service | Không có rate limit trên /forgot-password | **High** | Rate limiting (5 req/min/IP), CAPTCHA sau 3 lần thất bại |
| A05 | Security Misconfiguration | Web App, API Gateway | Debug mode tắt, nhưng default CORS cho phép `*` | **Medium** | Whitelist CORS origins, remove unnecessary headers |
| A06 | Vulnerable Components | Tất cả services | Chưa có automated dependency scanning | **High** | Tích hợp OWASP Dependency-Check vào CI/CD |
| A07 | Identification & Auth | Auth Service | Password policy yếu (min 6 chars), không MFA | **High** | Min 12 chars + complexity, mandatory MFA cho admin |
| A08 | Software & Data Integrity | CI/CD Pipeline | Docker image không signed, không verify checksum | **Medium** | Docker Content Trust, SLSA Level 2 |
| A09 | Security Logging Failures | Tất cả services | Log application events nhưng không log security events | **High** | Log failed auth, access denied, input validation failures → SIEM |
| A10 | SSRF | Order Service | Endpoint nhận URL để fetch product image | **Medium** | Whitelist allowed domains, block private IP ranges |

#### Bước 2.2 — Mitigation Priority Matrix

```
┌────────────────────────────────────────────────────────────────────┐
│ MITIGATION PRIORITY │
│ │
│ NGAY LẬP TỨC (Sprint hiện tại): │
│ ├── A01: Implement object-level authorization │
│ ├── A04: Rate limiting trên sensitive endpoints │
│ └── A07: Enforce strong password + MFA cho admin │
│ │
│ NGẮN HẠN (1-2 Sprint): │
│ ├── A02: Encrypt PII at rest │
│ ├── A06: Integrate dependency scanning │
│ └── A09: Security event logging + SIEM │
│ │
│ TRUNG HẠN (1-2 tháng): │
│ ├── A03: Audit & fix raw queries │
│ ├── A05: Harden CORS + security headers │
│ ├── A08: Docker Content Trust + SLSA │
│ └── A10: SSRF protection │
└────────────────────────────────────────────────────────────────────┘
```

---

### Lab 3: Security Architecture Review (35 phút)

**Mục tiêu:** Sử dụng checklist để review toàn diện hệ thống e-commerce mẫu

#### Bước 3.1 — Mô tả hệ thống e-commerce mẫu

```
Hệ thống: ShopVN E-Commerce Platform
- Frontend: React SPA, hosted trên CloudFront
- API Gateway: Kong (rate limiting, auth plugin)
- Backend: 4 microservices (Auth, Product, Order, Payment)
- Database: PostgreSQL (User, Product), MongoDB (Orders)
- Cache: Redis (session, product cache)
- Message Queue: RabbitMQ (order events)
- Payment: Tích hợp Stripe API
- Storage: AWS S3 (product images)
- Monitoring: Prometheus + Grafana
- CI/CD: GitHub Actions → Docker → AWS ECS
```

#### Bước 3.2 — Security Review theo Checklist

**Sinh viên điền vào bảng review:**

| # | Hạng mục | Câu hỏi kiểm tra | Hiện trạng | Pass/Fail | Ghi chú & Recommendation |
|---|----------|-------------------|-----------|-----------|---------------------------|
| 1 | **Authentication** | MFA có được bật cho admin? | Chưa có MFA | [Khong] FAIL | Triển khai TOTP MFA cho tất cả admin accounts |
| 2 | | Password policy có đủ mạnh? | Min 6 chars, no complexity | [Khong] FAIL | Min 12 chars, upper+lower+digit+special |
| 3 | | Session timeout có hợp lý? | JWT expiry 24h | WARN | Giảm xuống 1h, dùng refresh token |
| 4 | **Authorization** | RBAC có được implement? | Có 3 roles: admin, seller, buyer | [OK] PASS | |
| 5 | | Object-level authorization? | Chưa check owner trên orders | [Khong] FAIL | Check `order.userId == currentUser.id` |
| 6 | **Data Protection** | Data encrypted at rest? | DB: No, S3: Yes (SSE-S3) | [Khong] FAIL | Enable PostgreSQL TDE hoặc column-level encryption |
| 7 | | Data encrypted in transit? | HTTPS everywhere | [OK] PASS | |
| 8 | | PII handling compliant? | Chưa có data classification | WARN | Classify PII fields, implement data masking |
| 9 | **Input Validation** | Server-side validation? | Có ở hầu hết endpoints | [OK] PASS | |
| 10 | | File upload validation? | Check extension only | [Khong] FAIL | Validate MIME type, scan malware, size limit |
| 11 | **API Security** | Rate limiting? | Kong: 100 req/min global | WARN | Per-user rate limiting, stricter cho auth endpoints |
| 12 | | API versioning? | No | WARN | Implement `/api/v1/` prefix |
| 13 | **Secrets Management** | Secrets in env vars? | Yes, plain text in .env | [Khong] FAIL | Migrate to AWS Secrets Manager hoặc HashiCorp Vault |
| 14 | **Logging** | Security events logged? | Only application errors | [Khong] FAIL | Log auth events, access denied, data changes |
| 15 | | Log injection prevention? | No sanitization | [Khong] FAIL | Sanitize log input, structured logging (JSON) |

#### Bước 3.3 — Tổng hợp Security Review Report

```markdown
# Security Architecture Review Report — ShopVN E-Commerce

## Executive Summary
- **Scope:** Full architecture review của ShopVN platform
- **Date:** [Ngày thực hiện]
- **Reviewer:** [Tên sinh viên]
- **Overall Rating:** MEDIUM-HIGH RISK

## Key Findings
- 7/15 items FAIL, 4/15 WARN, 4/15 PASS
- Critical gaps: Authentication (no MFA), Secrets Management, Data Protection
- Highest risk: Broken Access Control (object-level) + Secrets in plain text

## Recommendations (by Priority)
### P0 — Critical (Fix within 1 week)
1. Implement MFA cho admin accounts
2. Migrate secrets từ .env → Secrets Manager
3. Implement object-level authorization

### P1 — High (Fix within 1 month)
4. Encrypt PII data at rest
5. Security event logging + SIEM integration
6. Fix file upload validation

### P2 — Medium (Fix within 1 quarter)
7. Strengthen password policy
8. Reduce JWT expiry, implement refresh tokens
9. Per-user rate limiting
10. Log injection prevention
```

---

### Lab 4: Security Testing Tools (25 phút)

**Mục tiêu:** Sử dụng OWASP ZAP, Dependency-Check, SonarQube để phát hiện lỗ hổng

#### Bước 4.1 — OWASP ZAP Scan

OWASP ZAP (Zed Attack Proxy) — công cụ DAST (Dynamic Application Security Testing) miễn phí.

**Cài đặt:**

```bash
# Cài đặt ZAP CLI (Docker)
docker pull ghcr.io/zaproxy/zaproxy:stable

# Baseline scan (passive — nhanh, an toàn)
docker run -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
 -t https://target-app.example.com \
 -r zap-report.html

# Full scan (active — chậm hơn, tìm nhiều hơn, CHỈ dùng trên môi trường test)
docker run -t ghcr.io/zaproxy/zaproxy:stable zap-full-scan.py \
 -t https://target-app.example.com \
 -r zap-full-report.html

# API scan (cho REST API)
docker run -t ghcr.io/zaproxy/zaproxy:stable zap-api-scan.py \
 -t https://target-app.example.com/openapi.json \
 -f openapi \
 -r zap-api-report.html
```

**Đọc kết quả ZAP:**

| Alert Level | Ý nghĩa | Ví dụ |
|-------------|----------|-------|
| **High** | Lỗ hổng nghiêm trọng, cần fix ngay | SQL Injection, XSS (Reflected) |
| **Medium** | Lỗ hổng cần xử lý | Missing security headers, cookie flags |
| **Low** | Rủi ro thấp | Server version disclosure |
| **Informational** | Thông tin tham khảo | Content-type header |

#### Bước 4.2 — OWASP Dependency-Check

Dependency-Check quét thư viện/dependency để tìm CVE (Common Vulnerabilities and Exposures) đã biết.

```bash
# Cài đặt dependency-check CLI
# Download từ: https://github.com/jeremylong/DependencyCheck/releases

# Scan project Java/Maven
dependency-check.sh \
 --project "ShopVN" \
 --scan ./target \
 --format HTML \
 --out ./reports/dependency-check-report.html

# Scan project Node.js
dependency-check.sh \
 --project "ShopVN-Frontend" \
 --scan ./node_modules \
 --format HTML \
 --out ./reports/dc-frontend.html

# Tích hợp Maven (pom.xml)
# Thêm plugin:
# <plugin>
# <groupId>org.owasp</groupId>
# <artifactId>dependency-check-maven</artifactId>
# <version>9.0.9</version>
# </plugin>
mvn org.owasp:dependency-check-maven:check

# NPM native audit
npm audit
npm audit --json > npm-audit-report.json

# Trivy (container + dependency scan)
trivy fs --security-checks vuln ./
trivy image shopvn/api-server:latest
```

**Đọc kết quả Dependency-Check:**

| Severity | CVSS Score | Ví dụ | Hành động |
|----------|-----------|-------|-----------|
| **Critical** | 9.0 – 10.0 | Log4Shell (CVE-2021-44228) | Upgrade ngay lập tức |
| **High** | 7.0 – 8.9 | Spring4Shell (CVE-2022-22965) | Upgrade trong sprint này |
| **Medium** | 4.0 – 6.9 | Info disclosure in library X | Lên kế hoạch upgrade |
| **Low** | 0.1 – 3.9 | Minor DoS in test library | Evaluate risk, có thể chấp nhận |

#### Bước 4.3 — SonarQube Security Rules

SonarQube là công cụ SAST (Static Application Security Testing) tích hợp phân tích code quality và security.

```bash
# Chạy SonarQube bằng Docker
docker run -d --name sonarqube \
 -p 9000:9000 \
 sonarqube:lts-community

# Chờ SonarQube khởi động xong (khoảng 1-2 phút)
# Truy cập: http://localhost:9000 (admin/admin)

# Scan project với SonarScanner
docker run --rm \
 -e SONAR_HOST_URL="http://host.docker.internal:9000" \
 -e SONAR_TOKEN="sqp_your_token_here" \
 -v "$(pwd):/usr/src" \
 sonarsource/sonar-scanner-cli \
 -Dsonar.projectKey=shopvn \
 -Dsonar.sources=./src

# Scan Maven project
mvn sonar:sonar \
 -Dsonar.host.url=http://localhost:9000 \
 -Dsonar.token=sqp_your_token_here
```

**Security Hotspots thường gặp trong SonarQube:**

| Rule ID | Mô tả | Ví dụ code vi phạm |
|---------|--------|---------------------|
| S2068 | Hardcoded credentials | `String password = "admin123";` |
| S2077 | SQL Injection | `query("SELECT * FROM users WHERE id=" + userId)` |
| S5131 | XSS | `response.write(request.getParameter("name"))` |
| S4790 | Weak hashing | `MessageDigest.getInstance("MD5")` |
| S5527 | Insecure TLS | `SSLContext.getInstance("TLSv1.0")` |
| S2245 | Predictable random | `new Random()` thay vì `SecureRandom` |
| S4423 | Weak cipher | `Cipher.getInstance("DES")` |

---

## Self-Assessment (30 câu hỏi)

### Band 1: Cơ bản (Câu 1–10)

**Câu 1.** STRIDE — chữ "I" viết tắt của gì?
- A) Integrity
- B) Information Disclosure
- C) Injection
- D) Identity Theft

**Đáp án: B** — "I" trong STRIDE là **Information Disclosure** (lộ thông tin). Integrity là thuộc tính bị vi phạm bởi **Tampering** (chữ T).

---

**Câu 2.** Trust Boundary trong DFD đại diện cho gì?
- A) Ranh giới vật lý của mạng
- B) Nơi mức độ tin cậy thay đổi
- C) Firewall
- D) Điểm xác thực

**Đáp án: B** — Trust Boundary là ranh giới nơi mức độ tin cậy (trust level) thay đổi. Ví dụ: giữa internet và internal network, giữa application layer và database layer.

---

**Câu 3.** Defense in Depth có nghĩa là gì?
- A) Một lớp bảo vệ rất mạnh
- B) Nhiều lớp bảo mật chồng lên nhau
- C) Mã hóa sâu nhiều lần
- D) Network isolation hoàn toàn

**Đáp án: B** — Defense in Depth sử dụng nhiều lớp bảo vệ (perimeter, network, application, data) để nếu một lớp bị phá vỡ, các lớp khác vẫn bảo vệ hệ thống.

---

**Câu 4.** Nguyên tắc cốt lõi của Zero Trust là gì?
- A) Trust internal network
- B) Never trust, always verify
- C) Trust after first login
- D) Trust verified devices forever

**Đáp án: B** — Zero Trust yêu cầu "Never trust, always verify" — không tin tưởng bất kỳ entity nào kể cả bên trong mạng nội bộ, mọi request đều phải xác thực.

---

**Câu 5.** Fail Secure nghĩa là gì?
- A) Khi lỗi xảy ra, cho phép truy cập để đảm bảo availability
- B) Khi lỗi xảy ra, mặc định từ chối truy cập
- C) Gửi alert khi có lỗi
- D) Tự động retry khi lỗi

**Đáp án: B** — Fail Secure = khi hệ thống gặp lỗi, mặc định **deny** truy cập. Ngược lại là Fail Open (cho phép truy cập khi lỗi — rất nguy hiểm).

---

**Câu 6.** CIA Triad bao gồm những thuộc tính nào?
- A) Confidentiality, Identity, Availability
- B) Confidentiality, Integrity, Authentication
- C) Confidentiality, Integrity, Availability
- D) Compliance, Integrity, Authorization

**Đáp án: C** — CIA Triad gồm **Confidentiality** (bảo mật), **Integrity** (toàn vẹn), **Availability** (sẵn sàng) — ba thuộc tính bảo mật cốt lõi.

---

**Câu 7.** OWASP Top 10 (2021) — lỗ hổng #1 là gì?
- A) Injection
- B) Broken Access Control
- C) Cross-Site Scripting
- D) Cryptographic Failures

**Đáp án: B** — Từ 2021, **Broken Access Control** (A01) vượt lên vị trí #1, thay thế Injection (giờ là A03).

---

**Câu 8.** Security tactic nào thuộc nhóm "Resist"?
- A) Intrusion Detection
- B) Revoke Access
- C) Validate Input
- D) Audit Trail

**Đáp án: C** — **Validate Input** thuộc nhóm Resist (chống lại tấn công). Intrusion Detection → Detect, Revoke Access → React, Audit Trail → Recover.

---

**Câu 9.** SAST và DAST khác nhau thế nào?
- A) SAST quét source code (static), DAST quét ứng dụng đang chạy (dynamic)
- B) SAST chạy nhanh hơn DAST
- C) DAST chỉ dùng cho web application
- D) SAST tìm được nhiều lỗi hơn DAST

**Đáp án: A** — **SAST** (Static) phân tích source code/bytecode mà không cần chạy ứng dụng. **DAST** (Dynamic) quét ứng dụng đang chạy bằng cách gửi request thực tế.

---

**Câu 10.** Non-repudiation đảm bảo điều gì?
- A) Dữ liệu không bị thay đổi
- B) Người dùng không thể phủ nhận hành động đã thực hiện
- C) Hệ thống luôn sẵn sàng
- D) Chỉ người được phép mới truy cập

**Đáp án: B** — Non-repudiation đảm bảo rằng một bên tham gia giao dịch/hành động **không thể phủ nhận** đã thực hiện hành động đó. Thường đạt được bằng digital signature và audit logging.

---

### Band 2: Trung bình (Câu 11–20)

**Câu 11.** Trong STRIDE, Process (hình tròn trong DFD) chịu bao nhiêu loại threat?
- A) 3
- B) 4
- C) 5
- D) 6 (tất cả)

**Đáp án: D** — Process chịu tất cả 6 loại threat STRIDE (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege) vì nó xử lý dữ liệu và thực thi logic.

---

**Câu 12.** Khi thực hiện threat modeling, bước đầu tiên nên là gì?
- A) Liệt kê mitigations
- B) Vẽ Data Flow Diagram
- C) Scan vulnerabilities
- D) Viết test cases

**Đáp án: B** — Bước đầu tiên là vẽ **Data Flow Diagram (DFD)** để hiểu kiến trúc hệ thống, data flows, trust boundaries. Từ đó mới xác định threats.

---

**Câu 13.** OWASP A04:2021 (Insecure Design) khác gì so với các lỗ hổng implementation?
- A) Insecure Design là lỗi ở level thiết kế, không thể fix bằng code review
- B) Insecure Design ít nguy hiểm hơn
- C) Insecure Design chỉ áp dụng cho web app
- D) Không có sự khác biệt

**Đáp án: A** — Insecure Design là lỗi ở mức **thiết kế kiến trúc**. Ví dụ: thiết kế không có rate limiting, không có abuse case analysis. Khác với implementation bugs (SQL injection, XSS) — code sai có thể fix, nhưng design sai cần redesign.

---

**Câu 14.** Rate limiting bảo vệ chống lại threat nào trong STRIDE?
- A) Spoofing
- B) Tampering
- C) Denial of Service
- D) Elevation of Privilege

**Đáp án: C** — Rate limiting chủ yếu chống **Denial of Service** bằng cách giới hạn số request/time window. Ngoài ra còn hỗ trợ chống brute-force (liên quan Spoofing).

---

**Câu 15.** Trong Zero Trust, "micro-segmentation" nghĩa là gì?
- A) Chia database thành nhiều bảng nhỏ
- B) Chia network thành các segment nhỏ, mỗi segment có policy riêng
- C) Chia code thành microservices
- D) Chia team thành nhóm nhỏ

**Đáp án: B** — Micro-segmentation chia **network** thành các segment nhỏ với security policy riêng biệt. Trong Kubernetes, thực hiện bằng Network Policies. Mục đích: giới hạn lateral movement khi một service bị compromise.

---

**Câu 16.** Công cụ nào sau đây là DAST tool?
- A) SonarQube
- B) OWASP ZAP
- C) ESLint
- D) FindBugs

**Đáp án: B** — **OWASP ZAP** là DAST tool (quét ứng dụng đang chạy). SonarQube, ESLint, FindBugs đều là SAST tools (phân tích code tĩnh).

---

**Câu 17.** CVSS score 9.5 thuộc severity level nào?
- A) Medium
- B) High
- C) Critical
- D) Low

**Đáp án: C** — CVSS 9.0–10.0 = **Critical**. Ví dụ: Log4Shell (CVE-2021-44228) có CVSS 10.0. Cần patch/upgrade ngay lập tức.

---

**Câu 18.** Tại sao nên dùng `SecureRandom` thay vì `Random` trong Java?
- A) SecureRandom nhanh hơn
- B) Random tạo số dự đoán được (predictable), SecureRandom dùng entropy source an toàn
- C) SecureRandom dễ dùng hơn
- D) Không có sự khác biệt

**Đáp án: B** — `java.util.Random` dùng linear congruential generator — **dự đoán được** nếu biết seed. `SecureRandom` dùng OS entropy source (/dev/urandom) — không thể dự đoán. Dùng Random cho security token = lỗ hổng nghiêm trọng.

---

**Câu 19.** Principle "Complete Mediation" yêu cầu gì?
- A) Mã hóa tất cả dữ liệu
- B) Kiểm tra quyền truy cập cho MỌI request, không cache kết quả authorization
- C) Log tất cả hành động
- D) Test tất cả endpoints

**Đáp án: B** — Complete Mediation = kiểm tra authorization cho **mọi** access request. Không cache kết quả authz vì quyền có thể thay đổi. Mỗi API call đều phải verify permissions.

---

**Câu 20.** Khi phát hiện hardcoded secret trong source code, hành động đúng là gì?
- A) Chỉ cần xóa secret khỏi code
- B) Xóa khỏi code + rotate secret + kiểm tra git history
- C) Thêm file vào .gitignore
- D) Encrypt secret trong code

**Đáp án: B** — Phải **(1)** xóa khỏi code, **(2)** rotate/revoke secret cũ (vì đã bị lộ trong git history), **(3)** dùng `git filter-branch` hoặc BFG Repo Cleaner để xóa khỏi history, **(4)** chuyển sang Vault/Secrets Manager.

---

### Band 3: Nâng cao (Câu 21–30)

**Câu 21.** Trong kiến trúc microservices, mTLS (mutual TLS) giải quyết threat nào?
- A) Chỉ Spoofing
- B) Spoofing + Information Disclosure + Tampering
- C) Chỉ Information Disclosure
- D) Denial of Service

**Đáp án: B** — mTLS giải quyết: **Spoofing** (cả hai bên xác thực danh tính bằng certificate), **Information Disclosure** (mã hóa traffic), **Tampering** (TLS đảm bảo integrity). Service mesh như Istio tự động quản lý mTLS.

---

**Câu 22.** Tại sao JWT với thuật toán "none" là lỗ hổng nghiêm trọng?
- A) Token quá lớn
- B) Kẻ tấn công có thể forge token không cần secret key
- C) Token không có expiry
- D) Không thể refresh

**Đáp án: B** — JWT algorithm "none" = **không có signature verification**. Kẻ tấn công tạo JWT với payload tùy ý (vd: `"role": "admin"`), set `"alg": "none"` → server chấp nhận mà không verify. Fix: whitelist allowed algorithms, reject "none".

---

**Câu 23.** SSRF (Server-Side Request Forgery) nguy hiểm vì lý do gì?
- A) Chỉ ảnh hưởng frontend
- B) Server gửi request theo ý attacker, có thể truy cập internal service/metadata
- C) Chỉ gây DoS
- D) Chỉ ảnh hưởng database

**Đáp án: B** — SSRF cho phép attacker điều khiển server gửi request đến **internal services** (vd: `http://169.254.169.254/latest/meta-data/` trên AWS để lấy IAM credentials). Capital One breach (2019) liên quan SSRF.

---

**Câu 24.** Khi thiết kế hệ thống payment, nguyên tắc nào QUAN TRỌNG NHẤT?
- A) Performance optimization
- B) Idempotency + audit trail + encryption + least privilege
- C) Microservices architecture
- D) Real-time notifications

**Đáp án: B** — Payment system cần: **Idempotency** (tránh charge 2 lần), **Audit trail** (non-repudiation cho mọi giao dịch), **Encryption** (PCI-DSS compliance), **Least privilege** (payment service chỉ access payment DB).

---

**Câu 25.** Supply chain attack trong software là gì?
- A) Tấn công vào network
- B) Tấn công vào dependency/library/build pipeline mà ứng dụng sử dụng
- C) Tấn công vào database
- D) Social engineering

**Đáp án: B** — Supply chain attack nhắm vào **dependency, library, hoặc build pipeline**. Ví dụ: SolarWinds (malicious code trong build), event-stream npm package (crypto-mining code). Mitigation: dependency scanning, SLSA framework, lock files, signature verification.

---

**Câu 26.** Trong Kubernetes, Pod Security Standard "Restricted" yêu cầu gì?
- A) Pod chạy bằng root user
- B) Pod phải non-root, read-only root filesystem, no privilege escalation, restricted capabilities
- C) Pod có full network access
- D) Pod mount host filesystem

**Đáp án: B** — Restricted policy yêu cầu: **non-root** user, **read-only** root filesystem, **no privilege escalation** (`allowPrivilegeEscalation: false`), drop **ALL** capabilities, restricted seccomp profile. Đây là mức strict nhất.

---

**Câu 27.** OWASP ASVS (Application Security Verification Standard) Level 2 phù hợp cho loại ứng dụng nào?
- A) Internal tools ít nhạy cảm
- B) Ứng dụng xử lý dữ liệu nhạy cảm (healthcare, financial, PII)
- C) Chỉ dành cho military/government
- D) Prototype / MVP

**Đáp án: B** — ASVS Level 1 = cơ bản (mọi ứng dụng), Level 2 = ứng dụng xử lý **dữ liệu nhạy cảm** (phổ biến nhất cho enterprise), Level 3 = critical applications (banking core, military).

---

**Câu 28.** Threat modeling nên thực hiện ở giai đoạn nào trong SDLC?
- A) Chỉ khi có security incident
- B) Ở giai đoạn Design, và lặp lại khi architecture thay đổi
- C) Chỉ trước khi release
- D) Chỉ ở giai đoạn testing

**Đáp án: B** — Threat modeling hiệu quả nhất ở giai đoạn **Design** (shift-left security). Thực hiện lại khi architecture thay đổi đáng kể (thêm service, thay đổi data flow, tích hợp third-party mới).

---

**Câu 29.** Confused Deputy Problem là gì?
- A) Khi developer không hiểu requirements
- B) Khi một service có quyền cao bị lợi dụng bởi entity có quyền thấp hơn
- C) Khi hai service xung đột
- D) Khi deployment sai configuration

**Đáp án: B** — Confused Deputy: service A (có quyền cao) bị service B (quyền thấp) lợi dụng để thực hiện hành động mà B không có quyền. Ví dụ: API Gateway có quyền access DB, attacker gửi crafted request qua Gateway để access data không được phép. Fix: validate caller context, capability-based security.

---

**Câu 30.** Trong security architecture, "blast radius" là gì và làm sao giảm thiểu?
- A) Vùng bị ảnh hưởng bởi DDoS, giảm bằng CDN
- B) Phạm vi thiệt hại khi một component bị compromise; giảm bằng segmentation, least privilege, và isolation
- C) Số lượng users bị ảnh hưởng, giảm bằng load balancing
- D) Kích thước log file, giảm bằng log rotation

**Đáp án: B** — Blast radius = **phạm vi thiệt hại** khi một phần hệ thống bị compromise. Giảm thiểu bằng: **(1)** Network segmentation (micro-segmentation), **(2)** Least privilege (mỗi service chỉ access data cần thiết), **(3)** Isolation (separate databases per service), **(4)** Short-lived credentials. Ví dụ: nếu Order Service bị hack nhưng không có quyền access User DB → blast radius giới hạn ở order data.

---

## Extend Labs (10 bài)

### EL1: Full STRIDE cho Hệ thống Banking
```
Mục tiêu: Threat modeling hoàn chỉnh cho hệ thống Internet Banking
- Vẽ DFD Level 0 + Level 1 cho: Mobile App, API Gateway, Core Banking,
 Card Service, Notification Service, Fraud Detection
- STRIDE analysis cho tất cả elements (tối thiểu 30 threats)
- Risk matrix với heatmap
- Mitigation plan có priority và timeline
Deliverable: Threat model document (15+ trang)
Độ khó: ****
```

### EL2: OWASP Top 10 Penetration Testing
```
Mục tiêu: Thực hành tìm lỗ hổng OWASP trên DVWA/Juice Shop
- Cài đặt OWASP Juice Shop: docker run -p 3000:3000 bkimminich/juice-shop
- Tìm và exploit ít nhất 5/10 OWASP vulnerabilities
- Document: steps to reproduce, impact, fix recommendation
- Viết automation script cho ít nhất 2 exploits
Deliverable: Penetration test report
Độ khó: ****
```

### EL3: Security Pipeline Integration
```
Mục tiêu: Tích hợp security tools vào CI/CD pipeline
- Tạo GitHub Actions workflow với:
 - SAST: SonarQube scan
 - SCA: OWASP Dependency-Check
 - DAST: ZAP baseline scan
 - Container: Trivy image scan
- Cấu hình quality gate: fail build nếu có Critical/High vulnerability
- Tạo security dashboard tổng hợp kết quả
Deliverable: .github/workflows/security.yml + screenshots
Độ khó: ***
```

### EL4: Cloud Security Architecture Review
```
Mục tiêu: Review security cho kiến trúc AWS
- Review IAM policies (least privilege analysis)
- Kiểm tra Security Groups và NACLs
- S3 bucket policies và encryption
- RDS encryption, backup, access control
- CloudTrail + GuardDuty configuration
- Sử dụng AWS Security Hub / Prowler để audit
Deliverable: Cloud security review report
Độ khó: ****
```

### EL5: API Security Hardening
```
Mục tiêu: Secure một REST API theo OWASP API Security Top 10
- Implement OAuth 2.0 + PKCE flow
- Rate limiting (per-user, per-endpoint)
- Input validation (JSON Schema)
- Output filtering (chỉ return fields cần thiết)
- Security headers (CORS, CSP, HSTS)
- API versioning và deprecation policy
Deliverable: Secured API code + Postman collection test
Độ khó: ***
```

### EL6: Container & Kubernetes Security
```
Mục tiêu: Harden Docker containers và Kubernetes cluster
- Dockerfile best practices (multi-stage, non-root, minimal base)
- Scan image: trivy image myapp:latest
- Kubernetes: Pod Security Standards (Restricted)
- Network Policies (deny-all default, whitelist)
- RBAC cho developers, CI/CD service accounts
- Secret management: Sealed Secrets hoặc External Secrets
Deliverable: Hardened Dockerfile + K8s manifests + scan reports
Độ khó: ****
```

### EL7: Zero Trust Network Implementation
```
Mục tiêu: Triển khai Zero Trust với service mesh
- Cài đặt Istio service mesh
- Enable mTLS (STRICT mode) giữa tất cả services
- Implement AuthorizationPolicy (chỉ cho phép traffic cần thiết)
- JWT validation tại Istio ingress gateway
- Observe traffic với Kiali dashboard
- Test: verify service A không thể gọi service B nếu không được phép
Deliverable: Istio configs + screenshots + test results
Độ khó: *****
```

### EL8: Security Monitoring & Incident Response
```
Mục tiêu: Xây dựng hệ thống giám sát bảo mật
- Deploy ELK Stack (Elasticsearch, Logstash, Kibana)
- Cấu hình security event logging (failed auth, privilege changes)
- Tạo Kibana dashboards cho security metrics
- Cấu hình alerts: brute-force detection (>5 failed login/5min)
- Viết Incident Response Playbook cho 3 scenarios:
 (1) Data breach, (2) DDoS, (3) Compromised credentials
Deliverable: ELK configs + dashboards + IR playbook
Độ khó: ****
```

### EL9: Compliance Mapping (PCI-DSS / GDPR)
```
Mục tiêu: Map security controls với compliance requirements
- Chọn 1 framework: PCI-DSS v4.0 hoặc GDPR
- Map từng requirement vào kiến trúc e-commerce:
 PCI-DSS: Requirement 1-12 mapping
 GDPR: Article 25 (Data Protection by Design), Article 32 (Security)
- Gap analysis: requirements chưa đáp ứng
- Remediation plan với effort estimation
Deliverable: Compliance mapping matrix + gap analysis + remediation plan
Độ khó: ****
```

### EL10: Red Team / Blue Team Exercise
```
Mục tiêu: Mô phỏng tấn công và phòng thủ
- Red Team (tấn công):
 - Reconnaissance: Nmap, OSINT
 - Exploitation: SQLi, XSS, SSRF trên lab environment
 - Post-exploitation: Lateral movement, data exfiltration
- Blue Team (phòng thủ):
 - Detection: Phân tích logs, identify attack patterns
 - Response: Block attacker, patch vulnerabilities
 - Recovery: Restore affected systems
- Post-exercise: Lessons learned document
Deliverable: Attack report + Defense report + Lessons learned
Độ khó: *****
```

---

## Deliverables Checklist

| # | Deliverable | Lab | Mô tả | Check |
|---|-------------|-----|--------|-------|
| 1 | STRIDE Threat Model | Lab 1 | DFD diagram + STRIDE analysis table (≥14 threats) + Risk matrix | ☐ |
| 2 | OWASP Mapping Table | Lab 2 | 10 OWASP items mapped to architecture + mitigations + priority | ☐ |
| 3 | Security Review Report | Lab 3 | Checklist review (15 items) + Summary report + Recommendations | ☐ |
| 4 | Security Tool Results | Lab 4 | ZAP scan report + Dependency-Check report + SonarQube screenshot | ☐ |
| 5 | Self-Assessment | — | 30 câu hỏi đã trả lời, ghi chú những phần cần học thêm | ☐ |

---

## Lỗi Thường Gặp

| # | Lỗi | Mô tả | Cách sửa |
|---|------|--------|----------|
| 1 | **Threat modeling quá chung** | Viết "hacker có thể tấn công" mà không chỉ rõ attack vector | Mô tả cụ thể: attacker type, entry point, technique, impacted asset |
| 2 | **Bỏ qua trust boundaries** | DFD không vẽ trust boundaries → thiếu threats ở boundary crossing | Xác định rõ trust boundaries: internetDMZ, DMZinternal, appDB |
| 3 | **Chỉ focus CIA, bỏ qua Non-repudiation** | Không consider audit trail và accountability | Thêm logging, digital signatures cho critical transactions |
| 4 | **Mitigation không khả thi** | Đề xuất "encrypt everything" mà không xét performance/cost | Mitigation phải cụ thể, có cost-benefit analysis, prioritized |
| 5 | **OWASP mapping sai severity** | Đánh giá tất cả vulnerabilities đều High | Dùng CVSS scoring, xét context cụ thể của hệ thống |
| 6 | **Security review không có evidence** | Checklist chỉ ghi Pass/Fail mà không có bằng chứng | Mỗi item phải có screenshot, config snippet, hoặc test result |
| 7 | **Dùng deprecated algorithms** | Recommend MD5/SHA-1 cho hashing, TLS 1.0/1.1 | Dùng bcrypt/argon2 cho password, SHA-256+ cho integrity, TLS 1.3 |
| 8 | **Không consider insider threats** | Chỉ focus external attackers | STRIDE áp dụng cho cả internal actors, xét Separation of Duties |
| 9 | **Security testing chỉ chạy 1 lần** | Scan ZAP/SonarQube 1 lần rồi bỏ | Tích hợp vào CI/CD pipeline, chạy mỗi build/deploy |
| 10 | **Bỏ qua dependency vulnerabilities** | Không scan third-party libraries | Tích hợp OWASP Dependency-Check / npm audit / Trivy vào pipeline |

---

## Rubric Chấm điểm

| Tiêu chí | Xuất sắc (100%) | Khá (75%) | Trung bình (50%) | Yếu (<50%) | Điểm tối đa |
|----------|------------------|-----------|-------------------|-------------|-------------|
| **STRIDE Threat Model** | DFD chính xác, ≥14 threats được xác định với đầy đủ description, likelihood, impact, mitigation. Risk matrix hoàn chỉnh | DFD đúng, 10-13 threats, có mitigation nhưng chưa đầy đủ | DFD thiếu elements, 5-9 threats, mitigation chung chung | DFD sai hoặc thiếu, <5 threats, không có mitigation | **25** |
| **OWASP Analysis** | Tất cả 10 OWASP items được map chính xác vào architecture, mitigation cụ thể và khả thi, priority hợp lý | 7-9 items mapped, mitigation khá cụ thể | 4-6 items mapped, mitigation chưa cụ thể | <4 items, mapping sai hoặc quá chung | **20** |
| **Security Review** | Checklist 15 items hoàn chỉnh, có evidence cho mỗi item, report rõ ràng với executive summary và prioritized recommendations | 11-14 items có evidence, report đủ nội dung | 7-10 items, thiếu evidence, report thiếu phần | <7 items, không có report tổng hợp | **25** |
| **Security Tools** | Chạy thành công cả 3 tools (ZAP + Dependency-Check + SonarQube), phân tích kết quả đúng, đề xuất fix hợp lý | 2/3 tools chạy thành công, phân tích khá | 1/3 tools, phân tích cơ bản | Không chạy được tool nào hoặc chỉ copy kết quả | **15** |
| **Trình bày & Tổng hợp** | Document chuyên nghiệp, logical flow, kết nối giữa các phần, no typos | Document tốt, có flow | Document đủ nội dung nhưng chưa liên kết | Document lộn xộn, thiếu nội dung | **15** |
| **Tổng** | | | | | **100** |

---

## Tài liệu Tham khảo

1. **Adam Shostack** — *Threat Modeling: Designing for Security*, Wiley, 2014
2. **OWASP** — [OWASP Top 10 (2021)](https://owasp.org/Top10/)
3. **OWASP** — [Threat Modeling Guide](https://owasp.org/www-community/Threat_Modeling)
4. **Microsoft** — [STRIDE Threat Model](https://learn.microsoft.com/en-us/azure/security/develop/threat-modeling-tool-threats)
5. **NIST** — [Cybersecurity Framework v2.0](https://www.nist.gov/cyberframework)
6. **NIST SP 800-207** — *Zero Trust Architecture*, 2020
7. **OWASP ZAP** — [Getting Started Guide](https://www.zaproxy.org/getting-started/)
8. **OWASP Dependency-Check** — [GitHub](https://github.com/jeremylong/DependencyCheck)
9. **Bass, Clements, Kazman** — *Software Architecture in Practice*, 4th Ed. (Chapter 9: Security)
10. **ĐH Bách Khoa HN** — IT4995 Software Architecture (Security module)
