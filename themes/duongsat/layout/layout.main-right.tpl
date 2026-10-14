<!-- BEGIN: main -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<!-- ===== BODY ===== -->
<div class="row">
    <div class="col-md-24">[HEADER]</div>
</div>
<div class="row np-body-row">
    <div class="col-sm-24 col-md-17 np-main">
        [TOP]
        {MODULE_CONTENT}
        <div class="ds-home-bottom">[BOTTOM]</div>
    </div>
    <div class="col-sm-24 col-md-7 np-sidebar">
        [RIGHT]
    </div>
</div>
<div class="row">
    <div class="col-md-24">[FOOTER]</div>
</div>
<!-- ===== END BODY ===== -->
{FILE "footer_extended.tpl"}
{FILE "footer_only.tpl"}
<!-- END: main -->
