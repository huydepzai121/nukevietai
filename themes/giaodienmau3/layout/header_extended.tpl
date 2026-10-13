    <noscript>
        <div class="alert alert-danger">{LANG.nojs}</div>
    </noscript>
    <header>
        <div class="site-banner" style="background-image: url('{BANNER_SRC}');"></div>
        <div class="section-header-bar">
            <div class="wraper">
                <nav class="header-nav">
                    <div class="header-nav-inner">
                        <span class="current-date">{NV_CURRENTTIME}</span>
                        <div class="grp">
                            <div class="contactDefault">
                                [CONTACT_DEFAULT]
                            </div>
                            <div class="social-icons">
                                [SOCIAL_ICONS]
                            </div>
                            <div class="personalArea">
                                [PERSONALAREA]
                            </div>
                        </div>
                    </div>
                    <div id="tip" data-content="">
                        <div class="bg"></div>
                    </div>
                </nav>
            </div>
        </div>
        <div class="section-header">
            <div class="wraper">
                <div id="header">
                    <div class="masthead-issue">
                        <div class="kicker-mini">Số ra hôm nay</div>
                        <div>{NV_CURRENTTIME}</div>
                    </div>
                    <div class="logo">
                        <a title="{SITE_NAME}" href="{THEME_SITE_HREF}"><img src="{LOGO_SRC}" alt="{SITE_NAME}"></a>
                        <!-- BEGIN: site_name_h1 -->
                        <h1 class="sr-only">{SITE_NAME}</h1>
                        <!-- END: site_name_h1 -->
                        <!-- BEGIN: site_name_span -->
                        <span class="sr-only">{SITE_NAME}</span>
                        <!-- END: site_name_span -->
                        <span class="site_description">{SITE_DESCRIPTION}</span>
                    </div>
                    <div class="right-ads">
                        [HEAD_RIGHT]
                        <!--
                            Ô tìm kiếm + đăng nhập/đặt báo dưới đây là markup tĩnh đặt cạnh
                            [HEAD_RIGHT], KHÔNG thay thế vị trí block (quyết định đã chốt,
                            xem docs/giaodienmau3.md). Ô tìm kiếm dùng đúng thuộc tính của
                            headerSearch mặc định (data-url, data-minlength) nên vẫn hoạt
                            động thật qua js/main.js.
                        -->
                        <div class="masthead-tools">
                            <div class="headerSearch search-box">
                                <input type="text" class="form-control" maxlength="{NV_MAX_SEARCH_LENGTH}" placeholder="{LANG.search}...">
                                <span class="input-group-btn"><button type="button" class="btn" data-url="{THEME_SEARCH_URL}" data-minlength="{NV_MIN_SEARCH_LENGTH}" data-click="y"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"></circle><path d="M20 20l-4.3-4.3"></path></svg></button></span>
                            </div>
                            <div class="account-links">
                                <a href="javascript:void(0);" onclick="return loginForm('');">Đăng nhập</a>
                                <span>·</span>
                                <a href="#">Đặt báo</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="section-nav">
        <div class="wraper">
            <nav class="second-nav" id="menusite">
                <div class="container">
                    <div class="row">
                        <div class="bg box-shadow">
                            [MENU_SITE]
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <div class="section-body">
        <div class="wraper">
            <section>
                <div class="container" id="body">
                    <nav class="third-nav">
                        <div class="row">
                            <div class="bg">
                            <div class="clearfix">
                                <div class="col-xs-24 col-md-24">
                                    <!-- BEGIN: breadcrumbs -->
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
                                    <!-- END: breadcrumbs -->
                                    <!-- BEGIN: currenttime --><span class="current-time">{NV_CURRENTTIME}</span><!-- END: currenttime -->
                                </div>
                            </div>
                            </div>
                        </div>
                    </nav>
                    [THEME_ERROR_INFO]
