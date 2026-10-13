<!-- BEGIN: main -->
<!-- BEGIN: viewdescription -->
<div class="news_column panel panel-primary">
    <div class="panel-heading">
        <span class="bar"></span>
        <h1>{CONTENT.title}</h1>
    </div>
    <div class="panel-body clearfix">
        <!-- BEGIN: image -->
        <img alt="{CONTENT.title}" src="{HOMEIMG1}" width="{IMGWIDTH1}" class="thumb imghome pull-left mr-1" />
        <!-- END: image -->
        <p>{CONTENT.description}</p>
    </div>
</div>
<!-- END: viewdescription -->
<!-- BEGIN: viewcatloop -->
<div class="news_column">
    <!-- BEGIN: featured -->
    <div class="panel panel-default">
        <div class="panel-body featured">
            <div class="news-item news-item--lead">
                <!-- BEGIN: image -->
                <a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}><img alt="{HOMEIMGALT1}" src="{HOMEIMG1}" width="{IMGWIDTH1}" class="thumb imghome" /></a>
                <!-- END: image -->
                <div>
                    <h2>
                        <a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}>{CONTENT.title}</a>
                        <!-- BEGIN: newday --><span class="icon_new">&nbsp;</span><!-- END: newday -->
                    </h2>
                    <div class="meta">
                        <span><em class="fa fa-clock-o">&nbsp;</em>{CONTENT.publtime}</span>
                        <span><em class="fa fa-eye">&nbsp;</em>{LANG.view}: {CONTENT.hitstotal}</span>
                        <!-- BEGIN: comment -->
                        <span><em class="fa fa-comment-o">&nbsp;</em>{LANG.total_comment}: {CONTENT.hitscm}</span>
                        <!-- END: comment -->
                    </div>
                    {CONTENT.hometext}
                    <!-- BEGIN: adminlink -->
                    <p class="text-right">
                        {ADMINLINK}
                    </p>
                    <!-- END: adminlink -->
                </div>
            </div>
        </div>
    </div>
    <!-- END: featured -->
    <!-- BEGIN: news -->
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="news-item">
                <!-- BEGIN: image -->
                <a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}><img alt="{HOMEIMGALT1}" src="{HOMEIMG1}" width="{IMGWIDTH1}" class="thumb imghome" /></a>
                <!-- END: image -->
                <div>
                    <h3>
                        <a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}>{CONTENT.title}</a>
                        <!-- BEGIN: newday -->
                        <span class="icon_new">&nbsp;</span>
                        <!-- END: newday -->
                    </h3>
                    <div class="meta">
                        <span><em class="fa fa-clock-o">&nbsp;</em>{CONTENT.publtime}</span>
                        <span><em class="fa fa-eye">&nbsp;</em>{LANG.view}: {CONTENT.hitstotal}</span>
                        <!-- BEGIN: comment -->
                        <span><em class="fa fa-comment-o">&nbsp;</em>{LANG.total_comment}: {CONTENT.hitscm}</span>
                        <!-- END: comment -->
                    </div>
                    {CONTENT.hometext}
                    <!-- BEGIN: adminlink -->
                    <p class="text-right">
                        {ADMINLINK}
                    </p>
                    <!-- END: adminlink -->
                </div>
            </div>
        </div>
    </div>
    <!-- END: news -->
</div>
<!-- END: viewcatloop -->
<!-- BEGIN: related -->
<div class="panel panel-default">
    <div class="panel-heading">
        <span class="bar"></span>
        <h3>{ORTHERNEWS}</h3>
    </div>
    <div class="panel-body">
        <ul class="related side-list list-items">
            <!-- BEGIN: loop -->
            <li>
                <a href="{RELATED.link}" title="{RELATED.title}" {EXTLINK}>{RELATED.title} <em>({RELATED.publtime}) </em></a>
                <!-- BEGIN: newday -->
                <span class="icon_new">&nbsp;</span>
                <!-- END: newday -->
            </li>
            <!-- END: loop -->
        </ul>
    </div>
</div>
<!-- END: related -->
<!-- BEGIN: generate_page -->
<div class="clearfix"></div>
<div class="text-center">
    {GENERATE_PAGE}
</div>
<!-- END: generate_page -->
<!-- END: main -->
