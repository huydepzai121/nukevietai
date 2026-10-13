<!DOCTYPE html>
    <html lang="{LANG.Content_Language}" xmlns="http://www.w3.org/1999/xhtml" prefix="og: http://ogp.me/ns#">
    <head>
        <title>{THEME_PAGE_TITLE}</title>
        <script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/theme-mode.js"></script>
        <!-- BEGIN: metatags --><meta {THEME_META_TAGS.name}="{THEME_META_TAGS.value}" content="{THEME_META_TAGS.content}">
        <!-- END: metatags -->
        <link rel="shortcut icon" href="{SITE_FAVICON}">
        <link rel="icon" type="image/png" href="{NV_BASE_SITEURL}uploads/favicon.png">
        <link rel="apple-touch-icon" href="{NV_BASE_SITEURL}uploads/apple-touch-icon.png">
        <meta name="theme-color" content="#09090b">
        <!-- BEGIN: links -->
        <link<!-- BEGIN: attr --> {LINKS.key}<!-- BEGIN: val -->="{LINKS.value}"<!-- END: val --><!-- END: attr -->>
        <!-- END: links -->
        <!-- BEGIN: js -->
        <script<!-- BEGIN: ext --> src="{JS_SRC}"<!-- END: ext -->><!-- BEGIN: int -->{JS_CONTENT}<!-- END: int --></script>
        <!-- END: js -->
        <script type="application/ld+json">
        {
            "@context": "https://schema.org",
            "@type": "Organization",
            "url": "{NV_MY_DOMAIN}",
            "logo": "{NV_MY_DOMAIN}{LOGO_SRC}"
        }
        </script>
    </head>
    <body>
