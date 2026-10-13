---
name: nukeviet-theme
description: Dựng hoặc sửa giao diện (theme) cho NukeViet 4.x theo chuẩn thiết kế web (lưới 24 cột, breakpoint, spacing, typography, marker section, checklist) — tự tạo themes/<tên>/ từ theme có sẵn + design system, sửa layout/*.tpl, block, template module (news, comment...), khai báo CSS/JS trong theme.php và config.ini. Dùng khi người dùng nói "làm giao diện", "dựng theme", "đổi giao diện", "áp thiết kế vào NukeViet", "sửa layout/tpl", hoặc khi cần chuyển bản thiết kế tĩnh thành theme chạy được.
---

# Dựng giao diện NukeViet 4.x

Mọi đường dẫn dưới đây là đường dẫn thật trong repo này và đã được kiểm chứng.
Khi cần chi tiết cấu trúc (schema `config.ini`, danh sách tpl, danh sách vị trí
block), đọc `references/cau-truc-theme.md`. Chuẩn thiết kế (bản chuyển của
`web-design-standard` sang Bootstrap 3 / cấu trúc theme) ở
`references/chuan-thiet-ke.md` — **đọc trước khi dựng hay sửa giao diện**.

## Quy tắc gốc

1. **Không sửa trực tiếp `themes/default`.** Chính `themes/default/config.ini`
   ghi: không được xóa, đổi tên và không nên sửa trực tiếp; hãy copy thành giao
   diện khác. Mọi thay đổi đi vào theme mới.
2. **Không tự bịa cấu trúc.** Trước khi viết một tpl, mở file tương ứng trong
   `themes/default/` và đọc. Tên biến (`{BLOCK_CONTENT}`), khối
   (`<!-- BEGIN: main -->`), vị trí (`[LEFT]`) là hợp đồng với core, sai một chữ
   là trang trắng.
3. **Giữ Bootstrap 3 24 cột của NukeViet.** Không thay bằng Bootstrap 5 — core
   và tpl module viết markup BS3. Áp chuẩn bằng `css/nv-standard.css`.
4. **Không nạp `components.css` của design system tĩnh vào theme.** Nhiều tên
   class trùng markup core (`.display` trong breadcrumbs, `.label` của BS3,
   `.nav`, `.btn`…). Theme dùng token của design system + CSS viết theo markup thật.
5. **Lấy giá trị từ nguồn, không ước lượng.** Màu, cỡ chữ, khoảng cách phải chép
   đúng từ CSS hiện có hoặc từ bản thiết kế, không làm tròn về lưới 4/8px.

## Quy trình

### Bước 1 — Xác định nguồn thiết kế

Hỏi (hoặc tự tìm) bản thiết kế sẽ áp vào:

- Có sẵn bộ HTML/CSS tĩnh? Trong repo này là `giaodienmau/`, kèm hệ thống thiết kế
  ở `giaodienmau/design-system.html` (mục 7 là bảng ánh xạ sang file theme) và tài
  liệu ở `docs/giaodienmau.md`.
- Chỉ có yêu cầu bằng lời? Dựng bản tĩnh trước rồi mới làm theme — đừng vừa thiết
  kế vừa sửa tpl, sai ở đâu sẽ không biết.

Chốt trước khi code: theme nhân bản từ đâu (`default` cho web, `mobile_default`
cho bản di động riêng), tên thư mục theme, những module nào phải sửa template.

### Bước 2 — Tạo bộ khung theme (tự áp chuẩn)

```bash
node .claude/skills/nukeviet-theme/scripts/scaffold-theme.mjs   --name <ten-theme> --from <default|theme-có-sẵn>   --design-system <thư-mục-design-system>   --title "Tên hiển thị" --author "Tác giả" --root <gốc NukeViet>
```

Script:

1. Nhân bản `themes/<from>` sang `themes/<ten-theme>` (từ chối ghi đè), cập nhật `<info>` trong `config.ini`.
2. Chép `<design-system>/tokens.css` → `css/ds-tokens.css` (token `--color-*`, `--space-*`, `--text-*`…).
3. Chép `assets/nv-standard.css` → `css/nv-standard.css`: khung 1190px, gutter 20px,
   chữ 16px tỉ lệ 1.25, văn bản dài 65ch, `.nv-section`, focus, vùng chạm.
4. Khai báo hai file trên trong `theme.php` (`ds-tokens.css` trước `tokens.css` của theme
   nếu có; `nv-standard.css` ngay trước `custom.css`).
5. Chèn marker HEADER / FOOTER / BODY vào `header_extended.tpl`, `footer_extended.tpl`, `layout.*.tpl`.

`--from` một theme đã có lớp nhìn (ví dụ `giaodienmau3` — Nhật Trình) để kế thừa
toàn bộ tpl/CSS đã khớp markup thật; `--from default` khi làm lớp nhìn mới.
`--no-standard` chỉ nhân bản như cũ.

Sau đó: thay `default.jpg`, rồi gỡ các chỗ trái chuẩn mà theme nguồn mang theo
(script kiểm ở Bước 7 sẽ chỉ ra: width px cho khung/cột, cột grid bằng px…).

### Bước 3 — Đưa CSS vào

CSS của theme được nạp trong `themes/<ten-theme>/theme.php`, hàm `nv_site_theme()`
(xem `themes/default/theme.php:68`). Thứ tự nạp hiện tại:

1. `assets/css/font-awesome.min.css` (dùng chung của hệ thống)
2. `css/bootstrap.min.css` — hoặc `css/bootstrap.non-responsive.css` khi
   `current_theme_type` khác `r`
3. `css/style.css`
4. `css/style.responsive.css` — hoặc `css/style.non-responsive.css`
5. CSS do module đăng ký, rồi cuối cùng `css/custom.css`

Hai cách đưa thiết kế vào, chọn theo mức độ thay đổi:

- **Thay đổi nhỏ:** viết đè vào `css/custom.css` (nạp sau cùng nên luôn thắng).
- **Làm lại giao diện:** thêm file CSS riêng và khai báo trong `theme.php` ngay
  trước `custom.css`. Giữ nguyên `bootstrap.min.css` trừ khi bạn thay cả hệ lưới.

CSS riêng của một module phải đặt tên đúng module: `css/<tên-module>.css`
(`includes/core/user_functions.php:672` tự nạp file này khi tồn tại) — ví dụ
`css/news.css`.

Khi nguồn là `giaodienmau/`, chép `assets/css/*.css` vào `themes/<ten-theme>/css/`
và giữ nguyên thứ tự `tokens → base → components → page-*`.

### Bước 4 — Sửa layout

Trong `themes/<ten-theme>/layout/`:

| File | Vai trò |
|------|---------|
| `header_only.tpl` | `<head>`, thẻ meta, `[LINKS]`, `[JS]` — hiếm khi phải sửa |
| `header_extended.tpl` | Thanh trên, logo, menu, breadcrumb, ô tìm kiếm |
| `layout.*.tpl` | Bố cục cột, đặt các vị trí block và `{MODULE_CONTENT}` |
| `block.*.tpl` | Khung một block: `default`, `primary`, `border`, `simple`, `no_title` |
| `footer_extended.tpl`, `footer_only.tpl` | Chân trang |
| `simple.tpl` | Trang tối giản (in ấn, popup) |

Lưới của theme default là **24 cột** (BS3). Khung `.wraper` của default rộng
1080px; chuẩn nâng lên **1190px** qua `nv-standard.css`. Ví dụ
`layout.left-main-right.tpl` chia `col-md-5` / `col-md-13` / `col-md-6`. Mọi row
quan trọng khai báo tối thiểu 3 mốc `col-xs-*` / `col-sm-*` / `col-md-*`.

Khi sửa một phần ("sửa header"), chỉ sửa nội dung giữa cặp marker tương ứng và
đúng khối CSS `/* HEADER STYLES */ … /* END HEADER STYLES */`, không đụng phần khác.

Bố cục mặc định khai báo trong `config.ini` ở thẻ `<layoutdefault>`; muốn một
function dùng bố cục khác thì thêm vào `<setlayout>`.

Mỗi vị trí block dùng trong tpl **phải** có thẻ `<position>` tương ứng trong
`config.ini`, nếu không quản trị sẽ không hiện vị trí đó.

### Bước 5 — Sửa template module

Template module nằm ở `themes/<ten-theme>/modules/<tên-module>/`. Core mở chúng
bằng đường dẫn `themes/<template>/modules/<module_theme>/` (ví dụ
`modules/news/theme.php:28`). Giữ nguyên tên file; chỉ sửa nội dung.

Với site tin tức, các file hay phải sửa nhất:

- `modules/news/block_newscenter.tpl`, `block_headline.tpl`, `block_news.tpl`,
  `block_tophits.tpl`, `block_category.tpl` — trang chủ module news dựng từ block,
  không có `main.tpl`
- `modules/news/viewcat_*.tpl` — các kiểu hiển thị chuyên mục (`grid`, `list`,
  `page`, `top`, `two_column`, `main_left`, `main_right`, `main_bottom`)
- `modules/news/detail.tpl` — trang chi tiết bài viết
- `modules/news/topic.tpl`, `search.tpl`, `content.tpl`, `print.tpl` — chủ đề, tìm
  kiếm, trang nội dung, bản in
- `modules/comment/main.tpl`, `comment.tpl` — bình luận

Sửa tpl thì giữ nguyên mọi `{BIẾN}` và cặp `<!-- BEGIN: x -->` / `<!-- END: x -->`
đang có; muốn bỏ một khối thì bỏ cả cặp, không xóa nửa vời.

### Bước 6 — Block và cấu hình mặc định

Block cấp theme nằm ở `themes/<ten-theme>/blocks/` (cặp `.php` + `.tpl`, có thể
kèm `.ini`) và được khai báo trong `<setblocks>` của `config.ini` với
`<module>theme</module>`. Xem `includes/core/user_functions.php:177` cho thứ tự
tìm file.

Khung hiển thị block chọn theo thẻ `<template>`; core tìm
`layout/block.<template>.tpl` lần lượt trong theme của module → `module_theme` →
`site_theme` → `themes/default` (`includes/core/user_functions.php:188-198`).

### Bước 7 — Kích hoạt và kiểm tra

Chạy kiểm tự động trước (chỉ đọc, mã thoát 1 khi có lỗi):

```bash
node .claude/skills/nukeviet-theme/scripts/check-theme.mjs --name <ten-theme> --root <gốc NukeViet>
```

Kiểm: cặp BEGIN/END so với default, `[TAG]` có `<position>`, CSS khai báo trong
`theme.php` tồn tại và đúng thứ tự, marker đủ cặp, không width px cho khung/cột,
`<img>` có `alt`. Sau đó `php -l themes/<ten-theme>/theme.php`.

Vào **Quản trị → Giao diện**, chọn theme mới. Rồi kiểm bằng mắt, đủ 5 mục
(cộng checklist trong `references/chuan-thiet-ke.md`):

1. Trang chủ, trang chuyên mục, trang chi tiết bài viết đều lên đúng bố cục.
2. Tất cả block ở cột trái/phải hiện đủ, không vỡ khung.
3. Kiểm ở 390 · 768 · 992 · 1200px: menu, ảnh, bảng không tràn ngang; focus bàn phím hiện rõ.
4. Trang lỗi và `info_die` (`system/error_info.tpl`, `system/info_die.tpl`) vẫn đọc được.
5. Console trình duyệt không có 404 cho CSS/JS/font của theme.

## Lỗi thường gặp

- **Trang trắng sau khi sửa tpl** — sai cặp `BEGIN/END` hoặc xóa nhầm `{MODULE_CONTENT}`.
  So lại với file cùng tên trong `themes/default/`.
- **Vị trí block biến mất trong quản trị** — dùng `[TAG]` trong tpl nhưng quên khai
  báo `<position>` trong `config.ini`.
- **CSS không đổi** — quên xóa cache, hoặc file mới nạp trước `custom.css` nên bị
  đè. Kiểm thứ tự trong `theme.php`.
- **Theme không hiện trong danh sách** — thiếu `config.ini` hoặc XML sai cú pháp.
- **Sửa nhầm `themes/default`** — kiểm `git status` trước khi commit.

## Phạm vi

Skill này lo phần giao diện. Không sửa `modules/*/funcs/*.php`,
`includes/`, hay CSDL để chiều một bố cục — nếu bản thiết kế cần dữ liệu mà module
không trả về, báo lại thay vì tự đổi logic module.
