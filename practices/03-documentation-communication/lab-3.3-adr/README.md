# Lab 3.3: Architecture Decision Records (ADR)

## 1. Tổng quan

| Thông tin | Giá trị |
|-----------|---------|
| **Thời lượng** | 3 giờ |
| **Độ khó** | Intermediate |
| **Yêu cầu trước** | Lab 3.1 (Documentation Basics), Lab 3.2 (Diagram as Code) |
| **CLO** | CLO4 |
| **Công cụ** | MADR, adr-tools CLI, Git |
| **Ngôn ngữ** | Markdown |

Architecture Decision Records (ADR) là phương pháp ghi lại các quyết định kiến trúc phần mềm một cách có cấu trúc. Được đề xuất bởi **Michael Nygard** vào năm 2011, ADR đã trở thành best practice được áp dụng rộng rãi trong ngành công nghiệp phần mềm — từ startup đến enterprise. Lab này hướng dẫn bạn viết, quản lý và review ADR theo chuẩn chuyên nghiệp.

---

## 2. Mục tiêu Học tập

Sau khi hoàn thành lab này, bạn có thể:

1. **Hiểu khái niệm ADR** — giải thích được ADR là gì, tại sao cần ADR, và vai trò của ADR trong software architecture documentation
2. **Viết ADR theo nhiều format** — thực hành viết ADR theo Nygard format, MADR format và Y-statement format
3. **Quản lý ADR lifecycle** — thực hiện đầy đủ vòng đời ADR: Proposed → Accepted → Deprecated / Superseded, bao gồm linking và versioning
4. **Sử dụng adr-tools CLI** — cài đặt và sử dụng adr-tools để tạo, liệt kê, supersede và quản lý ADR từ command line
5. **Áp dụng ADR review process** — tổ chức review ADR qua Pull Request, team discussion và decision meeting theo quy trình thực tế

---

## 3. Phân bổ Thời gian

| Hoạt động | Thời lượng | Mô tả |
|-----------|-----------|-------|
| Lý thuyết ADR | 30 phút | Concept, formats, lifecycle, best practices |
| Lab 1: Setup & First ADR | 25 phút | Install adr-tools, init, tạo ADR đầu tiên |
| Lab 2: Viết 3 ADR theo MADR | 35 phút | DB selection, auth strategy, caching solution |
| Lab 3: ADR Lifecycle | 25 phút | Supersede, deprecate, linking ADRs |
| Lab 4: ADR Review Process | 25 phút | PR-based review, team discussion simulation |
| Self-Assessment | 20 phút | 30 câu hỏi trắc nghiệm + tự luận |
| Extend Labs | 20 phút | Bài tập mở rộng nâng cao |
| **Tổng** | **3 giờ** | |

---

## 4. Lý thuyết

### 4.1 ADR Concept — Michael Nygard

**Architecture Decision Record (ADR)** là một tài liệu ngắn gọn ghi lại một quyết định kiến trúc quan trọng, bao gồm context dẫn đến quyết định đó và consequences của nó.

Michael Nygard đề xuất ADR trong bài blog nổi tiếng *"Documenting Architecture Decisions"* (2011) với ý tưởng cốt lõi:

> "Architecture decisions are those decisions that are hard to reverse. We should record them along with their context and consequences."

**Tại sao cần ADR?**

| Không có ADR | Có ADR |
|-------------|--------|
| "Tại sao chúng ta chọn PostgreSQL?" — không ai nhớ | Quyết định, lý do, và trade-offs được ghi lại rõ ràng |
| Knowledge bị mất khi người ra đi | Knowledge được bảo tồn trong repository |
| Lặp lại discussions cũ vì quên kết luận | Tham khảo lại decision history nhanh chóng |
| Onboarding chậm — nhân viên mới không hiểu context | New members đọc ADR để hiểu "why" behind decisions |
| Blame game khi quyết định gây ra vấn đề | Rõ ràng ai quyết định, tại sao, và dựa trên thông tin nào |

**Đặc điểm của một ADR tốt:**
- **Immutable** — một khi accepted, không sửa nội dung, chỉ supersede bằng ADR mới
- **Short** — 1-2 trang, đủ để người đọc hiểu context + decision + consequences
- **Specific** — mỗi ADR chỉ ghi một quyết định duy nhất
- **Dated** — có ngày tạo và ngày thay đổi status

### 4.2 ADR Formats

#### Format 1: Nygard (Original)

Format ngắn gọn nhất, gồm 5 phần:

```markdown
# [Number]. [Title]

Date: [YYYY-MM-DD]

## Status
[Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

## Context
[Mô tả tình huống, vấn đề cần giải quyết, các ràng buộc]

## Decision
[Quyết định được đưa ra]

## Consequences
[Hệ quả tích cực và tiêu cực]
```

#### Format 2: MADR (Markdown Any Decision Records)

Format chi tiết hơn, phổ biến nhất hiện nay. Bao gồm thêm Decision Drivers và Considered Options:

```markdown
# [Title]

## Status
[Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

## Date
[YYYY-MM-DD]

## Context and Problem Statement
[Mô tả vấn đề dưới dạng câu hỏi. Ví dụ: "Chúng ta nên chọn database nào cho hệ thống?"]

## Decision Drivers
- [Driver 1: ví dụ "Performance requirement"]
- [Driver 2: ví dụ "Team expertise"]
- [Driver 3: ví dụ "Cost"]

## Considered Options
1. [Option A]
2. [Option B]
3. [Option C]

## Decision Outcome
Chosen option: "[Option X]", because [justification].

### Positive Consequences
- [Positive 1]
- [Positive 2]

### Negative Consequences
- [Negative 1]
- [Negative 2]

## Pros and Cons of the Options

### [Option A]
- Good, because [argument]
- Bad, because [argument]

### [Option B]
- Good, because [argument]
- Bad, because [argument]

### [Option C]
- Good, because [argument]
- Bad, because [argument]

## Links
- [Related ADR](./XXXX-related-decision.md)
- [Reference](https://example.com)
```

#### Format 3: Y-statement

Format cô đọng nhất, viết decision trong một câu duy nhất theo cấu trúc:

```
In the context of [use case/requirement],
facing [concern],
we decided for [option]
and neglected [other options],
to achieve [quality goals],
accepting [downside/trade-off].
```

**Ví dụ:**

```
In the context of the e-commerce platform's payment processing,
facing the need for high reliability and PCI compliance,
we decided for Stripe as payment gateway
and neglected PayPal and Braintree,
to achieve fast integration and built-in compliance,
accepting higher transaction fees (2.9% + 30¢ per transaction).
```

### 4.3 ADR Lifecycle

ADR có 4 trạng thái chính:

```
 ┌──────────────┐
 │ Proposed │ ← Tạo mới, chờ review
 └──────┬───────┘
 │ (approved by team)
 ┌──────▼───────┐
 │ Accepted │ ← Đã được chấp nhận, đang áp dụng
 └──────┬───────┘
 │
 ┌────────────┼─────────────┐
 │ │
 ┌─────────▼────────┐ ┌────────────▼───────────┐
 │ Deprecated │ │ Superseded by X │
 │ (không còn dùng) │ │ (thay thế bởi ADR mới) │
 └──────────────────┘ └────────────────────────┘
```

| Status | Ý nghĩa | Khi nào dùng |
|--------|---------|--------------|
| **Proposed** | Đang đề xuất, chờ review | Vừa tạo ADR, cần team thảo luận |
| **Accepted** | Đã chấp nhận, đang áp dụng | Team đã đồng ý, decision có hiệu lực |
| **Deprecated** | Không còn phù hợp | Decision không còn relevant (ví dụ: service bị xóa) |
| **Superseded** | Bị thay thế bởi ADR mới | Có quyết định mới thay thế quyết định cũ |

**Quy tắc quan trọng:** Không bao giờ sửa nội dung ADR đã Accepted. Nếu cần thay đổi decision, tạo ADR mới và supersede ADR cũ.

### 4.4 ADR as Code — adr-tools CLI

**adr-tools** là bộ command-line tool do Nat Pryce phát triển, giúp quản lý ADR trong project:

```bash
# Cài đặt trên macOS
brew install adr-tools

# Cài đặt trên Linux (Ubuntu/Debian)
sudo apt-get install adr-tools

# Cài đặt trên Windows (dùng npm alternative)
npm install -g adr-log

# Hoặc clone repo trực tiếp
git clone https://github.com/npryce/adr-tools.git
export PATH="$PWD/adr-tools/src:$PATH"
```

**Các lệnh chính:**

| Lệnh | Mô tả | Ví dụ |
|-------|--------|-------|
| `adr init` | Khởi tạo thư mục ADR | `adr init docs/adr` |
| `adr new` | Tạo ADR mới | `adr new "Use PostgreSQL"` |
| `adr list` | Liệt kê tất cả ADR | `adr list` |
| `adr link` | Tạo liên kết giữa các ADR | `adr link 5 "Supersedes" 2 "Superseded by"` |
| `adr generate toc` | Tạo Table of Contents | `adr generate toc` |
| `adr generate graph` | Tạo graph quan hệ | `adr generate graph \| dot -Tpng > graph.png` |

### 4.5 Khi nào nên viết ADR?

**Viết ADR khi:**
- Chọn technology stack (database, framework, language)
- Quyết định architecture pattern (monolith vs microservices, event-driven, CQRS)
- Thiết kế API strategy (REST vs GraphQL vs gRPC)
- Chọn authentication/authorization method (JWT, OAuth, Session)
- Quyết định deployment strategy (Kubernetes, serverless, VM)
- Thay đổi significant conventions (coding standards, branching strategy)
- Bất kỳ quyết định nào **khó đảo ngược** hoặc **ảnh hưởng nhiều team**

**Không cần viết ADR cho:**
- Bug fixes
- Minor refactoring
- UI tweaks
- Dependency version updates (trừ khi major version với breaking changes)
- Quyết định chỉ ảnh hưởng trong 1 function/module nhỏ

### 4.6 ADR Best Practices

1. **Giữ ADR ngắn gọn** — 1-2 trang, tập trung vào decision và reasoning
2. **Viết cho người đọc tương lai** — giải thích context đầy đủ, đừng giả định người đọc biết background
3. **Liệt kê tất cả options đã xem xét** — kể cả options bị loại, để tránh ai đó đề xuất lại
4. **Ghi rõ consequences tiêu cực** — transparency giúp team hiểu trade-offs
5. **Dùng số thứ tự** — ADR-001, ADR-002,... để dễ tham chiếu
6. **Link các ADR liên quan** — tạo web of decisions để hiểu context rộng hơn
7. **Review ADR như code** — dùng Pull Request, yêu cầu ít nhất 2 reviewers
8. **Lưu ADR trong Git** — cùng repository với code, version control tự nhiên
9. **Không sửa ADR đã Accepted** — tạo ADR mới nếu cần thay đổi
10. **Cập nhật status kịp thời** — đánh dấu Deprecated/Superseded khi có thay đổi

### 4.7 ADR vs RFC

| Tiêu chí | ADR | RFC (Request for Comments) |
|----------|-----|---------------------------|
| **Mục đích** | Ghi lại decision đã/sẽ được đưa ra | Đề xuất thay đổi lớn, thu thập feedback |
| **Scope** | Một quyết định cụ thể | Một thay đổi lớn, có thể gồm nhiều decisions |
| **Độ dài** | 1-2 trang | 5-20+ trang |
| **Audience** | Developers, architects | Toàn bộ engineering organization |
| **Lifetime** | Immutable sau khi accepted | Có thể revise trước khi finalize |
| **Khi nào dùng** | Mọi architectural decision | Major cross-team changes, new systems |

### 4.8 Lưu trữ ADR trong Git

**Cấu trúc thư mục khuyến nghị:**

```
project-root/
├── docs/
│ └── adr/
│ ├── 0001-record-architecture-decisions.md
│ ├── 0002-use-postgresql-as-database.md
│ ├── 0003-adopt-microservices.md
│ ├── 0004-use-jwt-for-authentication.md
│ ├── 0005-use-redis-for-caching.md
│ └── README.md ← Table of Contents
├── src/
└── README.md
```

**Lợi ích lưu trong Git:**
- Version history tự nhiên — biết ai viết/sửa ADR khi nào
- Code review qua Pull Request
- ADR luôn đi cùng code — không bị lạc ở Confluence/Wiki
- Branch-based workflow — ADR mới có thể review trước khi merge
- CI/CD có thể validate format ADR tự động

---

## 5. Step-by-step Labs

### Lab 1: Install adr-tools & Create First ADR (25 phút)

**Mục tiêu:** Cài đặt adr-tools, khởi tạo thư mục ADR, tạo ADR đầu tiên.

#### Bước 1: Tạo project và cài adr-tools

```bash
# Tạo project mới
mkdir my-ecommerce-platform && cd my-ecommerce-platform
git init

# Cài đặt adr-tools
# macOS:
brew install adr-tools

# Linux (manual install):
git clone https://github.com/npryce/adr-tools.git /tmp/adr-tools
sudo cp /tmp/adr-tools/src/* /usr/local/bin/

# Windows (PowerShell — dùng script tương đương):
# Download từ https://github.com/npryce/adr-tools/releases
# Hoặc dùng WSL
```

#### Bước 2: Khởi tạo thư mục ADR

```bash
# Khởi tạo ADR directory
adr init docs/adr

# Kiểm tra — adr-tools tự tạo ADR đầu tiên
ls docs/adr/
# Output: 0001-record-architecture-decisions.md
```

Xem nội dung ADR mặc định:

```bash
cat docs/adr/0001-record-architecture-decisions.md
```

Output:

```markdown
# 1. Record architecture decisions

Date: 2026-03-19

## Status

Accepted

## Context

We need to record the architectural decisions made on this project.

## Decision

We will use Architecture Decision Records, as described by Michael Nygard.

## Consequences

See Michael Nygard's article, linked above.
```

#### Bước 3: Tạo ADR đầu tiên — Chọn Frontend Framework

```bash
adr new "Use React as frontend framework"
# Output: docs/adr/0002-use-react-as-frontend-framework.md
```

Mở file và chỉnh sửa nội dung:

```markdown
# 2. Use React as frontend framework

Date: 2026-03-19

## Status

Accepted

## Context

Chúng ta cần chọn frontend framework cho e-commerce platform. Yêu cầu:
- Component-based architecture cho reusable UI
- Large ecosystem với nhiều thư viện hỗ trợ
- Server-side rendering (SSR) cho SEO
- Team có 5 developers, 3 người đã có kinh nghiệm React

## Decision

Chúng ta sẽ sử dụng **React 18 với Next.js 14** làm frontend framework.

Lý do chính:
- 3/5 developers đã có kinh nghiệm React
- Next.js cung cấp SSR/SSG tốt cho SEO
- Ecosystem lớn nhất (npm packages, community)
- Phù hợp với hiring — dễ tuyển React developers

## Consequences

**Positive:**
- Team có thể bắt đầu nhanh do đã có kinh nghiệm
- Cộng đồng lớn, dễ tìm solutions cho vấn đề
- Next.js cung cấp nhiều features built-in (routing, API routes, image optimization)

**Negative:**
- React không phải framework hoàn chỉnh — cần chọn thêm state management, form library
- Bundle size có thể lớn nếu không optimize carefully
- 2 developers cần thời gian học React (ước tính 2-3 tuần)
```

#### Bước 4: Kiểm tra và liệt kê ADR

```bash
# Liệt kê tất cả ADR
adr list
# Output:
# docs/adr/0001-record-architecture-decisions.md
# docs/adr/0002-use-react-as-frontend-framework.md

# Tạo Table of Contents
adr generate toc > docs/adr/README.md

# Commit
git add docs/adr/
git commit -m "docs: initialize ADR and add framework decision"
```

---

### Lab 2: Viết 3 ADR theo MADR Format (35 phút)

**Mục tiêu:** Viết 3 ADR đầy đủ theo MADR format cho các quyết định: Database Selection, Authentication Strategy, Caching Solution.

#### ADR-003: Database Selection

Tạo file `docs/adr/0003-use-postgresql-as-primary-database.md`:

```markdown
# 3. Use PostgreSQL as Primary Database

## Status

Accepted

## Date

2026-03-19

## Context and Problem Statement

E-commerce platform cần một primary database để lưu trữ dữ liệu transactional (orders, payments, users, products). Database phải đảm bảo:
- ACID transactions cho orders và payments
- Hỗ trợ complex queries cho reporting và analytics
- Scale đến hàng triệu records
- High availability (99.9% uptime)

Team hiện có kinh nghiệm với SQL databases (MySQL, PostgreSQL).

## Decision Drivers

- **Data consistency**: Orders và payments yêu cầu ACID transactions — không chấp nhận data loss
- **Query complexity**: Cần JOINs, aggregations, window functions cho reporting
- **Scalability**: Phải handle growth từ 10K đến 1M orders/tháng trong 2 năm
- **Team expertise**: Team mạnh về SQL, 4/5 thành viên có kinh nghiệm PostgreSQL/MySQL
- **Cost**: Open-source preferred, budget hạn chế cho database licensing
- **JSON support**: Product attributes linh hoạt, cần semi-structured data

## Considered Options

1. PostgreSQL 16
2. MySQL 8
3. MongoDB 7
4. CockroachDB

## Decision Outcome

Chosen option: **"PostgreSQL 16"**, because nó cung cấp ACID transactions mạnh mẽ, JSON support xuất sắc (JSONB), rich query capabilities, và team đã có kinh nghiệm. Đây là lựa chọn cân bằng tốt nhất giữa features, performance và chi phí.

### Positive Consequences

- ACID guarantees cho mọi financial transactions
- JSONB cho phép lưu flexible product attributes mà không cần schema migration
- Mature ecosystem: pgAdmin, pg_stat, extensions (PostGIS, pg_trgm)
- Compatible với major cloud providers (AWS RDS, GCP Cloud SQL, Azure)
- Team bắt đầu nhanh do đã familiar

### Negative Consequences

- Cần plan read replicas sớm cho reporting workload
- Horizontal sharding phức tạp hơn MongoDB — cần Citus hoặc manual sharding
- Write-heavy workload có thể cần tuning (WAL, vacuum)
- Connection pooling cần PgBouncer

## Pros and Cons of the Options

### PostgreSQL 16

- Good, because ACID transactions mạnh nhất trong các options
- Good, because JSONB support cho semi-structured data
- Good, because rich extensions ecosystem (PostGIS, full-text search, pg_trgm)
- Good, because team đã có kinh nghiệm
- Good, because open-source, cost-effective
- Bad, because horizontal scaling phức tạp
- Bad, because replication setup phức tạp hơn MySQL

### MySQL 8

- Good, because replication đơn giản (built-in Group Replication)
- Good, because documentation phong phú, cộng đồng lớn
- Good, because performance tốt cho read-heavy workloads
- Bad, because JSON support kém hơn PostgreSQL
- Bad, because window functions và CTE support muộn hơn
- Bad, because ít extensions hữu ích

### MongoDB 7

- Good, because flexible schema, dễ thay đổi data model
- Good, because horizontal scaling (sharding) built-in
- Good, because document model phù hợp cho product catalog
- Bad, because không có true ACID transactions cho multi-document
- Bad, because không phù hợp cho complex JOINs
- Bad, because team không có kinh nghiệm NoSQL
- Bad, because eventual consistency gây rủi ro cho financial data

### CockroachDB

- Good, because distributed SQL, automatic sharding
- Good, because PostgreSQL-compatible wire protocol
- Good, because strong consistency across regions
- Bad, because operational complexity cao
- Bad, because newer, ít community support
- Bad, because licensing cost cao cho enterprise features
- Bad, because team chưa có kinh nghiệm

## Links

- [PostgreSQL Documentation](https://www.postgresql.org/docs/16/)
- Relates to ADR-005: Use Redis for caching
- Relates to ADR-008: Use read replicas for reporting queries
```

#### ADR-004: Authentication Strategy

Tạo file `docs/adr/0004-use-jwt-for-authentication.md`:

```markdown
# 4. Use JWT for Authentication

## Status

Accepted

## Date

2026-03-19

## Context and Problem Statement

E-commerce platform cần authentication mechanism cho users (customers và admins). Hệ thống sẽ có:
- Web app (Next.js)
- Mobile app (React Native — planned)
- Public API cho third-party integrations
- Microservices cần verify user identity

Câu hỏi: Chúng ta nên sử dụng authentication method nào?

## Decision Drivers

- **Stateless**: Microservices không nên share session state
- **Cross-platform**: Phải hoạt động trên web, mobile, và API
- **Scalability**: Không tạo bottleneck khi scale horizontally
- **Security**: Đáp ứng OWASP best practices
- **Developer experience**: Dễ implement, debug, và test

## Considered Options

1. JWT (JSON Web Tokens) with refresh tokens
2. Server-side sessions (stored in Redis)
3. OAuth 2.0 + OpenID Connect (third-party provider)

## Decision Outcome

Chosen option: **"JWT with refresh tokens"**, because nó stateless (phù hợp microservices), hoạt động cross-platform, và team có thể self-host toàn bộ auth infrastructure.

Implementation details:
- Access token: JWT, expires in 15 minutes
- Refresh token: opaque token, stored in database, expires in 7 days
- Signing algorithm: RS256 (asymmetric — services chỉ cần public key để verify)
- Token storage: httpOnly cookie (web), secure storage (mobile)

### Positive Consequences

- Stateless — mỗi service tự verify token mà không cần call auth service
- Cross-platform — JWT hoạt động trên web, mobile, API
- Decoupled — services không phụ thuộc vào centralized session store
- Standard — JWT là industry standard, nhiều libraries hỗ trợ

### Negative Consequences

- Token revocation khó — cần implement blacklist hoặc short expiry
- Token size lớn hơn session ID
- Cần implement refresh token rotation để giảm rủi ro
- Key management — cần rotate signing keys định kỳ

## Pros and Cons of the Options

### JWT with refresh tokens

- Good, because stateless, phù hợp microservices architecture
- Good, because cross-platform (web, mobile, API)
- Good, because self-contained — chứa user info, không cần DB lookup
- Good, because industry standard (RFC 7519)
- Bad, because token revocation phức tạp
- Bad, because payload không nên chứa sensitive data
- Bad, because cần cẩn thận với signing key management

### Server-side sessions (Redis)

- Good, because dễ revoke — xóa session khỏi Redis
- Good, because session ID nhỏ gọn
- Good, because familiar pattern cho team
- Bad, because stateful — cần shared Redis cho mọi services
- Bad, because Redis trở thành single point of failure
- Bad, because không phù hợp cho mobile apps và third-party API

### OAuth 2.0 + OpenID Connect (Auth0/Keycloak)

- Good, because mature, battle-tested
- Good, because supports social login (Google, Facebook)
- Good, because compliance features built-in
- Bad, because vendor lock-in (Auth0) hoặc operational overhead (Keycloak)
- Bad, because cost cao cho Auth0 ở quy mô lớn
- Bad, because thêm external dependency
- Bad, because latency tăng khi verify token với provider

## Links

- [JWT RFC 7519](https://datatracker.ietf.org/doc/html/rfc7519)
- [OWASP JWT Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/JSON_Web_Token_for_Java_Cheat_Sheet.html)
- Relates to ADR-003: Database Selection (refresh tokens stored in PostgreSQL)
```

#### ADR-005: Caching Solution

Tạo file `docs/adr/0005-use-redis-for-caching.md`:

```markdown
# 5. Use Redis for Caching

## Status

Accepted

## Date

2026-03-19

## Context and Problem Statement

E-commerce platform cần caching layer để:
- Giảm load cho PostgreSQL (product catalog queries chiếm 70% traffic)
- Tăng response time cho frequently accessed data
- Cache session-related data (shopping cart, user preferences)
- Rate limiting cho API

Câu hỏi: Chúng ta nên sử dụng caching solution nào?

## Decision Drivers

- **Performance**: Sub-millisecond latency cho cached data
- **Data structures**: Cần hỗ trợ nhiều loại data (strings, lists, sets, hashes)
- **Persistence**: Cần optional persistence cho shopping cart data
- **Cluster support**: Horizontal scaling khi traffic tăng
- **Maturity**: Proven solution, large community

## Considered Options

1. Redis 7
2. Memcached
3. Application-level caching (in-memory, per-instance)

## Decision Outcome

Chosen option: **"Redis 7"**, because nó cung cấp rich data structures, optional persistence, cluster support, và mature ecosystem. Redis phù hợp cho cả caching, rate limiting, và session storage.

### Positive Consequences

- Sub-millisecond latency cho cached queries
- Rich data structures: shopping cart (hash), leaderboard (sorted set), rate limiting (string + expiry)
- Redis Cluster cho horizontal scaling
- Pub/Sub cho real-time notifications
- Optional persistence (RDB + AOF) cho shopping cart data

### Negative Consequences

- Thêm infrastructure component cần quản lý
- Memory cost — Redis lưu data trong RAM
- Cache invalidation complexity — cần strategy rõ ràng
- Thundering herd khi cache expires cho popular items

## Pros and Cons of the Options

### Redis 7

- Good, because rich data structures (strings, lists, sets, sorted sets, hashes, streams)
- Good, because optional persistence (RDB snapshots, AOF)
- Good, because Redis Cluster cho horizontal scaling
- Good, because Pub/Sub, Streams cho real-time features
- Good, because Lua scripting cho atomic operations
- Bad, because single-threaded event loop (mitigated bởi io-threads trong Redis 7)
- Bad, because memory-bound — cost cao cho large datasets

### Memcached

- Good, because đơn giản, dễ setup
- Good, because multi-threaded — better CPU utilization
- Good, because memory efficient cho simple key-value
- Bad, because chỉ hỗ trợ string values
- Bad, because không có persistence
- Bad, because không có Pub/Sub hay advanced data structures
- Bad, because không phù hợp cho shopping cart (cần hash structure)

### Application-level caching

- Good, because không cần external dependency
- Good, because fastest latency (in-process)
- Good, because đơn giản nhất
- Bad, because không shared giữa instances — cache inconsistency
- Bad, because memory per instance tăng
- Bad, because cache warm-up khi deploy mới
- Bad, because không phù hợp cho distributed system

## Links

- [Redis Documentation](https://redis.io/docs/)
- Relates to ADR-003: Database Selection (caching layer for PostgreSQL)
- Relates to ADR-004: Authentication (rate limiting via Redis)
```

---

### Lab 3: ADR Lifecycle — Supersede, Deprecate, Link (25 phút)

**Mục tiêu:** Thực hành quản lý lifecycle của ADR — supersede một ADR cũ, deprecate một ADR, và tạo links giữa các ADR.

#### Bước 1: Supersede một ADR

Giả sử sau 6 tháng, team quyết định chuyển từ JWT sang OAuth 2.0 + Keycloak vì yêu cầu compliance mới. Ta cần:

1. Tạo ADR mới:

```bash
adr new -s 4 "Use Keycloak for authentication and authorization"
# -s 4 nghĩa là supersede ADR số 4
# Output: docs/adr/0006-use-keycloak-for-authentication-and-authorization.md
```

2. adr-tools tự động cập nhật status của ADR-004:

```markdown
## Status

Superseded by [6. Use Keycloak for authentication and authorization](0006-use-keycloak-for-authentication-and-authorization.md)
```

3. Viết nội dung ADR-006:

```markdown
# 6. Use Keycloak for Authentication and Authorization

## Status

Accepted

## Date

2026-09-19

## Context and Problem Statement

Sau 6 tháng vận hành với JWT authentication (ADR-004), chúng ta gặp các vấn đề:
- Token revocation phức tạp — đã xảy ra 2 security incidents
- Compliance team yêu cầu centralized audit logging cho authentication events
- Cần Social Login (Google, Apple) cho mobile app
- RBAC (Role-Based Access Control) trở nên phức tạp với custom JWT claims

Cần reevaluate authentication strategy.

## Decision Outcome

Chosen option: **"Keycloak"**, self-hosted OpenID Connect provider.

Supersedes [ADR-004: Use JWT for Authentication](0004-use-jwt-for-authentication.md).

### Positive Consequences

- Centralized authentication — một nơi quản lý users, roles, permissions
- Built-in audit logging cho compliance
- Social Login support (Google, Apple, Facebook)
- Token revocation đơn giản (revoke tại Keycloak)
- RBAC/ABAC built-in

### Negative Consequences

- Thêm infrastructure component (Keycloak server, database riêng)
- Migration effort từ custom JWT sang Keycloak (estimated 3 sprints)
- Keycloak trở thành single point of failure — cần HA setup
- Learning curve cho team
```

#### Bước 2: Deprecate một ADR

Giả sử một microservice bị xóa, ADR liên quan cần deprecated:

```bash
# Mở ADR cần deprecate và cập nhật status
# Ví dụ: ADR cho notification service bị remove
```

Trong file ADR, cập nhật status:

```markdown
## Status

Deprecated

## Deprecation Note

Service notification đã bị xóa khỏi hệ thống vào 2026-08-01.
Chức năng notification được tích hợp vào User Service.
ADR này được giữ lại cho historical reference.
```

#### Bước 3: Link các ADR với nhau

Sử dụng `adr link` command:

```bash
# Link ADR-005 (Redis caching) liên quan đến ADR-003 (PostgreSQL)
adr link 5 "Complements" 3 "Is complemented by"

# Link ADR-006 (Keycloak) supersedes ADR-004 (JWT)
# Đã tự động khi dùng -s flag
```

Kiểm tra graph:

```bash
# Generate dependency graph
adr generate graph | dot -Tpng -o docs/adr/adr-graph.png

# Generate Table of Contents
adr generate toc > docs/adr/README.md
cat docs/adr/README.md
```

---

### Lab 4: ADR Review Process (25 phút)

**Mục tiêu:** Thực hành quy trình review ADR qua Pull Request, team discussion, và decision meeting.

#### Bước 1: PR-based ADR Review

Tạo branch và ADR mới:

```bash
# Tạo branch cho ADR proposal
git checkout -b adr/007-message-queue-selection

# Tạo ADR mới với status Proposed
adr new "Use RabbitMQ as message broker"
```

Viết ADR-007 với status **Proposed**:

```markdown
# 7. Use RabbitMQ as Message Broker

## Status

Proposed

## Date

2026-03-19

## Context and Problem Statement

Microservices cần communicate asynchronously cho:
- Order processing pipeline (Order → Payment → Inventory → Shipping)
- Event notification (price changes, stock alerts)
- Background job processing (email, report generation)

Cần chọn message broker phù hợp.

## Decision Drivers

- **Reliability**: Messages không được mất (order processing)
- **Routing flexibility**: Cần topic-based và direct routing
- **Operational simplicity**: Team chưa có kinh nghiệm message brokers
- **Throughput**: ~10K messages/second peak
- **Monitoring**: Cần visibility vào queue depth, consumer lag

## Considered Options

1. RabbitMQ
2. Apache Kafka
3. Amazon SQS + SNS

## Decision Outcome

Chosen option: **"RabbitMQ"**, because nó cung cấp flexible routing, message acknowledgment, đủ throughput cho use case hiện tại, và dễ vận hành hơn Kafka.

## Pros and Cons of the Options

### RabbitMQ

- Good, because flexible routing (direct, topic, fanout, headers)
- Good, because message acknowledgment và dead letter queues
- Good, because management UI built-in
- Good, because đủ throughput cho 10K msg/s
- Good, because lightweight, dễ deploy
- Bad, because không phù hợp cho event streaming / replay
- Bad, because throughput thấp hơn Kafka ở scale lớn

### Apache Kafka

- Good, because throughput cực cao (millions msg/s)
- Good, because event replay — consumers có thể đọc lại messages
- Good, because durable log — lưu trữ lâu dài
- Bad, because operational complexity cao (ZooKeeper/KRaft)
- Bad, because overkill cho ~10K msg/s
- Bad, because learning curve lớn cho team
- Bad, because consumer group management phức tạp

### Amazon SQS + SNS

- Good, because fully managed, zero ops
- Good, because auto-scaling built-in
- Good, because pay-per-use
- Bad, because vendor lock-in (AWS)
- Bad, because limited routing flexibility
- Bad, because latency cao hơn self-hosted solutions
- Bad, because cost khó predict ở scale lớn

## Links

- [RabbitMQ Documentation](https://www.rabbitmq.com/docs)
- Relates to ADR-003: Database Selection
```

#### Bước 2: Tạo Pull Request

```bash
git add docs/adr/0007-use-rabbitmq-as-message-broker.md
git commit -m "docs(adr): propose RabbitMQ as message broker [ADR-007]"
git push origin adr/007-message-queue-selection
```

PR Description template:

```markdown
## ADR Proposal: Use RabbitMQ as Message Broker

**ADR Number:** 007
**Status:** Proposed
**Author:** [Your Name]

### Summary
Đề xuất sử dụng RabbitMQ làm message broker cho async communication giữa microservices.

### Review Checklist
- [ ] Context đầy đủ và rõ ràng
- [ ] Tất cả viable options đã được xem xét
- [ ] Pros/cons balanced và honest
- [ ] Decision reasoning rõ ràng
- [ ] Consequences bao gồm cả negative impacts
- [ ] Related ADRs đã được link
- [ ] Date và status chính xác

### Questions for Reviewers
1. Có option nào khác chưa xem xét?
2. Throughput 10K msg/s có chính xác không?
3. Team có concerns gì về operational complexity?

### Decision Meeting
- **Date:** [Scheduled date]
- **Attendees:** Tech Lead, Backend Team, DevOps
- **Duration:** 30 minutes
```

#### Bước 3: Decision Meeting Simulation

Sau khi review, team meeting để quyết định:

```
Agenda:
1. Author trình bày ADR (5 phút)
2. Q&A và discussion (15 phút)
3. Vote hoặc consensus (5 phút)
4. Action items (5 phút)

Possible outcomes:
a) Accepted → Update status, merge PR
b) Rejected → Close PR, ghi lại lý do
c) Needs revision → Request changes trên PR
d) Deferred → Giữ Proposed, schedule follow-up
```

Sau khi team chấp nhận:

```bash
# Update status trong file ADR
# Status: Proposed → Accepted

# Merge PR
git checkout main
git merge adr/007-message-queue-selection
```

---

## 6. Self-Assessment (30 câu)

### Cơ bản (1-10)

**1. ADR là viết tắt của gì?**

> **Đáp án:** Architecture Decision Record — tài liệu ghi lại một quyết định kiến trúc phần mềm cùng với context và consequences.

**2. Ai là người đề xuất ADR?**

> **Đáp án:** Michael Nygard, trong bài blog *"Documenting Architecture Decisions"* năm 2011.

**3. Một ADR theo Nygard format gồm những phần nào?**

> **Đáp án:** 5 phần: Title, Status, Context, Decision, Consequences.

**4. Liệt kê 4 trạng thái trong ADR lifecycle.**

> **Đáp án:** Proposed → Accepted → Deprecated / Superseded.

**5. MADR là viết tắt của gì? Nó khác Nygard format như thế nào?**

> **Đáp án:** Markdown Any Decision Records. MADR mở rộng Nygard format bằng cách thêm Decision Drivers, Considered Options (với pros/cons chi tiết cho từng option), và Links. MADR structured hơn và phù hợp cho complex decisions.

**6. Khi nào nên viết ADR?**

> **Đáp án:** Khi đưa ra quyết định kiến trúc quan trọng và khó đảo ngược: chọn technology stack, architecture pattern, API strategy, authentication method, deployment strategy, hoặc bất kỳ quyết định nào ảnh hưởng nhiều team/components.

**7. Khi nào KHÔNG cần viết ADR?**

> **Đáp án:** Bug fixes, minor refactoring, UI tweaks, dependency version updates nhỏ, quyết định chỉ ảnh hưởng trong một function/module nhỏ — tức là những thay đổi dễ đảo ngược và phạm vi hẹp.

**8. Tại sao ADR nên là immutable sau khi Accepted?**

> **Đáp án:** Vì ADR ghi lại decision tại một thời điểm cụ thể với context cụ thể. Nếu sửa nội dung, ta mất historical record — không biết decision ban đầu là gì. Nếu cần thay đổi, tạo ADR mới và supersede ADR cũ.

**9. "Context" section trong ADR nên chứa thông tin gì?**

> **Đáp án:** Mô tả tình huống hiện tại, vấn đề cần giải quyết, các ràng buộc (constraints), requirements, và forces/drivers dẫn đến việc cần đưa ra quyết định. Phải viết đủ chi tiết để người đọc trong tương lai hiểu "tại sao cần quyết định này".

**10. "Consequences" section cần ghi những gì?**

> **Đáp án:** Cả positive consequences (điều tốt hơn sau quyết định) và negative consequences (trade-offs, rủi ro, chi phí). Transparency về negative consequences giúp team hiểu trade-offs và chuẩn bị mitigation plans.

### Trung bình (11-20)

**11. adr-tools là gì? Liệt kê 4 lệnh chính.**

> **Đáp án:** adr-tools là command-line tool do Nat Pryce phát triển để quản lý ADR. 4 lệnh chính: `adr init` (khởi tạo), `adr new` (tạo ADR mới), `adr list` (liệt kê), `adr link` (tạo liên kết), ngoài ra còn `adr generate toc` và `adr generate graph`.

**12. So sánh ADR và RFC. Khi nào dùng ADR, khi nào dùng RFC?**

> **Đáp án:** ADR ghi lại một quyết định cụ thể (1-2 trang), dùng cho architectural decisions. RFC là đề xuất thay đổi lớn (5-20+ trang), thu thập feedback từ nhiều team, dùng cho major cross-team changes. ADR immutable sau khi accepted, RFC có thể revise. Một RFC có thể dẫn đến nhiều ADR.

**13. Y-statement format là gì? Cho ví dụ.**

> **Đáp án:** Y-statement là format cô đọng viết decision trong một câu: "In the context of [use case], facing [concern], we decided for [option] and neglected [other options], to achieve [quality goals], accepting [downside]." Ví dụ: "In the context of API design, facing the need for mobile-friendly data fetching, we decided for GraphQL and neglected REST, to achieve flexible queries and reduced over-fetching, accepting added backend complexity."

**14. "Decision Drivers" là gì? Tại sao cần liệt kê?**

> **Đáp án:** Decision Drivers là các yếu tố quan trọng ảnh hưởng đến quyết định (performance, cost, team skills, security, compliance...). Cần liệt kê để người đọc hiểu criteria đánh giá các options và tại sao option được chọn phù hợp nhất với các drivers đó.

**15. Giải thích sự khác nhau giữa Deprecated và Superseded.**

> **Đáp án:** Deprecated: quyết định không còn relevant vì context đã thay đổi (ví dụ: service bị xóa, feature bị loại bỏ). Superseded: quyết định bị thay thế bởi quyết định mới — có ADR mới thay thế, link rõ ràng "Superseded by ADR-XXX".

**16. Tại sao nên lưu ADR trong Git cùng với source code?**

> **Đáp án:** 5 lý do: (1) Version history tự nhiên — biết ai viết/sửa khi nào, (2) Code review qua Pull Request, (3) ADR luôn đi cùng code — không bị lạc, (4) Branch-based workflow cho ADR proposals, (5) CI/CD có thể validate format. ADR trong Confluence/Wiki dễ bị outdated và disconnected từ code.

**17. ADR naming convention chuẩn là gì?**

> **Đáp án:** `NNNN-title-in-kebab-case.md` — ví dụ: `0001-record-architecture-decisions.md`, `0002-use-postgresql-as-database.md`. Số thứ tự tăng dần (4 chữ số, padded zeros), title viết thường, dùng dấu gạch ngang. Giúp sắp xếp chronological tự nhiên.

**18. ADR review process nên diễn ra như thế nào?**

> **Đáp án:** (1) Author viết ADR với status Proposed, (2) Tạo PR/MR, (3) Reviewers (ít nhất 2 người, bao gồm senior/architect) review context, options, decision reasoning, (4) Discussion trên PR hoặc meeting, (5) Đạt consensus hoặc vote, (6) Update status thành Accepted, merge PR. Có thể kết hợp Architecture Review Board cho decisions lớn.

**19. Liệt kê 5 anti-patterns khi viết ADR.**

> **Đáp án:** (1) Viết ADR sau khi implement xong (retroactive) — mất giá trị discussion, (2) ADR quá dài/chi tiết — không ai đọc, (3) Chỉ ghi positive consequences — thiếu transparency, (4) Không liệt kê alternatives đã xem xét — dẫn đến rediscussion, (5) Không cập nhật status — ADR outdated gây confusion.

**20. Làm thế nào link related ADRs? Cho ví dụ.**

> **Đáp án:** Dùng section "Links" hoặc "Related Decisions" ở cuối ADR: `Supersedes: [ADR-004](0004-use-jwt.md)`, `Relates to: [ADR-003](0003-use-postgresql.md)`, `Superseded by: [ADR-006](0006-use-keycloak.md)`. Với adr-tools: `adr link 5 "Complements" 3 "Is complemented by"`.

### Nâng cao (21-30)

**21. ADR áp dụng trong microservices như thế nào?**

> **Đáp án:** Trong microservices, ADR cần ở 2 level: (1) **Platform-level ADR** — quyết định áp dụng cho toàn bộ platform (API gateway, service mesh, observability), lưu trong platform/shared repo; (2) **Service-level ADR** — quyết định riêng cho từng service (database, library), lưu trong repo của service đó. Cross-cutting decisions cần review bởi Architecture Review Board.

**22. ADR governance là gì?**

> **Đáp án:** ADR governance là quy trình và chính sách quản lý ADR trong tổ chức: ai có quyền propose/approve ADR, review process, escalation path cho disagreements, compliance requirements, periodic review schedule, và archival policy. Thường do Architecture Review Board (ARB) hoặc Tech Lead group quản lý.

**23. Làm thế nào tích hợp ADR vào CI/CD pipeline?**

> **Đáp án:** (1) Lint ADR format trong CI — kiểm tra required sections, naming convention, (2) Auto-generate ADR index/Table of Contents khi merge, (3) Check broken links giữa ADR, (4) Generate static site từ ADR (dùng Log4brains hoặc custom script), (5) Block merge nếu ADR missing required fields. Ví dụ: dùng `adr-log` package hoặc custom GitHub Action.

**24. Living documentation với ADR — giải thích concept.**

> **Đáp án:** Living documentation nghĩa là documentation tự cập nhật và luôn phản ánh trạng thái hiện tại. Với ADR: (1) ADR được version control cùng code trong Git, (2) Status được cập nhật khi có thay đổi, (3) Deprecated/Superseded ADR vẫn giữ lại cho historical reference, (4) Auto-generated index/graph hiển thị current state, (5) ADR review schedule định kỳ để đảm bảo accuracy.

**25. Giải thích ADR metrics: Decision Velocity, Superseded Rate, Coverage.**

> **Đáp án:** **Decision Velocity**: số ADR mới tạo / thời gian — cho biết team có document decisions hay không. **Superseded Rate**: % ADR bị superseded / tổng ADR — rate cao có thể cho thấy decisions không stable hoặc context thay đổi nhanh. **Coverage**: % significant decisions có ADR — target 100% cho architectural decisions. Metrics giúp đánh giá effectiveness của ADR practice.

**26. Khi nào nên viết Retrospective ADR (ADR cho quyết định đã thực hiện)?**

> **Đáp án:** Khi adopt ADR practice cho project đang chạy — cần document existing decisions để: (1) Capture tribal knowledge trước khi team members rời đi, (2) Tạo baseline cho future decisions, (3) Giúp new members hiểu system. Retrospective ADR ghi rõ "This is a retrospective ADR" và "Decision was made on [past date]". Ưu tiên viết cho decisions quan trọng nhất trước.

**27. ADR cho cross-team decisions khác gì single-team decisions?**

> **Đáp án:** Cross-team ADR cần: (1) Reviewers từ tất cả affected teams, (2) Broader context — explain impact lên từng team, (3) Phải review bởi Architecture Review Board, (4) Longer discussion period, (5) Lưu trong shared/platform repository thay vì service repo, (6) Communication plan — announce decision tới toàn bộ org. Thường kết hợp với RFC cho proposals lớn.

**28. So sánh tools: adr-tools, Log4brains, ADR Manager.**

> **Đáp án:** **adr-tools**: CLI đơn giản, tạo/quản lý ADR files, generate TOC và graph, lightweight, no dependencies. **Log4brains**: modern tool, generate static website từ ADR, preview changes, Git integration, hỗ trợ multiple packages. **ADR Manager**: GUI-based, GitHub integration, search và filter ADR, phù hợp cho non-technical stakeholders. Khuyến nghị: bắt đầu với adr-tools, upgrade lên Log4brains khi cần web UI.

**29. Làm thế nào handle disagreements khi review ADR?**

> **Đáp án:** (1) Đảm bảo tất cả options đã được explore đầy đủ, (2) Sử dụng Decision Matrix với weighted criteria để objectify, (3) Nếu không consensus — escalate lên Tech Lead hoặc Architecture Review Board, (4) Timeboxed discussion — set deadline cho decision, (5) "Disagree and commit" — ghi lại dissenting opinions trong ADR nhưng team thống nhất follow decision, (6) ADR có thể schedule review sau 3-6 tháng.

**30. ADR trong compliance-regulated environments (HIPAA, PCI-DSS, SOC2)?**

> **Đáp án:** ADR đặc biệt valuable trong regulated environments: (1) Audit trail — Git history chứng minh decisions được review và approved, (2) Compliance mapping — mỗi ADR ghi rõ compliance requirements nào được đáp ứng, (3) Risk assessment — consequences section ghi rõ security risks và mitigations, (4) Approved reviewers — required approvals từ compliance officer, (5) Retention policy — ADR không được xóa, chỉ deprecate/supersede. ADR trở thành evidence cho auditors.

---

## 7. Extend Labs (10 bài)

### EL1: Complete ADR Repository

```
Mục tiêu: Xây dựng hệ thống ADR hoàn chỉnh cho một dự án e-commerce
Yêu cầu:
- Viết 10+ ADR bao gồm: database, framework, auth, caching, messaging,
 deployment, monitoring, API design, testing strategy, CI/CD
- Tạo linking relationships (supersedes, relates to, complements)
- Generate ADR graph (dùng adr generate graph)
- Generate Table of Contents tự động
- Commit history rõ ràng cho từng ADR
Deliverable: Git repository với docs/adr/ chứa 10+ ADR files
Độ khó: ***
```

### EL2: ADR với Decision Matrix

```
Mục tiêu: Kết hợp ADR với Decision Matrix cho lựa chọn có trọng số
Yêu cầu:
- Chọn 1 quyết định phức tạp (ví dụ: cloud provider selection)
- Tạo Decision Matrix với 5+ criteria, mỗi criteria có weight (1-5)
- Score mỗi option theo từng criteria (1-10)
- Tính weighted score, chọn option có score cao nhất
- Viết ADR reference Decision Matrix trong reasoning
Deliverable: ADR file + Decision Matrix (markdown table)
Độ khó: ***
```

### EL3: Retrospective ADRs

```
Mục tiêu: Viết ADR cho quyết định đã tồn tại (capture tribal knowledge)
Yêu cầu:
- Chọn 1 open-source project lớn (ví dụ: Next.js, Kubernetes)
- Nghiên cứu 3 quyết định kiến trúc quan trọng của project đó
- Viết 3 Retrospective ADRs (ghi rõ "Retrospective ADR")
- Include actual context từ blog posts, GitHub issues, RFCs
Deliverable: 3 ADR files với references tới sources
Độ khó: ***
```

### EL4: Log4brains Setup

```
Mục tiêu: Setup Log4brains để generate static website từ ADR
Yêu cầu:
- npm install log4brains
- Init log4brains trong project
- Viết 5 ADR bằng Log4brains CLI
- Generate static website
- Deploy lên GitHub Pages hoặc Netlify
- Preview ADR changes locally
Deliverable: Log4brains website URL + screenshots
Độ khó: ***
```

### EL5: ADR CI/CD Integration

```
Mục tiêu: Tích hợp ADR validation vào CI/CD pipeline
Yêu cầu:
- Viết script validate ADR format (check required sections)
- Tạo GitHub Action kiểm tra ADR format khi có PR
- Auto-generate Table of Contents khi merge
- Check broken links giữa ADR
- Thêm ADR template vào .github/PULL_REQUEST_TEMPLATE/
Deliverable: GitHub Action workflow file + validation script
Độ khó: ****
```

### EL6: ADR Review Simulation

```
Mục tiêu: Simulate full ADR review process với team (3+ người)
Yêu cầu:
- Assign roles: Author, Reviewer 1, Reviewer 2, Tech Lead
- Author propose ADR qua Pull Request
- Reviewers comment, đặt câu hỏi, suggest changes
- Tổ chức 15-phút decision meeting
- Ghi meeting notes vào PR
- Update ADR status, merge hoặc close PR
Deliverable: PR với comments, meeting notes, final ADR
Độ khó: ***
```

### EL7: Cross-Team ADR Governance

```
Mục tiêu: Thiết kế ADR governance process cho organization
Yêu cầu:
- Định nghĩa ADR categories (team-level, platform-level, org-level)
- Viết governance document: who can propose, review, approve
- Thiết kế escalation path cho disagreements
- Tạo ADR template cho mỗi category
- Định nghĩa review SLA (ví dụ: team-level < 3 days, platform < 1 week)
Deliverable: ADR Governance Document (markdown)
Độ khó: ****
```

### EL8: Architecture Pattern Decisions

```
Mục tiêu: Viết ADR cho các quyết định architecture pattern
Yêu cầu:
- ADR 1: Monolith vs Microservices vs Modular Monolith
- ADR 2: Synchronous vs Asynchronous communication
- ADR 3: Event-Driven Architecture vs Request/Response
- ADR 4: CQRS vs Traditional CRUD
- Mỗi ADR phải include architecture diagram (text-based)
Deliverable: 4 ADR files với diagrams
Độ khó: ****
```

### EL9: ADR Metrics Dashboard

```
Mục tiêu: Xây dựng dashboard tracking ADR metrics
Yêu cầu:
- Viết script parse tất cả ADR files để extract metadata
- Track metrics: total ADRs, by status, by author, by date
- Tính Decision Velocity (ADR/month)
- Tính Superseded Rate
- Visualize bằng chart (dùng Chart.js hoặc Mermaid)
- Output HTML report
Deliverable: Script + sample HTML report
Độ khó: ****
```

### EL10: ADR Compliance Mapping

```
Mục tiêu: Map ADR với compliance requirements
Yêu cầu:
- Chọn compliance framework (SOC2, HIPAA, hoặc PCI-DSS)
- Viết 3 ADR cho security-related decisions
- Mỗi ADR include "Compliance" section mapping tới specific controls
- Tạo traceability matrix: ADR Compliance Control
- Viết audit preparation document reference ADRs
Deliverable: 3 ADR files + Traceability Matrix + Audit prep doc
Độ khó: *****
```

---

## 8. Deliverables Checklist

| # | Deliverable | Yêu cầu | Check |
|---|------------|---------|-------|
| 1 | ADR directory structure | `docs/adr/` được khởi tạo bằng `adr init`, có ADR-0001 mặc định | [ ] |
| 2 | ADR-0002: Frontend Framework | ADR chọn framework, theo Nygard format, status Accepted | [ ] |
| 3 | ADR-0003: Database Selection | ADR theo MADR format đầy đủ, ≥3 options, pros/cons chi tiết | [ ] |
| 4 | ADR-0004: Authentication Strategy | ADR theo MADR format, bao gồm implementation details | [ ] |
| 5 | ADR-0005: Caching Solution | ADR theo MADR format, link tới ADR-0003 | [ ] |
| 6 | ADR-0006: Supersede ADR-0004 | ADR mới supersede ADR-0004, ADR-0004 status updated | [ ] |
| 7 | ADR-0007: Message Broker (Proposed) | ADR với status Proposed, sẵn sàng cho PR review | [ ] |
| 8 | ADR Graph | Generate graph từ `adr generate graph`, lưu dưới dạng image | [ ] |
| 9 | ADR Table of Contents | `docs/adr/README.md` auto-generated bằng `adr generate toc` | [ ] |
| 10 | Git history | Tất cả ADR được commit với meaningful commit messages | [ ] |

---

## 9. Lỗi Thường Gặp

| # | Lỗi | Mô tả | Cách sửa |
|---|-----|-------|----------|
| 1 | Viết ADR sau khi implement | ADR viết retroactively, mất giá trị thảo luận và review | Viết ADR **trước** hoặc **trong khi** đưa ra quyết định, không phải sau khi code xong |
| 2 | ADR quá dài, quá chi tiết | 5-10 trang, đọc mất 30 phút, không ai muốn đọc | Giữ 1-2 trang. Nếu cần detail, link tới tài liệu riêng. Tập trung context → decision → consequences |
| 3 | Chỉ liệt kê positive consequences | Không ghi trade-offs và risks, thiếu transparency | Luôn ghi **cả** positive và negative consequences. Negative consequences giúp team chuẩn bị mitigation |
| 4 | Không liệt kê alternatives | Chỉ ghi option được chọn, không ghi options đã xem xét | Liệt kê ≥2 alternatives với pros/cons. Tránh ai đó đề xuất lại option đã bị loại |
| 5 | Sửa ADR đã Accepted | Thay đổi nội dung ADR cũ thay vì tạo mới | Không bao giờ sửa nội dung ADR đã Accepted. Tạo ADR mới và supersede ADR cũ |
| 6 | Không cập nhật status | ADR cũ vẫn "Accepted" dù đã bị thay thế | Khi supersede hoặc deprecate, cập nhật status ADR cũ ngay lập tức. Dùng `adr link` để tự động hóa |
| 7 | Context quá vague | "We need a database" — không giải thích requirements, constraints | Viết context đủ chi tiết: requirements cụ thể, constraints, team skills, timeline, budget |
| 8 | ADR lưu ngoài Git | Lưu trong Confluence, Google Docs — bị disconnect khỏi code | Lưu ADR trong `docs/adr/` cùng repository. ADR là code documentation, phải đi cùng code |
| 9 | Không review ADR | Author tự viết, tự approve, không qua review | ADR cần ≥2 reviewers (bao gồm senior/architect). Dùng PR-based workflow |
| 10 | Naming convention không nhất quán | File names lộn xộn: `db.md`, `ADR_auth.md`, `003.md` | Dùng format chuẩn: `NNNN-title-in-kebab-case.md`. Dùng adr-tools để tự động generate |

---

## 10. Rubric (100 điểm)

| Tiêu chí | Xuất sắc (100%) | Tốt (75%) | Đạt (50%) | Chưa đạt (<50%) | Điểm |
|----------|----------------|-----------|-----------|-----------------|------|
| **ADR Setup & Tooling** (10đ) | adr-tools installed, init đúng, adr list/toc/graph hoạt động | Init đúng, dùng được basic commands | Tạo thư mục manual, không dùng adr-tools | Không setup được | /10 |
| **ADR Format & Structure** (20đ) | Tất cả ADR theo MADR format đầy đủ, consistent naming convention | Đa số ADR đúng format, 1-2 thiếu sections | Format không nhất quán, thiếu nhiều sections | Không theo format nào | /20 |
| **Context & Problem Statement** (15đ) | Context rõ ràng, đủ chi tiết, người đọc tương lai hiểu được | Context hợp lý nhưng thiếu 1-2 details quan trọng | Context quá vague hoặc quá dài | Không có context | /15 |
| **Options Analysis** (15đ) | ≥3 options, pros/cons balanced, honest, có evidence | 2-3 options, pros/cons reasonable | 1-2 options, pros/cons thiên lệch | Không liệt kê alternatives | /15 |
| **Decision Reasoning** (15đ) | Decision rõ ràng, reasoning logic, link tới decision drivers | Decision rõ nhưng reasoning chưa đủ mạnh | Decision có nhưng reasoning yếu | Không giải thích lý do | /15 |
| **Consequences** (10đ) | Cả positive và negative, realistic, có mitigation cho risks | Có cả 2 loại nhưng chưa đủ chi tiết | Chỉ có positive consequences | Không có consequences | /10 |
| **ADR Lifecycle** (10đ) | Supersede và deprecate đúng, links chính xác, status updated | Có supersede nhưng link chưa hoàn chỉnh | Có thay đổi status nhưng không link | Không thực hành lifecycle | /10 |
| **Git & Review Process** (5đ) | PR-based review, meaningful commits, review checklist used | Commits hợp lý, có review cơ bản | Chỉ commit không review | Không dùng Git | /5 |
| **Tổng** | | | | | **/100** |

**Thang điểm:**
- 90-100: Xuất sắc — ADR chất lượng production-ready
- 75-89: Tốt — ADR đầy đủ, cần polish minor
- 50-74: Đạt — Hiểu concept nhưng cần cải thiện chất lượng
- <50: Chưa đạt — Cần làm lại

---

## Tài liệu Tham khảo

1. Michael Nygard — [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
2. MADR — [Markdown Any Decision Records](https://adr.github.io/madr/)
3. ADR Tools — [github.com/npryce/adr-tools](https://github.com/npryce/adr-tools)
4. Log4brains — [github.com/thomvaill/log4brains](https://github.com/thomvaill/log4brains)
5. Joel Parker Henderson — [Architecture Decision Record collection](https://github.com/joelparkerhenderson/architecture-decision-record)
6. ThoughtWorks Technology Radar — ADR as "Adopt"

---

## Tiếp theo

Chuyển đến: [Lab 3.4: arc42 Documentation](../lab-3.4-arc42/)
