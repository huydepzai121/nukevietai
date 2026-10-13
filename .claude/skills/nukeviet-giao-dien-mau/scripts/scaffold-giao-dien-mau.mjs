#!/usr/bin/env node
/**
 * Tạo bộ khung giao diện mẫu tĩnh cho NukeViet.
 *
 * Sinh ra một bộ CHẠY ĐƯỢC NGAY nhưng CHƯA CÓ THẨM MỸ: đúng khung NukeViet
 * (.wraper 1080px, lưới 24 cột, chuỗi header → menu → breadcrumb → 3 cột →
 * footer, khối panel ba tầng), CSS chia ba lớp, bảng màu trung tính. Việc của
 * người thiết kế là đổi tokens và lớp nhìn, KHÔNG đổi khung.
 *
 * Dùng:
 *   node scaffold-giao-dien-mau.mjs --name giaodienmau3 --title "Tên site" --root D:/Dev/www/nukeviet
 *   node scaffold-giao-dien-mau.mjs --name giaodienmau3            (root = thư mục hiện tại)
 */

import fs from 'node:fs';
import path from 'node:path';

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

const die = (m) => {
    console.error('Lỗi: ' + m);
    process.exit(1);
};

const args = parseArgs(process.argv.slice(2));
const root = path.resolve(args.root === true || !args.root ? process.cwd() : args.root);
const name = args.name;
const title = args.title === true || !args.title ? 'Tên Site' : args.title;

if (!name || name === true) die('thiếu --name <tên-thư-mục>, ví dụ --name giaodienmau3');
if (!/^[a-z0-9][a-z0-9-]*$/.test(name)) die('tên thư mục chỉ gồm chữ thường, số và dấu "-"');

const out = path.join(root, name);
if (fs.existsSync(out)) die(`${out} đã tồn tại — chọn tên khác, script không ghi đè`);

/* ------------------------------------------------------------------ Mảnh dùng chung */

const head = (tieuDe, css) => `<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${tieuDe} — ${title}</title>
<link rel="stylesheet" href="assets/css/tokens.css">
<link rel="stylesheet" href="assets/css/base.css">
<link rel="stylesheet" href="assets/css/components.css">
<link rel="stylesheet" href="assets/css/${css}.css">
</head>
<body>
`;

const icon = {
    home: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"><path d="M3 11l9-7 9 7"></path><path d="M5 10v10h14V10"></path></svg>',
    tim: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7"></circle><path d="M20 20l-3.5-3.5"></path></svg>',
    len: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M12 19V6"></path><path d="M6 11l6-6 6 6"></path></svg>',
    anh: '<svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="3" y="5" width="18" height="14" rx="2"></rect><circle cx="8.5" cy="10" r="1.5"></circle><path d="M21 16l-5-5-4 4-2-2-4 4"></path></svg>',
};

const MUC = ['Thời sự', 'Kinh tế', 'Xã hội', 'Pháp luật', 'Thế giới', 'Thể thao'];

// Thanh trên + đầu trang + menu. Class personalArea / contactDefault là mốc
// đánh dấu vị trí block của NukeViet, cố ý không có style.
const khungTren = (mucDangXem) => `
<!-- Thanh trên — [CONTACT_DEFAULT] [SOCIAL_ICONS] [PERSONALAREA] -->
<div class="section-header-bar">
  <div class="wraper">
    <div class="header-nav-inner">
      <div class="contactDefault">Hotline [SỐ ĐIỆN THOẠI] · [EMAIL TÒA SOẠN]</div>
      <div class="spacer"></div>
      <div class="personalArea"><a href="#">Đăng nhập</a></div>
    </div>
  </div>
</div>

<!-- Đầu trang — logo, {SITE_DESCRIPTION}, [HEAD_RIGHT] -->
<div class="section-header">
  <div class="wraper">
    <div id="header">
      <div class="logo">
        <a href="index.html"><span class="brand">${title}</span></a>
        <span class="site_description">[Mô tả ngắn của site]</span>
      </div>
      <div class="right-ads">
        <div class="ads-slot" style="height: 90px;">Banner 728 × 90</div>
      </div>
    </div>
  </div>
</div>

<!-- Menu — [MENU_SITE] -->
<div class="section-nav">
  <div class="wraper">
    <ul class="navbar">
      <li class="${mucDangXem === 0 ? 'active' : ''}"><a href="index.html">${icon.home}</a></li>
${MUC.map((m, i) => `      <li class="${mucDangXem === i + 1 ? 'active' : ''}"><a href="chuyen-muc.html">${m}</a></li>`).join('\n')}
    </ul>
  </div>
</div>
`;

const thanhDuongDan = (duongDan) => `
    <!-- Đường dẫn + tìm kiếm -->
    <div class="third-nav">
      <ul class="breadcrumbs">
${duongDan.map((d) => `        <li><a href="${d[1]}">${d[0]}</a></li>`).join('\n')}
      </ul>
      <span class="current-time">Cập nhật [GIỜ], [NGÀY THÁNG NĂM]</span>
      <div class="headerSearch">
        <input type="text" placeholder="Tìm kiếm...">
        <span class="go">${icon.tim}</span>
      </div>
    </div>
`;

const khungDuoi = `
<!-- Chân trang — [FOOTER] -->
<div id="footer">
  <div class="wraper">
    <div class="grid-4">
      <div>
        <div class="h3">${title}</div>
        <p>Cơ quan chủ quản: [TÊN CƠ QUAN]</p>
        <p>Giấy phép số [SỐ GIẤY PHÉP] do [CƠ QUAN CẤP] cấp</p>
        <p>Tổng biên tập: [HỌ TÊN]</p>
        <p>[ĐỊA CHỈ TÒA SOẠN]</p>
      </div>
      <div>
        <div class="h3">Chuyên mục</div>
        <ul class="menu">
${MUC.slice(0, 4).map((m) => `          <li><a href="chuyen-muc.html">${m}</a></li>`).join('\n')}
        </ul>
      </div>
      <div>
        <div class="h3">Hỗ trợ</div>
        <ul class="menu">
          <li><a href="#">Liên hệ tòa soạn</a></li>
          <li><a href="#">Quảng cáo</a></li>
          <li><a href="#">Điều khoản sử dụng</a></li>
        </ul>
      </div>
      <div>
        <div class="h3">Nhận bản tin</div>
        <p>[Một dòng mời đăng ký]</p>
        <div class="footer-form">
          <input type="text" placeholder="Email của bạn">
          <button type="button">Đăng ký</button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="footerNav2">
  <div class="wraper">
    <div class="inner">
      <span>© [NĂM] ${title}</span>
      <span>Vận hành trên NukeViet CMS</span>
      <span class="bttop">${icon.len}</span>
    </div>
  </div>
</div>

</body>
</html>
`;

const oAnh = (cao, rong) =>
    `<div class="ph"${rong ? ` style="width: ${rong}px; height: ${cao}px;"` : ` style="height: ${cao}px;"`}>${icon.anh}</div>`;

const khoiBen = (tieuDe, muc) => `
        <div class="panel">
          <div class="panel-heading">${tieuDe}</div>
          <div class="panel-body">
            <ul class="side-list">
${muc.map((m) => `              <li><a href="chi-tiet.html">${m}</a></li>`).join('\n')}
            </ul>
          </div>
        </div>
`;

const TIN = [
    '[Tiêu đề tin thứ nhất, viết như tin thật để canh độ dài]',
    '[Tiêu đề tin thứ hai]',
    '[Tiêu đề tin thứ ba, dài hơn một chút để thử xuống dòng]',
    '[Tiêu đề tin thứ tư]',
];

/* ------------------------------------------------------------------------ Trang */

const trangChu = `${head('Trang chủ', 'page-home')}${khungTren(0)}
<div class="section-body">
  <div class="wraper">
${thanhDuongDan([['Trang chủ', 'index.html']])}
    <div class="body-grid">

      <!-- [LEFT] — 5/24 cột -->
      <div class="col-left">
${khoiBen('Chuyên mục', MUC)}
        <div class="ads-slot" style="height: 300px;">Quảng cáo 210 × 300</div>
      </div>

      <!-- {MODULE_CONTENT} — 13/24 cột -->
      <div class="col-main">
        <div class="panel">
          <div class="panel-body">
            <div class="hero">
              ${oAnh(300)}
              <span class="cat-tag">${MUC[0]}</span>
              <h2 class="headline"><a href="chi-tiet.html">[Tiêu đề tin nổi bật, khoảng 8–14 chữ]</a></h2>
              <p class="sapo">[Sapo hai tới ba dòng, tóm tắt nội dung chính của bài.]</p>
              <div class="meta"><span>[GIỜ] hôm nay</span><span>·</span><span>[TÊN TÁC GIẢ]</span></div>
            </div>
          </div>
        </div>

        <div class="panel">
          <div class="panel-heading">Tin mới nhất</div>
          <div class="panel-body">
${TIN.map(
    (t) => `            <div class="news-item">
              ${oAnh(110, 180)}
              <div>
                <h3 class="headline"><a href="chi-tiet.html">${t}</a></h3>
                <p class="tom-tat">[Một tới hai dòng tóm tắt.]</p>
                <div class="meta"><span class="cat-tag">${MUC[1]}</span><span>[GIỜ] hôm nay</span></div>
              </div>
            </div>`
).join('\n')}
          </div>
        </div>
      </div>

      <!-- [RIGHT] — 6/24 cột -->
      <div class="col-right">
        <div class="panel panel-primary">
          <div class="panel-heading">Đọc nhiều</div>
          <div class="panel-body">
            <ul class="hot-list">
${TIN.map((t, i) => `              <li><span class="num">${i + 1}</span><a href="chi-tiet.html">${t}</a></li>`).join('\n')}
            </ul>
          </div>
        </div>
        <div class="ads-slot" style="height: 250px;">Quảng cáo 255 × 250</div>
      </div>

    </div>
  </div>
</div>
${khungDuoi}`;

const trangChuyenMuc = `${head('Chuyên mục', 'page-category')}${khungTren(1)}
<div class="section-body">
  <div class="wraper">
${thanhDuongDan([['Trang chủ', 'index.html'], [MUC[0], 'chuyen-muc.html']])}
    <!-- layout.main-right: {MODULE_CONTENT} 18 cột + [RIGHT] 6 cột -->
    <div class="body-grid">
      <div class="col-main col-main--wide">
        <div class="cat-head">
          <h1>${MUC[0]}</h1>
          <p class="tom-tat">[Một dòng mô tả chuyên mục.]</p>
        </div>
        <div class="panel">
          <div class="panel-body">
${TIN.map(
    (t) => `            <div class="news-item">
              ${oAnh(120, 200)}
              <div>
                <h3 class="headline"><a href="chi-tiet.html">${t}</a></h3>
                <p class="tom-tat">[Một tới hai dòng tóm tắt.]</p>
                <div class="meta"><span class="cat-tag">${MUC[0]}</span><span>[GIỜ] hôm nay</span></div>
              </div>
            </div>`
).join('\n')}
          </div>
        </div>
        <div class="pager">
          <a href="#">Trước</a><a class="on" href="chuyen-muc.html">1</a><a href="#">2</a><a href="#">3</a><a href="#">Sau</a>
        </div>
      </div>
      <div class="col-right">
${khoiBen('Đọc nhiều trong chuyên mục', TIN)}
        <div class="ads-slot" style="height: 250px;">Quảng cáo 255 × 250</div>
      </div>
    </div>
  </div>
</div>
${khungDuoi}`;

const trangChiTiet = `${head('Chi tiết bài viết', 'page-article')}${khungTren(1)}
<div class="section-body">
  <div class="wraper">
${thanhDuongDan([['Trang chủ', 'index.html'], [MUC[0], 'chuyen-muc.html']])}
    <div class="body-grid">
      <div class="col-left">
${khoiBen('Cùng chuyên mục', TIN)}
      </div>

      <div class="col-main">
        <div class="panel">
          <div class="panel-body">
            <div id="news_detail">
              <span class="cat-tag">${MUC[0]}</span>
              <h1>[Tiêu đề bài viết, khoảng 8–14 chữ]</h1>
              <div class="byline">
                <span class="tom-tat">[TÊN TÁC GIẢ] · [GIỜ], [NGÀY THÁNG NĂM]</span>
              </div>
              <p class="sapo">[Sapo: hai tới ba dòng tóm tắt nội dung chính.]</p>
              ${oAnh(300)}
              <span class="imgalt">[Chú thích ảnh] — Ảnh: [TÊN TÁC GIẢ ẢNH]</span>
              <div class="bodytext">
                <p>[Đoạn thân bài thứ nhất. Viết đủ dài để canh được giãn dòng và bề rộng cột đọc.]</p>
                <p>[Đoạn thân bài thứ hai.]</p>
                <h2>[Tiêu đề phụ]</h2>
                <p>[Đoạn thân bài thứ ba.]</p>
              </div>
              <div class="article-tags">
                <span class="tom-tat">Từ khóa</span>
                <a class="tag" href="#">[Từ khóa 1]</a>
                <a class="tag" href="#">[Từ khóa 2]</a>
              </div>
            </div>
          </div>
        </div>

        <div class="panel panel-primary">
          <div class="panel-heading">Tin liên quan</div>
          <div class="panel-body">
            <ul class="side-list">
${TIN.map((t) => `              <li><a href="chi-tiet.html">${t}</a></li>`).join('\n')}
            </ul>
          </div>
        </div>

        <div class="panel">
          <div class="panel-heading">Ý kiến bạn đọc</div>
          <div class="panel-body">
            <textarea class="comment-box" placeholder="Viết bình luận của bạn..."></textarea>
            <div class="comment-actions">
              <span class="tom-tat">[Ghi chú về việc duyệt bình luận.]</span>
              <button type="button" class="btn btn-primary">Gửi bình luận</button>
            </div>
          </div>
        </div>
      </div>

      <div class="col-right">
        <div class="panel panel-primary">
          <div class="panel-heading">Đọc nhiều</div>
          <div class="panel-body">
            <ul class="hot-list">
${TIN.map((t, i) => `              <li><span class="num">${i + 1}</span><a href="chi-tiet.html">${t}</a></li>`).join('\n')}
            </ul>
          </div>
        </div>
        <div class="ads-slot" style="height: 250px;">Quảng cáo 255 × 250</div>
      </div>
    </div>
  </div>
</div>
${khungDuoi}`;

const trangMobile = `${head('Di động', 'page-mobile')}
<div class="section-header-bar">
  <div class="wraper">
    <div class="header-nav-inner">
      <div class="contactDefault">Hotline [SỐ ĐIỆN THOẠI]</div>
      <div class="spacer"></div>
      <div class="personalArea"><a href="#">Đăng nhập</a></div>
    </div>
  </div>
</div>

<div class="section-header">
  <div class="wraper">
    <div id="header">
      <div class="logo">
        <a href="mobile.html"><span class="brand">${title}</span></a>
        <span class="site_description">[Mô tả ngắn của site]</span>
      </div>
    </div>
  </div>
</div>

<div class="section-nav">
  <div class="wraper">
    <ul class="navbar">
      <li class="active"><a href="mobile.html">${icon.home}</a></li>
${MUC.slice(0, 3).map((m) => `      <li><a href="chuyen-muc.html">${m}</a></li>`).join('\n')}
    </ul>
  </div>
</div>

<div class="section-body">
  <div class="wraper">
    <div class="third-nav">
      <div class="headerSearch">
        <input type="text" placeholder="Tìm kiếm...">
        <span class="go">${icon.tim}</span>
      </div>
    </div>

    <div class="panel">
      <div class="panel-body">
        ${oAnh(190)}
        <span class="cat-tag">${MUC[0]}</span>
        <h2 class="headline"><a href="chi-tiet.html">[Tiêu đề tin nổi bật]</a></h2>
        <div class="meta"><span>[GIỜ] hôm nay</span></div>
      </div>
    </div>

    <div class="panel">
      <div class="panel-heading">Tin mới nhất</div>
      <div class="panel-body">
${TIN.map(
    (t) => `        <div class="m-item">
          <div>
            <h3 class="headline"><a href="chi-tiet.html">${t}</a></h3>
            <div class="meta"><span class="cat-tag">${MUC[1]}</span><span>[GIỜ]</span></div>
          </div>
          ${oAnh(70, 96)}
        </div>`
).join('\n')}
      </div>
    </div>

    <div class="ads-slot" style="height: 250px;">Quảng cáo 300 × 250</div>
  </div>
</div>

<div class="footerNav2">
  <div class="wraper">
    <div class="inner">
      <span>© [NĂM] ${title}</span>
      <span><a href="index.html">Xem bản máy tính</a></span>
    </div>
  </div>
</div>

</body>
</html>
`;

const trangHeThong = `${head('Hệ thống thiết kế', 'page-design-system')}
<div class="sheet">
  <h1 class="sheet-title">Hệ thống thiết kế — ${title}</h1>
  <p class="tom-tat">Bộ khung do script sinh ra. Đổi giá trị trong <code>assets/css/tokens.css</code>
  rồi cập nhật lại trang này cho khớp. Khung NukeViet thì giữ nguyên.</p>
  <div class="sheet-nav">
    <a href="index.html">Trang chủ</a>
    <a href="chuyen-muc.html">Chuyên mục</a>
    <a href="chi-tiet.html">Chi tiết bài viết</a>
    <a href="mobile.html">Di động</a>
  </div>

  <h2>1. Màu</h2>
  <div class="sw-grid">
    <div class="sw"><div class="chip" style="background-color: #2f5d8a;"></div><div class="name">Màu chính</div><div class="hex">#2f5d8a</div><div class="src">--mau-chinh · menu, nút, tiêu đề khối</div></div>
    <div class="sw"><div class="chip" style="background-color: #1f4062;"></div><div class="name">Màu chính đậm</div><div class="hex">#1f4062</div><div class="src">--mau-chinh-dam · liên kết, chân trang</div></div>
    <div class="sw"><div class="chip" style="background-color: #e8eef5;"></div><div class="name">Màu chính nhạt</div><div class="hex">#e8eef5</div><div class="src">--mau-chinh-nhat · khối nhấn, nhãn</div></div>
    <div class="sw"><div class="chip" style="background-color: #1c1c22;"></div><div class="name">Chữ đậm</div><div class="hex">#1c1c22</div><div class="src">--chu</div></div>
    <div class="sw"><div class="chip" style="background-color: #6b6b78;"></div><div class="name">Chữ mờ</div><div class="hex">#6b6b78</div><div class="src">--chu-mo · thời gian, tác giả</div></div>
    <div class="sw"><div class="chip" style="background-color: #f4f5f7;"></div><div class="name">Nền trang</div><div class="hex">#f4f5f7</div><div class="src">--nen</div></div>
    <div class="sw"><div class="chip" style="background-color: #ffffff;"></div><div class="name">Nền khối</div><div class="hex">#ffffff</div><div class="src">--nen-khoi</div></div>
    <div class="sw"><div class="chip" style="background-color: #e2e4ea;"></div><div class="name">Viền</div><div class="hex">#e2e4ea</div><div class="src">--vien</div></div>
  </div>

  <h2>2. Chữ</h2>
  <div class="type-row"><span class="lbl">Tiêu đề bài</span><span class="headline" style="font-size: 30px;">[Tiêu đề bài viết]</span></div>
  <div class="type-row"><span class="lbl">Tiêu đề tin</span><span class="headline" style="font-size: 17px;">[Tiêu đề tin trong danh sách]</span></div>
  <div class="type-row"><span class="lbl">Sapo</span><span class="sapo">[Sapo của bài viết]</span></div>
  <div class="type-row"><span class="lbl">Thân bài 16px / 1.75</span><span>[Đoạn thân bài]</span></div>
  <div class="type-row"><span class="lbl">Phụ chú 12.5px</span><span class="tom-tat">Thời gian, tác giả, số bình luận</span></div>

  <h2>3. Lưới</h2>
  <p class="tom-tat">Khung <code>.wraper</code> 1080px, lưới 24 cột, khoảng cách 30px. Không đổi.</p>
  <div class="gridnote">
    <div class="cell" style="width: 210px;">[LEFT] — 5 cột</div>
    <div class="cell" style="width: 555px;">{MODULE_CONTENT} — 13 cột</div>
    <div class="cell" style="width: 255px;">[RIGHT] — 6 cột</div>
  </div>

  <h2>4. Khối nội dung</h2>
  <div class="grid-2">
    <div class="panel">
      <div class="panel-heading">Khối mặc định</div>
      <div class="panel-body">Ba tầng panel → panel-heading → panel-body, tương ứng <code>block.default.tpl</code>.</div>
    </div>
    <div class="panel panel-primary">
      <div class="panel-heading">Khối nhấn</div>
      <div class="panel-body">Tương ứng <code>block.primary.tpl</code>.</div>
    </div>
  </div>

  <h2>5. Ánh xạ sang theme NukeViet</h2>
  <p class="tom-tat">Bảng này là thứ bước dựng theme đọc để biết sửa file nào. Cập nhật khi thêm trang mới.</p>
  <table class="maptable">
    <thead>
      <tr><th style="width: 28%;">Phần trong bản mẫu</th><th style="width: 34%;">File theme tương ứng</th><th>Ghi chú</th></tr>
    </thead>
    <tbody>
      <tr><td>Thanh trên, logo, menu, breadcrumb</td><td><code>layout/header_extended.tpl</code></td><td>[CONTACT_DEFAULT], [SOCIAL_ICONS], [PERSONALAREA], [HEAD_RIGHT], [MENU_SITE]</td></tr>
      <tr><td>Bố cục 3 cột</td><td><code>layout/layout.left-main-right.tpl</code></td><td>5 / 13 / 6 trong lưới 24 cột</td></tr>
      <tr><td>Bố cục 2 cột trang chuyên mục</td><td><code>layout/layout.main-right.tpl</code></td><td>18 / 6 cột</td></tr>
      <tr><td><code>.panel</code> / <code>.panel-primary</code></td><td><code>layout/block.default.tpl</code>, <code>block.primary.tpl</code></td><td>Giữ ba tầng, chỉ đổi trang trí</td></tr>
      <tr><td>Tin nổi bật, danh sách tin trang chủ</td><td><code>modules/news/block_*.tpl</code></td><td>Trang chủ module news dựng từ block, không có main.tpl</td></tr>
      <tr><td>Danh sách theo chuyên mục</td><td><code>modules/news/viewcat_*.tpl</code></td><td>list, page, grid</td></tr>
      <tr><td>Chi tiết bài viết</td><td><code>modules/news/detail.tpl</code></td><td></td></tr>
      <tr><td>Bình luận</td><td><code>modules/comment/main.tpl</code>, <code>comment.tpl</code></td><td></td></tr>
      <tr><td>Ô quảng cáo</td><td>block <code>banners</code></td><td>Thay <code>.ads-slot</code> bằng block thật</td></tr>
      <tr><td>Chân trang</td><td><code>layout/footer_extended.tpl</code></td><td>[FOOTER] và .footerNav2</td></tr>
      <tr><td>Token và thành phần</td><td><code>css/</code> của theme</td><td>Nạp tokens → base → components → trang, trước custom.css</td></tr>
    </tbody>
  </table>

  <h2>6. Nguyên tắc khi mở rộng</h2>
  <ul class="rules">
    <li>Màu mới thêm vào <code>tokens.css</code>, không rải mã màu trong trang.</li>
    <li>Thành phần dùng ở nhiều trang để <code>components.css</code>, không để <code>page-*.css</code>.</li>
    <li>Vùng chạm trên di động tối thiểu 44px; chữ thân bài không nhỏ hơn 16px.</li>
    <li>Biểu tượng vẽ bằng SVG nội tuyến, không dùng emoji.</li>
    <li>Dữ kiện chưa có để trong ngoặc vuông, không bịa.</li>
  </ul>
</div>

</body>
</html>
`;

/* -------------------------------------------------------------------------- CSS */

const cssTokens = `/**
 * ${name} — Design tokens
 *
 * ĐÂY LÀ NƠI ĐỔI LỚP NHÌN. Bảng màu dưới đây trung tính, cố ý nhạt, để thấy rõ
 * chỗ nào chưa được thiết kế. Đổi giá trị ở đây, đừng rải mã màu trong trang.
 *
 * Bám theme có sẵn thì chép đúng giá trị từ themes/<theme>/css/style.css và ghi
 * chú selector gốc vào cuối mỗi dòng.
 */

:root {
    --mau-chinh: #2f5d8a;
    --mau-chinh-dam: #1f4062;
    --mau-chinh-nhat: #e8eef5;

    --chu: #1c1c22;
    --chu-nhat: #3d3d48;
    --chu-mo: #6b6b78;

    --nen: #f4f5f7;
    --nen-khoi: #ffffff;
    --nen-dau-khoi: #f7f8fa;
    --vien: #e2e4ea;
    --vien-nhat: #eceef2;

    --chu-thuong: system-ui, -apple-system, 'Segoe UI', sans-serif;

    /* Lưới NukeViet — KHÔNG ĐỔI */
    --khung: 1080px;
    --cach-cot: 30px;
    --cot-trai: 210px;   /* 5/24  */
    --cot-giua: 555px;   /* 13/24 */
    --cot-phai: 255px;   /* 6/24  */
    --cot-rong: 795px;   /* 18/24 */

    --bo-goc: 6px;
    --bo-goc-nho: 4px;
}
`;

const cssBase = `/**
 * ${name} — Nền tảng: reset, chữ, khung trang, lưới
 */

* { box-sizing: border-box; }

body {
    margin: 0;
    background-color: var(--nen);
    color: var(--chu);
    font-family: var(--chu-thuong);
    font-size: 14px;
    line-height: 1.5;
    -webkit-font-smoothing: antialiased;
}

a, a:link, a:visited { color: var(--mau-chinh-dam); text-decoration: none; }
a:hover, a:focus { color: var(--mau-chinh); }

h1, h2, h3 { margin: 0; font-weight: 700; line-height: 1.25; }
p { margin: 0 0 10px; }
ul { margin: 0; padding: 0; list-style: none; }
img { display: block; max-width: 100%; }

/* Khung 1080px của theme NukeViet */
.wraper { width: var(--khung); margin: 0 auto; }

/* Bố cục 3 cột theo layout.left-main-right (5 / 13 / 6 trong lưới 24 cột) */
.body-grid { display: flex; gap: var(--cach-cot); padding: 18px 0 30px; align-items: flex-start; }
.col-left { width: var(--cot-trai); flex-shrink: 0; }
.col-main { width: var(--cot-giua); flex-shrink: 0; }
.col-right { width: var(--cot-phai); flex-shrink: 0; }

/* Biến thể layout.main-right (18 / 6 cột) */
.col-main--wide { width: var(--cot-rong); }

.grid-2 { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 20px; }
.grid-4 { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: var(--cach-cot); }

.tom-tat { color: var(--chu-mo); font-size: 12.5px; }
`;

const cssComponents = `/**
 * ${name} — Thành phần dùng chung
 *
 * Mọi thứ xuất hiện ở nhiều trang phải nằm ở đây, KHÔNG nằm ở page-*.css:
 * khi lên theme, page-* dễ thành css/<module>.css mà file đó chỉ được nạp trên
 * trang thuộc đúng module ấy.
 */

/* Thanh trên — [CONTACT_DEFAULT] [SOCIAL_ICONS] [PERSONALAREA] */
.section-header-bar { background-color: var(--mau-chinh-dam); color: #ffffff; font-size: 12.5px; }
.header-nav-inner { display: flex; align-items: center; gap: 16px; height: 36px; }
.header-nav-inner .spacer { flex-grow: 1; }
.header-nav-inner a { color: #ffffff; }

/* Đầu trang — logo + [HEAD_RIGHT] */
.section-header { background-color: var(--nen-khoi); border-bottom: 1px solid var(--vien); }
#header { display: flex; align-items: center; gap: var(--cach-cot); padding: 18px 0; }
#header .logo .brand { display: block; font-size: 26px; font-weight: 700; color: var(--mau-chinh-dam); }
#header .logo .site_description { color: var(--chu-mo); font-size: 12.5px; }
#header .right-ads { flex-grow: 1; }

.ads-slot {
    border: 1px dashed var(--vien); background-color: var(--nen-khoi); color: var(--chu-mo);
    border-radius: var(--bo-goc); display: flex; align-items: center; justify-content: center;
    font-size: 12px; text-transform: uppercase; letter-spacing: .5px; margin-bottom: 18px;
}

/* Menu — [MENU_SITE] */
.section-nav { background-color: var(--nen-khoi); }
.navbar { display: flex; align-items: stretch; border-top: 1px solid var(--vien); }
.navbar a { display: block; padding: 12px 15px; color: var(--chu-nhat); font-size: 13.5px; font-weight: 600; }
.navbar a:hover { background-color: var(--nen); }
.navbar li.active a { color: var(--mau-chinh-dam); box-shadow: inset 0 -3px 0 var(--mau-chinh); }

/* Đường dẫn + tìm kiếm */
.third-nav { display: flex; align-items: center; gap: 10px; padding: 14px 0 0; }
.breadcrumbs { display: flex; align-items: center; gap: 8px; font-size: 12.5px; color: var(--chu-mo); }
.breadcrumbs a { color: var(--chu-mo); }
.current-time { color: var(--chu-mo); font-size: 12.5px; margin-left: auto; }
.headerSearch {
    display: flex; align-items: center; gap: 8px; height: 36px; width: 240px;
    background-color: var(--nen-khoi); border: 1px solid var(--vien);
    border-radius: var(--bo-goc); padding: 0 8px 0 12px;
}
.headerSearch input { flex-grow: 1; border: 0; outline: 0; background: none; height: 34px; font-family: inherit; font-size: 13px; color: var(--chu); }
.headerSearch .go { color: var(--mau-chinh); display: flex; align-items: center; }

/* Khối — block.default.tpl / block.primary.tpl */
.panel {
    background-color: var(--nen-khoi); border: 1px solid var(--vien);
    border-radius: var(--bo-goc); margin-bottom: 18px; overflow: hidden;
}
.panel-heading {
    padding: 12px 16px; background-color: var(--nen-dau-khoi);
    border-bottom: 1px solid var(--vien); font-size: 14px; font-weight: 700;
}
.panel-body { padding: 16px; }
.panel-primary { border-color: var(--mau-chinh); }
.panel-primary > .panel-heading { background-color: var(--mau-chinh); border-color: var(--mau-chinh); color: #ffffff; }

/* Ô giữ chỗ ảnh — thay bằng ảnh thật khi có */
.ph {
    background-color: var(--vien-nhat); color: var(--chu-mo);
    border-radius: var(--bo-goc-nho); flex-shrink: 0;
    display: flex; align-items: center; justify-content: center;
}

/* Mẫu tin */
.headline { font-size: 17px; }
.headline a { color: var(--chu); }
.sapo { font-size: 15px; font-weight: 600; line-height: 1.6; color: var(--chu-nhat); }
.meta { display: flex; align-items: center; gap: 7px; margin-top: 7px; color: var(--chu-mo); font-size: 12.5px; }
.cat-tag {
    display: inline-block; padding: 3px 9px; border-radius: var(--bo-goc-nho);
    background-color: var(--mau-chinh-nhat); color: var(--mau-chinh-dam);
    font-size: 11.5px; font-weight: 700;
}
.news-item { display: flex; gap: 14px; padding: 14px 0; border-bottom: 1px solid var(--vien-nhat); }
.news-item:first-child { padding-top: 0; }
.news-item:last-child { border-bottom: 0; padding-bottom: 0; }
.news-item .tom-tat { margin: 6px 0 0; }

.hot-list li { display: flex; gap: 10px; padding: 10px 0; border-bottom: 1px solid var(--vien-nhat); }
.hot-list li:first-child { padding-top: 0; }
.hot-list li:last-child { border-bottom: 0; padding-bottom: 0; }
.hot-list a { color: var(--chu); font-size: 13px; font-weight: 600; line-height: 1.45; }
.hot-list .num {
    flex-shrink: 0; width: 22px; height: 22px; border-radius: var(--bo-goc-nho);
    background-color: var(--mau-chinh-nhat); color: var(--mau-chinh-dam);
    font-size: 12px; font-weight: 700; display: flex; align-items: center; justify-content: center;
}

.side-list li { padding: 10px 0; border-bottom: 1px solid var(--vien-nhat); }
.side-list li:first-child { padding-top: 0; }
.side-list li:last-child { border-bottom: 0; padding-bottom: 0; }
.side-list a { color: var(--chu); font-size: 13px; font-weight: 600; line-height: 1.45; }

.tag {
    display: inline-block; padding: 5px 11px; border-radius: var(--bo-goc-nho);
    background-color: var(--nen); border: 1px solid var(--vien);
    font-size: 12.5px; font-weight: 600; color: var(--chu-nhat);
}

.btn {
    display: inline-flex; align-items: center; justify-content: center;
    height: 44px; padding: 0 20px; border: 0; border-radius: var(--bo-goc);
    font-family: inherit; font-size: 14px; font-weight: 700; cursor: pointer;
}
.btn-primary { background-color: var(--mau-chinh); color: #ffffff; }

.pager { display: flex; gap: 4px; justify-content: center; margin-top: 20px; }
.pager a {
    min-width: 36px; height: 36px; line-height: 34px; padding: 0 10px; text-align: center;
    border: 1px solid var(--vien); background-color: var(--nen-khoi); color: var(--mau-chinh-dam);
    border-radius: var(--bo-goc-nho);
}
.pager a.on { background-color: var(--mau-chinh); border-color: var(--mau-chinh); color: #ffffff; }

/* Chân trang — [FOOTER] */
#footer { background-color: var(--mau-chinh-dam); color: #d6dce4; padding: 28px 0 22px; font-size: 13px; }
#footer a { color: #d6dce4; }
#footer a:hover { color: #ffffff; }
#footer p { margin: 0 0 5px; }
#footer .h3 { color: #ffffff; font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: .6px; margin-bottom: 12px; }
#footer .menu li a { display: block; padding: 5px 0; }
.footer-form { display: flex; gap: 6px; margin-top: 10px; }
.footer-form input { flex-grow: 1; height: 34px; border: 0; border-radius: var(--bo-goc-nho); padding: 0 10px; font-family: inherit; font-size: 13px; }
.footer-form button { height: 34px; padding: 0 14px; border: 0; border-radius: var(--bo-goc-nho); background-color: var(--mau-chinh); color: #ffffff; font-family: inherit; font-size: 13px; font-weight: 700; cursor: pointer; }

.footerNav2 { background-color: #16304a; color: #9aa8b8; padding: 12px 0; font-size: 12.5px; }
.footerNav2 .inner { display: flex; align-items: center; gap: 14px; }
.footerNav2 a { color: #9aa8b8; }
.footerNav2 .bttop { margin-left: auto; color: #9aa8b8; display: flex; align-items: center; }
`;

const cssHome = `/**
 * ${name} — Trang chủ
 */

.hero .ph { width: 100%; }
.hero .cat-tag { margin-top: 12px; }
.hero .headline { font-size: 26px; margin: 10px 0 8px; }
`;

const cssCategory = `/**
 * ${name} — Trang chuyên mục
 */

.cat-head { padding-bottom: 12px; margin-bottom: 16px; border-bottom: 2px solid var(--mau-chinh); }
.cat-head h1 { font-size: 26px; color: var(--mau-chinh-dam); }
.cat-head .tom-tat { margin: 6px 0 0; }
`;

const cssArticle = `/**
 * ${name} — Trang chi tiết bài viết
 */

#news_detail h1 { font-size: 28px; margin: 10px 0 12px; }
.byline { padding-bottom: 12px; margin-bottom: 14px; border-bottom: 1px solid var(--vien-nhat); }
#news_detail .sapo { margin-bottom: 14px; }
#news_detail .ph { width: 100%; }
.imgalt { display: block; text-align: center; margin-top: 6px; color: var(--chu-mo); font-size: 12.5px; font-style: italic; }
.bodytext { margin-top: 16px; }
.bodytext p { font-size: 16px; line-height: 1.75; margin: 0 0 16px; }
.bodytext h2 { font-size: 20px; margin: 22px 0 10px; }
.article-tags { display: flex; align-items: center; flex-wrap: wrap; gap: 8px; margin-top: 18px; padding-top: 14px; border-top: 1px solid var(--vien-nhat); }
.comment-box {
    width: 100%; height: 84px; border: 1px solid var(--vien); border-radius: var(--bo-goc);
    padding: 10px 12px; font-family: inherit; font-size: 14px; color: var(--chu); resize: none; outline: 0;
}
.comment-actions { display: flex; align-items: center; justify-content: space-between; gap: 12px; margin-top: 10px; }
`;

const cssMobile = `/**
 * ${name} — Bản di động 390px
 *
 * LƯU Ý: những rule chỉ phục vụ việc XEM MẪU ở khung 390px (ví dụ
 * body { max-width: 390px } và viền giả khung điện thoại) phải nằm hết trong
 * file này, để bước dựng theme biết đường loại bỏ. Đừng để lẫn sang file khác.
 */

body {
    max-width: 390px;
    margin: 0 auto;
    border-left: 1px solid var(--vien);
    border-right: 1px solid var(--vien);
}

.wraper { width: 100%; padding: 0 12px; }
#header { padding: 14px 0; }
#header .logo .brand { font-size: 21px; }
#header .right-ads { display: none; }
.navbar { overflow: hidden; }
.navbar a { padding: 13px 12px; min-height: 44px; }
.headerSearch { width: 100%; height: 44px; }
.headerSearch input { height: 42px; }
.third-nav { padding: 12px 0; }
.panel { margin-bottom: 12px; }
.panel-body .ph { width: 100%; }

.m-item { display: flex; gap: 12px; padding: 12px 0; border-bottom: 1px solid var(--vien-nhat); }
.m-item:first-child { padding-top: 0; }
.m-item:last-child { border-bottom: 0; padding-bottom: 0; }
.m-item .headline { font-size: 14.5px; }

.footerNav2 .inner { flex-direction: column; align-items: flex-start; gap: 4px; }
`;

const cssSheet = `/**
 * ${name} — Trang hệ thống thiết kế
 * Chỉ dùng cho design-system.html, không đưa vào theme.
 */

body { background-color: var(--nen-khoi); }

.sheet { width: var(--khung); margin: 0 auto; padding: 30px 0 40px; }
.sheet-title { font-size: 26px; color: var(--mau-chinh-dam); }
.sheet h2 { font-size: 18px; color: var(--mau-chinh-dam); padding-bottom: 8px; border-bottom: 2px solid var(--mau-chinh-nhat); margin: 32px 0 16px; }
.sheet code { font-family: 'Courier New', Courier, monospace; font-size: 12.5px; background-color: var(--mau-chinh-nhat); color: var(--mau-chinh-dam); padding: 1px 5px; border-radius: 3px; }

.sheet-nav { display: flex; flex-wrap: wrap; gap: 8px; margin: 14px 0 0; }
.sheet-nav a { padding: 7px 14px; border: 1px solid var(--vien); border-radius: var(--bo-goc); background-color: var(--nen); font-size: 13px; font-weight: 600; color: var(--chu-nhat); }
.sheet-nav a:hover { border-color: var(--mau-chinh); color: var(--mau-chinh-dam); }

.sw-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 16px; }
.sw .chip { height: 64px; border-radius: var(--bo-goc); border: 1px solid rgba(0, 0, 0, .1); }
.sw .name { font-size: 12.5px; font-weight: 700; margin-top: 8px; }
.sw .hex { font-size: 12px; color: var(--chu-mo); font-family: 'Courier New', Courier, monospace; }
.sw .src { font-size: 11px; color: var(--chu-mo); margin-top: 3px; line-height: 1.4; }

.type-row { display: flex; align-items: baseline; gap: 20px; padding: 11px 0; border-bottom: 1px solid var(--vien-nhat); }
.type-row .lbl { width: 220px; flex-shrink: 0; font-size: 12px; color: var(--chu-mo); font-family: 'Courier New', Courier, monospace; }

.gridnote { display: flex; gap: var(--cach-cot); }
.gridnote .cell {
    background-color: var(--mau-chinh-nhat); border: 1px solid var(--vien);
    border-radius: var(--bo-goc-nho); height: 58px;
    display: flex; align-items: center; justify-content: center;
    font-size: 12.5px; font-weight: 600; color: var(--mau-chinh-dam);
}

.maptable { width: 100%; border-collapse: collapse; font-size: 13px; }
.maptable th, .maptable td { text-align: left; padding: 10px 13px; border: 1px solid var(--vien); vertical-align: top; }
.maptable th { background-color: var(--nen); font-weight: 700; }

.rules { line-height: 1.9; }
.rules li { padding-left: 18px; position: relative; }
.rules li::before {
    content: ''; position: absolute; left: 2px; top: 12px;
    width: 6px; height: 6px; border-radius: 50%; background-color: var(--mau-chinh);
}
`;

/* -------------------------------------------------------------------------- Ghi */

const files = {
    'index.html': trangChu,
    'chuyen-muc.html': trangChuyenMuc,
    'chi-tiet.html': trangChiTiet,
    'mobile.html': trangMobile,
    'design-system.html': trangHeThong,
    'assets/css/tokens.css': cssTokens,
    'assets/css/base.css': cssBase,
    'assets/css/components.css': cssComponents,
    'assets/css/page-home.css': cssHome,
    'assets/css/page-category.css': cssCategory,
    'assets/css/page-article.css': cssArticle,
    'assets/css/page-mobile.css': cssMobile,
    'assets/css/page-design-system.css': cssSheet,
    'assets/img/.gitkeep': '',
};

for (const [p, noiDung] of Object.entries(files)) {
    const dich = path.join(out, p);
    fs.mkdirSync(path.dirname(dich), { recursive: true });
    fs.writeFileSync(dich, noiDung);
}

console.log(`Đã tạo ${name}/ (${Object.keys(files).length} file).`);
console.log('Bước tiếp theo:');
console.log(`  1. Mở ${name}/index.html bằng trình duyệt để xem bộ khung`);
console.log(`  2. Đổi lớp nhìn trong ${name}/assets/css/tokens.css, rồi tới components.css`);
console.log(`  3. Thay nội dung trong ngoặc vuông [ ] bằng nội dung mẫu thật`);
console.log(`  4. Cập nhật ${name}/design-system.html cho khớp, nhất là bảng ánh xạ`);
console.log(`  5. Kiểm: node <skill>/scripts/check-giao-dien-mau.mjs ${name}`);
