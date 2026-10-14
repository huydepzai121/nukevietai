<!-- BEGIN: main -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<!-- ===== BODY ===== -->
[HEADER]
<div class="at-with-sidebar">
    <main class="at-main">
        [TOP]
        {MODULE_CONTENT}
        [BOTTOM]
    </main>
    <aside class="at-sidebar">
        [RIGHT]
    </aside>
</div>
[FOOTER]
<!-- ===== END BODY ===== -->
{FILE "footer_extended.tpl"}
{FILE "footer_only.tpl"}
<!-- END: main -->
