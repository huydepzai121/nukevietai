<!-- BEGIN: main -->
<div id="hot-news">
    <article class="hero-story">
        <a class="ph" href="{main.link}" title="{main.title}" {main.target_blank}><img src="{main.imgsource}" alt="{main.title}" width="{main.width}"/></a>
        <h2 class="headline headline--hero"><a href="{main.link}" title="{main.title}" {main.target_blank}>{main.titleclean60}</a></h2>
        <div class="excerpt">{main.hometext}</div>
        <div class="meta"><a href="{main.link}">{lang.more}</a></div>
    </article>
    <div class="grid-2">
        <!-- BEGIN: othernews -->
        <article class="story-card">
            <a class="ph ph--2" title="{othernews.title}" href="{othernews.link}" {othernews.target_blank}><img src="{othernews.imgsource}" alt="{othernews.title}"/></a>
            <h3 class="headline headline--sub"><a class="show" href="{othernews.link}" {othernews.target_blank} <!-- BEGIN: tooltip -->data-placement="{TOOLTIP_POSITION}" data-content="{othernews.hometext_clean}" data-img="{othernews.imgsource}" data-rel="tooltip"<!-- END: tooltip --> title="{othernews.title}">{othernews.titleclean60}</a></h3>
        </article>
        <!-- END: othernews -->
    </div>
</div>
<!-- END: main -->
