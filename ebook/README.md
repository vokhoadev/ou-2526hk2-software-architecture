# Sách Kiến trúc phần mềm — Bản hợp nhất (`sach-HopNhat-ITEC2313`)

Thư mục này gộp nội dung từ **`sach-Chuong1`** (Tổng quan KTPM), **`sach-Chuong2`** (Kiến trúc phân tán) và **`sach-Chuong3`** (Các mẫu kiến trúc) thành **một luồng đọc** và một lệnh build PDF.

## Cấu trúc

| Thư mục | Nội dung |
|---------|-----------|
| `00-FrontMatter.md` | Bìa, lời nói đầu, mục lục cấu trúc |
| `00-QuyUoc-Soan-Thao.md` | Quy ước trích dẫn, hình, liên kết giữa các phần |
| `Part-01-Software-Architecture/` | Phần I — 8 chương + Ch05b |
| `Part-02-Distributed-Systems/` | Phần II — Hệ phân tán (6 chương) |
| `Part-03-Architecture-Patterns/` | Phần III — Mẫu kiến trúc (15 chương) |
| `assets/figures/part-01`, `part-02`, `part-03/` | Hình copy từ ba bản gốc |
| `BackMatter/` | Tham khảo gộp, glossary, bài tập, đáp án, index, errata |
| `build/book-order.txt` | Thứ tự file cho Pandoc |
| `_meta/` | Template soạn thảo (từ Chuong3) |

## Thứ tự đọc / build

1. Mở `00-FrontMatter.md` rồi đọc tuần tự theo `build/book-order.txt`, hoặc  
2. Xuất PDF (cần [Pandoc](https://pandoc.org/) và LaTeX nếu dùng `--pdf-engine=xelatex`):

```bash
cd sach-HopNhat-ITEC2313
bash build/build-pdf.sh
# hoặc:
FILES=$(grep -v '^[[:space:]]*$' build/book-order.txt | tr '\n' ' ')
pandoc --from=markdown-yaml_metadata_block --file-scope $FILES -o Sach-HopNhat.html --toc --resource-path=".:assets/figures:assets/figures/part-01:assets/figures/part-01/sketchnotes:assets/figures/part-02:assets/figures/part-03"
```

**Lưu ý:** Mermaid trong các chương có thể không render trong PDF mặc định; xem tài liệu Pandoc (filter) hoặc xuất HTML.

## Đồng bộ với bản gốc

Ba thư mục `sach-Chuong{1,2,3}` vẫn là nơi chỉnh sửa từng phần. Sau khi sửa gốc, cần **copy lại** file tương ứng vào đây (hoặc viết script rsync). Bản hợp nhất không tự cập nhật.

## Phụ lục

- `BackMatter/99-ThamKhao-HopNhat.md` — gộp References + Tham khảo Phần II + III  
- `BackMatter/99-Glossary-HopNhat.md` — gộp glossary ba phần  
- `BackMatter/99-BaiTap-HopNhat.md` — bài tập Phần II + III  
- `BackMatter/99-DapAn-HopNhat.md` — đáp án tương ứng  
