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

<ul class="dotted-list">
	<!-- BEGIN: viewcatloop -->
	<li>
		<a class="show" href="{CONTENT.link}" {CONTENT.target_blank} <!-- BEGIN: tooltip -->data-content="{CONTENT.hometext_clean}" data-img="{CONTENT.imghome}" data-rel="tooltip" data-placement="{TOOLTIP_POSITION}"<!-- END: tooltip --> title="{CONTENT.title}">
			<span class="num-badge">{NUMBER}</span>{CONTENT.title}
			<!-- BEGIN: newday -->
			<span class="icon_new"></span>
			<!-- END: newday -->
		</a>
	</li>
	<!-- END: viewcatloop -->
</ul>

<!-- BEGIN: generate_page -->
<div class="text-center">
	{GENERATE_PAGE}
</div>
<!-- END: generate_page -->
<!-- END: main -->
