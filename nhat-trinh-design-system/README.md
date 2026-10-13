# Nhật Trình — Design System

Hệ thống thiết kế dùng chung cho **mọi loại website**: giới thiệu doanh nghiệp,
landing page, bán hàng, blog, tin tức, hồ sơ cá nhân, trang tài liệu.
Phong cách **báo in cổ điển**: giấy ngà, mực đen, đỏ nhấn, hai họ chữ serif,
không bo góc, không đổ bóng. Dựng trên **Bootstrap 3.4.1 lưới 24 cột của NukeViet**
(`themes/default/css/bootstrap.min.css`), không cần build. Áp chuẩn `web-design-standard`
đã chuyển cho NukeViet: xem `.claude/skills/nukeviet-theme/references/chuan-thiet-ke.md`.

## Cách dùng

Nạp đúng thứ tự trong `<head>`:

```html
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,500;0,700;0,900;1,500&family=Noto+Serif:wght@400;600;700&display=swap">
<link rel="stylesheet" href="../themes/default/css/bootstrap.min.css">
<link rel="stylesheet" href="tokens.css">
<link rel="stylesheet" href="base.css">
<link rel="stylesheet" href="components.css">
<!-- CSS riêng của trang/dự án nạp sau cùng -->
```

Đây là bản mẫu tĩnh để chốt lớp nhìn. **Theme NukeViet không nạp `components.css`**:
nhiều tên class trùng với markup core (`.display` trong breadcrumbs, `.breadcrumbs`,
`.label`, `.nav`, `.btn`…). Theme dùng `tokens.css` + lớp chuyển đổi viết theo markup thật
(bản gốc ở `themes/giaodienmau3/css/`). Dựng theme bằng skill `nukeviet-theme`:

```bash
node .claude/skills/nukeviet-theme/scripts/scaffold-theme.mjs --name giaodienmau4   --from giaodienmau3 --design-system nhat-trinh-design-system --title "Nhật Trình"
```

Mỗi khối lớn trong bản mẫu và trong tpl được bọc comment `<!-- ===== TEN ===== -->` …
`<!-- ===== END TEN ===== -->` (xem `examples/business.html`).

## Nội dung gói

| File | Nội dung |
|------|----------|
| `tokens.css` | **Nguồn sự thật**: màu, chữ, khoảng cách, bố cục, ô giữ chỗ ảnh |
| `base.css` | Reset, chữ nền, `.container`, `.section`, lưới 24 cột, điểm ngắt |
| `components.css` | Thành phần dùng chung (danh sách bên dưới) |
| `index.html` | Trang tổng quan, dẫn tới mọi preview và ví dụ |
| `previews/*.html` | Từng nhóm: màu, chữ, khoảng cách, nút, biểu mẫu, thẻ, điều hướng, nhãn/bảng, ảnh, mẫu section |
| `examples/business.html` | Ví dụ website doanh nghiệp/dịch vụ một trang |
| `examples/news/` | Ví dụ website tin tức nhiều trang (bản gốc của phong cách này) |

## Token

`tokens.css` có hai lớp:

- **Nguyên liệu** `--nt-*`: giá trị gốc. Không dùng trực tiếp trong thành phần mới.
- **Ngữ nghĩa** `--color-*`, `--font-*`, `--text-*`, `--space-*`…: đặt tên theo vai trò.
  Mọi thành phần chỉ dùng lớp này. Muốn đổi thương hiệu, chỉ sửa lớp này.

### Màu

| Token | Giá trị | Vai trò |
|-------|---------|---------|
| `--color-bg` | `#f7f3ea` | Nền trang (không dùng trắng thuần) |
| `--color-surface` | `#fffdf7` | Thẻ, ô nhập, hộp nổi |
| `--color-surface-alt` | `#f2ece0` | Section xen kẽ, nền phụ |
| `--color-inverse` | `#14110d` | Nền tối: thanh trên cùng, chân trang, khối CTA |
| `--color-text` | `#14110d` | Tiêu đề |
| `--color-text-body` | `#3d372e` | Đoạn văn |
| `--color-text-muted` | `#7a7266` | Phụ chú, ngày giờ, nhãn |
| `--color-text-subtle` | `#9a9184` | Placeholder, mục bị tắt |
| `--color-accent` | `#a8231c` | Liên kết, CTA, nhãn, trạng thái chọn |
| `--color-accent-hover` | `#7c1813` | Hover |
| `--color-highlight` | `#d8b26a` | Điểm nhấn, **chỉ trên nền tối** |
| `--color-border` | `#d8cfbe` | Viền ô nhập, thẻ, dải phân cách |
| `--color-border-strong` | `#14110d` | Kẻ đôi, gạch chân tiêu đề, khung nhấn |
| `--color-border-dotted` | `#cfc5b2` | Kẻ chấm giữa các dòng danh sách |
| `--color-success` / `-bg` | `#3f5a2e` / `#e9ecdc` | Thông báo thành công |
| `--color-warning` / `-bg` | `#8a5a12` / `#f4e7c9` | Cảnh báo |
| `--color-danger` / `-bg` | `#a8231c` / `#f6e6e2` | Lỗi |

### Chữ

Chữ gốc 16px, tỉ lệ 1.25 (major third). Khối văn bản dài giới hạn `--measure: 65ch`.

- **Tiêu đề** `--font-display`: Playfair Display (500, 700, 900, nghiêng 500)
- **Thân và giao diện** `--font-body`: Noto Serif (400, 600, 700)

| Token | Cỡ | Dùng cho |
|-------|----|----------|
| `--text-display` | 61px (3.815rem) | Logo chữ, hero rất lớn (Playfair 900) |
| `--text-h1` | 39px (2.441rem) | Tiêu đề trang (hero 49px trên lg qua `.hero__title`) |
| `--text-h2` | 31px (1.953rem) | Tiêu đề mục |
| `--text-h3` | 25px (1.563rem) | Tiêu đề khối |
| `--text-h4` | 20px (1.25rem) | Tiêu đề thẻ (`.card__title`) |
| `--text-h5` / `--text-h6` | 16px / 13px | Tiêu đề phụ |
| `--text-lead` | 18px / 1.65 | Đoạn dẫn |
| `--text-body` | 16px / 1.55 | Chữ gốc |
| `--text-article` | 16px / 1.85 | Thân bài dài (không nhỏ hơn) |
| `--text-xs` | 12px | Phụ chú |
| `--text-label` | 11px, hoa, dãn .16em | Nhãn (eyebrow) |

Trên điện thoại (xs, < 768px) các cỡ lớn giảm một bậc: display 39, h1 31, h2 25, h3 20.

### Khoảng cách và bố cục

- Thang chuẩn: `--space-1` 4 · `-2` 8 · `-3` 16 · `-4` 24 · `-5` 48 · `-6` 96. Bootstrap 3 không có tiện ích `m-*`/`p-*` nên luôn dùng biến.
- Đệm dọc `.section`: xs 24px · sm 48px · md+ 96px.
- Khung `.wraper` / `.container` tối đa 1190px, `.container--narrow` 65ch, gutter 20px (10px mỗi bên).
- Điểm ngắt Bootstrap 3: xs < 768 · sm ≥ 768 · md ≥ 992 · lg ≥ 1200. Viết mobile-first.

### Lưới 24 cột

```html
<div class="wraper">
  <div class="row">
    <div class="col-xs-24 col-sm-12 col-md-8">1/3 trên desktop</div>
    <div class="col-xs-24 col-sm-12 col-md-16">2/3 trên desktop</div>
  </div>
</div>
```

- Lưới là `.row` + `.col-xs/sm/md/lg-N` (N = 1…24) của bootstrap.min.css NukeViet.
  Mọi row quan trọng khai báo tối thiểu 3 mốc: xs / sm / md.
- Tỉ lệ tròn dùng số chẵn: 6 = 1/4, 8 = 1/3, 12 = 1/2, 16 = 2/3, 18 = 3/4.
- `.grid`, `.layout-*`, `.hero` là mẫu CSS Grid cùng tỉ lệ; không đặt cùng phần tử với `.container`.
- Không dùng width px cho khối layout chính; px chỉ cho spacing, viền, icon.

| Mẫu dựng sẵn | xs | sm | md+ |
|------|------|------|------|
| `.grid.grid-2` | 24 | 12/12 | 12/12 |
| `.grid.grid-3` | 24 | 12/12 | 8/8/8 |
| `.grid.grid-4` | 24 | 12/12 | 6/6/6/6 |
| `.layout-sidebar` | 24 | 16/8 | 18/6 |
| `.layout-3col` | 24 | ẩn trái, 16/8 | 5/13/6 |
| `.hero` | 24 | 12/12 | 13/11 |
| `.footer-grid` | 24 + 12/12 | 24 + 8/8/8 | 9/5/5/5 |

Vùng chạm tối thiểu 44px.

### Hình khối

- `--radius: 0` — không bo góc ở bất kỳ đâu.
- `--shadow: none` — phân lớp bằng đường kẻ, không bằng bóng.
- Kẻ đôi `.rule-double` (3px + 1px mực) ngăn các tầng lớn như đầu trang và menu.
- Tiêu đề khối `.section-title`: gạch chân 2px mực.
- Khung nhấn: viền 2px mực (`.card--featured`).
- Danh sách: kẻ chấm 1px.

## Thành phần

| Nhóm | Class |
|------|-------|
| Chữ biên tập | `.eyebrow` (`--plain`), `.display`, `.tagline`, `.lead`, `.meta`, `.prose`, `.quote`, `.numeral`, `.section-title`, `.rule-double` |
| Nút | `.btn`, `.btn-primary`, `.btn-dark`, `.btn-link`, `.btn-sm`, `.btn-lg`, `.btn-block` |
| Biểu mẫu | `.field`, `.label`, `.input`, `.select`, `.textarea`, `.help`, `.check`, `.input-group`, trạng thái `.is-invalid` |
| Thẻ | `.card` + `__media`, `__title`, `__text`; biến thể `--row`, `--boxed`, `--featured` |
| Danh sách | `.list-ruled`, `.list-ranked` (đánh số đỏ), `.spec` (thông số) |
| Nhãn | `.tag`, `.badge` (`--dark`, `--outline`) |
| Thông báo | `.alert` (`--info`, `--success`, `--warning`, `--danger`) |
| Bảng | `.table`, cột số `.num` |
| Điều hướng | `.topbar`, `.site-header`, `.brand`, `.nav` + `.nav__list`, `.breadcrumbs`, `.tabs`, `.pager` |
| Section | `.section` (`--alt`, `--inverse`), `.hero` + `__title`, `__media`, `.cta`, `.site-footer`, `.footer-grid`, `.footer-title`, `.footer-links`, `.footer-bottom` |
| Ảnh | `.ph`, `.ph--2` … `.ph--8`, `.media`, `.figure` |
| Bố cục | `.wraper`/`.container`, `.row` + `.col-*-N`, `.grid`, `.layout-sidebar`, `.layout-3col`, `.stack`, `.stack-lg`, `.cluster` |

Trạng thái chọn dùng thuộc tính ARIA: `aria-current="page"` cho menu và phân trang,
`aria-selected="true"` cho tab.

## Áp dụng cho từng loại website

| Loại | Gợi ý |
|------|-------|
| Doanh nghiệp / dịch vụ | `.hero` → dịch vụ đánh số `.numeral` → dự án `.card` → bảng giá `.card--featured` → `.quote` → biểu mẫu liên hệ. Xem `examples/business.html` |
| Landing page | Một CTA đỏ chính, section xen kẽ `.section--alt`, kết thúc bằng `.cta` nền mực |
| Bán hàng | `.card` sản phẩm + `.numeral` cho giá, `.spec` cho thông số, `.badge` cho khuyến mãi, `.tabs` cho mô tả / đánh giá |
| Blog / tạp chí | `.layout-sidebar`, `.prose` cho bài viết, `.list-ranked` cho bài đọc nhiều, `.tag` cho chủ đề |
| Tin tức | `.layout-3col`, logo chữ `.display`, `.topbar` ngày giờ. Xem `examples/news/` |
| Hồ sơ / portfolio | `.display` cho tên, `.tagline`, lưới `.card` dự án, `.spec` cho thông tin |
| Tài liệu / quản trị | `.layout-sidebar` với menu dọc `.list-ruled`, `.table`, `.alert`, `.tabs` |

## Nguyên tắc

1. Chỉ dùng token ngữ nghĩa; không viết mã màu rời. Cần màu mới thì thêm vào `tokens.css` kèm ghi chú vai trò.
2. Tiêu đề luôn Playfair Display, còn lại Noto Serif. Không thêm họ chữ thứ ba.
3. Không bo góc, không đổ bóng, không gradient trang trí (trừ ô giữ chỗ ảnh).
4. Mỗi màn hình chỉ một nút đỏ chính; hành động phụ dùng `.btn` viền mực.
5. Vàng đồng `--color-highlight` chỉ đặt trên nền tối.
6. Nhóm phần tử cùng cấp bằng flex / grid + `gap`, không dùng margin lẻ.
7. Chưa có ảnh thật thì dùng `.ph`, luân phiên 8 biến thể; không tạo gradient mới.
8. Biểu tượng vẽ bằng SVG nội tuyến, nét mảnh, màu `currentColor`; không emoji, không icon font.
9. Văn bản tiếng Việt, câu ngắn, giọng khách quan. Dữ kiện chưa có (tên, số điện thoại, giá, ngày…) để trong `[ ]`, không bịa.
10. Thiết kế từ điện thoại lên: kiểm tra ở 390px, 768px, 992px và 1200px.
11. Một `h1` duy nhất mỗi trang, heading không nhảy cấp; ảnh có `alt`; focus bàn phím luôn hiện rõ.
