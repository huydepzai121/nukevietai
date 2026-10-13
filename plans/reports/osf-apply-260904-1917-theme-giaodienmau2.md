# Dựng theme `themes/giaodienmau2/` từ bản thiết kế `giaodienmau2/`

Ngày: 2026-09-04 · Nhánh: `nukeviet4.6`

## 1. Kết quả

Theme "Nhịp Phố" đã có đủ bộ khung nhân bản từ `themes/default` (262 mục),
`config.ini` hợp lệ, CSS và các template chính đã mang lớp nhìn mới.
Không có file nào ngoài `themes/giaodienmau2/` bị thay đổi.

## 2. File đã tạo / sửa

### Bộ khung
- `themes/giaodienmau2/**` — tạo bằng
  `.claude/skills/nukeviet-theme/scripts/scaffold-theme.mjs`
  (`--name giaodienmau2 --title "Nhịp Phố" --author "Nguyễn Thế Huy"`).
- `themes/giaodienmau2/default.jpg` — thay bằng `giaodienmau2/assets/img/hero.jpg`.

### CSS (`themes/giaodienmau2/css/`)
| File | Nguồn |
|------|-------|
| `tokens.css` | chép nguyên `giaodienmau2/assets/css/tokens.css`, giữ `@import` Be Vietnam Pro |
| `base.css` | từ `assets/css/base.css`, đã bỏ phần khung/lưới (xem mục 3) |
| `components.css` | từ `assets/css/components.css`, viết lại bộ chọn theo markup thật (xem mục 3) |
| `gd2-responsive.css` | từ `assets/css/page-mobile.css`, gói trong `@media (max-width: 767px)` |
| `news.css` | `themes/default/css/news.css` + `page-home.css` + `page-article.css` + phần điều chỉnh |

- `themes/giaodienmau2/theme.php` — thêm 4 khai báo CSS (`tokens` → `base` →
  `components` → `gd2-responsive`) ngay trước `custom.css` trong `nv_site_theme()`.
  Không khai báo `news.css`: core tự nạp theo tên module
  (`includes/core/user_functions.php:672`).

### Layout (`themes/giaodienmau2/layout/`)
- `header_extended.tpl` — thanh trên dải màu, ô dấu gradient + logo +
  `{SITE_DESCRIPTION}`, `[HEAD_RIGHT]`, `[MENU_SITE]`, hàng breadcrumb +
  `{NV_CURRENTTIME}` + ô tìm kiếm dạng viên thuốc.
- `footer_extended.tpl` — chân trang nền `#17153b` 4 cột (`col-md-6` × 4) +
  `.footerNav2` có `.inner`.
- `block.default.tpl`, `block.primary.tpl` — thẻ bo 18px, `panel-heading` có
  `<span class="bar"></span>` trước `{BLOCK_TITLE}`, thêm `id="block-{BLOCK_ID}"`.
- `layout.left-main-right.tpl` và các `layout.*.tpl` khác, `header_only.tpl`:
  **giữ nguyên** — cấu trúc cột 5/13/6 và các `[TAG]` đã đúng, không cần đổi.

### Template module (`themes/giaodienmau2/modules/`)
- `news/detail.tpl` — h1, byline (avatar + tác giả/nguồn + thời gian + nút gửi
  mail/in/lưu), sapo, figure + chú thích, thân bài, từ khóa dạng `.tag`,
  nút chia sẻ, tin liên quan dạng lưới.
- `news/block_newscenter.tpl` — ảnh lớn phủ tiêu đề (`.hero-photo`) + 3 tin phụ
  (`.sub-grid`).
- `news/block_news.tpl` — `.side-list`; `news/block_tophits.tpl` — `.hot-list`
  có số thứ tự; `news/block_category.tpl` — `.cat-list` có chấm màu.
- `news/block_headline.tpl` — chỉ thêm class `.thumb` / `.side-list`, giữ nguyên
  id và JS của slider/tabs.
- `news/viewcat_list.tpl` (`.cat-line`), `viewcat_page.tpl` (`.news-item`),
  `viewcat_grid.tpl` (`.card`).
- `comment/main.tpl`, `comment/comment.tpl` — đầu khối có thanh màu, ô nhập
  `.comment-box`, hàng nút `.comment-actions`, avatar bo tròn.
- Các tpl module còn lại giữ nguyên bản nhân bản từ `default`.

## 3. Quyết định kỹ thuật

1. **`base.css` bỏ `.wraper`, `.body-grid`, `.col-*`.** Bản tĩnh tự dựng lưới
   bằng flex; theme thật dùng lưới Bootstrap 24 cột và `.wraper` do
   `css/style.css` + `css/style.responsive.css` điều khiển. Nếu giữ
   `.wraper { width: 1080px }` thì nó nạp sau `style.responsive.css` và phá
   phần thu hẹp ở dải 768–1199px.
2. **`base.css` đổi `img { display: block }` thành `img { max-width: 100% }`.**
   `display: block` toàn cục làm hỏng ảnh nội tuyến trong thân bài và bình luận;
   chỗ nào cần block thì đặt trên `.thumb`, `.hero-photo img`, `.figure.center img`.
3. **`components.css` viết lại bộ chọn menu.** `[MENU_SITE]` là block do
   `modules/menu/global.bootstrap.tpl` sinh ra
   (`div.navbar > div.navbar-collapse > ul.nav.navbar-nav`), không phải
   `ul.navbar` của bản tĩnh. Bộ chọn `.navbar` của bản tĩnh sẽ trúng nhầm thẻ
   bọc của Bootstrap. Đã đổi sang `#menusite .navbar-nav > li > a` v.v., giữ
   nguyên giá trị màu/bo/cỡ chữ của thiết kế. Ô tìm kiếm cũng vậy: bám
   `.headerSearch .input-group`, `.form-control`, `.btn-info`.
4. **`news.css` giữ lại toàn bộ `themes/default/css/news.css`** rồi mới nối phần
   thiết kế. Các tpl module news chưa đổi (print, topic, search, viewcat_top…)
   vẫn cần bộ style gốc; xóa đi là làm hỏng chức năng.
5. **Style bình luận đặt trong `components.css`, không nằm trong `news.css`.**
   Module comment nạp `css/comment.css` chứ không nạp `news.css`; đặt ở
   `components.css` (luôn nạp) là chỗ duy nhất đúng cho mọi trang có bình luận.
6. **Bỏ hai rule chỉ dành cho bản mẫu tĩnh**: `.navbar li.active a` /
   `.navbar li:nth-child(4) a` trong `page-article.css` (giả lập trạng thái
   "đang ở chuyên mục Đô thị") và `body { max-width: 390px; border-left/right }`
   trong `page-mobile.css` (khung artboard).
7. **Số thứ tự của `.hot-list` dùng CSS counter.** XTemplate không có biến đếm
   vòng lặp, `block_tophits.tpl` không nhận số thứ tự từ PHP.
8. **`viewcat_grid.tpl` bỏ đoạn JS cân bằng chiều cao `.thumbnail`.** Thẻ mới
   dùng `.card` với `height: calc(100% - 20px)`, không cần JS.

## 4. Hạng mục chưa làm và lý do

- **Nhãn chuyên mục (`.cat-tag`) trên trang chi tiết bài viết.**
  `detail_theme()` (`modules/news/theme.php:702`) không đưa tên/liên kết chuyên
  mục vào `{DETAIL.*}`; chỉ có `catid`. Muốn có nhãn này phải sửa
  `modules/news/theme.php` hoặc `funcs/detail.php` — ngoài phạm vi của skill
  giao diện. Hiện chuyên mục vẫn hiển thị qua breadcrumb ở `header_extended.tpl`.
  Nhãn chuyên mục **có** ở các trang danh sách vì `{CAT}` sẵn có ở đó.
- **Ô quảng cáo `.ads-slot`.** Giữ lại CSS để dùng khi cần, nhưng trong theme
  các vị trí này là block `banners` thật (`[HEAD_RIGHT]`, `[LEFT]`, `[RIGHT]`),
  không chèn ô giữ chỗ vào tpl.
- **Bản di động riêng (`mobile.html`, `.tabbar`).** NukeViet dùng chung một
  theme responsive; `.m-item` và `.tabbar` đã đưa vào `gd2-responsive.css` theo
  yêu cầu nhưng chưa có tpl nào sinh ra markup đó — đây là thành phần để dùng về
  sau, không phải mã chết bắt buộc.
- **Kiểm bằng mắt trên trình duyệt (bước 7 của skill).** Chưa chạy được vì phiên
  này không có web server + CSDL NukeViet đang chạy. Cần kích hoạt theme trong
  Quản trị → Giao diện rồi kiểm 5 mục của bước 7.

## 5. Cách đã kiểm chứng

1. **Đối chiếu tpl với bản default** — script tạm (đặt ở thư mục tạm của hệ
   thống, không trong repo) so từng file `.tpl` đã sửa với file cùng tên trong
   `themes/default`: liệt kê biến `{…}`, `{FILE "…"}` và mọi cặp
   `BEGIN`/`END`. Kết quả: **15/15 file đã sửa còn đủ biến và khối, các cặp
   BEGIN/END cân bằng**, không file nào thiếu.
2. **XML `config.ini`** — `simplexml_load_file` parse thành công,
   `<name>Nhịp Phố</name>`, `<layoutdefault>left-main-right</layoutdefault>`.
3. **Vị trí block** — mọi `[TAG]` xuất hiện trong `layout/*.tpl` đều có
   `<position>` tương ứng trong `config.ini` (trừ `[THEME_ERROR_INFO]`, vốn là
   placeholder hệ thống, `themes/default` cũng vậy).
4. **PHP lint** — `php -l` (PHP 8.5.9) sạch cho `theme.php`, `config.php`,
   `config_default.php`.
5. **Phạm vi thay đổi** — `git status --short` chỉ có `themes/giaodienmau2/` là
   thư mục mới do phiên này tạo; không có file đã theo dõi nào bị sửa.
