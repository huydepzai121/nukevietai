# Ảnh PHP + Apache cho NukeViet, dùng cho môi trường phát triển cục bộ.
#
# NukeViet 4.x yêu cầu PHP 7.4 – 8.5 (install/ini.php:48-49) và các phần mở rộng
# gd, xml, openssl, session, json, curl (install/ini.php:20). Lớp CSDL kế thừa
# PDO (vendor/vinades/nukeviet/Core/Database.php) nên bắt buộc có pdo_mysql.
#
# Dựng một tầng (không multi-stage như hstdt-docker): stack này chỉ chạy cục bộ,
# giữ một tầng thì dễ đọc và không phải đoán tên gói runtime (libzip4 hay libzip5,
# libicu72 hay libicu74) mỗi lần ảnh nền đổi phiên bản.

ARG PHP_VERSION=8.3
FROM docker.io/php:${PHP_VERSION}-apache

LABEL org.opencontainers.image.title="NukeViet dev (PHP + Apache)"

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        libicu-dev \
        libonig-dev \
        unzip \
    ; \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j"$(nproc)" gd pdo_mysql mysqli zip mbstring intl exif; \
    docker-php-ext-enable opcache; \
    rm -rf /var/lib/apt/lists/*

# .htaccess của NukeViet dùng mod_rewrite và mod_env; headers/expires cho tài nguyên tĩnh
RUN set -eux; \
    a2enmod rewrite env headers expires remoteip; \
    { \
        echo 'ServerSignature Off'; \
        echo 'ServerTokens Prod'; \
        echo 'ServerName localhost'; \
    } >> /etc/apache2/apache2.conf

WORKDIR /var/www/html
