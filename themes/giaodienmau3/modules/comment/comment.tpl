<!-- BEGIN: main -->
<!-- BEGIN: comment_result -->
<div class="alert alert-info" id="alert-info">{STATUS_COMMENT}</div>
<script type="text/javascript">$('#alert-info').delay(5000).fadeOut('slow');</script>
<!-- END: comment_result -->
<ul class="comment-list">
    <!-- BEGIN: detail -->
    <li class="comment-item" id="cid_{COMMENT.cid}">
        <span class="avatar">
            <img src="{COMMENT.photo}" alt="{COMMENT.post_name}" width="40" />
        </span>
        <div class="comment-body">
            <div>{COMMENT.content}</div>
            <div class="comment-info">
                <div>
                    <strong>{COMMENT.post_name}</strong>
                    <!-- BEGIN: emailcomm -->
                    <a title="mailto {COMMENT.post_email}" href="mailto:{COMMENT.post_email}">{COMMENT.post_email}</a>
                    <!-- END: emailcomm -->
                    <span class="text-muted">{LANG.pubtime} {COMMENT.post_time}</span>
                </div>
                <ul class="comment-tool">
                    <!-- BEGIN: delete -->
                    <li><a href="javascript:void(0);" onclick="nv_commment_delete({COMMENT.cid}, '{COMMENT.check_like}')"><em class="fa fa-trash-o"></em> {LANG.delete}</a></li>
                    <!-- END: delete -->
                    <!-- BEGIN: allowed_comm -->
                    <li><a href="javascript:void(0);" data-post-name="{COMMENT.post_name}" onclick="nv_commment_feedback(event, {COMMENT.cid})"><em class="fa fa-reply"></em> {LANG.feedback}</a></li>
                    <!-- END: allowed_comm -->
                    <li><a href="javascript:void(0);" onclick="nv_commment_like(event, {COMMENT.cid}, '{COMMENT.check_like}', '1')"><em class="fa fa-thumbs-o-up"></em> {LANG.like}</a> <span id="like{COMMENT.cid}">{COMMENT.likes}</span></li>
                    <li><a href="javascript:void(0);" onclick="nv_commment_like(event, {COMMENT.cid}, '{COMMENT.check_like}', '-1')"><em class="fa fa-thumbs-o-down"></em> {LANG.dislike}</a> <span id="dislike{COMMENT.cid}">{COMMENT.dislikes}</span></li>
                    <!-- BEGIN: attach -->
                    <li><a href="{COMMENT.attach}" rel="nofollow"><i class="fa fa-fw fa-download"></i>{LANG.attachdownload}</a></li>
                    <!-- END: attach -->
                </ul>
            </div>
            <!-- BEGIN: children -->
            {CHILDREN}
            <!-- END: children -->
        </div>
    </li>
    <!-- END: detail -->
</ul>
<div class="text-center">{PAGE}</div>
<!-- END: main -->
<!-- BEGIN: children -->
<ul class="comment-list">
    <!-- BEGIN: detail -->
    <li class="comment-item" id="cid_{COMMENT.cid}">
        <div class="comment-body">
            <div>{COMMENT.content}</div>
            <div class="comment-info">
                <div>
                    <strong>{COMMENT.post_name}</strong>
                    <!-- BEGIN: emailcomm -->
                    <a title="mailto {COMMENT.post_email}" href="mailto:{COMMENT.post_email}">{COMMENT.post_email}</a>
                    <!-- END: emailcomm -->
                    <span class="text-muted">{LANG.pubtime} {COMMENT.post_time}</span>
                </div>
                <ul class="comment-tool">
                    <!-- BEGIN: delete -->
                    <li><a href="javascript:void(0);" onclick="nv_commment_delete({COMMENT.cid}, '{COMMENT.check_like}')"><em class="fa fa-trash-o"></em> {LANG.delete}</a></li>
                    <!-- END: delete -->
                    <!-- BEGIN: allowed_comm -->
                    <li><a href="javascript:void(0);" data-post-name="{COMMENT.post_name}" onclick="nv_commment_feedback(event, {COMMENT.cid})"><em class="fa fa-reply"></em> {LANG.feedback}</a></li>
                    <!-- END: allowed_comm -->
                    <li><a href="javascript:void(0);" onclick="nv_commment_like(event, {COMMENT.cid}, '{COMMENT.check_like}', '1')"><em class="fa fa-thumbs-o-up"></em> {LANG.like}</a> <span id="like{COMMENT.cid}">{COMMENT.likes}</span></li>
                    <li><a href="javascript:void(0);" onclick="nv_commment_like(event, {COMMENT.cid}, '{COMMENT.check_like}', '-1')"><em class="fa fa-thumbs-o-down"></em> {LANG.dislike}</a> <span id="dislike{COMMENT.cid}">{COMMENT.dislikes}</span></li>
                    <!-- BEGIN: attach -->
                    <li><a href="{COMMENT.attach}" rel="nofollow"><i class="fa fa-fw fa-download"></i>{LANG.attachdownload}</a></li>
                    <!-- END: attach -->
                </ul>
            </div>
        </div> <!-- BEGIN: children --> {CHILDREN} <!-- END: children -->
    </li>
    <!-- END: detail -->
</ul>
<div class="text-center">{PAGE}</div>
<!-- END: children -->
