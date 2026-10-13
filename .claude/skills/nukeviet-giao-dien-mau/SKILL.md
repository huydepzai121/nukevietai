---
name: nukeviet-giao-dien-mau
description: Dựng bộ giao diện mẫu tĩnh (HTML + CSS) cho website NukeViet — trang chủ, chuyên mục, chi tiết bài viết, bản di động và trang hệ thống thiết kế kèm bảng ánh xạ sang file theme. Dùng khi người dùng nói "thiết kế giao diện", "làm giao diện demo", "dựng bản mẫu", "vẽ giao diện mới", "đổi màu giao diện", hoặc khi cần chốt thiết kế trước rồi mới dựng theme thật. Kết quả là thư mục giaodienmau*/ ở gốc repo, đầu vào cho skill nukeviet-theme.
---

# Dựng giao diện mẫu cho NukeViet

Bộ mẫu tĩnh là bước **trước** khi dựng theme. Mục đích: chốt xong lớp nhìn trên
HTML/CSS thuần, nơi sai ở đâu thấy ngay, rồi mới đụng vào `.tpl` — đừng vừa
thiết kế vừa sửa template.

Skill này tự tạo thư mục bộ mẫu, không giả định repo đã có sẵn cái nào. Khi cần
chi tiết khung bất biến, đọc `references/khung-nukeviet.md`.

Nếu repo tình cờ đã có bộ mẫu nào (`giaodienmau*/`) thì xem như ví dụ để đối
chiếu, nhưng đừng phụ thuộc vào chúng.

## Quy tắc gốc

1. **Khung là bất biến, lớp nhìn là tự do.** Màu, chữ, bo góc, khoảng cách,
   hình khối — thoải mái. Nhưng chuỗi khung, lưới 24 cột và cấu trúc khối phải
   giữ đúng NukeViet, nếu không bước dựng theme sẽ không ánh xạ được.
2. **Lấy giá trị từ nguồn, không ước lượng.** Bám theme có sẵn thì chép đúng mã
   màu và cỡ chữ từ `themes/default/css/*.css`; làm hướng mới thì ghi giá trị
   vào `tokens.css` rồi mọi nơi dùng biến, không rải mã màu khắp trang.
3. **Không bịa dữ kiện.** Số điện thoại, email, giấy phép, tên người, ngày giờ
   để trong ngoặc vuông `[ ]`. Tiêu đề và sapo được phép là nội dung mẫu, nhưng
   phải nói rõ khi bàn giao.

## Quy trình

### Bước 1 — Chốt hướng thiết kế với người dùng

Hỏi trước khi vẽ, đừng tự chọn thẩm mỹ:

- Bám theme đang chạy, hay làm hướng mới hoàn toàn, hay giữ cấu trúc mà đổi lớp nhìn?
- Phong cách nào? Đưa 2–4 hướng khác nhau rõ rệt, mỗi hướng nêu được một trục
  ("dày đặc thông tin" so với "thoáng, ảnh lớn").
- Mockup tĩnh hay prototype bấm được?

Nếu bám theme có sẵn thì trước khi vẽ phải đọc và chép giá trị thật từ
`themes/<theme>/css/style.css`, `news.css`, `menu.css` và các `layout/*.tpl`.

### Bước 2 — Tạo bộ khung

```bash
node .claude/skills/nukeviet-giao-dien-mau/scripts/scaffold-giao-dien-mau.mjs --name giaodienmau3 --title "Tên site" --root D:/Dev/www/nukeviet
```

Script sinh ra một bộ **chạy được ngay nhưng chưa có thẩm mỹ**: đủ 5 trang, CSS
chia ba lớp, bảng màu trung tính cố ý nhạt để thấy rõ chỗ nào chưa được thiết
kế, và khung NukeViet đã đúng sẵn. Nó từ chối ghi đè lên thư mục đã có.

Việc của bạn sau đó là đổi lớp nhìn, **không đổi khung**. Bắt đầu từ
`tokens.css`, rồi tới `components.css`.

Tên thư mục đặt theo thứ tự: `giaodienmau`, `giaodienmau2`, … Cấu trúc sinh ra:

```
giaodienmau2/
├─ index.html            Trang chủ                    (bắt buộc)
├─ chi-tiet.html         Trang chi tiết bài viết      (bắt buộc)
├─ mobile.html           Bản thu gọn 390px            (bắt buộc)
├─ design-system.html    Hệ thống thiết kế            (bắt buộc)
├─ chuyen-muc.html       Trang chuyên mục             (nên có)
└─ assets/
   ├─ css/tokens.css        Biến: màu, chữ, lưới, bo góc
   ├─ css/base.css          Reset, chữ nền, khung .wraper, lưới
   ├─ css/components.css    Header, menu, breadcrumb, panel, mẫu tin, footer
   ├─ css/page-*.css        Phần riêng từng trang
   └─ img/                  Ảnh, nếu dùng ảnh thật
```

Thứ tự nạp CSS trong mọi trang, không đảo: `tokens → base → components → page-*`.

Muốn tự dựng tay thay vì chạy script cũng được, miễn ra đúng cấu trúc trên và
qua được bước kiểm ở bước 6.

Trang tĩnh không có cơ chế include, nên header và footer buộc phải lặp lại ở mỗi
trang. Chấp nhận điều đó; khi lên theme chúng gộp về `header_extended.tpl` và
`footer_extended.tpl`.

### Bước 3 — Giữ đúng khung NukeViet

Mỗi trang desktop phải có đủ chuỗi này, đúng thứ tự:

| Phần | Mốc trong HTML | Tương ứng khi lên theme |
|------|----------------|--------------------------|
| Thanh trên | `.section-header-bar` | `[CONTACT_DEFAULT]`, `[SOCIAL_ICONS]`, `[PERSONALAREA]` |
| Đầu trang | `#header` + `.logo` + `.right-ads` | logo, `{SITE_DESCRIPTION}`, `[HEAD_RIGHT]` |
| Menu | `.section-nav` | `[MENU_SITE]` |
| Đường dẫn | `.third-nav` + `.breadcrumbs` | breadcrumb + `{NV_CURRENTTIME}` + ô tìm kiếm |
| Thân trang | `.body-grid` + `.col-left/.col-main/.col-right` | `layout.left-main-right.tpl` |
| Khối | `.panel` / `.panel-primary` | `block.default.tpl` / `block.primary.tpl` |
| Chân trang | `#footer` + `.footerNav2` | `[FOOTER]` |

Bản di động bỏ `#footer` được, nhưng vẫn giữ các mốc còn lại.

Lưới: khung `.wraper` rộng **1080px**, lưới **24 cột**, khoảng cách **30px**.
Bố cục ba cột `left-main-right` là 5 / 13 / 6 cột — tức nội dung
**210 / 555 / 255px**. Bố cục hai cột `main-right` là 18 / 6 — **795 / 255px**.

### Bước 4 — Viết CSS ba lớp

- `tokens.css`: chỉ chứa `:root { --… }`. Mỗi biến ghi chú nguồn gốc nếu chép từ
  theme có sẵn.
- `base.css`: reset, `body`, liên kết, tiêu đề, `.wraper`, `.body-grid`, `.col-*`,
  các lưới phụ dùng lại.
- `components.css`: mọi thứ dùng ở nhiều trang.
- `page-*.css`: chỉ phần riêng của một trang.

Đặt style vào đúng lớp là chuyện quan trọng, không phải hình thức: xem
"Lỗi thường gặp" bên dưới.

### Bước 5 — Trang hệ thống thiết kế

`design-system.html` là bàn giao thật sự, không phải trang trang trí. Bắt buộc có:

1. Bảng màu, mỗi ô ghi mã màu và **nơi dùng** (hoặc selector gốc nếu chép từ theme).
2. Thang chữ: từng cấp kèm cỡ, độ đậm, giãn dòng.
3. Sơ đồ lưới và bo góc.
4. Các thành phần: khối mặc định, khối nhấn, nút, nhãn, mẫu tin.
5. **Bảng ánh xạ sang file theme** — phần quan trọng nhất. Mỗi dòng: phần trong
   bản mẫu → file theme tương ứng → ghi chú. Bước dựng theme đọc bảng này để
   biết sửa file nào; thiếu nó là bước sau phải tự dò và sẽ sót.
6. Nguyên tắc mở rộng: thêm màu thì thêm vào tokens, vùng chạm tối thiểu 44px,
   biểu tượng vẽ bằng SVG…

Làm bộ mẫu thứ hai trở đi thì thêm mục **so sánh với bộ trước**: cái gì giữ
nguyên, cái gì đổi. Người xem cần biết ngay khác biệt nằm ở đâu.

### Bước 6 — Tự kiểm

```bash
node .claude/skills/nukeviet-giao-dien-mau/scripts/check-giao-dien-mau.mjs giaodienmau2
```

Script kiểm: đủ trang bắt buộc, đủ ba lớp CSS, đúng thứ tự nạp, còn nguyên khung
NukeViet, có bảng ánh xạ, thẻ HTML cân bằng, class nào chưa có style, ảnh thiếu
`alt`, còn sót lorem ipsum hay emoji. Chỉ đọc, không sửa gì.

Sau đó mở tất cả các trang bằng trình duyệt và **thu cửa sổ xuống 390px** — script
không thấy được bố cục vỡ.

### Bước 7 — Ghi tài liệu

Thêm `docs/<tên-thư-mục>.md`: vị trí, cấu trúc, nguồn giá trị thiết kế, ảnh lấy
từ đâu, nội dung nào là mẫu. Nối tới `docs/quy-trinh-lam-giao-dien.md`.

## Quy tắc nội dung và hình

- **Biểu tượng vẽ bằng SVG nội tuyến**, lưới 16/20/24px, một phong cách nhất
  quán. Không emoji, không font biểu tượng.
- **Ảnh**: dùng ảnh thật thì đặt trong `assets/img/`, luôn có `alt`, bo theo
  token bán kính. Chưa có ảnh thì vẽ ô giữ chỗ, đừng để trống.
- **Vùng chạm trên di động tối thiểu 44px**; chữ thân bài không nhỏ hơn 16px.
- **Nhóm phần tử cùng cấp bằng `flex`/`grid` kèm `gap`**, không dùng margin lẻ
  từng phần tử.
- **Không dùng ảnh nền hay gradient tràn lan.** Một dải chuyển màu đặt đúng chỗ
  là đủ; còn lại dùng màu phẳng.

## Lỗi thường gặp

- **Rule của khung xem mẫu lọt vào bản thiết kế** — ví dụ
  `body { max-width: 390px; border-left: … }` để giả khung điện thoại, hay
  `li:nth-child(4)` để giả trạng thái menu đang chọn. Chúng thuộc về trang mẫu
  di động, không thuộc về giao diện; khi lên theme phải bỏ. Tách sẵn vào
  `page-mobile.css` để bước sau biết đường loại.
- **Đặt style của thành phần dùng chung vào CSS riêng của một trang** — lên theme
  thành `css/<module>.css`, mà NukeViet chỉ nạp file đó khi trang đang render
  thuộc đúng module ấy. Block toàn cục đặt ở trang chủ dùng module khác sẽ mất
  style. Cái gì dùng ở nhiều nơi thì để `components.css`.
- **Thiếu bảng ánh xạ** trong `design-system.html` — bước dựng theme mất phương
  hướng.
- **Bịa số liệu** cho đẹp trang: giấy phép, hotline, tên tổng biên tập. Để `[ ]`.
- **CSS chết**: viết rule cho class mà markup không dùng, hoặc ngược lại. Script
  kiểm bắt được cả hai chiều.
- **Đổi lưới** cho vừa ý tưởng bố cục. Lưới 24 cột và `.wraper` 1080px là hợp
  đồng với theme; muốn đổi thì phải đổi cả theme, và đó là quyết định của người
  dùng, không phải của người vẽ.

## Bàn giao

Nói rõ ba điều, đừng để người dùng tự phát hiện:

1. Nội dung nào là mẫu, dữ kiện nào đang để trong `[ ]`.
2. Ảnh lấy từ đâu, có được dùng thật không.
3. Chỗ nào cố ý lệch khỏi theme gốc và vì sao.

Chốt xong bộ mẫu thì chuyển sang skill `nukeviet-theme` để dựng thành theme
chạy được. Quy trình đầy đủ: `docs/quy-trinh-lam-giao-dien.md`.

## Phạm vi

Skill này chỉ dựng bản mẫu tĩnh trong thư mục `giaodienmau*/`. Không sửa
`themes/`, `modules/`, `includes/`. Muốn dựng theme thật thì dùng
`nukeviet-theme`.
