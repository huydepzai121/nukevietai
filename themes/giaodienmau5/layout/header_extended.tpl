<!-- ===== HEADER ===== -->
    <noscript>
        <div class="alert alert-danger">{LANG.nojs}</div>
    </noscript>
    <a class="skip-link" href="#body">Bỏ qua tới nội dung</a>
    <header class="at-header" id="at-header">
        <div class="at-container at-header-row">
            <a class="at-brand" title="{SITE_NAME}" href="{THEME_SITE_HREF}">
                <svg class="at-brand-mark" width="32" height="32" viewBox="0 0 48 48" aria-hidden="true"><defs><linearGradient id="atg" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#6366f1"/><stop offset="1" stop-color="#06b6d4"/></linearGradient></defs><rect x="2" y="2" width="44" height="44" rx="11" fill="url(#atg)"/><path d="M14 33 L24 14 L34 33 M18.5 26 H29.5" stroke="#fff" stroke-width="2.4" stroke-linecap="round" fill="none"/><circle cx="24" cy="14" r="2.8" fill="#fff"/><circle cx="14" cy="33" r="2.8" fill="#fff"/><circle cx="34" cy="33" r="2.8" fill="#fff"/></svg>
                <span class="at-brand-text">AI <b>Today</b></span>
                <!-- BEGIN: site_name_h1 --><h1 class="sr-only">{SITE_NAME}</h1><!-- END: site_name_h1 -->
                <!-- BEGIN: site_name_span --><span class="sr-only">{SITE_NAME}</span><!-- END: site_name_span -->
            </a>
            <nav class="at-nav" id="menusite" aria-label="Menu chính">
                [MENU_SITE]
            </nav>
            <div class="at-actions">
                <div class="headerSearch at-search">
                    <div class="input-group">
                        <input type="text" class="form-control" maxlength="{NV_MAX_SEARCH_LENGTH}" placeholder="{LANG.search}..." aria-label="{LANG.search}"><span class="input-group-btn"><button type="button" class="btn btn-info" data-url="{THEME_SEARCH_URL}" data-minlength="{NV_MIN_SEARCH_LENGTH}" data-click="y" aria-label="{LANG.search}"><em class="fa fa-search"></em></button></span>
                    </div>
                </div>
                <button type="button" class="theme-toggle" aria-label="Chuyển chế độ sáng/tối" title="Chuyển chế độ sáng/tối">
                    <svg class="ic-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>
                    <svg class="ic-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z"/></svg>
                </button>
                <div class="personalArea">[PERSONALAREA]</div>
            </div>
        </div>
        <div id="tip" data-content=""><div class="bg"></div></div>
    </header>
    <div class="section-body">
        <div class="wraper">
            <section>
                <div class="container" id="body">
                    <!-- BEGIN: breadcrumbs -->
                    <nav class="third-nav at-crumbs" aria-label="breadcrumb">
                        <div class="breadcrumbs-wrap">
                            <div class="display">
                                <a class="show-subs-breadcrumbs hidden" href="#" onclick="showSubBreadcrumbs(this, event);"><em class="fa fa-lg fa-angle-right"></em></a>
                                <ul class="breadcrumbs list-none"></ul>
                            </div>
                            <ul class="subs-breadcrumbs"></ul>
                            <ul class="temp-breadcrumbs hidden" itemscope itemtype="https://schema.org/BreadcrumbList">
                                <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a href="{THEME_SITE_HREF}" itemprop="item" title="{LANG.Home}"><span itemprop="name">{LANG.Home}</span></a><i class="hidden" itemprop="position" content="1"></i></li>
                                <!-- BEGIN: loop --><li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a href="{BREADCRUMBS.link}" itemprop="item" title="{BREADCRUMBS.title}"><span class="txt" itemprop="name">{BREADCRUMBS.title}</span></a><i class="hidden" itemprop="position" content="{BREADCRUMBS.position}"></i></li><!-- END: loop -->
                            </ul>
                        </div>
                    </nav>
                    <!-- END: breadcrumbs -->
                    <!-- BEGIN: currenttime --><!-- END: currenttime -->
                    [THEME_ERROR_INFO]
<!-- ===== END HEADER ===== -->
