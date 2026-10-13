<!-- BEGIN: main -->
<!-- BEGIN: viewdescription -->
<div class="news_column panel panel-primary">
	<div class="panel-heading">
		<span class="bar"></span>
		<h3>{CONTENT.title}</h3>
	</div>
	<div class="panel-body clearfix">
		<!-- BEGIN: image -->
		<img alt="{CONTENT.title}" src="{HOMEIMG1}" width="{IMGWIDTH1}" class="thumb imghome pull-left mr-1" />
		<!-- END: image -->
		<p class="text-justify">{CONTENT.description}</p>
	</div>
</div>
<!-- END: viewdescription -->

<!-- BEGIN: featuredloop -->
<div class="news_column">
	<div class="panel panel-default">
		<div class="panel-body featured">
			<div class="news-item news-item--lead">
				<!-- BEGIN: image -->
				<a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}><img alt="{HOMEIMGALT1}" src="{HOMEIMG1}" width="150px" class="thumb imghome" /></a>
				<!-- END: image -->
				<div>
					<h2>
						<a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}>{CONTENT.title}</a>
					</h2>
					<div class="meta">
						<span><em class="fa fa-clock-o">&nbsp;</em>{CONTENT.publtime}</span>
						<span><em class="fa fa-eye">&nbsp;</em>{LANG.view}: {CONTENT.hitstotal}</span>
						<!-- BEGIN: comment -->
						<span><em class="fa fa-comment-o">&nbsp;</em>{LANG.total_comment}: {CONTENT.hitscm}</span>
						<!-- END: comment -->
					</div>
					<div class="text-justify">
						{CONTENT.hometext}
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
</div>
<!-- END: featuredloop -->

<!-- BEGIN: viewcatloop -->
<div class="col-xs-24 col-sm-12 col-md-8">
	<div class="card">
		<a title="{CONTENT.title}" href="{CONTENT.link}" {CONTENT.target_blank}><img alt="{HOMEIMGALT1}" src="{HOMEIMG1}" width="{IMGWIDTH1}" class="thumb"/></a>
		<div class="caption">
			<h3><a class="show" href="{CONTENT.link}" {CONTENT.target_blank} <!-- BEGIN: tooltip -->data-content="{CONTENT.hometext_clean}" data-img="" data-rel="tooltip" data-placement="{TOOLTIP_POSITION}"<!-- END: tooltip --> title="{CONTENT.title}">{CONTENT.title}</a></h3>
			<span>{ADMINLINK}</span>
		</div>
	</div>
</div>
<!-- END: viewcatloop -->
<div class="clear">&nbsp;</div>

<!-- BEGIN: generate_page -->
<div class="text-center">
	{GENERATE_PAGE}
</div>
<!-- END: generate_page -->
<!-- END: main -->
