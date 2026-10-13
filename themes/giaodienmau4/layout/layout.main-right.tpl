<!-- BEGIN: main -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<!-- ===== BODY ===== -->
<div class="row">
	<div class="col-md-24">
		[HEADER]
	</div>
</div>
<div class="row body-grid">
	<div class="col-sm-16 col-md-18 col-main col-main--wide">
		[TOP]
		{MODULE_CONTENT}
	</div>
	<div class="col-sm-8 col-md-6 col-right">
		[RIGHT]
	</div>
</div>
<div class="section-feature">
    <div class="wraper">
        [BOTTOM]
    </div>
</div>
<div class="row">
		[FOOTER]
</div>
<!-- ===== END BODY ===== -->
{FILE "footer_extended.tpl"}
{FILE "footer_only.tpl"}
<!-- END: main -->
