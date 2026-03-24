# Figures — Phần I (bản hợp nhất)

## Bản quyền và sử dụng

| File | Mô tả | Ghi chú bản quyền |
|------|--------|-------------------|
| `fig-*.svg` | Sơ đồ gốc trong repo | **CC BY-SA 4.0** — tác giả soạn tài liệu; được phép chia sẻ lại với ghi nguồn giống hệ. |
| Đối chiếu Pressman | Các chú thích trong chương ghi *aligned with Pressman & Maxim (2015), Fig …* | Không phải ảnh quét sách; sinh viên có sách in nên **đối chiếu** bản gốc McGraw-Hill. |

## Danh mục file (map tới chương)

| File | Tương đương học thuật | Chương gợi ý |
|------|------------------------|--------------|
| `fig-kruchten-4plus1-overview.svg` | Kruchten (1995), 4+1 view model | Ch. 1 |
| `fig-pressman-12-1-design-flow.svg` | Pressman (2015), Fig. 12.1, p. 226 | Ch. 3 |
| `fig-pressman-13-1-data-centered.svg` | Pressman (2015), Fig. 13.1, p. 259 → **Figure 4.2** | Ch. 4 |
| `fig-pressman-13-2-pipe-filter.svg` | Pressman (2015), Fig. 13.2, p. 260 → **Figure 4.3** | Ch. 4 |
| `fig-pressman-13-3-call-return-layered.svg` | Pressman (2015), Fig. 13.3–13.4 → **Figure 4.4** | Ch. 4 |
| `sketchnotes/sketch-*.svg` | Sketchnote (phác tay / ghi chú trực quan), CC BY-SA 4.0 | Ch. 1–8 — xem `sketchnotes/README.md` |
| `fig-pressman-13-5-system-context.svg` | Pressman (2015), Fig. 13.5, p. 268 | Ch. 6 |
| `fig-cost-of-change-curve.svg` | Ý Pressman / Boehm (đường cong chi phí đổi muộn) | Ch. 2 |
| `fig-iso-25010-quality-model-overview.svg` | ISO/IEC 25010 — cấu trúc khái niệm (rút gọn) | Ch. 5 |

## Kiểm tra SVG (XML hợp lệ)

Từ thư mục `figures/`:

```bash
python3 -c "import pathlib, xml.etree.ElementTree as ET; \
  [ET.parse(p) for p in pathlib.Path('.').rglob('*.svg')]"
```

Lệnh trên báo lỗi nếu file SVG không well-formed (ký tự điều khiển, `&` chưa escape, v.v.).

## Xuất PDF

Pandoc có thể nhúng SVG nếu dùng engine hỗ trợ (hoặc chuyển SVG → PDF/PNG trước khi build). Gợi ý: `pandoc ... --resource-path=.:figures:figures/sketchnotes` (xem `README.md` ở thư mục cha).

## Bản quyền

Xem `LICENSE-FIGURES.md` (CC BY-SA 4.0 cho `fig-*.svg` và `sketchnotes/sketch-*.svg`). Sketchnote: `sketchnotes/README.md`.
