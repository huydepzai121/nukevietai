<!-- ===== HEADER ===== -->
    <noscript>
        <div class="alert alert-danger">{LANG.nojs}</div>
    </noscript>
    <a class="skip-link" href="#body">Bỏ qua tới nội dung</a>
    <header class="ds-header" id="at-header">
        <div class="ds-banner">
            <div class="ds-wrap ds-banner__in">
                <a class="ds-brand" title="{SITE_NAME}" href="{THEME_SITE_HREF}">
                    <img class="ds-brand__logo" src="{NV_BASE_SITEURL}themes/{TEMPLATE}/images/ds-logo-oval.png" alt="{SITE_NAME}" width="160" height="100">
                    <span class="ds-brand__text"><span class="ds-brand__name">AI TODAY</span><span class="ds-brand__sub">Tin tức Trí tuệ nhân tạo</span></span>
                    <!-- BEGIN: site_name_h1 --><h1 class="sr-only">{SITE_NAME}</h1><!-- END: site_name_h1 -->
                    <!-- BEGIN: site_name_span --><span class="sr-only">{SITE_NAME}</span><!-- END: site_name_span -->
                </a>
                <div class="at-pos ds-headright">[HEAD_RIGHT]</div>
            </div>
        </div>
        <nav class="ds-nav" id="menusite" aria-label="Menu chính">
            <div class="ds-wrap">[MENU_SITE]</div>
        </nav>
        <div class="ds-bar">
            <div class="ds-wrap ds-bar__in">
                <span class="ds-date current-time">{NV_CURRENTTIME}</span>
                <!-- BEGIN: breadcrumbs -->
                <div class="breadcrumbs-wrap"><div class="display"><a class="show-subs-breadcrumbs hidden" href="#" onclick="showSubBreadcrumbs(this, event);"><em class="fa fa-lg fa-angle-right"></em></a><ul class="breadcrumbs list-none"></ul></div><ul class="subs-breadcrumbs"></ul><ul class="temp-breadcrumbs hidden" itemscope itemtype="https://schema.org/BreadcrumbList"><li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a href="{THEME_SITE_HREF}" itemprop="item" title="{LANG.Home}"><span itemprop="name">{LANG.Home}</span></a><i class="hidden" itemprop="position" content="1"></i></li><!-- BEGIN: loop --><li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a href="{BREADCRUMBS.link}" itemprop="item" title="{BREADCRUMBS.title}"><span class="txt" itemprop="name">{BREADCRUMBS.title}</span></a><i class="hidden" itemprop="position" content="{BREADCRUMBS.position}"></i></li><!-- END: loop --></ul></div>
                <!-- END: breadcrumbs -->
                <div class="ds-tickpos">[DS_TICKER]</div>
                <div class="ds-bar__right">
                    <div class="at-pos ds-social">[SOCIAL_ICONS]</div>
                    <div class="personalArea">[PERSONALAREA]</div>
                    <div class="headerSearch ds-search">
                        <input type="text" class="form-control" maxlength="{NV_MAX_SEARCH_LENGTH}" placeholder="Tìm kiếm..." aria-label="{LANG.search}"><button type="button" class="ds-search__btn" data-url="{THEME_SEARCH_URL}" data-minlength="{NV_MIN_SEARCH_LENGTH}" data-click="y" aria-label="{LANG.search}"><em class="fa fa-search"></em></button>
                    </div>
                </div>
            </div>
        </div>
        <div id="tip" data-content=""><div class="bg"></div></div>
    </header>
    <div class="ds-wrap at-pos contactDefault">[CONTACT_DEFAULT]</div>
    <div class="section-body">
        <div class="wraper">
            <section>
                <div class="container ds-body" id="body">
                    <!-- BEGIN: currenttime --><!-- END: currenttime -->
                    [THEME_ERROR_INFO]
<!-- ===== END HEADER ===== -->
