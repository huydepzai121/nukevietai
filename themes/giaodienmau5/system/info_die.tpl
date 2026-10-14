<!-- BEGIN: main -->
<!DOCTYPE html>
<html lang="{LANG.Content_Language}" data-theme="light">
    <head>
        <meta http-equiv="content-type" content="text/html; charset={SITE_CHARSET}" />
        <meta http-equiv="expires" content="0" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="noindex">
        <title>{PAGE_TITLE}</title>
        <link rel="shortcut icon" href="{SITE_FAVICON}" />
        <script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/theme-mode.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@700;900&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap&subset=vietnamese" rel="stylesheet">
        <style>
        :root{--red:#b3121c;--red2:#8c0d15;--ink:#1a1a1a;--muted:#5f6368;--line:#e3e3e3;--bg:#fff;--soft:#f6f5f2;--card:#fff}
        [data-theme="dark"]{--ink:#ececec;--muted:#a3a3a3;--line:#2c2c2c;--bg:#111;--soft:#181818;--card:#1a1a1a;--red:#e0313c}
        *{box-sizing:border-box}html{font-size:16px}
        body{margin:0;min-height:100vh;display:flex;flex-direction:column;background:var(--soft);color:var(--ink);font-family:"Be Vietnam Pro",system-ui,-apple-system,"Segoe UI",Roboto,sans-serif;font-size:16px;line-height:1.65}
        a{color:inherit;text-decoration:none}a:hover{color:var(--red)}
        :focus-visible{outline:3px solid #f2b705;outline-offset:2px}
        .top{background:var(--bg);border-bottom:3px solid var(--red)}
        .top-in{max-width:1190px;margin:0 auto;padding:16px 20px;display:flex;align-items:center;justify-content:space-between;gap:12px}
        .logo{display:inline-flex;align-items:center;gap:10px;font-family:Merriweather,Georgia,serif;font-weight:900;font-size:28px;letter-spacing:-.02em}
        .logo b{color:var(--red)}
        .tg{width:40px;height:40px;border-radius:50%;border:1px solid var(--line);background:transparent;color:var(--ink);cursor:pointer;font-size:18px}
        main{flex:1;display:flex;align-items:center;justify-content:center;padding:48px 20px}
        .card{width:100%;max-width:680px;background:var(--card);border:1px solid var(--line);border-top:4px solid var(--red);padding:40px 36px;text-align:center}
        .code{font-family:Merriweather,Georgia,serif;font-weight:900;font-size:88px;line-height:1;color:var(--red);margin:0 0 8px}
        h1{font-family:Merriweather,Georgia,serif;font-size:26px;line-height:1.3;margin:0 0 12px}
        .msg{color:var(--muted);font-size:16.5px;margin:0 0 28px}
        .msg p{margin:0 0 8px}
        form{display:flex;gap:8px;max-width:480px;margin:0 auto 28px}
        input[type=search]{flex:1;min-width:0;height:46px;padding:0 14px;font:inherit;font-size:16px;color:var(--ink);background:var(--bg);border:1px solid var(--line);border-radius:4px}
        button.go{height:46px;padding:0 20px;font:inherit;font-weight:600;color:#fff;background:var(--red);border:0;border-radius:4px;cursor:pointer}
        button.go:hover{background:var(--red2)}
        .btns{display:flex;flex-wrap:wrap;gap:10px;justify-content:center;margin-bottom:28px}
        .btn{display:inline-block;padding:10px 20px;font-weight:600;font-size:15px;border:1px solid var(--line);border-radius:4px}
        .btn.p{background:var(--red);border-color:var(--red);color:#fff}.btn.p:hover{background:var(--red2);color:#fff}
        .cats-t{font-size:13px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--muted);margin:0 0 12px;border-top:1px solid var(--line);padding-top:22px}
        .cats{display:flex;flex-wrap:wrap;gap:8px;justify-content:center;list-style:none;padding:0;margin:0}
        .cats a{display:inline-block;padding:6px 14px;font-size:15px;background:var(--soft);border:1px solid var(--line);border-radius:999px}
        footer{background:#141414;color:#a3a3a3;font-size:14px;text-align:center;padding:18px 20px}
        @media(max-width:600px){.card{padding:30px 20px}.code{font-size:68px}h1{font-size:22px}form{flex-direction:column}input[type=search]{flex:none;width:100%}button.go{width:100%}.logo{font-size:24px}}
        </style>
    </head>
    <body>
        <header class="top"><div class="top-in">
            <a class="logo" href="{HOME_LINK}" title="{SITE_NAME}"><svg width="36" height="36" viewBox="0 0 48 48" aria-hidden="true"><rect x="2" y="2" width="44" height="44" rx="8" fill="#b3121c"/><path d="M14 34 L24 13 L34 34 M18.6 27 H29.4" stroke="#fff" stroke-width="2.6" stroke-linecap="round" fill="none"/><circle cx="24" cy="13" r="3" fill="#fff"/><circle cx="14" cy="34" r="3" fill="#fff"/><circle cx="34" cy="34" r="3" fill="#fff"/></svg><span>AI <b>Today</b></span></a>
            <button type="button" class="tg theme-toggle" aria-label="Đổi giao diện sáng/tối" onclick="var r=document.documentElement,m=r.getAttribute('data-theme')==='dark'?'light':'dark';r.setAttribute('data-theme',m);try{localStorage.setItem('ai-theme-mode',m)}catch(e){}">&#9680;</button>
        </div></header>
        <main><div class="card">
            <p class="code" aria-hidden="true">!</p>
            <h1>{INFO_TITLE}</h1>
            <div class="msg">{INFO_CONTENT}</div>
            <form action="{NV_BASE_SITEURL}seek/" method="get" role="search">
                <input type="search" name="q" placeholder="Tìm bài viết về AI…" aria-label="Tìm kiếm" minlength="3">
                <button class="go" type="submit">Tìm kiếm</button>
            </form>
            <div class="btns">
                <!-- BEGIN: sitelink --><a class="btn p" href="{SITE_LINK}">{GO_SITEPAGE}</a><!-- END: sitelink -->
                <!-- BEGIN: adminlink --><a class="btn" href="{ADMIN_LINK}">{GO_ADMINPAGE}</a><!-- END: adminlink -->
                <a class="btn" href="javascript:history.back()">Quay lại trang trước</a>
            </div>
            <p class="cats-t">Chuyên mục</p>
            <ul class="cats">
                <li><a href="{NV_BASE_SITEURL}tin-tuc-ai/">Tin tức AI</a></li>
                <li><a href="{NV_BASE_SITEURL}mo-hinh-ngon-ngu-lon/">Mô hình ngôn ngữ lớn</a></li>
                <li><a href="{NV_BASE_SITEURL}cong-cu-ai/">Công cụ AI</a></li>
                <li><a href="{NV_BASE_SITEURL}thi-truong-dau-tu/">Thị trường &amp; Đầu tư</a></li>
                <li><a href="{NV_BASE_SITEURL}phan-cung-ai/">Phần cứng AI</a></li>
                <li><a href="{NV_BASE_SITEURL}dao-duc-phap-ly-ai/">Đạo đức &amp; Pháp lý AI</a></li>
            </ul>
        </div></main>
        <footer>© {SITE_NAME}</footer>
        <script>(function(){var c=document.querySelector('.code');var t=document.title.match(/\b([45]\d\d)\b/);if(c&&t)c.textContent=t[1];})();</script>
    </body>
</html>
<!-- END: main -->
