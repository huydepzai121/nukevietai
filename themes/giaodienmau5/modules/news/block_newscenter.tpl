<!-- BEGIN: main -->
<section class="np-hero" id="hot-news" data-np-carousel>
    <div class="np-hero-track">
        <article class="np-slide is-active">
            <a class="np-slide-link" href="{main.link}" title="{main.title}" {main.target_blank}>
                <img src="{main.imgsource}" alt="{main.title}">
                <div class="np-slide-caption">
                    <span class="np-kicker">Tiêu điểm</span>
                    <h2>{main.title}</h2>
                    <p>{main.hometext}</p>
                </div>
            </a>
        </article>
        <!-- BEGIN: othernews -->
        <article class="np-slide">
            <a class="np-slide-link" href="{othernews.link}" title="{othernews.title}" {othernews.target_blank}>
                <img src="{othernews.imgsource}" alt="{othernews.title}" loading="lazy">
                <div class="np-slide-caption">
                    <span class="np-kicker">Tiêu điểm</span>
                    <h2>{othernews.title}</h2>
                    <p>{othernews.hometext_clean}</p>
                </div>
            </a>
        </article>
        <!-- BEGIN: tooltip --><!-- END: tooltip -->
        <!-- END: othernews -->
    </div>
    <button type="button" class="np-hero-nav np-prev" aria-label="Tin trước"><em class="fa fa-chevron-left"></em></button>
    <button type="button" class="np-hero-nav np-next" aria-label="Tin sau"><em class="fa fa-chevron-right"></em></button>
    <div class="np-hero-dots" role="tablist"></div>
</section>
<!-- END: main -->
