# KIẾN TRÚC PHẦN MỀM

**Sách giáo trình — Bản hợp nhất (Phần I + II + III)**  
*Gộp từ tài liệu: Tổng quan KTPM · Kiến trúc phân tán · Các mẫu kiến trúc phần mềm*

---

**Tác giả:** ThS. Dương Hữu Thành  
**Đơn vị:** Khoa Công nghệ Thông tin — Trường Đại học Mở TP.HCM  
**Năm:** 2025  
**Phiên bản hợp nhất:** 1.0  
**Cập nhật lần cuối:** 2025-03-23  

**Xuất bản / Phân phối:** Tài liệu giáo trình nội bộ. Bản điện tử có thể dùng làm OER (*Open Educational Resource*).  
**Giấy phép (nếu phát hành mở):** CC BY-NC-SA (Ghi công — Không thương mại — Chia sẻ tương tự).  
**Errata & Changelog:** [BackMatter/99-Errata-HopNhat.md](BackMatter/99-Errata-HopNhat.md)

---

## Lời nói đầu (bản hợp nhất)

Cuốn sách này **gom một luồng đọc liên tục** ba khối nội dung môn **Kiến trúc phần mềm** (ITEC2313):

1. **Phần I — Tổng quan kiến trúc phần mềm:** định nghĩa, vai trò, chi phí và nợ kiến trúc, thiết kế và triển khai, thể loại và phong cách, chất lượng và NFR, quy trình, công cụ, case study.  
2. **Phần II — Kiến trúc phân tán:** khái niệm và thách thức, middleware, web services (SOAP, REST, GraphQL, gRPC), microservices, tổng kết.  
3. **Phần III — Các mẫu kiến trúc:** từ Layered, Master–Slave, Client–Server, P2P, Broker, MVC đến EDA, Pipe-and-Filter, Hexagonal/Clean, mẫu microservices, ADR, so sánh và tổng kết.

**Cách đọc đề xuất:** đi **tuần tự** từ Phần I → II → III để nền tảng (định nghĩa, NFR, quy trình) hỗ trợ đọc phần phân tán và pattern; có thể **tra cứu** theo mục lục hoặc [BackMatter/99-Index.md](BackMatter/99-Index.md) (chỉ mục gốc Phần III).

**Quy ước số chương:** mỗi phần giữ **đánh số chương nội bộ** (Chương 1, 2, … trong phần đó). Tham chiếu chéo trong văn bản dùng dạng **Phần I / II / III, Chương *n***.

**Trích dẫn và hình ảnh:** xem [00-QuyUoc-Soan-Thao.md](00-QuyUoc-Soan-Thao.md). **Danh mục tham khảo gộp:** [BackMatter/99-ThamKhao-HopNhat.md](BackMatter/99-ThamKhao-HopNhat.md). **Glossary gộp:** [BackMatter/99-Glossary-HopNhat.md](BackMatter/99-Glossary-HopNhat.md).

**Hình minh họa:** SVG sketchnote và sơ đồ Phần I nằm tại `assets/figures/part-01/`; Phần II và III tại `assets/figures/part-02/`, `assets/figures/part-03/`. Đường dẫn trong file Markdown đã chỉnh tương đối từ thư mục chương.

---

## Mục lục cấu trúc (chi tiết — sinh `--toc` khi xuất PDF)

**Phần mở đầu**

- Lời nói đầu (file này)  
- [Chuẩn soạn thảo và trích dẫn](00-QuyUoc-Soan-Thao.md)

**Phần I — Tổng quan kiến trúc phần mềm** (`Part-01-Software-Architecture/`)

| Chương | File |
|--------|------|
| 1 | Ch01-Software-architecture-definition.md |
| 2 | Ch02-Role-cost-and-architecture-debt.md |
| 3 | Ch03-Architecture-design-and-deployment.md |
| 4 | Ch04-Genres-styles-and-hybrid-architectures.md |
| 5 | Ch05-Quality-NFR-and-evaluation.md |
| 5b (phụ) | Ch05b-Modularity.md |
| 6 | Ch06-Process-governance-and-lifecycle.md |
| 7 | Ch07-Tools-and-documentation.md |
| 8 | Ch08-Ecommerce-case-study.md |

**Phần II — Kiến trúc phân tán** (`Part-02-Distributed-Systems/`)

| Chương | File |
|--------|------|
| 1 | Chuong01-GioiThieu.md |
| 2 | Chuong02-TongQuanPhanTan.md |
| 3 | Chuong03-Middleware.md |
| 4 | Chuong04-WebServices.md |
| 5 | Chuong05-Microservices.md |
| 6 | Chuong06-TongKet.md |

**Phần III — Các mẫu kiến trúc phần mềm** (`Part-03-Architecture-Patterns/`)

| Chương | File |
|--------|------|
| 1 | Chuong01-GioiThieu.md |
| 2 | Chuong02-TongQuan.md |
| 3 | Chuong03-Layered.md |
| 4 | Chuong04-MasterSlave.md |
| 5 | Chuong05-ClientServer.md |
| 6 | Chuong06-P2P.md |
| 7 | Chuong07-Broker.md |
| 8 | Chuong08-MVC.md |
| 9 | Chuong09-EDA.md |
| 10 | Chuong10-PipeFilter.md |
| 11 | Chuong11-HexagonalClean.md |
| 12 | Chuong12-MicroservicesPatterns.md |
| 13 | Chuong13-ADR.md |
| 14 | Chuong14-SoSanh.md |
| 15 | Chuong15-TongKet.md |

**Phụ lục** (`BackMatter/`)

- Tham khảo hợp nhất, Glossary hợp nhất, Bài tập & đáp án, Trắc nghiệm, Tự luận, Index, Errata — xem README gốc thư mục `sach-HopNhat-ITEC2313`.

---

## Nguồn bản tách (đồng bộ chỉnh sửa)

Các thư mục `sach-Chuong1`, `sach-Chuong2`, `sach-Chuong3` trong cùng repo vẫn là **nguồn soạn từng phần**. Bản hợp nhất này là **bản copy** theo kế hoạch gộp; khi sửa sâu, nên cập nhật nguồn rồi **copy lại** hoặc dùng quy trình merge thủ công.
