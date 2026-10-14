<!-- BEGIN: main -->
<!-- BEGIN: listcat -->
<section class="np-catblock news_column">
    <div class="np-section-head">
        <h2 class="np-section-title"><a title="{CAT.title}" href="{CAT.link}">{CAT.title}</a></h2>
        <ul class="np-subcats">
            <!-- BEGIN: subcatloop --><li><a title="{SUBCAT.title}" href="{SUBCAT.link}">{SUBCAT.title}</a></li><!-- END: subcatloop -->
        </ul>
        <a class="np-more" href="{CAT.link}" title="{CAT.title}">Xem tất cả <em class="fa fa-angle-right"></em></a>
        <!-- BEGIN: subcatmore --><!-- END: subcatmore -->
    </div>
    <!-- BEGIN: block_topcat --><div class="block-top clear">{BLOCK_TOPCAT}</div><!-- END: block_topcat -->
    <div class="row">
        <div class="col-sm-24 col-md-13">
            <article class="np-lead">
                <!-- BEGIN: image --><a class="np-lead-img" title="{CONTENT.title}" href="{CONTENT.link}" {CONTENT.target_blank}><img src="{HOMEIMG}" alt="{HOMEIMGALT}" loading="lazy"></a><!-- END: image -->
                <h3 class="np-lead-title"><a title="{CONTENT.title}" href="{CONTENT.link}" {CONTENT.target_blank}>{CONTENT.title}</a><!-- BEGIN: newday --><span class="np-new">Mới</span><!-- END: newday --></h3>
                <div class="np-meta"><span><em class="fa fa-clock-o"></em> {CONTENT.publtime}</span><span><em class="fa fa-eye"></em> {CONTENT.hitstotal}</span><!-- BEGIN: comment --><span><em class="fa fa-comment-o"></em> {CONTENT.hitscm}</span><!-- END: comment --></div>
                <div class="np-lead-text">{CONTENT.hometext}</div>
            </article>
        </div>
        <!-- BEGIN: related -->
        <div class="col-sm-24 col-md-11">
            <ul class="np-list">
                <!-- BEGIN: loop -->
                <li class="{CLASS}">
                    <a class="np-list-thumb" href="{OTHER.link}" title="{OTHER.title}" {OTHER.target_blank}><img src="{OTHER.imghome}" alt="{OTHER.title}" loading="lazy"></a>
                    <a class="np-list-title" href="{OTHER.link}" title="{OTHER.title}" {OTHER.target_blank}>{OTHER.title}</a>
                    <!-- BEGIN: tooltip --><!-- END: tooltip -->
                </li>
                <!-- END: loop -->
            </ul>
        </div>
        <!-- END: related -->
    </div>
    <!-- BEGIN: block_bottomcat --><div class="bottom-cat clear">{BLOCK_BOTTOMCAT}</div><!-- END: block_bottomcat -->
</section>
<!-- END: listcat -->
<!-- END: main -->
