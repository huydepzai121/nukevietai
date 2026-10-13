# Chuẩn thiết kế web — bản chuyển cho theme NukeViet 4.x

Chuẩn gốc (`web-design-standard`) viết cho trang HTML tĩnh dùng Bootstrap 5.
NukeViet 4.6 đã có sẵn **Bootstrap 3.4.1 biên dịch 24 cột**
(`themes/default/css/bootstrap.min.css`), và core + template module (news, users,
comment, modal `#sitemodal`, `data-toggle`, `.panel`, `.label`…) viết markup BS3.
Vì vậy chuẩn được giữ **về nội dung**, còn **cách làm** đổi theo cấu trúc theme.

## Bảng chuyển đổi

| Chuẩn gốc | Trong theme NukeViet |
|---|---|
| Bootstrap 5.3 qua CDN | Giữ `css/bootstrap.min.css` + `js/bootstrap.min.js` (BS3, 24 cột) của theme. **Không** thay bằng BS5. |
| Grid 24 cột (`$grid-columns: 24` / `.grid-24 .span-N`) | Có sẵn: `.row` + `.col-xs-N` / `.col-sm-N` / `.col-md-N` / `.col-lg-N` (N = 1…24). |
| Breakpoint BS5 (576/768/992/1200/1400) | BS3: xs < 768 · sm ≥ 768 · md ≥ 992 · lg ≥ 1200. "Mobile / md / lg" của chuẩn = **xs / sm / md**. |
| `.container { max-width: 1190px }` | `css/nv-standard.css`: `.wraper` tối đa 1190px (default là 1080px); `.container` bên trong giữ `width: 100%`. |
| Gutter 20px (10px mỗi bên) | `css/nv-standard.css` đặt lại `.row` −10px, cột 10px (bootstrap.min.css của NukeViet là 5px). |
| Spacing `m-* p-* gap-*` 0–5 | BS3 không có tiện ích này → dùng biến `--space-0…6` (4 · 8 · 16 · 24 · 48 · 96px) trong CSS của theme. |
| Section `py-4 / py-5 / 96px` | Lớp `.nv-section` trong `nv-standard.css`: 24px (xs) · 48px (sm) · 96px (md+). |
| Chữ gốc 16px, tỉ lệ 1.25, ≤ 2 họ chữ | `nv-standard.css` đặt `body` 16px, h1–h6 = 39 · 31 · 25 · 20 · 16 · 13px; font khai báo trong `theme.php`. |
| Văn bản dài `max-width: 65ch` | `#news-bodyhtml`, `.bodytext` (chi tiết tin, module page). |
| 1 file `.html`, CSS trong `<style>` | Theme nhiều file: CSS ở `css/*.css`, khai báo trong `theme.php` (`nv_site_theme()`), JS ở `js/`. |
| Lưu ở `themes/<tên-trang>-vN.html`, không ghi đè | Theme mới = thư mục mới `themes/<tên>` (script từ chối ghi đè). Đánh số theo repo: `giaodienmau`, `giaodienmau2`, … |
| Marker `<!-- ===== HEADER ===== -->` … `END HEADER` | Đặt trong tpl: `header_extended.tpl` (HEADER), `footer_extended.tpl` (FOOTER), `layout.*.tpl` (BODY), và trong CSS `/* HEADER STYLES */ … /* END HEADER STYLES */`. Parser XTemplate chỉ bắt `BEGIN:`/`END:` **có dấu hai chấm** nên marker không bị hiểu nhầm là khối. |
| Sửa đúng 1 section | Sửa đúng tpl/khối tương ứng (`header_extended.tpl`, `block_*.tpl`…), giữ nguyên `{BIẾN}` và cặp `BEGIN/END`. |
| Không width px cho layout chính | Không đặt `width: 1080px` cho `.wraper`, không `grid-template-columns: 210px 1fr 255px`; dùng `.col-*` hoặc `fr` theo tỉ lệ 24 cột (5fr 13fr 6fr). |

## Thành phần bắt buộc theo loại trang → vị trí NukeViet

| Thành phần | Nơi dựng trong theme |
|---|---|
| Header: logo, mô tả, menu | `layout/header_extended.tpl` (`{LOGO_SRC}`, `{SITE_NAME}`, `[MENU_SITE]`), menu là block của module menu |
| Thanh trên: liên hệ, MXH, tài khoản | `[CONTACT_DEFAULT]`, `[SOCIAL_ICONS]`, `[PERSONALAREA]` |
| Breadcrumb + tìm kiếm | Khối `breadcrumbs` trong `header_extended.tpl` |
| Tin nổi bật / lưới chuyên mục | `modules/news/block_newscenter.tpl`, `block_headline.tpl`, `viewcat_*.tpl` — **mọi khối chuyên mục cùng loại dùng chung 1 kiểu** (`viewcat_*` đã đảm bảo) |
| Sidebar: đọc nhiều, chuyên mục | `[LEFT]`/`[RIGHT]` + `block_tophits.tpl`, `block_category.tpl`, khung `layout/block.*.tpl` |
| Chi tiết bài | `modules/news/detail.tpl` — ảnh có `alt`, h1 duy nhất là tiêu đề bài |
| Footer: liên hệ/MXH, liên kết nhanh, bản quyền | `layout/footer_extended.tpl`: `[MENU_FOOTER]`, `[COMPANY_INFO]`, `[FOOTER_SITE]` |
| Hero / dịch vụ / CTA (doanh nghiệp, landing) | Block theme ở `blocks/` + `<setblocks>` trong `config.ini`, bọc `.nv-section`; layout riêng khai báo `<setlayout>` |

## Đa dạng hoá

Chuẩn mục 9 áp dụng **giữa các theme** (giaodienmau3 khác giaodienmau4), không
phải giữa các khối cùng loại trong một theme. Biến đổi tự do: màu, chữ, bo góc,
vị trí phần tử, hiệu ứng. Cố định: đủ thành phần, lưới 24 cột, breakpoint, tỉ lệ
ảnh quy định, marker, và **toàn bộ hợp đồng tpl với core**.

## Checklist bàn giao

- [ ] `node .claude/skills/nukeviet-theme/scripts/check-theme.mjs --name <tên>` không lỗi
- [ ] Theme ở thư mục mới `themes/<tên>`, không sửa `themes/default`
- [ ] `css/nv-standard.css` nạp trước `custom.css`; không nạp `components.css` của design system tĩnh
- [ ] Marker HEADER / BODY / FOOTER có đủ cặp mở/đóng
- [ ] Responsive kiểm ở 390 · 768 · 992 · 1200px; không tràn ngang
- [ ] Không width px cho `.wraper`/cột chính
- [ ] Focus bàn phím hiện rõ; tương phản chữ đạt AA
- [ ] Ảnh có `alt`; mỗi trang 1 `h1` (logo dùng `sr-only` h1 chỉ ở trang chủ — `site_name_h1`)
- [ ] Footer có liên hệ/MXH, liên kết nhanh, bản quyền
