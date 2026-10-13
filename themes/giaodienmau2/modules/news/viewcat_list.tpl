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

<div class="panel panel-default">
	<div class="panel-body">
		<div class="cat-line-list">
			<!-- BEGIN: viewcatloop -->
			<a class="show cat-line" href="{CONTENT.link}" {CONTENT.target_blank} <!-- BEGIN: tooltip -->data-content="{CONTENT.hometext_clean}" data-img="{CONTENT.imghome}" data-rel="tooltip" data-placement="{TOOLTIP_POSITION}"<!-- END: tooltip --> title="{CONTENT.title}">
				<span class="num">{NUMBER}</span>
				<h3>
					{CONTENT.title}
					<!-- BEGIN: newday -->
					<span class="icon_new">&nbsp;</span>
					<!-- END: newday -->
				</h3>
			</a>
			<!-- END: viewcatloop -->
		</div>
	</div>
</div>

<!-- BEGIN: generate_page -->
<div class="text-center">
	{GENERATE_PAGE}
</div>
<!-- END: generate_page -->
<!-- END: main -->
