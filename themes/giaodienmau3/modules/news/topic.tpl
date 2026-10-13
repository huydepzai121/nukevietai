<!-- BEGIN: main -->
<!-- BEGIN: topicdescription -->
<div class="news_column cat-head">
    <h1>{TOPPIC_TITLE}</h1>
    <!-- BEGIN: image -->
    <div class="ph cat-head-img"><img alt="{TOPPIC_TITLE}" src="{HOMEIMG1}" width="{IMGWIDTH1}"/></div>
    <!-- END: image -->
    <p class="lede">{TOPPIC_DESCRIPTION}</p>
</div>
<!-- END: topicdescription -->

<!-- BEGIN: topic -->
<div class="news_column panel">
    <div class="panel-body">
        <div class="lead-story">
            <!-- BEGIN: homethumb -->
            <a class="ph" href="{TOPIC.link}" title="{TOPIC.title}" {TOPIC.target_blank}><img alt="{TOPIC.alt}" src="{TOPIC.src}" width="{TOPIC.width}"/></a>
            <!-- END: homethumb -->
            <div class="body">
                <h3 class="headline headline--sub"><a href="{TOPIC.link}" title="{TOPIC.title}" {TOPIC.target_blank}>{TOPIC.title}</a></h3>
                <div class="meta">{TIME} {DATE}</div>
                <div class="excerpt">
                    {TOPIC.hometext}
                </div>
                <!-- BEGIN: adminlink -->
                <p class="text-right">
                    {ADMINLINK}
                </p>
                <!-- END: adminlink -->
            </div>
        </div>
    </div>
</div>
<!-- END: topic -->
<!-- BEGIN: other -->
<ul class="dotted-list">
    <!-- BEGIN: loop -->
    <li>
        <a title="{TOPIC_OTHER.title}" href="{TOPIC_OTHER.link}" {TOPIC_OTHER.target_blank}>{TOPIC_OTHER.title}</a>
        <span class="text-muted">({TOPIC_OTHER.publtime})</span>
    </li>
    <!-- END: loop -->
</ul>
<!-- END: other -->

<!-- BEGIN: generate_page -->
<div class="text-center">
    {GENERATE_PAGE}
</div>
<!-- END: generate_page -->
<!-- END: main -->
