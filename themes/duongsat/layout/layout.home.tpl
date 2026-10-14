<!-- BEGIN: main -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<!-- ===== BODY (home: top row 707+353, lower rows 795+265) ===== -->
<div class="row">
    <div class="col-md-24">[HEADER]</div>
</div>
<div class="row np-body-row ds-home-top">
    <div class="col-sm-24 col-md-16 ds-home-top__main">[TOP]</div>
    <div class="col-sm-24 col-md-8 ds-home-top__right">[DS_HOME_RIGHT]</div>
</div>
<div class="row np-body-row">
    <div class="col-sm-24 col-md-17 np-main">
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
