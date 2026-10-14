<?php
/* Duongsat - Danh sách tin đánh số - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_numlist')) {
    function nv_block_ds_numlist_fields()
    {
        return ['numrow' => ['Số tin', 'text'],'offset' => ['Bỏ qua N tin đầu', 'text'],'catids' => ['Chuyên mục (id, dấu phẩy; trống = tất cả)', 'text']];
    }
    function nv_block_ds_numlist_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_numlist_fields(), $data_block);
    }
    function nv_block_ds_numlist_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_numlist_fields());
    }
    function nv_block_ds_numlist($block_config)
    {
        global $home;
        $cfg = $block_config;
        $title = $block_config['title'] ?? '';

    $ids = ds_ids($cfg['catids'] ?? '');
    $rows = ds_rows($ids ? 'catid IN (' . $ids . ')' : '', ds_cfg_int($cfg, 'numrow', 6), ds_cfg_int($cfg, 'offset', 4));
    if (empty($rows)) {
        return '';
    }
    $h = '<div class="ds-box ds-notice"><h2 class="ds-box__title"><span>' . $title . '</span></h2><ol class="ds-numlist">';
    foreach ($rows as $r) {
        $h .= ds_li($r);
    }
    return $h . '</ol></div>';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_numlist($block_config);
}
