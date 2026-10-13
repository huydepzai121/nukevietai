<!-- BEGIN: main -->
<!-- BEGIN: viewdescription -->
<div class="news_column cat-head">
    <h1>{CONTENT.title}</h1>
    <!-- BEGIN: image -->
    <div class="ph cat-head-img"><img alt="{CONTENT.title}" src="{HOMEIMG1}" width="{IMGWIDTH1}"/></div>
    <!-- END: image -->
    <p class="lede">{CONTENT.description}</p>
</div>
<!-- END: viewdescription -->
<div class="news_column">
    <!-- BEGIN: catcontent -->
    <!-- BEGIN: content -->
    <div class="lead-story">
        <!-- BEGIN: image -->
        <a class="ph" href="{NEWSTOP.link}" title="{NEWSTOP.title}" {NEWSTOP.target_blank}><img alt="{HOMEIMGALT0}" src="{HOMEIMG0}" width="{IMGWIDTH0}"/></a>
        <!-- END: image -->
        <div class="body">
            <h3 class="headline headline--sub">
                <a href="{NEWSTOP.link}" title="{NEWSTOP.title}" {NEWSTOP.target_blank}>{NEWSTOP.title}</a>
                <!-- BEGIN: newday -->
                <span class="icon_new"></span>
                <!-- END: newday -->
            </h3>
            <div class="meta">
                {NEWSTOP.publtime} · {LANG.view}: {NEWSTOP.hitstotal}
                <!-- BEGIN: comment --> · {LANG.total_comment}: {NEWSTOP.hitscm}<!-- END: comment -->
            </div>
            <div class="excerpt">
                {NEWSTOP.hometext}
            </div>
            <!-- BEGIN: adminlink -->
            <p class="text-right">
                {ADMINLINK}
            </p>
            <!-- END: adminlink -->
        </div>
    </div>
    <!-- END: content -->
    <ul class="dotted-list">
        <!-- BEGIN: other -->
        <li>
            <a class="show" href="{NEWSTOP.link}" {NEWSTOP.target_blank} <!-- BEGIN: tooltip -->data-content="{NEWSTOP.hometext_clean}" data-img="{NEWSTOP.imghome}" data-placement="{TOOLTIP_POSITION}" data-rel="tooltip"<!-- END: tooltip --> title="{NEWSTOP.title}">{NEWSTOP.title}</a>
        </li>
        <!-- END: other -->
    </ul>
    <!-- END: catcontent -->
</div>
<div class="grid-2">
<!-- BEGIN: loopcat -->
<!-- BEGIN: block_topcat -->
<div class="block-top clear">
    {BLOCK_TOPCAT}
</div>
<!-- END: block_topcat -->
<div class="news_column two_column panel">
    <div class="panel-heading">
        <a title="{CAT.title}" href="{CAT.link}"><span>{CAT.title}</span></a>
    </div>
    <div class="panel-body">
        <!-- BEGIN: content -->
        <h3 class="headline">
            <a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}>{CONTENT.title}</a>
            <!-- BEGIN: newday -->
            <span class="icon_new"></span>
            <!-- END: newday -->
        </h3>
        <div class="meta">
            {CONTENT.publtime} · {CONTENT.hitstotal}
            <!-- BEGIN: comment --> · {CONTENT.hitscm}<!-- END: comment -->
        </div>
        <!-- BEGIN: image -->
        <a class="ph two-col-thumb" href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}><img alt="{HOMEIMGALT01}" src="{HOMEIMG01}" width="{IMGWIDTH0}"/></a>
        <!-- END: image -->
        <p class="excerpt">{CONTENT.hometext}</p>
        <!-- BEGIN: adminlink -->
        <p class="text-right">
            {ADMINLINK}
        </p>
        <!-- END: adminlink -->
        <!-- END: content -->
        <ul class="dotted-list">
            <!-- BEGIN: other -->
            <li class="{CLASS}">
                <a class="show" href="{CONTENT.link}" {CONTENT.target_blank} <!-- BEGIN: tooltip -->data-content="{CONTENT.hometext_clean}" data-img="{CONTENT.imghome}" data-rel="tooltip" data-placement="{TOOLTIP_POSITION}"<!-- END: tooltip --> title="{CONTENT.title}">{CONTENT.title}</a>
            </li>
            <!-- END: other -->
        </ul>
    </div>
</div>
<!-- BEGIN: block_bottomcat -->
<div class="bottom-cat clear">
    {BLOCK_BOTTOMCAT}
</div>
<!-- END: block_bottomcat -->
<!-- END: loopcat -->
</div>
<!-- END: main -->
