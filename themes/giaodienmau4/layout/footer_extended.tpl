<!-- ===== FOOTER ===== -->
                </div>
            </section>
        </div>
    </div>
    <footer class="section-footer-top" id="footer">
        <div class="wraper">
            <div class="container">
                <div class="row footer-grid">
                    <div class="col-xs-24 col-sm-12 col-md-6">
                        <div class="footer-brand">{NV_SITE_NAME}</div>
                        [COMPANY_INFO]
                        <div class="qr-code-wraper">
                            [QR_CODE]
                        </div>
                        <div id="ftip" data-content="">
                            <div class="bg"></div>
                        </div>
                    </div>
                    <div class="col-xs-24 col-sm-12 col-md-6">
                        [MENU_FOOTER]
                    </div>
                    <div class="col-xs-24 col-sm-12 col-md-6">
                        [FOOTER_SITE]
                    </div>
                    <div class="col-xs-24 col-sm-12 col-md-6">
                        [FEATURED_PRODUCT]
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <nav class="section-footer-bottom footerNav2">
        <div class="wraper">
            <div class="container">
                <div class="inner">
                    <span class="footer-copy">{NV_SITE_COPYRIGHT}</span>
                    <!-- BEGIN: theme_type -->
                    <div class="theme-change">
                    <!-- BEGIN: loop -->
                        <!-- BEGIN: other -->
                        <a href="{STHEME_TYPE}" rel="nofollow" title="{STHEME_INFO}"><i class="fa fa-{STHEME_ICON}"></i></a>
                        <!-- END: other -->
                        <!-- BEGIN: current -->
                        <span title="{LANG.theme_type_select}: {STHEME_TITLE}"><i class="fa fa-{STHEME_ICON}"></i></span>
                        <!-- END: current -->
                    <!-- END: loop -->
                    </div>
                    <!-- END: theme_type -->
                    <div class="bttop">
                        <a class="pointer"><i class="fa fa-eject fa-lg"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    {ADMINTOOLBAR}
    <!-- SiteModal Required!!! -->
    <div id="sitemodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fa fa-spinner fa-spin"></i>
                </div>
                <button type="button" class="close" data-dismiss="modal"><span class="fa fa-times"></span></button>
            </div>
        </div>
    </div>
    <div class="fix_banner_left">
        [FIX_BANNER_LEFT]
    </div>
    <div class="fix_banner_right">
        [FIX_BANNER_RIGHT]
    </div>
<!-- ===== END FOOTER ===== -->
