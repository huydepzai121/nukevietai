#!/usr/bin/env node
/**
 * Kiểm bộ giao diện mẫu tĩnh trước khi đem đi dựng theme.
 *
 * Chỉ đọc, không sửa gì. Kiểm những thứ mà bước dựng theme phụ thuộc vào và
 * người làm hay quên: đủ trang, đúng thứ tự nạp CSS, còn nguyên khung NukeViet,
 * có bảng ánh xạ sang file theme, thẻ cân bằng, không có class thiếu style.
 *
 * Dùng:
 *   node check-giao-dien-mau.mjs giaodienmau2
 *   node check-giao-dien-mau.mjs D:/Dev/www/nukeviet/giaodienmau2
 */

import fs from 'node:fs';
import path from 'node:path';

const dir = path.resolve(process.argv[2] || '.');

const loi = [];
const canh = [];
const dat = [];

const co = (p) => fs.existsSync(path.join(dir, p));
const doc = (p) => fs.readFileSync(path.join(dir, p), 'utf8');

if (!fs.existsSync(dir)) {
    console.error(`Lỗi: không thấy thư mục ${dir}`);
    process.exit(2);
}

/* ---------------------------------------------------------------- 1. Trang */

const TRANG_BAT_BUOC = ['index.html', 'chi-tiet.html', 'mobile.html', 'design-system.html'];
const thieuTrang = TRANG_BAT_BUOC.filter((f) => !co(f));
thieuTrang.length
    ? loi.push(`Thiếu trang bắt buộc: ${thieuTrang.join(', ')}`)
    : dat.push(`Đủ ${TRANG_BAT_BUOC.length} trang bắt buộc`);

const CSS_LOP = ['tokens', 'base', 'components'];
const thieuCss = CSS_LOP.filter((f) => !co(`assets/css/${f}.css`));
thieuCss.length
    ? loi.push(`Thiếu file CSS nền: ${thieuCss.map((f) => f + '.css').join(', ')}`)
    : dat.push('Đủ 3 lớp CSS nền: tokens, base, components');

/* ------------------------------------------------- 2. Thứ tự nạp CSS mỗi trang */

const trangHtml = fs.readdirSync(dir).filter((f) => f.endsWith('.html'));

for (const f of trangHtml) {
    const html = doc(f);
    const nap = [...html.matchAll(/<link[^>]+href="assets\/css\/([a-z0-9-]+)\.css"/g)].map((m) => m[1]);

    if (!nap.length) {
        loi.push(`${f}: không nạp file CSS nào từ assets/css/`);
        continue;
    }
    const mong = CSS_LOP.filter((c) => nap.includes(c));
    const thuTuDung = JSON.stringify(nap.slice(0, mong.length)) === JSON.stringify(mong);
    if (mong.length < CSS_LOP.length) {
        loi.push(`${f}: thiếu ${CSS_LOP.filter((c) => !nap.includes(c)).join(', ')} trong thẻ link`);
    } else if (!thuTuDung) {
        loi.push(`${f}: sai thứ tự nạp CSS (${nap.join(' → ')}), phải là tokens → base → components → page-*`);
    }
    const cuoi = nap[nap.length - 1];
    if (nap.length > CSS_LOP.length && !cuoi.startsWith('page-')) {
        canh.push(`${f}: file CSS cuối cùng là "${cuoi}", thường phải là page-*`);
    }
    for (const c of nap) {
        if (!co(`assets/css/${c}.css`)) loi.push(`${f}: nạp assets/css/${c}.css nhưng file không tồn tại`);
    }
}

/* -------------------------------------------- 3. Khung NukeViet còn nguyên không */

// Chuỗi mắt xích bắt buộc của theme NukeViet. Thiếu mắt nào thì bước dựng
// theme sẽ không ánh xạ được sang layout/*.tpl tương ứng.
const KHUNG = [
    { dau: 'class="wraper"', ten: '.wraper (khung 1080px)' },
    { dau: 'section-header-bar', ten: '.section-header-bar ([CONTACT_DEFAULT]/[SOCIAL_ICONS]/[PERSONALAREA])' },
    { dau: 'id="header"', ten: '#header (logo + [HEAD_RIGHT])' },
    { dau: 'section-nav', ten: '.section-nav ([MENU_SITE])' },
    { dau: 'third-nav', ten: '.third-nav (breadcrumb + tìm kiếm)' },
    { dau: 'class="panel', ten: '.panel (block.default.tpl / block.primary.tpl)' },
];
// #footer chỉ bắt buộc ở trang desktop; bản di động thường chỉ có .footerNav2
const KHUNG_DESKTOP = [{ dau: 'id="footer"', ten: '#footer ([FOOTER])' }];

for (const f of trangHtml) {
    if (f === 'design-system.html') continue;
    const html = doc(f);
    const canKiem = f === 'mobile.html' ? KHUNG : [...KHUNG, ...KHUNG_DESKTOP];
    const thieu = canKiem.filter((k) => !html.includes(k.dau)).map((k) => k.ten);
    if (thieu.length) loi.push(`${f}: mất mắt xích khung NukeViet — ${thieu.join('; ')}`);
}
if (!loi.some((l) => l.includes('khung NukeViet'))) dat.push('Mọi trang giữ đủ khung NukeViet');

/* ------------------------------------------- 4. Bảng ánh xạ sang file theme */

if (co('design-system.html')) {
    const ds = doc('design-system.html');
    const coBang = /<table[\s\S]*?\.tpl[\s\S]*?<\/table>/.test(ds);
    coBang
        ? dat.push('design-system.html có bảng ánh xạ sang file theme')
        : loi.push('design-system.html thiếu bảng ánh xạ sang file theme (.tpl) — bước dựng theme cần bảng này');
}

/* ------------------------------------------------------- 5. Thẻ HTML cân bằng */

const VOID = new Set(['meta', 'link', 'br', 'hr', 'img', 'input', 'source', 'col', 'area', 'base']);
const SVG = new Set(['path', 'circle', 'rect', 'line', 'polyline', 'polygon', 'ellipse', 'stop']);

for (const f of trangHtml) {
    const html = doc(f);
    const stack = [];
    const bad = [];
    for (const m of html.matchAll(/<(\/?)([a-zA-Z][\w-]*)([^>]*)>/g)) {
        const [, dong, raw, attrs] = m;
        const tag = raw.toLowerCase();
        if (tag === '!doctype') continue;
        const tuDong = attrs.trimEnd().endsWith('/');
        if (SVG.has(tag)) {
            if (!dong && !tuDong) stack.push(tag);
            else if (dong && stack[stack.length - 1] === tag) stack.pop();
            continue;
        }
        if (VOID.has(tag)) continue;
        if (dong) {
            const t = stack.pop();
            if (t !== tag) bad.push(`</${tag}> đóng khi đang mở <${t}>`);
        } else if (!tuDong) stack.push(tag);
    }
    if (bad.length) loi.push(`${f}: thẻ HTML lệch — ${bad.slice(0, 2).join(' | ')}`);
    else if (stack.length) loi.push(`${f}: thẻ chưa đóng — ${stack.join(', ')}`);
}
if (!loi.some((l) => l.includes('thẻ'))) dat.push('Thẻ HTML cân bằng ở mọi trang');

/* ---------------------------------------------------- 6. Class nào chưa có style */

if (co('assets/css')) {
    const cssGop = fs
        .readdirSync(path.join(dir, 'assets/css'))
        .filter((f) => f.endsWith('.css'))
        .map((f) => doc(`assets/css/${f}`))
        .join('\n');
    const daDinhNghia = new Set([...cssGop.matchAll(/\.([a-zA-Z][\w-]*)/g)].map((m) => m[1]));

    for (const f of trangHtml) {
        const dung = new Set();
        for (const m of doc(f).matchAll(/class="([^"]+)"/g)) {
            m[1].split(/\s+/).forEach((c) => c && dung.add(c));
        }
        // Bỏ qua class chỉ làm mốc cấu trúc, cố ý không có style: chúng đánh dấu
        // vị trí block của NukeViet ([PERSONALAREA], [CONTACT_DEFAULT]…) và thứ tự
        // mục menu (n0, n1…) để bước dựng theme biết chỗ nào ghép vào đâu.
        const MOC_CAU_TRUC = new Set([
            'section-nav', 'section-body', 'section-header',
            'personalArea', 'contactDefault', 'headerSearch',
        ]);
        const thieu = [...dung].filter(
            (c) => !daDinhNghia.has(c) && !/^n\d+$/.test(c) && !MOC_CAU_TRUC.has(c)
        );
        if (thieu.length) canh.push(`${f}: class chưa có style — ${thieu.join(', ')}`);
    }
}

/* ------------------------------------------------ 7. Nội dung còn dở, ảnh thiếu alt */

for (const f of trangHtml) {
    const html = doc(f);
    if (/lorem ipsum|TODO|FIXME|Welcome to our website/i.test(html)) {
        loi.push(`${f}: còn nội dung giữ chỗ kiểu lorem ipsum / TODO`);
    }
    const anhThieuAlt = [...html.matchAll(/<img\b(?![^>]*\balt=)[^>]*>/g)].length;
    if (anhThieuAlt) canh.push(`${f}: ${anhThieuAlt} thẻ <img> thiếu alt`);
    if (/[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}]/u.test(html)) {
        canh.push(`${f}: có emoji trong nội dung — biểu tượng nên vẽ bằng SVG nội tuyến`);
    }
}

/* ------------------------------------------------------------------- Kết quả */

const ten = path.basename(dir);
console.log(`\nKiểm bộ giao diện mẫu: ${ten}\n`);
for (const d of dat) console.log(`  ok    ${d}`);
for (const c of canh) console.log(`  luu y ${c}`);
for (const l of loi) console.log(`  LOI   ${l}`);
console.log(`\n${loi.length} lỗi, ${canh.length} lưu ý.\n`);
process.exit(loi.length ? 1 : 0);
