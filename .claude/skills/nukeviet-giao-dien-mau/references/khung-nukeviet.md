# Khung bất biến của giao diện NukeViet

Tra cứu cho người vẽ bản mẫu tĩnh. Mọi số liệu dưới đây đọc từ `themes/default`
của repo này. Lớp nhìn thì tự do, nhưng những thứ ở đây phải giữ đúng, nếu không
bước dựng theme sẽ không ánh xạ được.

## Lưới

| Thứ | Giá trị | Nguồn |
|-----|---------|-------|
| Khung nội dung | `.wraper` rộng **1080px**, canh giữa | `css/style.css` |
| Lưới | **24 cột** Bootstrap 3 (`col-md-1` … `col-md-24`) | `css/bootstrap.min.css` |
| Khoảng cách cột | **30px** (padding 15px mỗi bên, `.row` bù âm 15px) | Bootstrap 3 |
| Thu hẹp | `.wraper` và `.container` về 100% ở màn hình nhỏ | `css/style.responsive.css` |

Quy đổi bố cục ra bề rộng nội dung thật (đã trừ khoảng cách):

| Bố cục | Cột | Bề rộng nội dung |
|--------|-----|------------------|
| `layout.left-main-right` | 5 / 13 / 6 | 210 / 555 / 255 px |
| `layout.main-right` | 18 / 6 | 795 / 255 px |
| `layout.left-main` | 6 / 18 | 255 / 795 px |
| `layout.main` | 24 | 1080 px |

Vẽ bản mẫu bằng flex cũng được, miễn ra đúng những con số này.

## Chuỗi khung một trang

Thứ tự này cố định, đừng đảo:

```
.section-header-bar     Thanh trên: liên hệ, mạng xã hội, tài khoản
.section-header  #header    Logo + mô tả site + vùng banner phải
.section-nav                Menu chính
.section-body
  .third-nav                Đường dẫn + thời gian + ô tìm kiếm
  .body-grid                Ba cột nội dung
#footer                     Chân trang nhiều cột
.footerNav2                 Dải cuối: bản quyền, nút lên đầu trang
```

Bản di động được bỏ `#footer`, giữ các mắt còn lại.

## Vị trí block

Mỗi vùng trong bản mẫu tương ứng một `[TAG]` khi lên theme. Danh sách vị trí của
theme default:

`[PERSONALAREA]` `[SOCIAL_ICONS]` `[HEAD_RIGHT]` `[CONTACT_DEFAULT]` `[MENU_SITE]`
`[MENU_FOOTER]` `[HEADER]` `[LEFT]` `[RIGHT]` `[TOP]` `[BOTTOM]` `[FOOTER]`
`[FOOTER_SITE]` `[FEATURED_PRODUCT]` `[COMPANY_INFO]` `[QR_CODE]`
`[FIX_BANNER_LEFT]` `[FIX_BANNER_RIGHT]`

Trong bản mẫu nên đặt tên class trùng với vị trí (`personalArea`,
`contactDefault`, `social-icons`) để bước dựng theme biết ngay chỗ nào ghép vào
đâu. Những class đó có thể không có style — chúng chỉ là mốc.

## Khối nội dung

Mọi block của NukeViet đều bọc trong một khung chọn theo tên:
`block.default.tpl`, `block.primary.tpl`, `block.border.tpl`, `block.simple.tpl`,
`block.no_title.tpl`. Cấu trúc của `block.default.tpl`:

```html
<div class="panel panel-default">
    <div class="panel-heading">{BLOCK_TITLE}</div>
    <div class="panel-body">{BLOCK_CONTENT}</div>
</div>
```

Bản mẫu phải giữ đúng ba tầng **panel → panel-heading → panel-body**. Bên trong
mỗi tầng thì trang trí thoải mái: đổi bo góc, bỏ nền xám của `panel-heading`,
thêm thanh màu, thêm nút "Xem tất cả" — miễn cấu trúc còn nguyên.

## Trang cần vẽ và tpl tương ứng

| Trang mẫu | Tpl khi lên theme |
|-----------|-------------------|
| `index.html` | `modules/news/block_newscenter.tpl`, `block_headline.tpl`, `block_news.tpl`, `block_tophits.tpl`, `block_category.tpl` — trang chủ module news dựng từ block, **không có `main.tpl`** |
| `chuyen-muc.html` | `modules/news/viewcat_list.tpl`, `viewcat_page.tpl`, `viewcat_grid.tpl` |
| `chi-tiet.html` | `modules/news/detail.tpl` và `modules/comment/main.tpl`, `comment.tpl` |
| `mobile.html` | không có tpl riêng — theme default là giao diện co giãn, bản di động chỉ là `@media` |
| Khung chung mọi trang | `layout/header_extended.tpl`, `layout/footer_extended.tpl`, `layout/layout.*.tpl`, `layout/block.*.tpl` |

## Cơ chế nạp CSS cần biết khi chia file

Khi lên theme, CSS được nạp theo thứ tự này (`themes/default/theme.php`, hàm
`nv_site_theme()`):

1. `assets/css/font-awesome.min.css`
2. `css/bootstrap.min.css`
3. `css/style.css`
4. `css/style.responsive.css`
5. CSS do module đăng ký
6. `css/custom.css` — nạp sau cùng nên luôn ghi đè

Một điều dễ sập bẫy: **`css/<tên-module>.css` chỉ được nạp khi trang đang render
thuộc đúng module đó** (`includes/core/user_functions.php:672`). Nghĩa là style
của bất kỳ thành phần nào có thể xuất hiện ngoài module news — block toàn cục,
khung chung, mẫu tin dùng lại — phải nằm ở CSS nạp toàn cục, không nằm ở
`news.css`.

Vì vậy khi vẽ bản mẫu: cái gì dùng ở nhiều trang thì để `components.css`, chỉ
thứ thật sự riêng của một trang mới để `page-*.css`.

## Giá trị của theme default, để đối chiếu

Khi làm hướng "bám theme có sẵn" thì chép đúng những giá trị này, đừng làm tròn:

| Thứ | Giá trị | Selector gốc |
|-----|---------|--------------|
| Chữ nền | `#333`, 14px, giãn dòng 1.42857 | `body` |
| Họ chữ | `'Helvetica Neue', Helvetica, Arial, sans-serif` | `body` |
| Liên kết | `#1a3f5e`, hover `#0e2132` | `a:link` |
| Chữ mờ | `#707070` | `a.dimgray`, `.site_description` |
| Nền trang | `#eeeeee` | `body`, `.third-nav .bg` |
| Màu chính | `#428bca` → `#245682` | `.section-header-bar`, `#footer` |
| Dải cuối | `#193c5a` | `.footerNav2` |
| Viền | `#dddddd`; đậm `#dcdcdc`; ngăn tin `#dadada` | `--nv-border-color`, breadcrumbs, `#hot-news li` |
| Thanh menu | `#cccccc`, bo trên 5px | `.second-nav .bg` |
| Bo góc | 4px (Bootstrap 3) | — |

Mô tả site trong theme default dùng `'Times New Roman'` in nghiêng đậm 18px —
đó là họ chữ serif duy nhất có sẵn, dùng lại được cho tiêu đề tin mà không phải
nạp thêm webfont.
