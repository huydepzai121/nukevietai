<!-- BEGIN: main -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<!-- ===== BODY ===== -->
<div class="row">
	[HEADER]
</div>
<div class="row body-grid">
    <div class="col-sm-12 col-md-13 col-sm-push-6 col-md-push-5 col-main">
        [TOP]
        {MODULE_CONTENT}
    </div>
    <div class="col-sm-6 col-md-6 col-sm-push-6 col-md-push-5 col-right">
        [RIGHT]
    </div>
	<div class="col-sm-6 col-md-5 col-sm-pull-18 col-md-pull-19 col-left">
		[LEFT]
	</div>
</div>
<!-- Khối "Góc nhìn" — vị trí [BOTTOM] đặt ngoài lưới 3 cột để hiện thành dải
     toàn chiều rộng (xem docs/giaodienmau3.md, mục "Khối Góc nhìn"). Quản trị
     gắn một block tin tức sẵn có (vd block_news, template block.default) vào
     [BOTTOM] để có dáng "Góc nhìn"; không cần module mới. -->
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
