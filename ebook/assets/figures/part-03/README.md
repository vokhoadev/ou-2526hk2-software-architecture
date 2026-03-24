# Thư mục hình và sơ đồ (Figures)

Thư mục này dùng để chứa các file hình ảnh/sơ đồ chuẩn (C4, UML) cho sách, thay thế hoặc bổ sung cho sơ đồ ASCII trong nội dung chương.

**Sơ đồ chuẩn trong sách:** Các sơ đồ H3.1–H12.2 hiện dùng **Mermaid** trực tiếp trong file Markdown từng chương (flowchart, sequenceDiagram, stateDiagram-v2). Chúng render đúng trên GitHub, GitBook, MkDocs. **Khi cần in/PDF:** có thể export từ Mermaid sang PNG/SVG (Mermaid CLI, VS Code extension, hoặc mermaid.live) rồi đặt vào thư mục `figures/` và tham chiếu bằng `![Hx.x](figures/Hx.x.png)`.

*Gợi ý triển khai thực tế — diagram-as-code trong Git (xem thêm Chương 13 — ADR):*

![Sketchnote — Diagram as code](../part-01/sketchnotes/sketch-ch07-diagram-as-code.svg)

## Quy ước tên file

- **Hình theo chương:** `H<Chương>.<Số>.<đuôi>` — ví dụ `H3.1.png`, `H4.1.svg`, `H14.1.png`.
- **Định dạng khuyến nghị:** PNG hoặc SVG để in rõ và scale tốt.

## Các hình cần bổ sung (theo đánh số trong sách)

| Mã hình | Mô tả ngắn | Gợi ý công cụ |
|---------|------------|----------------|
| H3.1 | Mô hình bốn lớp (Layered) | C4 Level 1 hoặc UML Component diagram |
| H4.1 | Master-Slave — Master và các Slave | C4 hoặc UML Deployment/Component |
| H5.1 | Client-Server 2-tier / 3-tier | C4 Context hoặc Component |
| H6.1 | P2P — các peer và kết nối | Sơ đồ node/component |
| H7.1 | Broker — Client, Broker, Server | C4 hoặc sequence diagram |
| H8.1 | MVC — Model, View, Controller | UML Component hoặc C4 |
| H9.1 | Event-Driven — Producer, Event Bus, Consumers | C4 hoặc block diagram |
| H10.1 | Pipe-and-Filter — chuỗi filter | Data flow diagram |
| H11.1 | Hexagonal / Clean — Ports & Adapters | Vòng tròn layers (Uncle Bob style) |
| H12.1, H12.2 | Microservices patterns (Saga, Sidecar, Circuit Breaker) | C4 hoặc sequence |
| B14.1, B14.2 | Bảng so sánh — có thể giữ trong Markdown | — |

## Công cụ gợi ý

- **C4 Model:** [Structurizr](https://structurizr.com/), [C4-PlantUML](https://github.com/plantuml/plantuml-component-diagram), hoặc vẽ tay export PNG/SVG.
- **UML:** PlantUML, Draw.io, Lucidchart, hoặc Mermaid (export SVG/PNG).
- **Chèn vào sách:** Trong file Markdown chương, dùng cú pháp `![H3.1](figures/H3.1.png)` và giữ caption *Hình H3.1 — Mô hình bốn lớp.*

---
*Khi thêm hình mới, cập nhật bảng trên và đảm bảo tên file trùng với mã hình trong sách.*
