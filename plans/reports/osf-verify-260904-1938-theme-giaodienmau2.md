# Kiểm tra độc lập theme `themes/giaodienmau2/` ("Nhịp Phố")

Ngày: 2026-09-04 · Nhánh: `nukeviet4.6` · Chế độ: CHỈ ĐỌC (không sửa file nào)

Phạm vi kiểm: `themes/giaodienmau2/**`. Có đọc `themes/default/**`,
`includes/core/user_functions.php`, `giaodienmau2/assets/css/**` để đối chiếu,
không sửa.

Script kiểm đặt ngoài repo:
`C:/Users/Admin/AppData/Local/Temp/claude/D--Dev-www-nukeviet/97470455-ce60-469c-920d-1605b7b4defb/scratchpad/chk.js`
và `.../check-classes.js`.

---

## A. Toàn vẹn template — ĐẠT

Quét toàn bộ 117 file `.tpl` trong theme. 15 file khác bản `themes/default`:

```
layout/block.default.tpl      layout/block.primary.tpl
layout/footer_extended.tpl    layout/header_extended.tpl
modules/comment/comment.tpl   modules/comment/main.tpl
modules/news/block_category.tpl    block_headline.tpl    block_news.tpl
modules/news/block_newscenter.tpl  block_tophits.tpl     detail.tpl
modules/news/viewcat_grid.tpl      viewcat_list.tpl      viewcat_page.tpl
```

**A.1 Biến `{TÊN}` / `{MẢNG.khóa}` / `{FILE "..."}`** — không file nào mất biến so
với bản default. Chỉ có biến được THÊM:

| File | Biến thêm | Nguồn gán | Kết luận |
|------|-----------|-----------|----------|
| `layout/block.default.tpl`, `layout/block.primary.tpl` | `BLOCK_ID` | `includes/core/user_functions.php:202` (`$xtpl->assign('BLOCK_ID', $_row['bid'])`, gán vô điều kiện cho mọi block) | Hợp lệ |
| `layout/footer_extended.tpl` | `NV_SITE_NAME`, `NV_SITE_COPYRIGHT` | `themes/giaodienmau2/theme.php:100-101`, trong `nv_site_theme()` — cùng đối tượng XTemplate parse `footer_extended.tpl` qua `{FILE ...}` | Hợp lệ |

**A.2 Cân bằng `BEGIN`/`END`** — mọi file đã sửa đều cân bằng và trùng tên.

Bộ dò báo lệch ở 4 file: `modules/statistics/main.tpl`, `modules/statistics/referer.tpl`,
`modules/two-step-verification/config.tpl`, `modules/two-step-verification/main.tpl`.
Đã đối chiếu bằng `diff`: cả 4 **giống hệt** bản `themes/default` (đây là mẫu lồng
khối vốn có của NukeViet mà bộ dò phẳng của tôi hiểu sai), không phải lỗi do bước dựng.

**A.3 Bỏ khối nửa vời** — không có. Mọi tên khối `BEGIN` có trong bản default đều
còn trong bản mới (kiểm bằng tập hợp tên khối, không chỉ đếm).

**A.4 `{MODULE_CONTENT}` trong `layout/*.tpl`** — cả 7 file `layout.*.tpl` **không bị
sửa** (không có trong danh sách khác biệt), nên `{MODULE_CONTENT}` nguyên vẹn.

---

## B. Vị trí block — ĐẠT

`[TAG]` trong `themes/giaodienmau2/layout/*.tpl` (19 tag) so với 18 `<position><tag>`
trong `config.ini`. Chênh đúng một tag: `[THEME_ERROR_INFO]`
(`layout/header_extended.tpl:92`).

Đây **không** phải vị trí block: nó được thay bằng `str_replace` trong
`themes/giaodienmau2/theme.php:397`
(`$sitecontent = str_replace('[THEME_ERROR_INFO]', nv_error_info(), $sitecontent);`),
đúng như `themes/default/theme.php:379` và `themes/mobile_default/theme.php:274`.

Danh sách `<tag>` trong `config.ini` **giống hệt** bản default (diff rỗng). Không
thiếu vị trí nào.

---

## C. `config.ini` — ĐẠT

- `simplexml_load_file()` parse thành công.
- `<info><name>` = `Nhịp Phố` ✔
- `<info><author>` = `Nguyễn Thế Huy`
- `<layoutdefault>` = `left-main-right` → `themes/giaodienmau2/layout/layout.left-main-right.tpl` tồn tại ✔
- Khác bản default đúng 3 dòng: `name`, `author`, `description`.

---

## D. CSS

**D.1 Năm file có mặt** ✔ — `css/tokens.css` (53 dòng), `css/base.css` (71),
`css/components.css` (1055), `css/gd2-responsive.css` (219), `css/news.css` (1039).

**D.2 Khai báo trong `theme.php`** ✔ — `theme.php` chỉ khác bản default đúng 18 dòng
thêm vào (dòng 173-190): `tokens.css`, `base.css`, `components.css`,
`gd2-responsive.css`. **Không** khai báo `news.css`.

Đã đọc lại cơ chế nạp: `includes/core/user_functions.php`, hàm `nv_html_css()`
(dòng ~669-690):

```php
if (file_exists(NV_ROOTDIR . '/themes/' . $module_info['template'] . '/css/' . $module_info['module_theme'] . '.css')) { ... }
if (file_exists(NV_ROOTDIR . '/themes/' . $module_info['template'] . '/css/' . $module_file . '.css')) { ... }
```

Kết luận: **`news.css` CÓ được nạp, nhưng chỉ trên trang thuộc module news**
(`$module_file` = `news`). Trên trang của module khác thì không. Xem phát hiện
MAJOR-1 bên dưới.

Thứ tự nạp: `nv_html_css()` đi qua `$my_head`, được chèn ngay trước `</head>`
(`theme.php:400-401`), tức là **sau** `$html_links`. Vậy `news.css` đè được
`components.css` — đúng ý đồ.

**D.3 Trước `custom.css`** ✔ — 4 khai báo ở dòng 175-190, `custom.css` ở dòng 191-193.

**D.4 Rule của bản mẫu tĩnh** ✔ — không tìm thấy `max-width: 390px`, không có viền
giả khung điện thoại, không có `nth-child` nào trong 5 file. `body` chỉ được định
nghĩa một lần (`base.css:9`) với `background/color/font`, không có `max-width`.
Ghi chú ở đầu `gd2-responsive.css` nói rõ đã bỏ phần artboard 390px.

**D.5 `gd2-responsive.css` bọc `@media`** ✔ — đúng một `@media (max-width: 767px)`
mở ở dòng 10, không có rule nào (không có `{`) trước đó ngoài comment; file kết
thúc bằng `}` đóng media.

**D.6 Cú pháp** ✔ — ngoặc nhọn cân bằng ở cả 5 file:
`tokens 1/1`, `base 10/10`, `components 139/139`, `gd2-responsive 37/37`, `news 173/173`.

---

## E. PHP — ĐẠT

`php -l` (PHP 8.5.9) cho toàn bộ **17** file `.php` trong `themes/giaodienmau2/`
(`theme.php`, `config.php`, `config_default.php`, `blocks/*.php`): **không lỗi cú pháp**.

Bổ sung: `config.json` là JSON hợp lệ (`json_decode` != null).

---

## F. Phạm vi và vệ sinh — ĐẠT

**F.1** `git status --short`:

```
?? .claude/
?? docs/
?? giaodienmau/
?? giaodienmau2/
?? plans/
?? themes/giaodienmau2/
```

Không có file đã theo dõi nào bị sửa (`M`), xóa (`D`) hay đổi tên. Chỉ các thư mục
mới đã biết.

**F.2** Không có `*.bak`, `*.orig`, `*.tmp`, `*.log`, `*~`, `*.js.map`, không có
`node_modules/` trong theme.

**F.3** `themes/default/**` không bị đổi — `git status --short themes/default` rỗng.

Số file: `themes/giaodienmau2` 240, `themes/default` 236 — chênh đúng 4 file CSS mới.

---

## G. Đúng thiết kế — ĐẠT

`diff giaodienmau2/assets/css/tokens.css themes/giaodienmau2/css/tokens.css` **rỗng** —
bộ token chép nguyên vẹn từ bản tĩnh:

- `--bg: #f7f5ff`, `--ink: #17153b`, `--violet: #6b4eff`, `--coral: #ff6a4d`,
  `--mint: #12bfa0` ✔ (đủ 5 màu đề bài nêu)
- `--sans: 'Be Vietnam Pro', ...` ✔
- `--radius-card: 18px` ✔

Thanh màu trong `panel-heading` ✔ — `components.css:420` `.panel-heading .bar`
(4×17px, bo tròn, nền `--violet`); `components.css:465`
`.panel-primary .panel-heading .bar` đổi sang `--coral`. Markup tương ứng có ở
`layout/block.default.tpl:4` và `layout/block.primary.tpl:4`
(`<span class="bar"></span>` + `<h3>{BLOCK_TITLE}</h3>`).

Dải màu thanh trên cùng `components.css:14`
`linear-gradient(90deg, #6b4eff 0%, #a24bf0 52%, #ff6a4d 100%)` khớp
`giaodienmau2/assets/css/components.css:13`.

---

## DANH SÁCH PHÁT HIỆN

### CRITICAL — không có

### MAJOR

**MAJOR-1 — `block_newscenter.tpl` mất lớp nhìn khi trang chủ không phải module news**

`themes/giaodienmau2/modules/news/block_newscenter.tpl` dùng 5 class **mới** do bước
dựng đặt ra: `hero-photo`, `cap`, `shade`, `sub-grid`, `sub-item`. Cả 5 chỉ được
định nghĩa trong `themes/giaodienmau2/css/news.css` (ví dụ `.hero-photo` ở
`css/news.css:582`), **không** có trong `components.css`/`base.css`/`style.css`.

Đã xác nhận cả 5 là class mới: `grep` trong `themes/default/modules/news/block_*.tpl`
và `themes/default/css/news.css` đều trả 0.

`block_newscenter` là block toàn cục, thường được đặt ở `[TOP]`/`[LEFT]` của trang
chủ. Theo `nv_html_css()`, `news.css` chỉ nạp khi `$module_file == 'news'`. Nếu
module trang chủ là `page`, `contact`… thì block hiển thị **không có style**: ảnh
lớn không phủ tiêu đề, 3 tin phụ không xếp lưới.

Đề xuất (KHÔNG thực hiện ở bước này): chuyển 5 khối rule đó từ `css/news.css` sang
`css/components.css` — `components.css` được `theme.php` nạp trên mọi trang.

Lưu ý phân biệt: `lastest-news`, `hot-news-others` cũng chỉ nằm trong `news.css`,
nhưng đó là hạn chế **có sẵn** của `themes/default`, không do bước dựng gây ra.

### MINOR

**MINOR-1 — `.logo-text` không có style**
`themes/giaodienmau2/layout/header_extended.tpl:34` thêm `<div class="logo-text">`
bọc logo + `{SITE_DESCRIPTION}`. Class này không xuất hiện ở bất kỳ file CSS nào
trong theme. Là `div` block bình thường nằm trong `#header .logo` (flex,
`components.css:127`) nên vẫn hiển thị đúng, nhưng đây là class thừa hoặc là style
bị bỏ sót.

**MINOR-2 — `config.json` vẫn giữ bảng màu Bootstrap của bản default**
`themes/giaodienmau2/config.json` giống hệt bản default: `"@brand-primary": "#428bca"`.
Chỉ ảnh hưởng nếu ai đó biên dịch lại `bootstrap.min.css` từ LESS trong khu quản
trị — khi đó màu sinh ra sẽ lệch với `--violet: #6b4eff`. Không ảnh hưởng lúc chạy.

**MINOR-3 — Font nạp qua `@import` Google Fonts**
`themes/giaodienmau2/css/tokens.css:10` dùng
`@import url('https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro...')`.
`@import` chặn render (trình duyệt phải tải xong `tokens.css` mới bắt đầu tải font)
và phụ thuộc mạng ngoài. Theme đã có sẵn `themes/giaodienmau2/fonts/` để host cục bộ.
Cân nhắc chuyển sang `<link rel="preconnect">`/`$html_links` hoặc `@font-face` cục bộ.

**MINOR-4 — `{NV_SITE_COPYRIGHT}` có thể trùng lặp nội dung**
`layout/footer_extended.tpl` thêm `<span>{NV_SITE_COPYRIGHT}</span>` ở
`.footerNav2 .inner`. Nếu quản trị viên đã đặt block bản quyền
(`blocks/global.copyright.php`) ở `[FOOTER_SITE]` thì dòng bản quyền xuất hiện hai
lần. Là lựa chọn thiết kế, cần người dùng xác nhận.

---

## KHÔNG KIỂM ĐƯỢC

1. **Hiển thị thực tế.** Không có web server + CSDL NukeViet đang chạy nên không
   render được trang nào. Mọi kết luận về CSS là phân tích tĩnh: đối chiếu bộ chọn
   với markup trong `.tpl`, không phải nhìn kết quả.
2. **Trang quản trị / danh sách vị trí block.** Không xác nhận được các
   `<position>` thật sự hiện ra trong khu quản trị; chỉ đối chiếu được `config.ini`
   với `[TAG]` trong layout.
3. **Bộ chọn menu.** Báo cáo dựng nói đã đổi bộ chọn theo
   `modules/menu/global.bootstrap.tpl`. Tôi kiểm được là bộ chọn `#menusite .navbar-nav`
   tồn tại trong `components.css`, nhưng không kiểm được menu thật render ra HTML gì
   (phụ thuộc cấu hình block menu trong CSDL).
4. **Hiệu lực cascade thực tế.** Đã suy ra thứ tự nạp từ mã nguồn
   (`$html_links` → `$my_head` chèn trước `</head>`) nhưng không đo được bằng trình duyệt.
5. **Các module chưa đổi tpl** (banners, contact, users, voting, seek, page,
   freecontent, statistics, feeds, two-step-verification) giữ nguyên bản nhân bản từ
   `default`; chúng dùng CSS gốc, tôi không đánh giá mức độ hài hòa với lớp nhìn mới
   vì không render được.
6. **Ảnh `default.jpg`.** Chỉ xác nhận file khác bản default, không đánh giá được
   nội dung ảnh xem trước có đúng theme không.

---

```
Status: DONE_WITH_CONCERNS
Summary: Theme chạy được — template toàn vẹn (không mất biến, không lệch BEGIN/END),
config.ini hợp lệ và đủ vị trí block, PHP/CSS không lỗi cú pháp, gd2-responsive bọc
đúng @media, không có file ngoài phạm vi bị sửa, lớp nhìn khớp bản thiết kế. Một vấn
đề mức MAJOR: 5 class mới của block_newscenter chỉ nằm trong news.css nên block này
mất style khi trang chủ không thuộc module news.
CRITICAL: 0 — không có
MAJOR: 1
```
