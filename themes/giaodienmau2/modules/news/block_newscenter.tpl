<!-- BEGIN: main -->
<div id="hot-news">
    <div class="panel panel-default news_column">
        <div class="hero-photo">
            <a href="{main.link}" title="{main.title}" {main.target_blank}><img src="{main.imgsource}" alt="{main.title}" width="{main.width}"/></a>
            <div class="shade"></div>
            <div class="cap">
                <h2><a href="{main.link}" title="{main.title}" {main.target_blank}>{main.titleclean60}</a></h2>
                <div class="hometext">{main.hometext}</div>
                <div class="meta"><a href="{main.link}">{lang.more}</a></div>
            </div>
        </div>
        <div class="hot-news-others sub-grid">
            <!-- BEGIN: othernews -->
            <div class="sub-item">
                <a title="{othernews.title}" href="{othernews.link}" {othernews.target_blank}><img class="thumb" src="{othernews.imgsource}" alt="{othernews.title}"/></a>
                <h3><a class="show" href="{othernews.link}" {othernews.target_blank} <!-- BEGIN: tooltip -->data-placement="{TOOLTIP_POSITION}" data-content="{othernews.hometext_clean}" data-img="{othernews.imgsource}" data-rel="tooltip"<!-- END: tooltip --> title="{othernews.title}">{othernews.titleclean60}</a></h3>
            </div>
            <!-- END: othernews -->
        </div>
    </div>
</div>
<!-- END: main -->
