<!-- BEGIN: main -->
<!-- BEGIN: viewdescription -->
<div class="at-cat-head">
    <h1>{CONTENT.title}</h1>
    <p>{CONTENT.description}</p>
</div>
<!-- END: viewdescription -->
<div class="at-grid">
<!-- BEGIN: viewcatloop -->
    <!-- BEGIN: featured -->
    <article class="at-card at-card--featured">
        <!-- BEGIN: image --><a class="at-card-media" href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}><img alt="{HOMEIMGALT1}" src="{HOMEIMG1}" loading="lazy"></a><!-- END: image -->
        <div class="at-card-body">
            <h2 class="at-card-title"><a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}>{CONTENT.title}</a><!-- BEGIN: newday --><span class="at-badge">Mới</span><!-- END: newday --></h2>
            <div class="at-card-text">{CONTENT.hometext}</div>
            <div class="at-meta"><span>{CONTENT.publtime}</span><span>{CONTENT.hitstotal} lượt xem</span><!-- BEGIN: comment --><span>{CONTENT.hitscm} bình luận</span><!-- END: comment --></div>
            <!-- BEGIN: adminlink --><div class="at-admin">{ADMINLINK}</div><!-- END: adminlink -->
        </div>
    </article>
    <!-- END: featured -->
    <!-- BEGIN: news -->
    <article class="at-card">
        <!-- BEGIN: image --><a class="at-card-media" href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}><img alt="{HOMEIMGALT1}" src="{HOMEIMG1}" loading="lazy"></a><!-- END: image -->
        <div class="at-card-body">
            <h3 class="at-card-title"><a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}>{CONTENT.title}</a><!-- BEGIN: newday --><span class="at-badge">Mới</span><!-- END: newday --></h3>
            <div class="at-card-text">{CONTENT.hometext}</div>
            <div class="at-meta"><span>{CONTENT.publtime}</span><span>{CONTENT.hitstotal} lượt xem</span><!-- BEGIN: comment --><span>{CONTENT.hitscm} bình luận</span><!-- END: comment --></div>
            <!-- BEGIN: adminlink --><div class="at-admin">{ADMINLINK}</div><!-- END: adminlink -->
        </div>
    </article>
    <!-- END: news -->
<!-- END: viewcatloop -->
</div>
<!-- BEGIN: related -->
<section class="at-related">
    <h4>{ORTHERNEWS}</h4>
    <ul>
        <!-- BEGIN: loop --><li><a href="{RELATED.link}" title="{RELATED.title}" {EXTLINK}>{RELATED.title}</a> <time>{RELATED.publtime}</time><!-- BEGIN: newday --><!-- END: newday --></li><!-- END: loop -->
    </ul>
</section>
<!-- END: related -->
<!-- BEGIN: generate_page -->
<div class="at-pager">{GENERATE_PAGE}</div>
<!-- END: generate_page -->
<!-- END: main -->
