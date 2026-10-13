#!/usr/bin/env node
/**
 * Tạo bộ khung theme NukeViet mới bằng cách nhân bản một theme có sẵn.
 *
 * NukeViet khuyến nghị đúng cách này: themes/default/config.ini ghi rõ
 * "không nên sửa trực tiếp vào giao diện này, hãy copy thành giao diện khác".
 *
 * Dùng:
 *   node scaffold-theme.mjs --name giaodienmau --title "Giao diện mẫu" --author "Tên bạn"
 *   node scaffold-theme.mjs --name giaodienmau --from default --root D:/Dev/www/nukeviet
 *   node scaffold-theme.mjs --name giaodienmau4 --from giaodienmau3  *        --design-system nhat-trinh-design-system --title "Nhật Trình"
 *
 * Mặc định (bỏ được bằng --no-standard) script còn áp chuẩn thiết kế
 * (references/chuan-thiet-ke.md):
 *   - chép assets/nv-standard.css → css/nv-standard.css (khung 1190px, gutter
 *     20px, chữ gốc 16px tỉ lệ 1.25, focus, vùng chạm)
 *   - --design-system <dir>: chép <dir>/tokens.css → css/ds-tokens.css
 *     (không chép components.css — trùng tên class với markup core)
 *   - khai báo các file trên trong theme.php, ngay trước css/custom.css
 *   - chèn comment marker <!-- ===== TEN ===== --> ... <!-- ===== END TEN ===== -->
 *     vào header_extended.tpl, footer_extended.tpl và layout.*.tpl
 */

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const SKILL_DIR = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

const RESERVED = ['default', 'admin_default', 'mobile_default'];

function parseArgs(argv) {
    const args = {};
    for (let i = 0; i < argv.length; i++) {
        if (!argv[i].startsWith('--')) continue;
        const key = argv[i].slice(2);
        const next = argv[i + 1];
        args[key] = next && !next.startsWith('--') ? (i++, next) : true;
    }
    return args;
}

function die(message) {
    console.error('Lỗi: ' + message);
    process.exit(1);
}

const args = parseArgs(process.argv.slice(2));
const root = path.resolve(args.root || process.cwd());
const name = args.name;
const from = args.from || 'default';

if (!name || name === true) die('thiếu --name <tên-theme>');
if (!/^[a-z0-9][a-z0-9_-]*$/.test(name)) die('tên theme chỉ gồm chữ thường, số, "-" và "_", bắt đầu bằng chữ hoặc số');
if (RESERVED.includes(name)) die(`"${name}" là theme hệ thống, không được ghi đè`);

const themesDir = path.join(root, 'themes');
if (!fs.existsSync(themesDir)) die(`không thấy ${themesDir} — chạy lại với --root <thư mục gốc NukeViet>`);

const srcDir = path.join(themesDir, from);
const outDir = path.join(themesDir, name);
if (!fs.existsSync(srcDir)) die(`không thấy theme nguồn ${srcDir}`);
if (fs.existsSync(outDir)) die(`${outDir} đã tồn tại — xóa hoặc chọn tên khác, script không ghi đè`);

fs.cpSync(srcDir, outDir, { recursive: true });

// Cập nhật khối <info> trong config.ini
const configPath = path.join(outDir, 'config.ini');
if (fs.existsSync(configPath)) {
    let xml = fs.readFileSync(configPath, 'utf8');
    const replaceTag = (tag, value) => {
        if (value === undefined || value === true) return;
        const re = new RegExp(`(<info>[\\s\\S]*?<${tag}>)[\\s\\S]*?(</${tag}>)`);
        if (re.test(xml)) xml = xml.replace(re, `$1${value}$2`);
    };
    replaceTag('name', args.title || name);
    replaceTag('author', args.author);
    replaceTag('website', args.website);
    replaceTag(
        'description',
        args.description || `Giao diện ${args.title || name}, nhân bản từ theme ${from}.`
    );
    fs.writeFileSync(configPath, xml);
}

// ---------- Áp chuẩn thiết kế ----------
const applied = [];
if (!args['no-standard']) {
    const cssDir = path.join(outDir, 'css');
    const links = [];

    if (args['design-system'] && args['design-system'] !== true) {
        const dsDir = path.resolve(root, args['design-system']);
        const dsTokens = path.join(dsDir, 'tokens.css');
        if (!fs.existsSync(dsTokens)) die(`không thấy ${dsTokens}`);
        fs.copyFileSync(dsTokens, path.join(cssDir, 'ds-tokens.css'));
        links.push('ds-tokens.css');
        applied.push(`css/ds-tokens.css ← ${path.relative(root, dsTokens)}`);
    }

    fs.copyFileSync(path.join(SKILL_DIR, 'assets', 'nv-standard.css'), path.join(cssDir, 'nv-standard.css'));
    applied.push('css/nv-standard.css');

    // theme.php: ds-tokens.css nạp sớm nhất trong lớp nhìn (trước tokens.css của theme
    // nếu có, để token riêng của theme thắng); nv-standard.css nạp ngay trước custom.css.
    const themePhp = path.join(outDir, 'theme.php');
    let php = fs.readFileSync(themePhp, 'utf8');
    const linkCode = (file, comment) =>
        `    // ${comment}\n    $html_links[] = [\n        'rel' => 'stylesheet',\n        'href' => NV_STATIC_URL . 'themes/' . $global_config['module_theme'] . '/css/${file}'\n    ];\n`;
    const insertBefore = (needleFile, code) => {
        const esc = needleFile.replace(/\./g, '\\.');
        const re = new RegExp(String.raw` {4}\$html_links\[\] = \[\s*'rel' => 'stylesheet',\s*'href' => [^\n]*/css/` + esc + String.raw`'[\s\S]*?\];\r?\n`);
        const m = php.match(re);
        if (!m) return false;
        php = php.replace(m[0], code + m[0]);
        return true;
    };
    if (links.includes('ds-tokens.css') && !php.includes('/css/ds-tokens.css')) {
        const code = linkCode('ds-tokens.css', 'Token ngữ nghĩa từ design system (--color-*, --space-*, --text-*...)');
        if (!insertBefore('tokens.css', code) && !insertBefore('custom.css', code)) die('theme.php: không tìm thấy chỗ nạp css/custom.css');
    }
    if (!php.includes('/css/nv-standard.css')) {
        const code = linkCode('nv-standard.css', 'Chuẩn thiết kế: khung 1190px, lưới 24 cột gutter 20px, chữ 16px/1.25, focus');
        if (!insertBefore('custom.css', code)) die('theme.php: không tìm thấy chỗ nạp css/custom.css');
    }
    fs.writeFileSync(themePhp, php);
    applied.push('theme.php: khai báo CSS trước custom.css');

    // Marker section — parser XTemplate chỉ bắt "BEGIN:"/"END:" có dấu hai chấm nên an toàn.
    const layoutDir = path.join(outDir, 'layout');
    const wrapFile = (file, name) => {
        const f = path.join(layoutDir, file);
        if (!fs.existsSync(f)) return;
        let tpl = fs.readFileSync(f, 'utf8');
        if (tpl.includes(`<!-- ===== ${name} ===== -->`)) return;
        tpl = `<!-- ===== ${name} ===== -->\n${tpl.replace(/\s+$/, '')}\n<!-- ===== END ${name} ===== -->\n`;
        fs.writeFileSync(f, tpl);
        applied.push(`layout/${file}: marker ${name}`);
    };
    wrapFile('header_extended.tpl', 'HEADER');
    wrapFile('footer_extended.tpl', 'FOOTER');
    for (const file of fs.readdirSync(layoutDir).filter((f) => /^layout\..+\.tpl$/.test(f))) {
        const f = path.join(layoutDir, file);
        let tpl = fs.readFileSync(f, 'utf8');
        if (tpl.includes('<!-- ===== BODY ===== -->')) continue;
        const open = '{FILE "header_extended.tpl"}';
        const close = '{FILE "footer_extended.tpl"}';
        if (!tpl.includes(open) || !tpl.includes(close)) continue;
        tpl = tpl.replace(open, `${open}\n<!-- ===== BODY ===== -->`).replace(close, `<!-- ===== END BODY ===== -->\n${close}`);
        fs.writeFileSync(f, tpl);
    }
    applied.push('layout/layout.*.tpl: marker BODY');
}

const count = fs.readdirSync(outDir, { recursive: true }).length;
console.log(`Đã tạo themes/${name} từ themes/${from} (${count} mục).`);
if (applied.length) console.log('Đã áp chuẩn thiết kế:\n  - ' + applied.join('\n  - '));
console.log('Bước tiếp theo:');
console.log(`  1. Thay themes/${name}/default.jpg bằng ảnh thumbnail của giao diện mới`);
console.log(`  2. Đưa CSS thiết kế vào themes/${name}/css/ và khai báo trong themes/${name}/theme.php`);
console.log(`  3. Sửa layout/*.tpl và modules/*/*.tpl theo bản thiết kế`);
console.log(`  4. Chạy: node .claude/skills/nukeviet-theme/scripts/check-theme.mjs --name ${name}`);
console.log(`  5. Vào Quản trị → Giao diện để kích hoạt "${args.title || name}"`);
