<!-- ===== HEADER ===== -->
    <noscript>
        <div class="alert alert-danger">{LANG.nojs}</div>
    </noscript>
    <a class="skip-link" href="#body">Bỏ qua tới nội dung</a>
    <div class="np-topbar">
        <div class="np-container np-topbar-row">
            <div class="np-topbar-left">
                <span class="np-date" id="np-date"></span>
                <div class="at-pos at-pos--contact contactDefault">[CONTACT_DEFAULT]</div>
            </div>
            <a class="np-logo" title="{SITE_NAME}" href="{THEME_SITE_HREF}">
                <svg class="np-logo-mark" width="40" height="40" viewBox="0 0 48 48" aria-hidden="true"><rect x="2" y="2" width="44" height="44" rx="8" fill="#b3121c"/><path d="M14 34 L24 13 L34 34 M18.6 27 H29.4" stroke="#fff" stroke-width="2.6" stroke-linecap="round" fill="none"/><circle cx="24" cy="13" r="3" fill="#fff"/><circle cx="14" cy="34" r="3" fill="#fff"/><circle cx="34" cy="34" r="3" fill="#fff"/></svg>
                <span class="np-logo-text">AI <b>Today</b></span>
                <!-- BEGIN: site_name_h1 --><h1 class="sr-only">{SITE_NAME}</h1><!-- END: site_name_h1 -->
                <!-- BEGIN: site_name_span --><span class="sr-only">{SITE_NAME}</span><!-- END: site_name_span -->
            </a>
            <div class="np-topbar-right">
                <div class="at-pos at-pos--social social-icons">[SOCIAL_ICONS]</div>
                <button type="button" class="np-icon-btn" id="np-search-toggle" aria-label="{LANG.search}" aria-expanded="false" aria-controls="np-search"><em class="fa fa-search"></em></button>
                <button type="button" class="np-icon-btn theme-toggle" aria-label="Chuyển chế độ sáng/tối" title="Chuyển chế độ sáng/tối">
                    <svg class="ic-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>
                    <svg class="ic-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z"/></svg>
                </button>
                <div class="personalArea">[PERSONALAREA]</div>
            </div>
        </div>
        <div class="np-container np-site-desc">{SITE_DESCRIPTION}</div>
    </div>
    <header class="np-nav-wrap" id="at-header">
        <div class="np-container">
            <nav class="at-nav np-nav" id="menusite" aria-label="Menu chính">[MENU_SITE]</nav>
        </div>
        <div class="np-search" id="np-search" hidden>
            <div class="np-container">
                <div class="headerSearch input-group">
                    <input type="text" class="form-control" maxlength="{NV_MAX_SEARCH_LENGTH}" placeholder="Nhập từ khóa tìm kiếm..." aria-label="{LANG.search}"><span class="input-group-btn"><button type="button" class="btn btn-np" data-url="{THEME_SEARCH_URL}" data-minlength="{NV_MIN_SEARCH_LENGTH}" data-click="y"><em class="fa fa-search"></em> {LANG.search}</button></span>
                </div>
            </div>
        </div>
        <div id="tip" data-content=""><div class="bg"></div></div>
    </header>
    <div class="np-container at-pos at-pos--headright right-ads">[HEAD_RIGHT]</div>
    <div class="section-body">
        <div class="wraper">
            <section>
                <div class="container" id="body">
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
