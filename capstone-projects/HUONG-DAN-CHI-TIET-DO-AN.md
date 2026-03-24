# Hướng dẫn chi tiết làm đồ án lớn — Kiến trúc phần mềm

Tài liệu này **bổ sung** cho file đề chính thức `practices/Software Architecture - Capstone projects.md` (mở file đó song song khi làm). Sinh viên vẫn phải tuân thủ đầy đủ yêu cầu, rubric và deadline trong đề gốc.

---

## 0. Trước khi bắt đầu (Tuần 0 — chuẩn bị nhanh)

### 0.1 Đọc và ghi nhớ

- [ ] Đọc hết đề: mục I → IX (điểm, timeline, rubric, lưu ý đạo văn/commit/tuần).
- [ ] Xác định **1 đề tài** (A1–E3) hoặc **F1** (tự đề xuất — cần GV duyệt tuần 1).
- [ ] Thống nhất **stack** (ngôn ngữ, DB, frontend) — ghi vào README sau khi tạo repo.

### 0.2 Công cụ cần có trên máy mỗi thành viên

- Git, tài khoản GitHub.
- Docker Desktop (chạy được `docker compose`).
- IDE + extension định dạng code (Prettier/ESLint hoặc tương đương).
- Postman/Insomnia hoặc Thunder Client (gọi thử API).

### 0.3 Phân vai trong nhóm 3–4 người (gợi ý)

| Vai trò | Trách nhiệm chính |
|---------|-------------------|
| **Nhóm trưởng** | Repo, nhánh, báo cáo tuần, nhắc deadline, liên hệ GV |
| **Backend** | API, DB, migration, RabbitMQ consumer/producer, test API |
| **Frontend** | UI, gọi API, xử lý lỗi/loading, demo mượt |
| **DevOps/Tích hợp** | Docker Compose, CI/CD, Swagger export, docs/architecture |

*Có thể xoay vai; quan trọng là mỗi tuần mỗi người có commit.*

---

## 1. Tuần 1 — Lập nhóm, đề tài, khởi tạo repo

### 1.1 Deliverable theo đề gốc

- Danh sách nhóm + MSSV + đề tài đã chọn (không trùng lớp).
- Nếu **F1**: nộp bản đề xuất 1–2 trang (mô tả, ≥6 chức năng, ≥3 actors, kiến trúc dự kiến) và chờ phê duyệt.

### 1.2 Việc làm cụ thể

1. Tạo **organization/repo** GitHub (hoặc repo nhóm trưởng + thêm collaborator).
2. Khởi tạo cấu trúc thư mục theo đề (có thể rỗng ban đầu):

   ```
   project-name/
   ├── README.md
   ├── docker-compose.yml          # tuần sau có thể chỉ là stub
   ├── .github/workflows/ci.yml
   ├── docs/architecture/
   ├── docs/adrs/
   ├── docs/api/
   ├── weekly-reports/
   ├── backend/
   ├── frontend/
   └── database/migrations/        # hoặc ORM migrations trong backend
   ```

3. Viết `README.md` theo mẫu trong đề; tạm thời ghi “đang xây dựng” cho phần chạy Docker.
4. Tạo `weekly-reports/week-1.md` theo **đúng template** trong đề gốc; commit trước **23:59 Chủ nhật**.
5. Thống nhất **branching**: ví dụ `main` (ổn định), `develop`, feature branch `feature/ten-tinh-nang`, merge bằng PR (khuyến khích).

### 1.3 Checklist tuần 1

- [ ] Repo công khai (hoặc GV được quyền xem).
- [ ] Mỗi thành viên ≥1 commit.
- [ ] `week-1.md` đã commit.

---

## 2. Tuần 2 — Phân tích yêu cầu

### 2.1 Deliverable

- Use cases, actors, danh sách chức năng (mapping với đề tài đã chọn).
- **Danh sách màn hình** (UI) và **dự kiến API** (endpoint/method, mục đích) — sơ bộ, có thể bổ sung khi chi tiết hoá tuần sau.
- Bắt đầu **yêu cầu phi chức năng** (bảo mật cơ bản, hiệu năng chấp nhận được, log…).

### 2.2 Việc làm cụ thể

1. Liệt kê **tất cả chức năng** trong đề tài → chia thành epic (VD: Auth, CRUD X, Đặt hàng, Thanh toán mock…).
2. Liệt kê **actors** theo đề tài; vẽ **sơ đồ use case** (Draw.io / PlantUML / Mermaid) — actor ↔ use case khớp đề; lưu `docs/` hoặc dùng cho chương 2 báo cáo.
3. Xác định **luồng quan trọng** cần sequence diagram sau này (đặt hàng, thanh toán, gửi thông báo…).
4. Quyết định sơ bộ **entity** chính (User, Order, Product…) để tuần 3–4 thiết kế DB.
5. Lập **danh sách màn hình** — tên màn, vai trò người dùng (nếu có nhiều role), mapping với chức năng/epic (VD: Đăng nhập, Danh sách sản phẩm, Giỏ hàng, Admin dashboard…).
6. Liệt kê **API dự kiến** (REST/GraphQL hoặc theo stack) — path hoặc resource, HTTP method, mô tả ngắn; có thể bảng trong `docs/`; tuần sau có thể chuẩn hoá OpenAPI/Swagger nếu phù hợp.
7. Viết **yêu cầu phi chức năng** (bảo mật cơ bản, phân quyền, log/audit nếu cần, hiệu năng mức đồ án…) — gộp trong `docs/requirements.md` hoặc mục tương ứng chương 2.2 báo cáo.
8. Ghi nhận **hệ thống / dịch vụ ngoài** (thanh toán mock, email mock, OAuth…) — phục vụ sơ đồ **C4 Context** tuần 3; gợi ý chỗ có thể dùng **message queue** sau này nếu đề có luồng bất đồng bộ.

### 2.3 Checklist tuần 2

- [ ] Tài liệu use case, actors và **NFR** có trong repo (`docs/requirements.md` chẳng hạn) hoặc link Google Doc trong README.
- [ ] Có **danh sách màn hình** + **bảng API sơ bộ** (cùng file hoặc `docs/ui-screens.md`, `docs/api-outline.md`).
- [ ] `week-2.md` + commit mỗi người.

---

## 3. Tuần 3 — Thiết kế kiến trúc (C4 + ADR)

### 3.1 Deliverable

- **C4**: Context + Container + Component (bắt buộc theo đề).
- **ADR**: các quyết định kiến trúc quan trọng (kiến trúc tổng thể, DB, message queue, tuỳ chọn cache/auth…).

### 3.2 Việc làm cụ thể

1. **Đối chiếu tuần 2**: actors, use case, hệ thống ngoài, luồng có thể bất đồng bộ — C4 Context/Container phải **khớp** tài liệu đó (tránh thêm/bớt actor hoặc dịch vụ không có trong phạm vi đề).
2. Vẽ **C4 Context** trước (một khối hệ thống + actor + hệ thống ngoài + quan hệ).
3. Vẽ **C4 Container**: từng runtime/deployable (FE, API, DB, RabbitMQ…); ghi **giao thức / hướng** trên mũi tên khi có thể (HTTPS, JDBC/ORM tới DB, AMQP tới queue…).
4. Vẽ **C4 Component** — thường **đi sâu vào API/backend** (auth, module nghiệp vụ, repository, publisher/consumer…). SPA/React có thể chỉ cần là một container ở bước 3; component chi tiết cho FE là tuỳ chọn nếu báo cáo cần làm rõ.
5. Viết **ADR** theo template đề gốc: bối cảnh → quyết định → hệ quả/trade-off — có ADR cho **mẫu kiến trúc tổng thể**; DB, queue, auth… có thể tách file hoặc mục rõ ràng.
6. Thống nhất **tên gọi** trên sơ đồ với README/repo (ví dụ cùng một tên cho “API” / “backend”), để vấn đáp và code không lệch nhau.

### 3.3 Chọn mẫu kiến trúc (yêu cầu ≥1 mẫu đã học)

Ví dụ thường gặp với web app:

- **Layered (3 lớp)**: Presentation → Application/Service → Data — dễ chia việc, phù hợp đồ án.
- **Hexagonal / Ports & Adapters**: tách domain khỏi framework — tốt nếu nhóm muốn nhấn mạnh test và thay đổi adapter.

ADR đầu tiên (thường **ADR-001**) nên gắn với mẫu đã chọn: bối cảnh nhóm, quyết định, ưu/nhược, trade-off. Dùng template trong đề gốc.

### 3.4 C4 — gợi ý nội dung từng level

| Level | Nội dung cần có |
|-------|-----------------|
| **Context** | Actor/người dùng hệ thống + hệ thống ngoài (email mock, payment mock…) — **khớp** phần phân tích tuần 2 |
| **Container** | Web app, API, DB, RabbitMQ, (tuỳ chọn) Redis — mũi tên giao tiếp; có thể ghi chú auth (JWT/session) ở mức container nếu giúp hiểu |
| **Component** | Trong API: module auth, module domain chính, adapter DB, publisher/consumer queue… |

Lưu ảnh vào `docs/architecture/c4-context.png`, `c4-container.png`, `c4-component.png` (hoặc `.svg`).

### 3.5 Checklist tuần 3

- [ ] 3 file sơ đồ C4 trong repo; **các tầng thống nhất** (tên actor/hệ thống ngoài ở Context vẫn đúng khi zoom vào Container/Component).
- [ ] Các file ADR trong `docs/adrs/` bao quát các chủ đề chính (kiến trúc, DB, queue…).
- [ ] `week-3.md`.

---

## 4. Tuần 4–5 — Backend + Database

### 4.1 Deliverable

- Schema DB (migration hoặc script).
- **Sơ đồ DB cho báo cáo** (ERD hoặc logical schema — Draw.io/dbdiagram.io/PlantUML) — khớp với migration; lưu `docs/architecture/erd.png` (hoặc `.svg`) để chèn **chương 4.1** đề gốc.
- API đủ để frontend làm chức năng cốt lõi; **phân quyền theo role/actor** khớp phân tích tuần 2 (401/403/422 xử lý nhất quán).
- **Swagger/OpenAPI** (`docs/api/openapi.yaml` hoặc generate từ code) — cập nhật khi đổi endpoint.
- **Sequence diagram** cho các luồng nghiệp vụ chính (đã chọn tuần 2) — phục vụ **chương 4.3**; có thể Mermaid/PlantUML trong `docs/` hoặc ảnh export.

### 4.2 Thứ tự làm việc gợi ý

**Gợi ý chia nhẹ tuần 4 / tuần 5:** tuần 4 tập trung **schema + auth + CRUD nền + OpenAPI**; tuần 5 **luồng nghiệp vụ + queue + test + hoàn thiện ERD/sequence** (tuỳ nhóm có thể xê dịch).

1. **Đối chiếu** entity & API outline (tuần 2) với migration và route; nếu đổi so với C4/ADR (tuần 3) thì **cập nhật sơ đồ hoặc ADR** cho khớp thực tế.
2. **Auth cơ bản** (JWT session hoặc token — thống nhất một cách).
3. **CRUD** theo từng actor (phân quyền role).
4. **Luồng nghiệp vụ** (đặt vé, đặt phòng, order…) + transaction khi cần; validate input, phản hồi lỗi rõ ràng cho FE.
5. **RabbitMQ** — luồng bất đồng bộ theo yêu cầu đề (email mock, thông báo, xử lý nền…):

   - Ví dụ: sau khi tạo đơn → publish message → consumer gửi email mock / ghi log / cập nhật thông báo.
   - Cách demo: tạo đơn → xem queue có message / log consumer xử lý.

6. Viết **unit test** hoặc **integration test** cho service quan trọng (auth, luồng chính).
7. **Cấu hình chạy local**: biến môi trường (chuỗi kết nối DB, JWT secret, URL queue…); có **`.env.example`**; không commit secret thật. Nếu FE và API khác origin, cấu hình **CORS** (hoặc cookie/session) cho phù hợp.

### 4.3 API documentation

- Nếu framework hỗ trợ (Springdoc, swagger-ui express, FastAPI…): export YAML vào `docs/api/`.
- README liên kết: “API docs: http://localhost:…/swagger-ui” khi chạy local.

### 4.4 Checklist tuần 4–5

- [ ] DB chạy được qua Docker (hoặc sẽ nối vào compose tuần 6).
- [ ] Có **ERD / sơ đồ schema** trong repo (khớp code migration).
- [ ] Có **sequence diagram** minh họa luồng nghiệp vụ quan trọng (khi cần cho báo cáo).
- [ ] OpenAPI/Swagger có trong repo hoặc generate từ build.
- [ ] API **phân quyền** và mã lỗi cơ bản thống nhất với FE khi tích hợp.
- [ ] RabbitMQ có luồng **producer–consumer** thể hiện rõ trong demo/code.
- [ ] Có **test** (unit hoặc integration) cho phần quan trọng; CI tuần sau có thể gọi được.
- [ ] `.env.example` (hoặc tương đương) đã có; không lộ secret trên Git.
- [ ] `week-4.md`, `week-5.md`.

---

## 5. Tuần 5–6 — Frontend

### 5.1 Deliverable

- Giao diện đủ **actors** theo đề (customer, admin, …).
- Gọi API thật; xử lý lỗi 401/403/422 cơ bản.

### 5.2 Gợi ý triển khai

1. Trang public + login + dashboard theo role.
2. Form và bảng danh sách cho các CRUD chính.
3. Luồng “happy path” mượt cho **demo vấn đáp** (kịch bản 3–5 phút).

### 5.3 Checklist

- [ ] Build production (`npm run build` / tương đương) không lỗi.
- [ ] `week-6.md` (và tiếp tục commit tuần 5 nếu chưa xong).

---

## 6. Tuần 6–7 — Docker Compose + tích hợp + CI/CD

### 6.1 Docker Compose (bắt buộc — demo phải chạy bằng compose)

**Gợi ý các dịch vụ trong Compose:**

- `frontend` (nginx serve static hoặc dev server tùy môi trường — production nên build image).
- `backend`
- `db` (PostgreSQL/MySQL/…)
- `rabbitmq` (+ port management 15672 nếu cần debug)
- (Optional) `redis`

**Nguyên tắc:**

- Một lệnh: `docker compose up -d` (hoặc `docker-compose` tùy phiên bản).
- Biến môi trường: `.env.example` trong repo (không commit secret thật).

### 6.2 GitHub Actions (bắt buộc)

Pipeline có thể gồm:

- Trigger: `push`/`pull_request` vào `main` hoặc `develop`.
- Job: checkout → setup runtime → **chạy test** (backend và/hoặc frontend).
- (Khuyến khích) build Docker image hoặc `docker compose config` validate.

Lưu tại `.github/workflows/ci.yml`. Chụp màn hình pipeline xanh trong báo cáo hoặc README.

### 6.3 Checklist tuần 6–7

- [ ] `docker compose up` chạy full stack trên máy “sạch” (clone mới).
- [ ] CI chạy test hoặc build thành công.
- [ ] Chuẩn bị nội dung **chương 5 báo cáo**: mô tả ngắn **cấu trúc thư mục** (`backend/`, `frontend/`, `docs/`), trích `docker-compose.yml` (hoặc giải thích service), **ảnh/ghi chú pipeline CI** (mục V.1 — 5.1–5.3).
- [ ] Cập nhật README: port, account demo (nếu có), link video demo.
- [ ] `week-7.md`.

---

## 7. Tuần 8 — Testing, báo cáo, nộp bài

### 7.1 Testing

- Bổ sung test cho luồng dễ vỡ (đặt chỗ trùng, giỏ hàng, phân quyền).
- Ghi trong báo cáo: cách chạy test (`npm test`, `pytest`, `mvn test`…).

### 7.2 Báo cáo Word/PDF

Soạn **đúng cấu trúc mục V.1** trong đề gốc (7 chương + phụ lục ADR + API).

- **Ch.2:** lấy từ `docs/requirements.md` (hoặc tài liệu tuần 2): chức năng, NFR, actors, use case; có thể thêm bảng màn hình/API đã lập.
- **Ch.3:** C4 (3 ảnh `docs/architecture/`) + tóm tắt/viết lại ADR từ `docs/adrs/` (không chỉ dán link).
- **Ch.4:** ERD/schema + bảng/mô tả API (đồng bộ OpenAPI) + sequence diagram(s).
- **Ch.5–6:** cấu trúc code, Docker, CI/CD, hướng dẫn chạy (có thể rút từ README), screenshot demo.
- **Ch.7 + Phụ lục:** kết luận; phụ lục ADR đầy đủ + export/link API doc.

Xem thêm bảng **§10 — Đối chiếu repo ↔ báo cáo** dưới đây.

### 7.3 Nộp

- GitHub: code + docs + weekly-reports đầy đủ.
- LMS: báo cáo + đúng deadline **Tuần 8** (hard deadline theo đề).

### 7.4 Checklist tuần 8

- [ ] `week-8.md` (tổng kết).
- [ ] Rubric tự đối chiếu: Docker, RabbitMQ, CI/CD, C4, ADR, Swagger, test.
- [ ] Rehearsal demo 5 phút trên Docker Compose.

---

## 8. Tuần 9 — Vấn đáp

### 8.1 Chuẩn bị

- **Demo live** từ `docker compose up` (mạng ổn định, dữ liệu mẫu).
- Mỗi người nói được phần mình: 1 người kiến trúc/C4, 1 người backend/API/queue, 1 người frontend, 1 người DevOps/CI.
- Ôn **trade-off** trong ADR (tại sao không chọn microservices full nếu chỉ làm monolith có queue, v.v.).

### 8.2 Câu hỏi thường gặp (tự luyện)

- Vì sao chọn kiến trúc X? Layer nào phụ thuộc layer nào?
- RabbitMQ dùng ở đâu, nếu queue đầy hoặc consumer chết thì sao?
- Phân quyền triển khai thế nào? JWT lưu ở đâu?
- Cách deploy/mở rộng nếu tăng traffic (ý tưởng là đủ, không cần làm hết).

**Lưu ý đề:** vắng vấn đáp = 0 điểm phần liên quan; cả nhóm chuẩn bị kỹ lịch.

---

## 9. Bảng đối chiếu yêu cầu kỹ thuật (mục IV đề gốc)

| # | Yêu cầu | Gợi ý chứng minh trong repo/báo cáo |
|---|---------|--------------------------------------|
| 1–3 | Ngôn ngữ, DB, FE | README + Dockerfile từng phần |
| 4 | Git/GitHub | Lịch sử commit, PR, nhánh rõ |
| 5 | Mẫu kiến trúc | ADR-001 + giải thích trong báo cáo ch.3 |
| 6 | Đủ chức năng đề tài | Checklist chức năng + screenshot |
| 7 | Docker Compose | `docker-compose.yml` + hướng dẫn README |
| 8 | C4 | 3 ảnh trong `docs/architecture/` |
| 9 | ADR | `docs/adrs/*.md` |
| 10 | API docs | `openapi.yaml` hoặc Swagger UI |
| 11 | Test | Thư mục `tests/`, CI chạy test |
| 12 | RabbitMQ | Compose service + code publish/consume |
| 13 | CI/CD | `.github/workflows/*.yml` |
| 14 | README + branch | README đầy đủ; mô tả strategy trong README hoặc CONTRIBUTING |

**Rubric (mục VIII đề gốc):** Lập trình & triển khai ~40%, Báo cáo ~20% (cấu trúc V.1, C4, ADR, API doc, trình bày), Vấn đáp ~40%. Tài liệu kiến trúc trong repo là “nguồn thật”; báo cáo là bản trình bày có cấu trúc — nên giữ đồng bộ (cùng phiên bản sơ đồ/ADR).

---

## 10. Quy trình & đối chiếu tài liệu kiến trúc (repo ↔ báo cáo mục V.1)

Quy trình gợi ý: **yêu cầu (tuần 2) → quyết định & C4/ADR (tuần 3) → chi tiết DB/API/sequence (tuần 4–5) → triển khai & bằng chứng Docker/CI (tuần 6–7) → đóng gói báo cáo + phụ lục (tuần 8).**

| Chương báo cáo (V.1) | Nội dung chính | Nguồn / artifact trong repo (gợi ý) |
|----------------------|----------------|-------------------------------------|
| **1. Giới thiệu** | Bài toán, phạm vi, công nghệ | README, `week-1.md` |
| **2. Phân tích yêu cầu** | Chức năng, NFR, actors, use case | `docs/requirements.md`, use case (ảnh/Mermaid), `docs/ui-screens.md`, `docs/api-outline.md` |
| **3. Thiết kế kiến trúc** | Mẫu kiến trúc, C4, ADR | `docs/architecture/c4-*.png`, `docs/adrs/*.md` |
| **4. Thiết kế chi tiết** | Schema/ERD, API, sequence | `database/migrations/`, `docs/architecture/erd.*`, `docs/api/openapi.yaml`, `docs/*sequence*` |
| **5. Triển khai** | Cấu trúc code, Docker, CI/CD | Cây thư mục + giải thích, `docker-compose.yml`, `.github/workflows/ci.yml` + screenshot run |
| **6. Demo & cài đặt** | Chạy local, screenshot | README, ảnh demo UI |
| **7. Kết luận** | Kết quả, hạn chế, hướng phát triển | Tổng hợp nhóm |
| **Phụ lục** | ADR đầy đủ, API doc | Copy từ `docs/adrs/`, export OpenAPI hoặc link Swagger |

**Chuẩn đề gốc đã đủ khi:** (1) C4 đủ 3 level trong repo và báo cáo; (2) ADR cho các quyết định quan trọng (kiến trúc, DB, queue…); (3) OpenAPI/tương đương; (4) báo cáo đúng 7 chương + phụ lục. **C4 mức Code** không bắt buộc trong đề — tùy nhóm nếu muốn làm sâu.

---

## 11. Liên kết nhanh

- Đề bài đầy đủ: `../Software Architecture - Capstone projects.md` (thư mục `practices/`)
- C4 / Draw.io: https://app.diagrams.net/
- Mermaid: https://mermaid.live/

---

*Tài liệu hướng dẫn này là bản bổ trợ; mọi thay đổi chính thức từ giảng viên ưu tiên hơn.*
