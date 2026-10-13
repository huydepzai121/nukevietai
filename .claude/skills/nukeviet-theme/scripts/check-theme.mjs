#!/usr/bin/env node
/**
 * Kiểm một theme NukeViet theo hợp đồng với core và chuẩn thiết kế
 * (references/chuan-thiet-ke.md). Chỉ đọc, không sửa gì.
 *
 * Dùng:
 *   node check-theme.mjs --name giaodienmau4 [--root D:/Dev/www/nukeviet]
 *
 * Mã thoát: 0 = không lỗi, 1 = có lỗi, 2 = sai tham số.
 */

import fs from 'node:fs';
import path from 'node:path';

const argv = process.argv.slice(2);
const arg = (k) => {
    const i = argv.indexOf(`--${k}`);
    return i >= 0 && argv[i + 1] && !argv[i + 1].startsWith('--') ? argv[i + 1] : undefined;
};
const root = path.resolve(arg('root') || process.cwd());
const name = arg('name');
if (!name) {
    console.error('Lỗi: thiếu --name <tên-theme>');
    process.exit(2);
}
const dir = path.join(root, 'themes', name);
const ref = path.join(root, 'themes', 'default');
if (!fs.existsSync(dir)) {
    console.error(`Lỗi: không thấy ${dir}`);
    process.exit(2);
}

const loi = [];
const canh = [];
const dat = [];
const rel = (f) => path.relative(dir, f).replace(/\\/g, '/');
const tpls = fs.readdirSync(dir, { recursive: true }).map(String).filter((f) => f.endsWith('.tpl')).map((f) => path.join(dir, f));

// 1. Cặp BEGIN/END cân bằng và khớp khối với themes/default
const blocks = (s) => {
    const out = [];
    const stack = [];
    const re = /<!--\s*(BEGIN|END):\s*(\w+)/gi;
    let m;
    let ok = true;
    while ((m = re.exec(s))) {
        const [, word, b] = m;
        if (word.toUpperCase() === 'BEGIN') {
            stack.push(b);
            out.push(b);
        } else if (stack.pop() !== b) ok = false;
    }
    return { list: out.sort(), ok: ok && stack.length === 0 };
};
let tplOk = 0;
for (const f of tpls) {
    const s = fs.readFileSync(f, 'utf8');
    const b = blocks(s);
    const twin = path.join(ref, rel(f));
    if (!b.ok) {
        // Vài tpl gốc của core đóng khối lệch thứ tự sẵn (statistics, two-step-verification) — chỉ báo khi default không lệch
        const twinOk = !fs.existsSync(twin) || blocks(fs.readFileSync(twin, 'utf8')).ok;
        if (twinOk) loi.push(`${rel(f)}: cặp BEGIN/END lệch hoặc lồng sai`);
        else tplOk++;
        continue;
    }
    if (name !== 'default' && fs.existsSync(twin)) {
        const d = blocks(fs.readFileSync(twin, 'utf8')).list;
        const missing = d.filter((x) => !b.list.includes(x));
        if (missing.length) canh.push(`${rel(f)}: thiếu khối so với default: ${[...new Set(missing)].join(', ')}`);
    }
    tplOk++;
}
dat.push(`${tplOk}/${tpls.length} tpl cân bằng BEGIN/END`);

// 2. Vị trí [TAG] dùng trong layout phải khai báo <position> trong config.ini
const cfgPath = path.join(dir, 'config.ini');
if (!fs.existsSync(cfgPath)) loi.push('thiếu config.ini');
else {
    const cfg = fs.readFileSync(cfgPath, 'utf8');
    const declared = new Set([...cfg.matchAll(/<tag>\s*\[([A-Z0-9_]+)\]\s*<\/tag>/g)].map((m) => m[1]));
    const core = new Set(['THEME_ERROR_INFO']);
    const used = new Set();
    for (const f of tpls.filter((f) => rel(f).startsWith('layout/'))) {
        for (const m of fs.readFileSync(f, 'utf8').matchAll(/\[([A-Z][A-Z0-9_]+)\]/g)) used.add(m[1]);
    }
    const undeclared = [...used].filter((t) => !declared.has(t) && !core.has(t));
    if (undeclared.length) loi.push(`vị trí dùng trong layout nhưng chưa khai báo <position>: ${undeclared.join(', ')}`);
    else dat.push(`${used.size} vị trí block trong layout đều có <position>`);
}

// 3. CSS khai báo trong theme.php phải tồn tại; nv-standard.css nạp trước custom.css
const phpPath = path.join(dir, 'theme.php');
if (fs.existsSync(phpPath)) {
    const php = fs.readFileSync(phpPath, 'utf8');
    const files = [...php.matchAll(/'module_theme'\] \. '\/css\/([\w.-]+\.css)'/g)].map((m) => m[1]);
    const missing = [...new Set(files)].filter((f) => !fs.existsSync(path.join(dir, 'css', f)));
    if (missing.length) loi.push(`theme.php nạp CSS không tồn tại: ${missing.join(', ')}`);
    const iStd = php.indexOf('/css/nv-standard.css');
    const iCustom = php.indexOf("/css/custom.css'");
    if (iStd < 0) canh.push('theme.php chưa nạp css/nv-standard.css (chuẩn khung/lưới/chữ)');
    else if (iCustom >= 0 && iStd > iCustom) loi.push('css/nv-standard.css phải nạp TRƯỚC css/custom.css');
    else dat.push('css/nv-standard.css nạp trước custom.css');
    if (files.includes('components.css') && fs.existsSync(path.join(dir, 'css', 'components.css'))) {
        const c = fs.readFileSync(path.join(dir, 'css', 'components.css'), 'utf8');
        if (/^\.display\s*\{|^\.label\s*\{/m.test(c)) {
            loi.push('css/components.css có rule .display/.label trần — trùng class markup core (.display trong breadcrumbs, .label của BS3)');
        }
    }
} else loi.push('thiếu theme.php');

// 4. Marker section mở/đóng cân bằng trong layout
for (const f of tpls.filter((f) => rel(f).startsWith('layout/'))) {
    const s = fs.readFileSync(f, 'utf8');
    const opens = [...s.matchAll(/<!-- ===== (?!END )([A-Z0-9:\- ]+?) ===== -->/g)].map((m) => m[1]);
    const closes = [...s.matchAll(/<!-- ===== END ([A-Z0-9:\- ]+?) ===== -->/g)].map((m) => m[1]);
    const bad = opens.filter((o) => !closes.includes(o)).concat(closes.filter((c) => !opens.includes(c)));
    if (bad.length) loi.push(`${rel(f)}: marker thiếu cặp: ${bad.join(', ')}`);
}
for (const f of ['layout/header_extended.tpl', 'layout/footer_extended.tpl']) {
    const p = path.join(dir, f);
    if (fs.existsSync(p) && !fs.readFileSync(p, 'utf8').includes('<!-- ===== ')) canh.push(`${f}: chưa có marker section`);
}

// 5. Không đặt width px cố định cho khung/cột chính
const cssDir = path.join(dir, 'css');
const own = ['ds-tokens.css', 'tokens.css', 'base.css', 'components.css', 'nt-responsive.css', 'custom.css'];
for (const f of own.filter((f) => fs.existsSync(path.join(cssDir, f)))) {
    const s = fs.readFileSync(path.join(cssDir, f), 'utf8');
    for (const m of s.matchAll(/(\.wraper|\.col-[a-z]+-\d+|#body)\s*\{[^}]*\bwidth:\s*\d+px/g)) {
        loi.push(`css/${f}: ${m[1]} đặt width px cố định — dùng % / cột lưới`);
    }
    for (const m of s.matchAll(/grid-template-columns:[^;]*\b\d{3,}px/g)) {
        canh.push(`css/${f}: "${m[0].trim()}" — cột layout nên dùng fr/cột lưới, không px`);
    }
}

// 6. Ảnh trong tpl phải có alt
let noAlt = 0;
for (const f of tpls) {
    for (const m of fs.readFileSync(f, 'utf8').matchAll(/<img\b[^>]*>/gi)) if (!/\balt=/i.test(m[0])) noAlt++;
}
if (noAlt) canh.push(`${noAlt} thẻ <img> trong tpl thiếu alt`);
else dat.push('mọi <img> trong tpl đều có alt');

for (const x of dat) console.log(`  ✓ ${x}`);
for (const x of canh) console.log(`  ! ${x}`);
for (const x of loi) console.log(`  ✗ ${x}`);
console.log(`\n${loi.length} lỗi, ${canh.length} cảnh báo.`);
process.exit(loi.length ? 1 : 0);
