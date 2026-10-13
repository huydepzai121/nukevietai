<!-- BEGIN: main -->
<!-- BEGIN: listcat -->
<div class="news_column panel">
    <div class="panel-heading">
        <!-- BEGIN: subcatmore -->
        <a class="pull-right hidden-xs" title="{MORE.title}" href="{MORE.link}"><em class="fa fa-sign-out">&nbsp;</em></a>
        <!-- END: subcatmore -->
        <ul class="list-inline sub-list-icon" style="margin: 0">
            <li><h4><a title="{CAT.title}" href="{CAT.link}"><span>{CAT.title}</span></a></h4></li>
            <!-- BEGIN: subcatloop -->
            <li class="hidden-xs"><h4><a title="{SUBCAT.title}" href="{SUBCAT.link}">{SUBCAT.title}</a></h4></li>
            <!-- END: subcatloop -->
        </ul>
    </div>
    <!-- BEGIN: block_topcat -->
    <div class="block-top clear">
        {BLOCK_TOPCAT}
    </div>
    <!-- END: block_topcat -->
    <div class="panel-body">
        <div class="row">
            <div class="{WCT}">
                <!-- BEGIN: image -->
                <a class="ph related-thumb" title="{CONTENT.title}" href="{CONTENT.link}" {CONTENT.target_blank}><img src="{HOMEIMG}" alt="{HOMEIMGALT}" width="{IMGWIDTH}"/></a>
                <!-- END: image -->
                <h3 class="headline headline--sub">
                    <a title="{CONTENT.title}" href="{CONTENT.link}" {CONTENT.target_blank}>{CONTENT.title}</a>
                    <!-- BEGIN: newday -->
                    <span class="icon_new"></span>
                    <!-- END: newday -->
                </h3>
                <div class="meta">
                    {CONTENT.publtime} · {CONTENT.hitstotal}
                    <!-- BEGIN: comment --> · {CONTENT.hitscm}<!-- END: comment -->
                </div>
                <div class="excerpt">{CONTENT.hometext}</div>
            </div>

            <!-- BEGIN: related -->
            <div class="col-md-8">
                <ul class="dotted-list">
                    <!-- BEGIN: loop -->
                    <li class="{CLASS}">
                        <a class="show" href="{OTHER.link}" title="{OTHER.title}" {OTHER.target_blank} <!-- BEGIN: tooltip -->data-content="{OTHER.hometext_clean}" data-img="{OTHER.imghome}" data-rel="tooltip" data-placement="{TOOLTIP_POSITION}"<!-- END: tooltip -->>{OTHER.title}</a>
                    </li>
                    <!-- END: loop -->
                </ul>
            </div>
            <!-- END: related -->
        </div>
    </div>
</div>
<!-- BEGIN: block_bottomcat -->
<div class="bottom-cat clear">
    {BLOCK_BOTTOMCAT}
</div>
<!-- END: block_bottomcat -->
<!-- END: listcat -->
<!-- END: main -->
