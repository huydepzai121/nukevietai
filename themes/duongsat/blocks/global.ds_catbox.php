<?php
/* Duongsat - Hộp tin theo chuyên mục - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_catbox')) {
    function nv_block_ds_catbox_fields()
    {
        return ['catids' => ['Chuyên mục (id, dấu phẩy)', 'text'],'numrow' => ['Số tin', 'text'],'homeonly' => ['Chỉ hiện ở trang chủ (1/0)', 'text']];
    }
    function nv_block_ds_catbox_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_catbox_fields(), $data_block);
    }
    function nv_block_ds_catbox_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_catbox_fields());
    }
    function nv_block_ds_catbox($block_config)
    {
        global $home;
        $cfg = $block_config;
        $title = $block_config['title'] ?? '';

    if (ds_cfg_int($cfg, 'homeonly', 1) && empty($home)) {
        return '';
    }
    $ids = ds_ids($cfg['catids'] ?? '');
    $rows = ds_rows($ids ? 'catid IN (' . $ids . ')' : '', ds_cfg_int($cfg, 'numrow', 5));
    if (empty($rows)) {
        return '';
    }
    $f = array_shift($rows);
    $s = '<div class="ds-box ds-sec"><div class="ds-sec__head"><a href="' . $f['cat_link'] . '">' . $title . '</a></div><div class="ds-sec__body">';
    $s .= '<div class="ds-lead"><a class="ds-lead__img" href="' . $f['link'] . '"><img src="' . $f['thumb'] . '" alt="' . $f['title'] . '" loading="lazy"></a><h3><a href="' . $f['link'] . '">' . $f['title'] . '</a></h3><p>' . $f['desc'] . '</p></div><ul class="ds-sqlist">';
    foreach ($rows as $r) {
        $s .= ds_li($r);
    }
    return $s . '</ul></div></div>';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_catbox($block_config);
}
