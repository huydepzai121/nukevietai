# Kiểm tra vòng 2 — theme `themes/giaodienmau2/`

- Ngày: 2026-09-04
- Phạm vi: `themes/giaodienmau2/**` (chỉ đọc, không sửa file nào)
- Bối cảnh: kiểm lại sau vòng sửa chạm 3 file `css/news.css`, `css/components.css`, `layout/header_extended.tpl`

## A. Vòng sửa có đúng và đủ không

**A1 — news.css không còn rule của 5 class: ĐẠT**
`grep` cho 5 class (`hero-photo`, `sub-grid`, `cap`, `shade`, `sub-item`) trong `themes/giaodienmau2/css/news.css` chỉ trả về đúng một dòng chú thích:
- `css/news.css:581-582` — `/* Khối tin nổi bật (.hero-photo, .sub-grid) do block_newscenter dùng — là block toàn cục nên các rule của nó nằm ở css/components.css. */`

Không còn khối rule nào.

**A2 — components.css có đủ rule, giá trị nguyên văn: ĐẠT**
15 rule nằm ở `css/components.css:1058-1156`, dưới tiêu đề chú thích `1058-1063`. Đối chiếu từng dòng với nguồn gốc `giaodienmau2/assets/css/page-home.css:6-64`:

| Selector | components.css | page-home.css | Khớp |
|---|---|---|---|
| `.hero-photo` | 1065 | 7 | có |
| `.hero-photo img` | 1069 | 11 | có (`width:100%; height:310px; object-fit:cover`) |
| `.hero-photo .shade` | 1075 | 17 | có (gradient `rgba(15,13,40,.88/.55/0)`, `height:190px`) |
| `.hero-photo .cap` | 1087 | 29 | có (`left/right:22px; bottom:20px`) |
| `.hero-photo h2` | 1094 | 36 | có (`#ffffff; 27px; margin:12px 0 0`) |
| `.hero-photo .cap .meta` | 1100 | 42 | có (`rgba(255,255,255,.82)`) |
| `.sub-grid` | 1105 | 47 | có (`repeat(3, minmax(0,1fr)); gap:16px; padding:18px`) |
| `.sub-grid img` | 1112 | 54 | có (`100%/96px`) |
| `.sub-grid h3` | 1117 | 59 | có (`14px; margin-top:10px`) |
| `.sub-grid h3 a` | 1122 | 64 | có (`var(--ink)`) |

5 rule bổ sung (do vòng dựng theme thêm cho markup thật của block, không có trong bản tĩnh) vẫn còn nguyên: `.hero-photo a` (1127), `.hero-photo img` bản ghi đè (1131), `.hero-photo .cap .hometext` (1138), `.hero-photo .cap .meta a, .hero-photo .cap h2 a` (1148), `.sub-grid .sub-item .thumb` (1153). Không lệch giá trị màu/kích thước/khoảng cách.

**A3 — không trùng lặp: ĐẠT**
`grep -l` trên toàn bộ `css/*.css` cho `hero-photo|sub-grid|.sub-item|.shade` chỉ trả `components.css` (rule) và `news.css` (chú thích). Không file CSS nào khác của theme khai báo lại.

**A4 — thứ tự cascade: ĐẠT**
`.hero-photo img` xuất hiện hai lần: bản gốc ở `components.css:1069`, bản ghi đè (thêm `display: block`) ở `components.css:1131` — vẫn nằm sau. Thứ tự tương đối 10 rule gốc giống hệt `page-home.css`.

**A5 — ngoặc nhọn cân bằng: ĐẠT**
Đếm ký tự (chạy trong shell, không tạo file trong repo):
- `news.css` 158 `{` / 158 `}`
- `components.css` 154 / 154
- `tokens.css` 1 / 1, `base.css` 10 / 10, `gd2-responsive.css` 37 / 37

Không có rule cụt; đoạn cuối `components.css` kết thúc đúng ở `.sub-grid .sub-item .thumb {…}`.

## B. Vấn đề gốc đã hết chưa

Cơ chế nạp: `includes/core/user_functions.php:668-696` (`nv_html_css`) chỉ nạp `themes/<theme>/css/<module_theme>.css` hoặc `<module_file>.css`. Nghĩa là `css/news.css` chỉ được nạp khi trang đang xem thuộc module news — kết luận vòng trước đúng.

Danh sách class trích từ 5 block toàn cục trong `themes/giaodienmau2/modules/news/` và nơi có rule:

| Class | File có rule | Kết luận |
|---|---|---|
| `hero-photo`, `sub-grid`, `sub-item`, `cap`, `shade`, `hometext`, `meta` | components.css | đạt |
| `thumb` | components.css:504, 550, 659, 1153 (+ gd2-responsive) | đạt |
| `news_column` | components.css:511 (+ news.css cho trang chi tiết) | đạt |
| `side-list`, `hot-list`, `cat-list`, `num`, `txt`, `dot`, `has-img`, `block_news`, `block_tophits` | components.css (+ gd2-responsive) | đạt |
| `panel`, `panel-default`, `row`, `col-md-12`, `pull-left`, `clearfix`, `list-none`, `img-thumbnail`, `img-responsive`, `text-justify` | bootstrap.min.css / style.css (nạp toàn cục) | đạt |
| `sidebar`, `sidebar-nav`, `metismenu`, `arrow` | jquery.metisMenu.css / bootstrap | đạt |
| `contentdiv`, `sliderwrapper`, `slider-pagination`, `tabs` | contentslider.css / jquery.ui.tabs.css | đạt |
| `icon_new`, `margin_image` | style.css | đạt |
| `lastest-news` (block_headline) | chỉ news.css | MINOR — hạn chế sẵn có, `themes/default/css/news.css:16-33` cũng vậy |
| `hot-news-others` (block_newscenter) | chỉ news.css | MINOR — như trên, `themes/default/css/news.css:141-153` |
| `thumb-link`, `expand`, `show` | không có rule riêng trong theme | không phải hồi quy; `show`/`thumb-link` là hook JS/tooltip, `themes/default` cũng không style |

Ghi chú về `hot-news-others`: các rule còn lại trong `css/news.css:141-153` là `#hot-news .hot-news-others ul {...}`, nhắm vào thẻ `ul` mà markup `block_newscenter.tpl` không hề dùng (block dùng `div.sub-item`). Nên trên thực tế block không mất gì khi news.css vắng mặt.

Không class nào của 5 block phụ thuộc rule chỉ-có-trong-news.css theo cách làm mất style. **Vấn đề MAJOR vòng trước đã hết.**

## C. Template

`themes/giaodienmau2/layout/header_extended.tpl` so với `themes/default/layout/header_extended.tpl`:
- Tập biến `{...}`: `diff` tập hợp đã sắp xếp → rỗng (giống hệt).
- Tập `[X]` (position của theme): `diff` rỗng — `[CONTACT_DEFAULT]`, `[SOCIAL_ICONS]`, `[PERSONALAREA]`, `[HEAD_RIGHT]`, `[MENU_SITE]`, `[THEME_ERROR_INFO]` đủ.
- `{FILE "..."}`: cả hai file đều không có — khớp.
- Cặp block: `diff` danh sách `BEGIN:` rỗng; đếm 5 `BEGIN:` / 5 `END:` — cân bằng (`site_name_h1`, `site_name_span`, `breadcrumbs`, `loop`, `currenttime`).
- `logo-text`: `grep -rn "logo-text\|logo_text" themes/giaodienmau2/` → không có kết quả nào (CSS, JS, tpl). Thẻ `<div>` bao logo vẫn còn ở `header_extended.tpl:33-42`.

**ĐẠT.**

## D. Không hồi quy

1. `theme.php:173-195` — khai báo đúng 4 file theo thứ tự `tokens.css` (177) → `base.css` (181) → `components.css` (185) → `gd2-responsive.css` (189), rồi `custom.css` (193). Không khai báo `news.css`; có chú thích giải thích ở dòng 174. **ĐẠT.**
2. `css/gd2-responsive.css` — chỉ một `@media (max-width: 767px)` mở ở dòng 10, đóng ở dòng 219 (dòng cuối); không có `}` nào ở cột 0 giữa chừng. **ĐẠT.**
3. `config.ini` — là XML (không phải INI); `simplexml_load_file` parse sạch, root `theme`, `info/name` = `Nhịp Phố`, `layoutdefault` = `left-main-right`. **ĐẠT.**
4. `php -l` trên mọi `.php` trong theme (`theme.php`, `config.php`, `config_default.php`, `system/*`, `language/*`, `modules/*`) — không lỗi cú pháp. **ĐẠT.**
5. Rule bản mẫu tĩnh — `grep` `max-width: *390px`, `390px`, `nth-child` trên `tokens/base/components/news/gd2-responsive` chỉ trả một dòng **chú thích** ở `gd2-responsive.css:5` giải thích đã bỏ khung 390px. Không rule nào. **ĐẠT.**

## E. Phạm vi

- `git status --short`: chỉ 6 mục untracked — `.claude/`, `docs/`, `giaodienmau/`, `giaodienmau2/`, `plans/`, `themes/giaodienmau2/`. Không file đã theo dõi nào bị sửa/xóa.
- `git status --short themes/default` và `git diff --stat themes/default` đều rỗng → `themes/default/**` nguyên vẹn.
- `find` `*.bak`, `*.orig`, `*.tmp`, `*.rej`, `node_modules` trong theme → không có.

**ĐẠT.**

## Không kiểm được

- **Kết quả hiển thị thực tế**: không có web server + CSDL NukeViet chạy, không render được trang để so pixel. Không tính là lỗi.
- **Thứ tự nạp giữa `components.css` (theme.php) và `news.css` (core `nv_html_css`)** trên trang module news: xác định được về mặt code nhưng không xác nhận được bằng HTML thật. Cả hai file không còn selector trùng nhau cho 5 class nên rủi ro bằng 0.
- Các thư mục ngoài phạm vi (`giaodienmau/`, `giaodienmau2/`, `docs/`, `plans/`, `.claude/`): không kiểm được quyền sở hữu, không đánh giá.

## Danh sách phát hiện

**CRITICAL:** không có.

**MAJOR:** không có.

**MINOR:**
1. `lastest-news` (dùng bởi `modules/news/block_headline.tpl`) chỉ có rule ở `css/news.css:16-33, 933-946` → block headline mất phần style danh sách khi trang chủ thuộc module khác. Hạn chế kế thừa từ `themes/default/css/news.css:16-33`, không phải hồi quy của vòng sửa.
2. `hot-news-others` (dùng bởi `block_newscenter.tpl`) chỉ có rule ở `css/news.css:141-153`; các rule đó nhắm `ul` mà markup không dùng nên thực tế vô hại. Cũng là hạn chế kế thừa từ `themes/default`.
