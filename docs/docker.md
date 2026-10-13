# Chạy NukeViet bằng Docker (domain ảo)

Stack phát triển cục bộ cho repo này, dựng theo pattern của `hstdt-docker`:
php-apache tự build + MariaDB + phpMyAdmin + nginx reverse proxy, mạng riêng
với IP tĩnh và alias `*.local`.

**Chỉ dùng trên máy cá nhân.** MariaDB để mật khẩu root rỗng và PHP bật
`display_errors` — không đem cấu hình này lên máy chủ thật.

## Địa chỉ

Vào được ngay, không cần cấu hình gì thêm:

| Địa chỉ | Nội dung |
|---------|----------|
| http://localhost:8088 | Website |
| http://localhost:8089 | phpMyAdmin (user `root`, mật khẩu để trống) |
| `localhost:3307` | MariaDB, cho công cụ ngoài |

Thêm domain ảo vào file hosts (bước 1 bên dưới) thì có thêm:

| Địa chỉ | Nội dung |
|---------|----------|
| http://nukeviet.local:8088 | Website |
| http://db.nukeviet.local:8088 | phpMyAdmin |

## Cài đặt lần đầu

### 1. Thêm domain ảo vào file hosts (tùy chọn)

Bỏ qua bước này vẫn dùng được stack qua `localhost` như bảng trên. Muốn có tên
miền đẹp thì cần **quyền quản trị** — Windows không cho sửa file hosts nếu không.

Mở PowerShell bằng **Run as administrator** (chuột phải vào biểu tượng
PowerShell → *Run as administrator*), rồi chạy:

```powershell
Add-Content -Path "$env:windir\System32\drivers\etc\hosts" -Value "`n127.0.0.1 nukeviet.local`n127.0.0.1 db.nukeviet.local"
```

Nếu lệnh báo lỗi quyền thì cửa sổ PowerShell đó chưa phải quyền quản trị. Cách
khác: mở Notepad bằng quyền quản trị, `File → Open`, chọn
`C:\Windows\System32\drivers\etc\hosts` (đổi bộ lọc sang *All Files*), thêm hai
dòng rồi lưu:

```
127.0.0.1 nukeviet.local
127.0.0.1 db.nukeviet.local
```

Kiểm tra: `ping nukeviet.local` phải ra `127.0.0.1`. Nếu vẫn không ra thì chạy
`ipconfig /flushdns`.

### 2. Bật stack

```bash
docker compose up -d --build
```

Lần đầu mất vài phút vì phải build ảnh PHP. Các lần sau bỏ `--build`.

### 3. Chạy trình cài đặt NukeViet

Mở http://localhost:8088 (hoặc http://nukeviet.local:8088 nếu đã thêm hosts) —
sẽ tự chuyển tới `/install/index.php`.
Khai báo CSDL:

| Trường | Giá trị |
|--------|---------|
| Máy chủ CSDL | `nukeviet_db` |
| Cổng | `3306` |
| Tên đăng nhập | `root` |
| Mật khẩu | *(để trống)* |
| Tên CSDL | `nukeviet` *(đã tạo sẵn khi container khởi động lần đầu)* |

Lưu ý: máy chủ CSDL là **`nukeviet_db`**, không phải `localhost` — hai container
nói chuyện với nhau qua tên service trong mạng Docker.

Cài xong nhớ xóa hoặc đổi tên thư mục `install/` theo cảnh báo của NukeViet.

### 4. Kích hoạt giao diện

Vào **Quản trị → Giao diện**, chọn *Nhịp Phố* (`themes/giaodienmau2`).

## Lệnh hay dùng

```bash
docker compose ps                          # trạng thái
docker compose logs -f nukeviet_web        # log Apache/PHP
docker compose restart nukeviet_web        # nạp lại sau khi đổi php.ini / vhost
docker compose down                        # tắt, giữ dữ liệu
docker compose down -v                     # tắt và XÓA CSDL
docker compose exec nukeviet_web bash      # vào container web
```

Sao lưu CSDL:

```bash
docker compose exec -T nukeviet_db mariadb-dump -u root nukeviet > .docker/mariadb/dump/nukeviet.sql
```

Phục hồi (thư mục `.docker/mariadb/dump` được mount vào `/home` của container db):

```bash
docker compose exec -T nukeviet_db sh -c 'mariadb -u root nukeviet < /home/nukeviet.sql'
```

## Cấu trúc

```
docker-compose.yml            4 service, mạng 172.21.5.0/24
.env.example                  các biến ghi đè, chép thành .env nếu cần
.docker/
├─ php/Dockerfile             php:8.3-apache + gd, pdo_mysql, mysqli, zip,
│                             mbstring, intl, exif, opcache; bật mod_rewrite,
│                             env, headers, expires, remoteip
├─ php/php.ini                upload 256M, display_errors, opcache dev
├─ apache/nukeviet.conf       AllowOverride All cho .htaccess của NukeViet,
│                             chặn .docker/ .git/ .claude/ plans/
├─ nginx/nukeviet.conf        vhost nukeviet.local và db.nukeviet.local
└─ mariadb/nukeviet.cnf       utf8mb4, max_allowed_packet 256M
```

Gốc repo được mount thẳng vào `/var/www/html`, sửa file trên Windows là thấy
đổi ngay, không cần build lại.

## Vì sao chọn các con số này

- **Cổng 8088, 8089 và 3307**, mạng **172.21.0.0/16**: `hstdt-docker` đang giữ
  8080/8443, 3306 và 172.18.0.0/16; các dải 172.19 và 172.20 cũng đã có mạng
  Docker khác dùng. Chọn lệch để hai stack chạy song song được. Muốn đổi thì
  sửa `HTTP_PORT` / `PMA_PORT` / `DB_PORT` trong `.env`.
- **nginx chuyển tiếp `Host $http_host`** (không phải `$host`): `$http_host`
  giữ nguyên cổng người dùng gõ. NukeViet dựng URL tuyệt đối từ `HTTP_HOST`,
  mất cổng là mọi liên kết sinh ra trỏ sai.
- **Dữ liệu MariaDB nằm trong volume Docker**, không bind mount từ ổ Windows —
  bind mount đi qua lớp chia sẻ tệp nên chậm hơn nhiều với thành phần đọc ghi
  đĩa nặng. Giống lý do đã ghi trong `hstdt-docker/docker-compose.yml`.
- **PHP 8.3**: NukeViet 4.x nhận PHP 7.4 – 8.5 (`install/ini.php:48-49`).
  Đổi bằng `PHP_VERSION` trong `.env`.

## Trục trặc thường gặp

- **`ping nukeviet.local` không ra 127.0.0.1** — chưa thêm dòng hosts, hoặc
  thêm rồi mà trình duyệt còn cache DNS: `ipconfig /flushdns`. Trong lúc chưa
  thêm được thì dùng http://localhost:8088 và http://localhost:8089.
- **Cổng đã bị chiếm** — `netstat -ano | findstr :8088`, rồi đổi `HTTP_PORT`
  trong `.env` và `docker compose up -d`.
- **`networks have overlapping IPv4`** — dải 172.21 đã bị mạng Docker khác lấy.
  Xem `docker network ls` rồi đổi `subnet` và các `ipv4_address` trong
  `docker-compose.yml`, kèm `RemoteIPTrustedProxy` trong
  `.docker/apache/nukeviet.conf`.
- **Trình cài đặt báo `Could not connect to data server`** — hầu như luôn do
  điền sai máy chủ hoặc cổng CSDL. Máy chủ phải là `nukeviet_db` (không phải
  `localhost` — trong container đó là chính nó), cổng `3306` (không phải `3307`
  của Windows, càng không phải `8089` của phpMyAdmin). Cách kiểm nhanh và cách
  bật log truy vấn MariaDB để soi: `docs/quy-trinh-lam-giao-dien.md`.
- **Trang trắng hoặc lỗi 500** — `docker compose logs -f nukeviet_web`.
- **Đổi php.ini hoặc vhost mà không ăn** — `docker compose restart nukeviet_web`.
