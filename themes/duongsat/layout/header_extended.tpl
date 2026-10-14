<!-- ===== HEADER ===== -->
    <noscript>
        <div class="alert alert-danger">{LANG.nojs}</div>
    </noscript>
    <a class="skip-link" href="#body">Bỏ qua tới nội dung</a>
    <header class="ds-header" id="at-header">
        <div class="ds-banner">
            <div class="ds-wrap ds-banner__in">
                <a class="ds-brand" title="{SITE_NAME}" href="{THEME_SITE_HREF}">
                    <img class="ds-brand__logo" src="{NV_BASE_SITEURL}themes/{TEMPLATE}/images/ds-logo.svg" alt="{SITE_NAME}" width="120" height="80">
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
                <span class="ds-date" id="np-date">{NV_CURRENTTIME}</span>
                <div class="ds-ticker">
                    <strong class="ds-ticker__label"><em class="fa fa-certificate"></em> Điểm tin nhanh:</strong>
                    <div class="ds-ticker__track"><ul class="ds-ticker__list"><!-- BEGIN: ticker --><li><a href="{TICK.link}" title="{TICK.title}">{TICK.title}</a></li><!-- END: ticker --></ul></div>
                </div>
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
                    <!-- BEGIN: breadcrumbs -->
                    <nav class="np-bc" aria-label="Breadcrumb">
                        <ol class="np-bc__list" itemscope itemtype="https://schema.org/BreadcrumbList">
                            <li class="np-bc__item np-bc__item--home" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a href="{THEME_SITE_HREF}" itemprop="item" title="{LANG.Home}"><svg class="np-bc__home" viewBox="0 0 24 24" width="15" height="15" aria-hidden="true"><path fill="currentColor" d="M12 3.2 2.5 11h2.7v9.3h5.3v-6h3v6h5.3V11h2.7z"/></svg><span itemprop="name">{LANG.Home}</span></a><meta itemprop="position" content="1"></li>
                            <!-- BEGIN: loop --><li class="np-bc__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a href="{BREADCRUMBS.link}" itemprop="item" title="{BREADCRUMBS.title}"><span itemprop="name">{BREADCRUMBS.title}</span></a><meta itemprop="position" content="{BREADCRUMBS.position}"></li><!-- END: loop -->
                        </ol>
                    </nav>
                    <!-- END: breadcrumbs -->
                    <!-- BEGIN: currenttime --><!-- END: currenttime -->
                    [THEME_ERROR_INFO]
<!-- ===== END HEADER ===== -->
