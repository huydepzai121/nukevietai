# Giao diện mẫu 3 — "Nhật Trình"

Hướng thiết kế A đã được chốt: báo in cổ điển, giấy ngà, mực đen, đỏ nhấn, hai
họ chữ serif (Playfair Display + Noto Serif). Hoàn toàn mới, **không bám**
`themes/default` như bộ 1 (`docs/giaodienmau.md`) và không giữ nguyên cấu trúc
đổi lớp nhìn như bộ 2 (`docs/giaodienmau2.md`) — chỉ khung NukeViet (lưới,
chuỗi khối) là còn giữ, phần còn lại vẽ lại từ đầu.

## Vị trí

Thư mục `giaodienmau3/` ở gốc repo. Mở trực tiếp bằng trình duyệt, không cần
build, không cần chạy NukeViet.

## Cấu trúc

| File | Nội dung |
|------|----------|
| `index.html` | Trang chủ — `layout.left-main-right` (5 / 13 / 6 cột), dựng theo `Main.dc.html` |
| `chuyen-muc.html` | Trang chuyên mục "Thời sự" — `layout.main-right` (18 / 6 cột) |
| `chi-tiet.html` | Trang chi tiết bài viết, tiếp nối tin nổi bật của trang chủ |
| `mobile.html` | Bản thu gọn 390px, dựng theo `MobileA.dc.html` |
| `design-system.html` | Hệ thống thiết kế: so sánh với 2 bộ trước, màu, chữ, lưới, ô giữ chỗ ảnh, thành phần, bảng ánh xạ sang theme |
| `assets/css/tokens.css` | Biến CSS — màu, chữ, lưới, bo góc (= 0), 8 dải gradient ô giữ chỗ ảnh |
| `assets/css/base.css` | Reset, chữ nền, khung `.wraper`, `.body-grid`, `.col-*` |
| `assets/css/components.css` | Thành phần dùng lại: măng sét, menu, đường dẫn, panel, mẫu tin, hộp bản tin, chân trang |
| `assets/css/page-home.css` | Riêng trang chủ: tin nổi bật dọc, lưới 2 tin phụ |
| `assets/css/page-category.css` | Riêng trang chuyên mục: tiêu đề mục, tab chuyên mục con, tin nổi bật ngang |
| `assets/css/page-article.css` | Riêng trang chi tiết: sapo, thân bài, trích dẫn, bình luận |
| `assets/css/page-mobile.css` | Riêng bản di động — gồm cả rule giả khung 390px của trang xem mẫu |
| `assets/css/page-design-system.css` | Riêng trang hệ thống thiết kế |

Thứ tự nạp CSS bắt buộc trong mọi trang: `tokens` → `base` → `components` →
`page-*`.

## Giữ gì, đổi gì so với bộ 1 và bộ 2

Giữ nguyên ở cả ba bộ: `.wraper` 1080px, lưới 24 cột, bố cục `left-main-right`
(210/555/255px) và `main-right` (795/255px), chuỗi khung
`.section-header-bar` → `#header`+`.logo`+`.right-ads` → `.section-nav` →
`.third-nav` → `.body-grid` → `#footer` + `.footerNav2`, cấu trúc khối
`panel` → `panel-heading` → `panel-body`.

Đổi so với cả hai bộ trước:

- **Không bám theme default** (khác bộ 1) và **không chỉ đổi lớp nhìn trên
  cấu trúc cũ** (khác bộ 2) — đây là hướng thiết kế hoàn toàn mới, giá trị lấy
  từ artboard đã chốt, không phải từ `themes/default`.
- **Bo góc = 0** ở mọi nơi (bộ 1: 4px Bootstrap, bộ 2: 18px). Thay vào đó dùng
  kẻ đôi (viền trên 3px + viền dưới 1px mực) giữa măng sét và menu, gạch chân
  2px mực dưới đầu khối, viền chấm 1px giữa các dòng danh sách.
- **Màu**: nền giấy `#f7f3ea`, mực `#14110d`, đỏ nhấn `#a8231c`, vàng đồng
  `#d8b26a` — thay hẳn xanh của bộ 1 và tím/san hô/bạc hà của bộ 2.
- **Chữ**: `Playfair Display` (tiêu đề) + `Noto Serif` (thân bài), nạp bằng
  `<link rel="stylesheet">` tới Google Fonts trong `<head>` mỗi trang — khác
  cách `giaodienmau2` nạp font bằng `@import` trong `tokens.css`. Cả hai cách
  đều hợp lệ; bộ này chọn `<link>` để trình duyệt tải font song song với CSS.
- **Ảnh**: ô giữ chỗ dải chuyển màu sepia (8 biến thể `--nt-ph-1`…`--nt-ph-8`,
  xem mục 5 của `design-system.html`) thay cho ô đơn sắc của bộ 1 và ảnh thật
  của bộ 2.
- **Menu**: chữ hoa dãn chữ rộng, mục đang chọn gạch chân đỏ 2px — khác navbar
  chữ nhật của bộ 1 và viên thuốc bo tròn của bộ 2.
- **Nội dung riêng, không có ở hai bộ trước**: măng sét kiểu "số báo" (kỳ báo,
  giá bán) ở đầu trang chủ/chuyên mục/chi tiết; khối "Góc nhìn" (bình luận
  cộng tác viên, 4 thẻ) ở cuối trang chủ, ánh xạ sang vị trí `[BOTTOM]`.

Bảng so sánh đầy đủ ở mục 1 của `design-system.html`.

## Nguồn giá trị thiết kế

Toàn bộ màu, cỡ chữ, khoảng cách, chiều cao chép nguyên từ hai artboard đã
chốt và đã rà soát của hướng A:

- Bản desktop 1080px — `Main.dc.html`
- Bản điện thoại 390px — `MobileA.dc.html`

Hai file này là Design Component (`.dc.html`); phần lấy giá trị là markup +
style nội tuyến bên trong, bỏ qua `<script src="./support.js">`, `<x-dc>`,
`<helmet>`. Không làm tròn về lưới 4/8px, không tự nghĩ giá trị mới — mọi mã
màu, cỡ chữ, giãn dòng trong `tokens.css`/`components.css` đều có nguồn từ hai
file trên. Riêng khung NukeViet (lưới 1080px/24 cột, chuỗi khối, cấu trúc
panel) lấy từ `references/khung-nukeviet.md`, không phải từ artboard.

## Ảnh

Không có ảnh thật. Mọi vị trí ảnh trong artboard được vẽ lại bằng `<div>` ô
giữ chỗ (`.ph`), tô bằng 8 dải chuyển màu sepia lấy nguyên từ artboard (không
tải ảnh từ mạng, không dùng ảnh thật). Vì là `<div>`, các ô này không cần
thuộc tính `alt`.

## Nội dung mẫu

Tiêu đề, sapo và nội dung bài chi tiết là nội dung mẫu, viết theo giọng của
hai artboard gốc (bản tin ngắn, khách quan, nhiều số liệu). Trang chuyên mục
và trang chi tiết là nội dung mới, viết thêm cho đủ ba trang còn lại (artboard
gốc chỉ có trang chủ và bản di động), giữ cùng chủ đề và giọng văn.

Dữ kiện cứng — hotline, email, giấy phép, tổng biên tập, địa chỉ, ngày giờ, số
liệu, giá tiền, tên người, tên phóng viên — đều để trong ngoặc vuông `[ ]` và
phải thay bằng dữ kiện thật trước khi dùng.

## Bước tiếp theo

Bộ mẫu này đã được dựng thành theme `themes/giaodienmau3` ("Nhật Trình").
Quy trình đầy đủ từ bản mẫu tĩnh tới theme chạy được:
`docs/quy-trinh-lam-giao-dien.md`. Bảng ánh xạ từng phần sang file theme nằm ở
mục 9 của `giaodienmau3/design-system.html`, đối chiếu trực tiếp với tên file
thật trong `themes/default/`.

Hai điểm bàn giao còn để ngỏ, admin cần xử lý khi đưa theme vào dùng thật:

- `themes/giaodienmau3/default.jpg` (ảnh xem trước theme trong trang quản trị)
  vẫn đang là ảnh gốc của `themes/default` — chưa thay bằng ảnh chụp giao diện
  "Nhật Trình" thật.
- Khối "Góc nhìn" ở vị trí `[BOTTOM]` không có module tương ứng sẵn trong core
  NukeViet; theme đã dựng sẵn CSS (`.section-feature` trong `components.css`)
  nhưng admin cần tự gắn một block tin (`block_news`) vào vị trí `[BOTTOM]`
  trong trang quản trị mới hiện nội dung.
