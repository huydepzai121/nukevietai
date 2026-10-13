<!-- BEGIN: main -->
<script type="text/javascript" src="{NV_STATIC_URL}{NV_ASSETS_DIR}/js/star-rating/jquery.rating.pack.js"></script>
<script src="{NV_STATIC_URL}{NV_ASSETS_DIR}/js/star-rating/jquery.MetaData.js" type="text/javascript"></script>
<link href="{NV_STATIC_URL}{NV_ASSETS_DIR}/js/star-rating/jquery.rating.css" type="text/css" rel="stylesheet"/>
<link href="{NV_STATIC_URL}{NV_ASSETS_DIR}/js/highlight/github.min.css" rel="stylesheet">
<div class="news_column panel" itemtype="http://schema.org/NewsArticle" itemscope>
    <div class="panel-body">
        <div id="news_detail">
            <h1 class="article-title" itemprop="headline">{DETAIL.title}</h1>
            <div class="hidden hide d-none" itemprop="author" itemtype="http://schema.org/Person" itemscope>
                <span itemprop="name">{SCHEMA_AUTHOR}</span>
            </div>
            <span class="hidden hide d-none" itemprop="datePublished">{SCHEMA_DATEPUBLISHED}</span>
            <span class="hidden hide d-none" itemprop="dateModified">{SCHEMA_DATEPUBLISHED}</span>
            <span class="hidden hide d-none" itemprop="mainEntityOfPage">{SCHEMA_URL}</span>
            <span class="hidden hide d-none" itemprop="image">{SCHEMA_IMAGE}</span>
            <div class="hidden hide d-none" itemprop="publisher" itemtype="http://schema.org/Organization" itemscope>
                <span itemprop="name">{SCHEMA_ORGNAME}</span>
                <span itemprop="logo" itemtype="http://schema.org/ImageObject" itemscope>
                    <span itemprop="url">{SCHEMA_ORGLOGO}</span>
                </span>
            </div>

            <div class="article-meta">
                <span>
                    <!-- BEGIN: author -->
                    <!-- BEGIN: name -->{LANG.author}: {DETAIL.author}<!-- END: name -->
                    <!-- BEGIN: source --> · {LANG.source}: {DETAIL.source}<!-- END: source -->
                    <!-- END: author -->
                    {DETAIL.publtime}
                </span>
                <div class="icons">
                    <!-- BEGIN: allowed_send -->
                    <span title="{LANG.sendmail}" onclick="newsSendMailModal('#newsSendMailModal', '{URL_SENDMAIL}', '{CHECKSESSION}');"><em class="fa fa-envelope"></em></span>
                    <!-- START FORFOOTER -->
                    <div class="modal fade" id="newsSendMailModal" tabindex="-1" role="dialog" data-loaded="false">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <div class="modal-title h2"><strong>{LANG.sendmail}</strong></div>
                                </div>
                                <div class="modal-body"></div>
                            </div>
                        </div>
                    </div>
                    <!-- END FORFOOTER -->
                    <!-- END: allowed_send -->
                    <!-- BEGIN: allowed_print -->
                    <span title="{LANG.print}" onclick="nv_open_browse('{URL_PRINT}','{TITLE}',840,500,'resizable=yes,scrollbars=yes,toolbar=no,location=no,status=no');return false"><em class="fa fa-print"></em></span>
                    <!-- END: allowed_print -->
                    <!-- BEGIN: allowed_save -->
                    <a title="{LANG.savefile}" href="{URL_SAVEFILE}"><em class="fa fa-save"></em></a>
                    <!-- END: allowed_save -->
                </div>
            </div>

            <!-- BEGIN: no_public -->
            <div class="alert alert-warning">
                {LANG.no_public}
            </div>
            <!-- END: no_public -->
            <!-- BEGIN: show_player -->
            <link rel="stylesheet" href="{NV_STATIC_URL}{NV_ASSETS_DIR}/js/plyr/plyr.css" />
            <script src="{NV_STATIC_URL}{NV_ASSETS_DIR}/js/plyr/plyr.polyfilled.js"></script>
            <div class="news-detail-player">
                <div class="player">
                    <audio id="newsVoicePlayer" data-voice-id="{DETAIL.current_voice.id}" data-voice-path="{DETAIL.current_voice.path}" data-voice-title="{DETAIL.current_voice.title}" data-autoplay="{DETAIL.autoplay}"></audio>
                </div>
                <div class="source">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-microphone" aria-hidden="true"></i> <span data-news="voiceval" class="val">{DETAIL.current_voice.title}</span> <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-right">
                            <!-- BEGIN: loop -->
                            <li><a href="#" data-news="voicesel" data-id="{VOICE.id}" data-path="{VOICE.path}" data-tokend="{NV_CHECK_SESSION}">{VOICE.title}</a></li>
                            <!-- END: loop -->
                        </ul>
                    </div>
                </div>
                <div class="tools">
                    <div class="news-switch">
                        <div class="news-switch-label">
                            {LANG.autoplay}:
                        </div>
                        <div data-news="switchapl" class="news-switch-btn{DETAIL.css_autoplay}" role="button" data-busy="false" data-tokend="{NV_CHECK_SESSION}">
                            <span class="news-switch-slider"></span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END: show_player -->
            <!-- BEGIN: showhometext -->
            <div class="clearfix">
                <!-- BEGIN: imgthumb -->
                <!-- BEGIN: note -->
                <figure class="article-figure pointer" onclick="modalShowByObj('#imgpreview');">
                    <div style="width:{DETAIL.image.width}px;">
                        <img alt="{DETAIL.image.alt}" src="{DETAIL.image.src}" title="{DETAIL.image.note}"/>
                        <figcaption class="figure-caption">{DETAIL.image.note}</figcaption>
                    </div>
                </figure>
                <div id="imgpreview" style="display:none">
                    <p class="text-center"><img alt="{DETAIL.image.alt}" src="{DETAIL.homeimgfile}" srcset="{DETAIL.srcset}" title="{DETAIL.image.note}"/></p>
                    <figcaption>{DETAIL.image.note}</figcaption>
                </div>
                <!-- END: note -->
                <!-- BEGIN: empty -->
                <figure class="article-figure pointer" style="width:{DETAIL.image.width}px;" onclick="modalShowByObj('#imgpreview');">
                    <img alt="{DETAIL.image.alt}" src="{DETAIL.image.src}" title="{DETAIL.image.note}"/>
                </figure>
                <div id="imgpreview" style="display:none">
                    <p class="text-center"><img alt="{DETAIL.image.alt}" src="{DETAIL.homeimgfile}" srcset="{DETAIL.srcset}" title="{DETAIL.image.note}"/></p>
                </div>
                <!-- END: empty -->
                <!-- END: imgthumb -->

                <div class="lede-text" itemprop="description">{DETAIL.hometext}</div>

                <!-- BEGIN: imgfull -->
                <figure class="article-figure">
                    <img alt="{DETAIL.image.alt}" src="{DETAIL.image.src}" srcset="{DETAIL.srcset}" width="{DETAIL.image.width}"/>
                    <!-- BEGIN: note --><figcaption class="figure-caption">{DETAIL.image.note}</figcaption><!-- END: note -->
                </figure>
                <!-- END: imgfull -->
            </div>
            <!-- END: showhometext -->
            <div id="news-bodyhtml" class="article-body">
                {DETAIL.bodyhtml}
            </div>
            <!-- BEGIN: files -->
            <div class="panel">
                <div class="panel-heading">
                    <i class="fa fa-download"></i> {LANG.files}
                </div>
                <div class="dotted-list news-download-file">
                    <!-- BEGIN: loop -->
                    <div class="list-group-item">
                        <!-- BEGIN: show_quick_viewfile -->
                        <span class="badge">
                            <a role="button" data-toggle="collapse" href="#file-{FILE.key}" aria-expanded="false" aria-controls="file-{FILE.key}">
                                <i class="fa fa-eye" data-rel="tooltip" data-content="{LANG.preview}"></i>
                            </a>
                        </span>
                        <!-- END: show_quick_viewfile -->
                        <!-- BEGIN: show_quick_viewimg -->
                        <span class="badge">
                            <a href="javascript:void(0)" data-src="{FILE.src}" data-toggle="newsattachimage">
                                <i class="fa fa-eye" data-rel="tooltip" data-content="{LANG.preview}"></i>
                            </a>
                        </span>
                        <!-- END: show_quick_viewimg -->
                        <a href="{FILE.url}" title="{FILE.titledown} {FILE.title}" download>{FILE.titledown}: <strong>{FILE.title}</strong></a>
                        <!-- BEGIN: content_quick_viewfile -->
                        <div class="clearfix"></div>
                        <div class="collapse" id="file-{FILE.key}" data-src="{FILE.urlfile}" data-toggle="collapsefile" data-loaded="false">
                            <div class="well margin-top">
                                <iframe height="600" scrolling="yes" src="" width="100%"></iframe>
                            </div>
                        </div>
                        <!-- END: content_quick_viewfile -->
                    </div>
                    <!-- END: loop -->
                </div>
            </div>
            <!-- END: files -->
            <!-- BEGIN: copyright -->
            <div class="alert alert-info margin-bottom-lg">
                {COPYRIGHT}
            </div>
            <!-- END: copyright -->

            <!-- BEGIN: keywords -->
            <div class="article-tags">
                <span class="text-muted">{LANG.tags}:</span><!-- BEGIN: loop --><a class="tag" title="{KEYWORD}" href="{LINK_KEYWORDS}">{KEYWORD}</a>{SLASH}<!-- END: loop -->
            </div>
            <!-- END: keywords -->

            <!-- BEGIN: socialbutton -->
            <div class="social-share-container">
                <div class="social-share-label"><i class="fa fa-share-alt" aria-hidden="true"></i> {LANG_GLOBAL.share}:</div>
                <div class="social-share-buttons">
                    <!-- BEGIN: facebook --><button type="button" class="social-share-facebook" data-toggle="nv-social-share" data-platform="facebook" data-url="{DETAIL.link}" data-title="{DETAIL.title}"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></svg> Facebook</button><!-- END: facebook -->
                    <!-- BEGIN: twitter --><button type="button" class="social-share-twitter" data-toggle="nv-social-share" data-platform="twitter" data-url="{DETAIL.link}" data-title="{DETAIL.title}"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z"></path></svg> Tweet</button><!-- END: twitter -->
                </div>
            </div>
            <!-- END: socialbutton -->
        </div>
    </div>
</div>

<!-- BEGIN: adminlink -->
<p class="text-center margin-bottom-lg">
    {ADMINLINK}
</p>
<!-- END: adminlink -->

<!-- BEGIN: allowed_rating -->
<div class="news_column panel">
    <div class="panel-body">
        <form id="form3B" action="">
            <div class="clearfix">
                <p id="stringrating">{STRINGRATING}</p>
                <!-- BEGIN: data_rating -->
                <span itemscope itemtype="https://schema.org/AggregateRating">
                    <span class="hidden d-none hide" itemprop="itemReviewed" itemscope itemtype="https://schema.org/CreativeWorkSeries">
                        <span class="hidden d-none hide" itemprop="name">{DETAIL.title}</span>
                    </span>
                    {LANG.rating_average}:
                    <span id="numberrating" itemprop="ratingValue">{DETAIL.numberrating}</span> -
                    <span id="click_rating" itemprop="ratingCount">{DETAIL.click_rating}</span> {LANG.rating_count}
                    <span class="hidden d-none hide" itemprop="bestRating">5</span>
                </span>
                <!-- END: data_rating -->
                <div style="padding: 5px;">
                    <!-- BEGIN: star --><input class="hover-star required" type="radio" value="{STAR.val}" title="{STAR.title}"{STAR.checked}/><!-- END: star -->
                    <span id="hover-test" style="margin: 0 0 0 20px;">{LANG.star_note}</span>
                </div>
            </div>
        </form>
        <script type="text/javascript">
        $(function() {
            var isDisable = false;
            $('.hover-star').rating({
                focus : function(value, link) {
                    var tip = $('#hover-test');
                    if (!isDisable) {
                        tip[0].data = tip[0].data || tip.html();
                        tip.html(link.title || 'value: ' + value)
                    }
                },
                blur : function(value, link) {
                    var tip = $('#hover-test');
                    if (!isDisable) {
                        $('#hover-test').html(tip[0].data || '')
                    }
                },
                callback : function(value, link) {
                    if (!isDisable) {
                        isDisable = true;
                        $('.hover-star').rating('disable');
                        sendrating('{NEWSID}', value, '{NEWSCHECKSS}');
                    }
                }
            });
            <!-- BEGIN: disablerating -->
            $(".hover-star").rating('disable');
            isDisable = true;
            <!-- END: disablerating -->
        })
        </script>
    </div>
</div>
<!-- END: allowed_rating -->

<!-- BEGIN: comment -->
<div class="news_column panel">
    <div class="panel-body">
    {CONTENT_COMMENT}
    </div>
</div>
<!-- END: comment -->

<!-- BEGIN: others -->
<div class="news_column panel">
    <div class="panel-body">
        <!-- BEGIN: topic -->
        <div class="clearfix">
            <div class="panel-heading">{LANG.topic}<a class="pull-right" title="{TOPIC.topictitle}" href="{TOPIC.topiclink}">{LANG.more}</a></div>
            <ul class="dotted-list">
                <!-- BEGIN: loop -->
                <li>
                    <a href="{TOPIC.link}" {TOPIC.target_blank} <!-- BEGIN: tooltip -->data-placement="{TOOLTIP_POSITION}" data-content="{TOPIC.hometext_clean}" data-img="{TOPIC.imghome}" data-rel="tooltip"<!-- END: tooltip --> title="{TOPIC.title}">{TOPIC.title}</a>
                    <span class="text-muted">({TOPIC.time})</span>
                    <!-- BEGIN: newday -->
                    <span class="icon_new"></span>
                    <!-- END: newday -->
                </li>
                <!-- END: loop -->
            </ul>
        </div>
        <!-- END: topic -->

        <!-- BEGIN: related_new -->
        <div class="panel-heading">{LANG.related_new}</div>
        <ul class="dotted-list">
            <!-- BEGIN: loop -->
            <li>
                <a href="{RELATED_NEW.link}" {RELATED_NEW.target_blank} <!-- BEGIN: tooltip -->data-placement="{TOOLTIP_POSITION}" data-content="{RELATED_NEW.hometext_clean}" data-img="{RELATED_NEW.imghome}" data-rel="tooltip"<!-- END: tooltip --> title="{RELATED_NEW.title}">{RELATED_NEW.title}</a>
                <span class="text-muted">({RELATED_NEW.time})</span>
                <!-- BEGIN: newday -->
                <span class="icon_new"></span>
                <!-- END: newday -->
            </li>
            <!-- END: loop -->
        </ul>
        <!-- END: related_new -->

        <!-- BEGIN: related -->
        <div class="panel-heading">{LANG.related}</div>
        <ul class="dotted-list">
            <!-- BEGIN: loop -->
            <li>
                <a href="{RELATED.link}" {RELATED.target_blank} <!-- BEGIN: tooltip --> data-placement="{TOOLTIP_POSITION}" data-content="{RELATED.hometext_clean}" data-img="{RELATED.imghome}" data-rel="tooltip"<!-- END: tooltip --> title="{RELATED.title}">{RELATED.title}</a>
                <span class="text-muted">({RELATED.time})</span>
                <!-- BEGIN: newday -->
                <span class="icon_new"></span>
                <!-- END: newday -->
            </li>
            <!-- END: loop -->
        </ul>
        <!-- END: related -->
    </div>
</div>
<!-- END: others -->

<script type="text/javascript" src="{NV_STATIC_URL}{NV_ASSETS_DIR}/js/highlight/highlight.min.js"></script>
<script type="text/javascript">hljs.initHighlightingOnLoad();</script>
<!-- END: main -->
<!-- BEGIN: no_permission -->
<div class="alert alert-info">
    {NO_PERMISSION}
</div>
<!-- END: no_permission -->
