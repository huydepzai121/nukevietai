<!-- BEGIN: main -->
<!-- BEGIN: viewdescription -->
<div class="news_column cat-head">
	<h1>{CONTENT.title}</h1>
	<!-- BEGIN: image -->
	<div class="ph cat-head-img"><img alt="{CONTENT.title}" src="{HOMEIMG1}"/></div>
	<!-- END: image -->
	<p class="lede">{CONTENT.description}</p>
</div>
<!-- END: viewdescription -->

<!-- BEGIN: featuredloop -->
<div class="news_column">
	<div class="lead-story">
		<!-- BEGIN: image -->
		<a class="ph" href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}><img alt="{HOMEIMGALT1}" src="{HOMEIMG1}" width="150"/></a>
		<!-- END: image -->
		<div class="body">
			<h2 class="headline headline--sub">
				<a href="{CONTENT.link}" title="{CONTENT.title}" {CONTENT.target_blank}>{CONTENT.title}</a>
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
</div>
<!-- END: featuredloop -->

<div class="grid-3">
	<!-- BEGIN: viewcatloop -->
	<article class="cat-card">
		<a class="ph" title="{CONTENT.title}" href="{CONTENT.link}" {CONTENT.target_blank}><img alt="{HOMEIMGALT1}" src="{HOMEIMG1}" width="{IMGWIDTH1}"/></a>
		<h3 class="headline headline--sm">
			<a class="show" href="{CONTENT.link}" {CONTENT.target_blank} <!-- BEGIN: tooltip -->data-content="{CONTENT.hometext_clean}" data-img="" data-rel="tooltip" data-placement="{TOOLTIP_POSITION}"<!-- END: tooltip --> title="{CONTENT.title}">{CONTENT.title}</a>
		</h3>
		<div class="meta">{ADMINLINK}</div>
	</article>
	<!-- END: viewcatloop -->
</div>

<!-- BEGIN: generate_page -->
<div class="text-center">
	{GENERATE_PAGE}
</div>
<!-- END: generate_page -->
<!-- END: main -->
