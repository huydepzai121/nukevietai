# Giao diện mẫu 2 — "Nhịp Phố"

Hướng thiết kế thứ hai cho website tin tức. Cấu trúc giữ nguyên theo
`themes/default` của NukeViet, chỉ thay lớp nhìn. Xem hướng thứ nhất ở
`docs/giaodienmau.md`.

## Vị trí

Thư mục `giaodienmau2/` ở gốc repo. Mở trực tiếp bằng trình duyệt, không cần build.

## Cấu trúc

| File | Nội dung |
|------|----------|
| `index.html` | Trang chủ — `layout.left-main-right` (5 / 13 / 6 cột) |
| `chi-tiet.html` | Trang chi tiết bài viết |
| `mobile.html` | Bản thu gọn ở 390px |
| `design-system.html` | Hệ thống thiết kế: so sánh với mẫu 1, màu, chữ, lưới, thành phần, bảng ánh xạ sang theme |
| `assets/css/tokens.css` | Biến CSS — màu, chữ, lưới, bo góc |
| `assets/css/base.css` | Reset, chữ nền, khung `.wraper`, lưới |
| `assets/css/components.css` | Thành phần dùng lại: header, menu, breadcrumb, thẻ, mẫu tin, footer |
| `assets/css/page-*.css` | Phần riêng của từng trang |
| `assets/img/` | 10 ảnh minh họa |

Thứ tự nạp CSS bắt buộc: `tokens` → `base` → `components` → `page-*`.

## Giữ gì, đổi gì

Giữ nguyên: `.wraper` 1080px, lưới 24 cột, bố cục `left-main-right`, cấu trúc khối
`block.default` / `block.primary`, chuỗi thanh trên → logo + banner → menu →
breadcrumb → 3 cột → footer → `footerNav2`.

Đổi: bảng màu tím `#6b4eff` với san hô `#ff6a4d` và bạc hà `#12bfa0`; chữ
`Be Vietnam Pro` (đủ dấu tiếng Việt ở mọi độ đậm) thay cho Helvetica + Times;
thẻ bo 18px có bóng nhẹ, đầu khối dùng thanh màu 4px thay nền xám; menu dạng
viên thuốc; nhãn chuyên mục đổi màu theo mục; tiêu đề đặt trên ảnh lớn.
Bảng so sánh đầy đủ ở mục 1 của `design-system.html`.

## Ảnh

10 ảnh trong `assets/img/` lấy từ picsum.photos, chỉ để minh họa bố cục — thay
bằng ảnh của tòa soạn trước khi dùng thật.

## Nội dung mẫu

Tiêu đề và sapo là nội dung mẫu. Dữ kiện cứng (hotline, email, giấy phép, tên
người, ngày giờ) để trong ngoặc vuông `[ ]` và phải thay trước khi dùng thật.

## Bước tiếp theo

Bộ mẫu này đã được dựng thành theme `themes/giaodienmau2` ("Nhịp Phố").
Quy trình đầy đủ từ bản mẫu tĩnh tới theme chạy được:
`docs/quy-trinh-lam-giao-dien.md`. Bảng ánh xạ từng phần sang file theme nằm ở
mục 8 của `giaodienmau2/design-system.html`.
