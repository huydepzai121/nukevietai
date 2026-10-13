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
    <div class="lead-story">
        <!-- BEGIN: image -->
        <a class="ph" href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}><img alt="{HOMEIMGALT0}" src="{HOMEIMG0}" width="{IMGWIDTH0}"/></a>
        <!-- END: image -->
        <div class="body">
            <h2 class="headline headline--hero">
                <a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}>{CONTENT.title}</a>
                <!-- BEGIN: newday -->
                <span class="icon_new"></span>
                <!-- END: newday -->
            </h2>
            <div class="meta">
                {CONTENT.publtime} · {LANG.view}: {CONTENT.hitstotal}
                <!-- BEGIN: comment --> · {LANG.total_comment}: {CONTENT.hitscm}<!-- END: comment -->
            </div>
            <div class="excerpt">
                {CONTENT.hometext}
            </div>
            <!-- BEGIN: adminlink -->
            <p class="text-right">
                {ADMINLINK}
            </p>
            <!-- END: adminlink -->
        </div>
    </div>
    <!-- END: catcontent -->
    <ul class="dotted-list">
        <!-- BEGIN: catcontentloop -->
        <li>
            <a title="{CONTENT.title}" href="{CONTENT.link}" {CONTENT.target_blank}>{CONTENT.title}</a>
            <!-- BEGIN: newday --><span class="icon_new"></span><!-- END: newday -->
        </li>
        <!-- END: catcontentloop -->
    </ul>
</div>
<!-- BEGIN: generate_page -->
<div class="text-center">
    {GENERATE_PAGE}
</div>
<!-- END: generate_page -->
<!-- END: main -->
