# Chuẩn soạn thảo, hình ảnh và trích dẫn (bản hợp nhất)

Tài liệu `sach-HopNhat-ITEC2313` gộp ba phần soạn thảo; quy ước dưới đây **thống nhất cách đọc**, còn chi tiết trích dẫn IEEE/APA nằm ở từng đoạn và trong [BackMatter/99-ThamKhao-HopNhat.md](BackMatter/99-ThamKhao-HopNhat.md).

---

## 1. Trích dẫn trong văn bản

- **IEEE:** số trong ngoặc vuông `[n]` — bảng tương ứng theo **từng mục** trong file tham khảo hợp nhất (Phần I / II / III có thể dùng dải số khác nhau trong bản gốc).  
- **APA (7th ed.):** tác giả–năm — xem mục APA trong cùng file tham khảo.  
- **ISO/IEC/IEEE 42010** và tinh thần **IEEE 1471** được dùng ở Phần I khi nói về *architecture description*.

---

## 2. Hình ảnh (figures)

### Đánh số theo chương trong từng phần

- **Phần I:** *Figure C.N* — *C* là số chương **trong Phần I** (1–8), *N* là thứ tự hình trong chương.  
- **Phần II:** *Figure C.N* — *C* là số chương **trong Phần II** (1–6).  
- **Phần III:** trong README gốc có quy ước *H&lt;chương&gt;.&lt;số&gt;*; trong file chương vẫn có chú thích *Hình …* hoặc Mermaid — **không đổi số** trong bản hợp nhất lần đầu (phương án A: giữ nguyên theo phần).

### Sketchnote và SVG (Phần I)

Sketchnote và `fig-*.svg` nằm trong `assets/figures/part-01/` (kèm `sketchnotes/`). License: xem `assets/figures/part-01/LICENSE-FIGURES.md` và README trong cùng thư mục.

### Mermaid

Khối Mermaid được xem là hình khi có dòng *Figure …* / *Hình …* ngay sau khối.

### Đường dẫn tệp

Ảnh trong Markdown dùng đường dẫn **tương đối** từ file chương tới `assets/figures/part-01/`, `part-02/`, `part-03/`.

---

## 3. Liên kết chéo giữa các phần

Trong văn bản, tham chiếu dùng **Phần I**, **Phần II**, **Phần III** và **số chương trong phần đó** (ví dụ: *Phần III, Chương 12 — Microservices Patterns*). Không dùng tên thư mục `sach-Chuong2` trong bản in.

---

## 4. Xuất PDF (Pandoc)

Xem [README.md](README.md) và `build/book-order.txt`. Cần `--resource-path` gồm thư mục gốc bản hợp nhất và `assets/figures/part-01` … `part-03` (và toàn bộ `assets/figures` nếu cần). **Khuyến nghị:** `--from=markdown-yaml_metadata_block` và `--file-scope` để các dòng `---` (gạch ngang) trong chương không bị hiểu nhầm là khối YAML. Mermaid có thể yêu cầu filter hoặc bước tiền xử lý tùy môi trường.
