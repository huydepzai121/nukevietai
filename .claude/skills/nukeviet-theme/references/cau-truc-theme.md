# Cấu trúc theme NukeViet 4.x

Tra cứu chi tiết. Mọi mục dưới đây đọc từ `themes/default` và `includes/` của repo
này; khi nghi ngờ, mở file gốc đối chiếu.

## Cây thư mục

```
themes/<ten-theme>/
├─ config.ini            XML khai báo theme: info, layout mặc định, vị trí block, block mặc định
├─ config.json           Biến LESS của Bootstrap (chỉ dùng khi biên dịch lại bootstrap)
├─ config.php            Trang cấu hình theme trong quản trị (tùy chọn)
├─ config_default.php    Giá trị mặc định cho config.php
├─ theme.php             nv_site_theme(), nv_error_theme(), nv_mailHTML(); nơi khai báo CSS/JS
├─ default.jpg           Ảnh thumbnail hiện trong quản trị
├─ css/                  CSS của theme và của từng module
├─ js/                   JS của theme
├─ fonts/                Font đóng gói kèm theme
├─ images/               Ảnh giao diện
├─ layout/               Khung trang và khung block
├─ blocks/               Block cấp theme (.php + .tpl, có thể kèm .ini)
├─ modules/<module>/     Template của từng module
├─ system/               Trang hệ thống: lỗi, info_die, mail, config, alert
└─ language/             Ngôn ngữ riêng của theme (vi, en, fr + bản admin_*)
```

## config.ini

XML, gồm 4 nhóm:

```xml
<theme>
    <info>
        <name>Tên hiển thị</name>
        <author>Tác giả</author>
        <website>https://…</website>
        <description>Mô tả</description>
        <thumbnail>default.jpg</thumbnail>
    </info>

    <layoutdefault>left-main-right</layoutdefault>

    <positions>
        <position><name>LEFT</name><tag>[LEFT]</tag></position>
        …
    </positions>

    <setlayout>
        <layout>
            <name>left-main</name>
            <funcs>page:main</funcs>
        </layout>
    </setlayout>

    <setblocks>
        <block>
            <module>news</module>
            <file_name>global.block_category.php</file_name>
            <title>Chủ đề</title>
            <template>no_title</template>
            <position>[LEFT]</position>
            <all_func>0</all_func>
            <config>…chuỗi serialize của PHP…</config>
            <funcs>news:main,viewcat,detail</funcs>
        </block>
    </setblocks>
</theme>
```

Ghi chú:

- `<layoutdefault>` là phần đuôi của `layout.<tên>.tpl`.
- `<setlayout>` chỉ định bố cục khác cho từng `module:func`.
- `<setblocks>` là block cài sẵn khi kích hoạt theme lần đầu. `<all_func>1</all_func>`
  nghĩa là hiện ở mọi function; `0` thì phải liệt kê `<funcs>`.
- `<config>` là chuỗi `serialize()` của PHP. Đừng viết tay — lấy từ theme có sẵn
  hoặc để trống `<config/>`.
- `<module>theme</module>` trỏ tới file trong `themes/<ten-theme>/blocks/`.

## Vị trí block trong theme default

`[PERSONALAREA]` `[SOCIAL_ICONS]` `[HEAD_RIGHT]` `[CONTACT_DEFAULT]` `[MENU_SITE]`
`[MENU_FOOTER]` `[HEADER]` `[LEFT]` `[RIGHT]` `[TOP]` `[BOTTOM]` `[FOOTER]`
`[FOOTER_SITE]` `[FEATURED_PRODUCT]` `[COMPANY_INFO]` `[QR_CODE]`
`[FIX_BANNER_LEFT]` `[FIX_BANNER_RIGHT]`

Thêm vị trí mới: khai báo `<position>` trong `config.ini` rồi đặt `[TAG]` vào tpl.
Thiếu một trong hai thì vị trí không dùng được.

## layout/

| File | Vai trò |
|------|---------|
| `header_only.tpl` | Toàn bộ `<head>` + mở `<body>`; chứa `[metatags]`, `[links]`, `[js]` |
| `header_extended.tpl` | Thanh trên, logo, `[MENU_SITE]`, breadcrumb, ô tìm kiếm |
| `footer_extended.tpl` | Nội dung chân trang |
| `footer_only.tpl` | Đóng `<body>`, JS cuối trang |
| `simple.tpl` | Trang tối giản, dùng khi `nv_site_theme($contents, false)` |
| `layout.main.tpl` | 1 cột |
| `layout.left-main.tpl` | Trái + giữa |
| `layout.main-right.tpl` | Giữa + phải (18 / 6 cột) |
| `layout.left-main-right.tpl` | Trái + giữa + phải (5 / 13 / 6 cột) |
| `layout.left-right-main.tpl` | Thứ tự nguồn khác, hiển thị vẫn 3 cột |
| `layout.main-left-right.tpl` | Thứ tự nguồn khác, hiển thị vẫn 3 cột |
| `block.default.tpl` | Khung block `panel panel-default` |
| `block.primary.tpl` | Khung block `panel panel-primary` |
| `block.border.tpl` | Khung có viền |
| `block.simple.tpl` | Khung tối giản |
| `block.no_title.tpl` | Không tiêu đề |

Biến trong `block.*.tpl`: `{BLOCK_ID}`, `{BLOCK_TITLE}`, `{BLOCK_CONTENT}`,
`{TEMPLATE}`, `{NV_BASE_SITEURL}`.

Biến trong `layout.*.tpl`: `{MODULE_CONTENT}` và các `[TAG]` vị trí.

## Lưới

- `.wraper` rộng **1080px** (`css/style.css`), thu về 100% ở màn hình nhỏ
  (`css/style.responsive.css`).
- Lưới **24 cột**, dùng lớp `col-xs-*`, `col-sm-*`, `col-md-*` tới `-24`.
- Khoảng cách cột 30px (15px padding mỗi bên, `.row` bù âm 15px).

## Nạp CSS/JS

Trong `themes/default/theme.php`, hàm `nv_site_theme()` (dòng 68) dựng mảng
`$html_links` theo thứ tự:

1. `assets/css/font-awesome.min.css`
2. `css/bootstrap.min.css` hoặc `css/bootstrap.non-responsive.css`
3. `css/style.css`
4. `css/style.responsive.css` hoặc `css/style.non-responsive.css`
5. `css/admin.css` (chỉ khi đang đăng nhập quản trị)
6. CSS do module/hệ thống đăng ký qua `nv_html_links()`
7. `css/custom.css` — nạp sau cùng nên luôn ghi đè
8. CSS sinh từ trang cấu hình theme, và Google Font nếu có cấu hình

`$global_config['current_theme_type'] == 'r'` là chế độ responsive; khác `r` thì
dùng bộ non-responsive và không chèn thẻ meta viewport.

CSS riêng của module: đặt `css/<tên-module>.css`, core tự nạp khi file tồn tại
(`includes/core/user_functions.php:672`).

## Template module

Core mở template module tại
`themes/<$module_info['template']>/modules/<$module_info['module_theme']>/`
(ví dụ `modules/news/theme.php:28`). Vì vậy tên thư mục trong `themes/<theme>/modules/`
phải trùng tên module gốc.

Danh sách module có template trong theme default: `banners`, `comment`, `contact`,
`feeds`, `freecontent`, `menu`, `news`, `page`, `seek`, `statistics`,
`two-step-verification`, `users`, `voting`.

Template của module news:

```
block_category  block_content  block_groups  block_headline  block_new_comment
block_news      block_newscenter  block_tophits
content  detail  print  search  sendmail  topic
viewcat_grid  viewcat_list  viewcat_page  viewcat_top  viewcat_two_column
viewcat_main_bottom  viewcat_main_left  viewcat_main_right
```

Module news **không có** `main.tpl`: trang chủ của module dựng từ các block.

## Thứ tự tìm khung block

`includes/core/user_functions.php:188-198` — core tìm `layout/block.<template>.tpl`
lần lượt trong:

1. `themes/<$module_info['theme']>/layout/`
2. `themes/<$global_config['module_theme']>/layout/`
3. `themes/<$global_config['site_theme']>/layout/`
4. `themes/default/layout/`

Không tìm thấy thì block hiện dưới dạng tiêu đề + nội dung trần.

## Trang hệ thống

`system/error_info.tpl`, `system/info_die.tpl`, `system/alert.tpl`,
`system/config.tpl`, `system/mail.tpl`, `system/admin_toolbar.tpl`.

Core dò theo thứ tự riêng cho từng trang:

- `error_info.tpl`: `admin_theme` (khi đang ở khu quản trị) → `site_theme` → default
  (`includes/core/theme_functions.php:97-110`)
- `info_die.tpl`: `admin_theme` → `themes/admin_default` → `module_theme` →
  `site_theme` → default (`includes/core/theme_functions.php:176-190`)

Nhân bản đủ thư mục `system/` là cách chắc chắn nhất để không rơi vào theme khác.

## Cú pháp XTemplate

- Biến: `{TEN_BIEN}`, mảng: `{MANG.khoa}`
- Khối lặp / khối điều kiện: `<!-- BEGIN: ten -->` … `<!-- END: ten -->`
- Nhúng file khác: `{FILE "header_only.tpl"}`
- Khối lồng nhau đặt tên theo đường dẫn khi parse: `main.metatags`, `main.loop`

Xóa hoặc đổi tên một khối mà PHP đang `parse()` sẽ gây lỗi; xóa thì phải xóa cả
cặp `BEGIN`/`END` và không đụng vào lời gọi trong PHP của module.
