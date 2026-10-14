<?php
/* Duongsat - Thông báo mới (danh sách có phân trang) - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_notice')) {
    function nv_block_ds_notice_fields()
    {
        return ['numrow' => ['Tổng số tin', 'text'],'perpage' => ['Số tin mỗi trang', 'text'],'catids' => ['Chỉ lấy chuyên mục (id, cách nhau dấu phẩy; trống = tất cả)', 'text']];
    }
    function nv_block_ds_notice_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_notice_fields(), $data_block);
    }
    function nv_block_ds_notice_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_notice_fields());
    }
    function nv_block_ds_notice($block_config)
    {
        global $home;
        $cfg = $block_config;
        $title = $block_config['title'] ?? '';

    $ids = ds_ids($cfg['catids'] ?? '');
    $per = ds_cfg_int($cfg, 'perpage', 4);
    $rows = ds_rows($ids ? 'catid IN (' . $ids . ')' : '', ds_cfg_int($cfg, 'numrow', 12));
    if (empty($rows)) {
        return '';
    }
    $h = '<div class="ds-box ds-notice"><h2 class="ds-box__title"><span>' . $title . '</span></h2><ul class="ds-dotlist" id="dsNotice" data-per="' . $per . '">';
    foreach ($rows as $i => $r) {
        $h .= ds_li($r, ($i < $per ? 'on' : '') . ($i % 3 == 2 ? ' blue' : ''));
    }
    return $h . '</ul><div class="ds-pager"><button type="button" class="btn btn-default btn-sm" data-dir="-1">&lsaquo; Trước</button> <button type="button" class="btn btn-default btn-sm" data-dir="1">Sau &rsaquo;</button></div></div>';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_notice($block_config);
}
