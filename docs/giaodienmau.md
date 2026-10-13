# Giao diện mẫu — website tin tức

Bản thiết kế tĩnh cho giao diện tin tức, bám theme `themes/default` của NukeViet.
Đây là bước 1: chốt thiết kế trên HTML/CSS tĩnh. Bước 2 (chưa làm) là chuyển thành
theme thật `themes/giaodienmau/`.

## Vị trí

Thư mục `giaodienmau/` ở gốc repo. Mở trực tiếp bằng trình duyệt, không cần build,
không cần chạy NukeViet.

## Cấu trúc

| File | Nội dung |
|------|----------|
| `index.html` | Trang chủ — bố cục `layout.left-main-right` (5 / 13 / 6 cột) |
| `chuyen-muc.html` | Trang chuyên mục — bố cục `layout.main-right` (18 / 6 cột) |
| `chi-tiet.html` | Trang chi tiết bài viết |
| `mobile.html` | Bản thu gọn ở 390px |
| `design-system.html` | Hệ thống thiết kế: token, thang chữ, lưới, thành phần, bảng ánh xạ sang theme |
| `assets/css/tokens.css` | Biến CSS — màu, chữ, lưới, bo góc, kèm ghi chú nguồn trong `themes/default` |
| `assets/css/base.css` | Reset, chữ nền, khung `.wraper`, các lưới dùng chung |
| `assets/css/components.css` | Thành phần dùng lại: header, menu, breadcrumb, panel, mẫu tin, footer |
| `assets/css/page-*.css` | Phần riêng của từng trang |

Thứ tự nạp CSS bắt buộc: `tokens` → `base` → `components` → `page-*`.

## Nguồn giá trị thiết kế

Mọi màu, cỡ chữ, khoảng cách đều lấy nguyên từ `themes/default`:

- `css/style.css` — `body`, `a`, `#header`, `.wraper` (1080px), `.section-header-bar`,
  `.second-nav`, `.third-nav`, `.breadcrumbs`, `#footer`, `.footerNav2`
- `css/news.css` — `div.news_column`, `#hot-news`, `ul.related`, `.imgalt`
- `css/menu.css` và `modules/menu/global.bootstrap.tpl` — thanh menu
- `layout/block.default.tpl`, `layout/block.primary.tpl` — khối nội dung

Chỉ hai màu là bổ sung ngoài theme gốc: `#dbe4ec` (ô giữ chỗ ảnh) và `#eef3f8`
(nền thẻ từ khóa). Chữ tiêu đề tin dùng `'Times New Roman'` — font đã có sẵn trong
theme ở `#header .logo .site_description`, nên không phải nạp webfont mới.

## Nội dung mẫu

Tiêu đề và sapo trong các trang là nội dung mẫu để xem bố cục. Dữ kiện cứng
(số điện thoại, email, giấy phép, tên người, ngày giờ) để trong ngoặc vuông `[ ]`
và phải thay trước khi dùng thật. Ảnh là ô giữ chỗ (`.ph`), chưa có ảnh thật.

## Bước tiếp theo

Bảng ánh xạ từng phần của bản mẫu sang file theme tương ứng nằm ở mục 7 của
`giaodienmau/design-system.html`. Quy trình dựng thành theme chạy được:
`docs/quy-trinh-lam-giao-dien.md`.
