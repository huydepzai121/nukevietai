# Từ giao diện mẫu đến theme NukeViet chạy được

Quy trình đã dùng thật trong repo này để dựng `themes/giaodienmau2` ("Nhịp Phố")
từ bản thiết kế tĩnh `giaodienmau2/`. Ghi lại để lần sau lặp lại được, và để
biết chỗ nào dễ sai.

Toàn bộ tài liệu này giả định **đã có sẵn bộ giao diện mẫu tĩnh** trong repo.
Chưa có thì làm bước 1 trước.

## Toàn cảnh

```
/design  →  giaodienmau*/         →  /osf autopilot  →  themes/<tên>/  →  Docker
(bản vẽ)    (HTML+CSS tĩnh)          (dựng theme)        (theme thật)     (chạy thử)
```

Bốn thư mục liên quan:

| Đường dẫn | Vai trò |
|-----------|---------|
| `giaodienmau/`, `giaodienmau2/` | Bản thiết kế tĩnh, mở bằng trình duyệt là xem được |
| `.claude/skills/nukeviet-giao-dien-mau/` | Skill dựng bộ mẫu tĩnh, kèm script kiểm |
| `.claude/skills/nukeviet-theme/` | Skill mô tả cấu trúc theme NukeViet và quy trình dựng |
| `themes/<tên>/` | Theme thật, kết quả cuối |
| `docs/docker.md` | Stack Docker để chạy thử |

## 1. Có bộ giao diện mẫu tĩnh

Mỗi bộ mẫu gồm các trang tĩnh, CSS tách lớp và một trang hệ thống thiết kế:

```
giaodienmau2/
├─ index.html            Trang chủ
├─ chi-tiet.html         Trang chi tiết bài viết
├─ mobile.html           Bản thu gọn 390px
├─ design-system.html    Hệ thống thiết kế — mục cuối là BẢNG ÁNH XẠ sang file theme
└─ assets/css/           tokens → base → components → page-*
```

**Bảng ánh xạ trong `design-system.html` là thứ quan trọng nhất** cho bước sau:
nó nói phần nào của bản mẫu tương ứng với file nào trong theme
(`header_extended.tpl`, `block.default.tpl`, `modules/news/detail.tpl`…).
Không có bảng đó thì bước dựng theme phải tự dò, dễ sót.

Chưa có bộ mẫu thì dùng skill `nukeviet-giao-dien-mau` để dựng — skill đó nêu
khung bất biến phải giữ, cách chia CSS ba lớp và những chỗ dễ sai. Kiểm bộ mẫu
trước khi đem đi dựng theme:

```bash
node .claude/skills/nukeviet-giao-dien-mau/scripts/check-giao-dien-mau.mjs giaodienmau2
```

Chi tiết từng bộ: `docs/giaodienmau.md`, `docs/giaodienmau2.md`.

## 2. Dựng theme bằng `/osf autopilot`

```
/osf autopilot dựng giaodienmau2 thành theme nukeviet luôn đi
```

`autopilot` tự chạy hết pipeline, không dừng hỏi giữa chừng. Nó chọn pipeline
theo mức rủi ro:

| Pipeline | Khi nào | Các bước |
|----------|---------|----------|
| Full | Việc phức tạp, đụng vùng nhạy cảm, sửa nhiều file cũ | spec → implement → verify → archive |
| **Verified** | **Việc dựng theme** — thêm mới hoàn toàn trong `themes/<tên>/`, không đụng file cũ | implement → verify |
| Light | Sửa vặt, rủi ro thấp | implement |

Dựng theme rơi vào **Verified**: toàn bộ là thêm mới, và "spec" đã có sẵn dưới
dạng skill `nukeviet-theme` + bảng ánh xạ + ba trang tĩnh. Không cần dựng
`openspec/` vào repo.

### Bản tóm tắt cần đưa cho autopilot

Càng cụ thể thì càng ít phải sửa lại. Bản đã dùng gồm:

- **Bối cảnh**: repo, phiên bản NukeViet, nhánh, đường dẫn bản thiết kế tĩnh.
- **Đọc trước**: `.claude/skills/nukeviet-theme/SKILL.md`, file `references/`
  của skill, mục bảng ánh xạ trong `design-system.html`, tài liệu bộ mẫu.
- **Phạm vi file nghiêm ngặt**: chỉ được tạo/sửa trong `themes/<tên>/`; cấm đụng
  `themes/default/`, `includes/`, `modules/`, thư mục bản mẫu tĩnh.
- **Kết quả chấp nhận**: liệt kê cụ thể, ví dụ "5 file CSS đúng chỗ", "theme.php
  khai báo đúng 4 file", "không tpl nào mất biến hay cặp BEGIN/END".

### Việc autopilot đã làm

1. Nhân bản `themes/default` → `themes/giaodienmau2` bằng
   `.claude/skills/nukeviet-theme/scripts/scaffold-theme.mjs`.
2. Chép CSS bản mẫu vào `css/`, khai báo trong `theme.php` trước `custom.css`.
3. Áp lớp nhìn vào `layout/*.tpl` và các tpl module news, comment.
4. Tự kiểm rồi giao cho bước verify độc lập.

## 3. Vòng kiểm tra

Bước verify **chỉ đọc và báo cáo**, không sửa. Nó phân loại phát hiện:

- **CRITICAL** — hỏng chức năng: mất biến hoặc lệch cặp `BEGIN/END` trong tpl,
  thiếu `<position>` trong `config.ini`, lỗi cú pháp XML/PHP/CSS.
- **MAJOR** — chạy được nhưng sai ý đồ.
- **MINOR** — vặt.

Có CRITICAL hoặc MAJOR thật thì quay lại bước implement để sửa, **rồi kiểm lại**
— không bỏ vòng kiểm sau khi sửa. Tối đa 3 vòng.

Lần dựng `giaodienmau2` mất 2 vòng: vòng 1 ra 0 CRITICAL và 1 MAJOR, vòng 2 sạch.

### MAJOR đã gặp, đáng nhớ

Block `block_newscenter` dùng 5 class chỉ được định nghĩa trong `css/news.css`.
Core NukeViet chỉ nạp `css/<tên-module>.css` khi trang đang render thuộc đúng
module đó (`includes/core/user_functions.php:672`). Mà `block_newscenter` là
**block toàn cục** — đặt được ở trang chủ thuộc module `page`, `contact`… và khi
đó `news.css` không nạp nên block mất style.

Cách sửa: chuyển các rule đó sang `css/components.css` (được khai báo nạp trên
mọi trang).

**Quy tắc rút ra:** class dùng bởi block toàn cục phải nằm trong CSS nạp toàn
cục, không nằm trong CSS theo module.

## 4. Chạy thử bằng Docker

Xem `docs/docker.md` cho toàn bộ. Tóm tắt:

```bash
docker compose up -d --build
```

| Địa chỉ | Nội dung |
|---------|----------|
| http://localhost:8088 | Website |
| http://localhost:8089 | phpMyAdmin |

Rồi chạy trình cài đặt NukeViet, khai báo CSDL:

| Trường | Giá trị |
|--------|---------|
| Máy chủ CSDL | **`nukeviet_db`** |
| Cổng | **`3306`** |
| Tên đăng nhập | `root` |
| Mật khẩu | *(để trống)* |
| Tên CSDL | `nukeviet` |

Cài xong: **Quản trị → Giao diện**, chọn theme mới.

### Ba chỗ nhầm về CSDL, đã gặp thật

Trình cài đặt chỉ báo đúng một câu `Could not connect to data server`
(`install/index.php:489`) cho mọi nguyên nhân, nên phải tự loại trừ:

| Điền sai | Vì sao sai |
|----------|-----------|
| Máy chủ `localhost` | Trong container web, `localhost` là chính container đó, không phải MariaDB. Hai container nói chuyện qua **tên service**. |
| Cổng `3307` | 3307 là cổng nhìn từ Windows. Từ trong container luôn là **3306**. |
| Cổng `8089` | 8089 là cổng phpMyAdmin, không phải cổng CSDL. |

Cách kiểm nhanh, chạy từ ngoài, không phải đoán:

```bash
docker compose exec -T nukeviet_web php -r '
try { new PDO("mysql:host=nukeviet_db;port=3306;dbname=nukeviet","root",""); echo "OK\n"; }
catch (Exception $e) { echo "LOI: ", $e->getMessage(), "\n"; }'
```

Nếu vẫn không rõ, bật log truy vấn của MariaDB để xem yêu cầu có tới nơi không:

```bash
docker compose exec -T nukeviet_db mariadb -u root -e "SET GLOBAL log_output='TABLE'; SET GLOBAL general_log=ON; TRUNCATE TABLE mysql.general_log;"
# thử lại trên trình cài đặt, rồi:
docker compose exec -T nukeviet_db mariadb -u root -e "SELECT event_time, user_host, LEFT(argument,80) FROM mysql.general_log ORDER BY event_time DESC LIMIT 20;"
# xong nhớ tắt:
docker compose exec -T nukeviet_db mariadb -u root -e "SET GLOBAL general_log=OFF; TRUNCATE TABLE mysql.general_log;"
```

Không thấy dòng nào tới MariaDB nghĩa là sai host hoặc sai cổng, chưa phải
chuyện tài khoản.

## Những giới hạn cần biết trước

- **Không sửa `themes/default`.** Chính `themes/default/config.ini` ghi rõ điều
  này. Mọi thay đổi đi vào theme mới.
- **Skill giao diện không sửa PHP của module.** Ví dụ nhãn chuyên mục trên trang
  chi tiết bài viết: `detail_theme()` không đưa tên chuyên mục vào `{DETAIL.*}`,
  chỉ có `catid`. Muốn có thì phải sửa `modules/news/theme.php` — việc đó nằm
  ngoài phạm vi và phải quyết định riêng, không để autopilot tự làm.
- **Kiểm bằng mắt là bắt buộc.** Verify chỉ phân tích tĩnh (biến trong tpl, cú
  pháp, phạm vi file). Nó không thấy được bố cục vỡ hay màu sai. Sau khi kích
  hoạt theme phải tự soát 5 mục ở bước 7 của `SKILL.md`.
- **Không đưa file rác vào repo.** Script kiểm tạm để trong thư mục tạm của hệ
  thống.
