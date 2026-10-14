<?php
/* Duongsat - Sự kiện qua ảnh (trình chiếu) - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_gallery')) {
    function nv_block_ds_gallery_fields()
    {
        return ['numrow' => ['Số ảnh', 'text'],'offset' => ['Bỏ qua N tin đầu', 'text']];
    }
    function nv_block_ds_gallery_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_gallery_fields(), $data_block);
    }
    function nv_block_ds_gallery_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_gallery_fields());
    }
    function nv_block_ds_gallery($block_config)
    {
        global $home;
        $cfg = $block_config;
        $title = $block_config['title'] ?? '';

    $rows = ds_rows("homeimgfile<>''", ds_cfg_int($cfg, 'numrow', 8), ds_cfg_int($cfg, 'offset', 3));
    if (empty($rows)) {
        return '';
    }
    $h = '<div class="ds-box ds-gallery"><h2 class="ds-box__title"><span>' . $title . '</span></h2><div class="ds-gal" id="dsGal">';
    foreach ($rows as $i => $r) {
        $h .= '<a class="ds-gal__item' . ($i == 0 ? ' active' : '') . '" href="' . $r['link'] . '" title="' . $r['title'] . '"><img src="' . $r['thumb'] . '" alt="' . $r['title'] . '" loading="lazy"><span>' . $r['title'] . '</span></a>';
    }
    return $h . '<button type="button" class="ds-gal__nav prev" data-dir="-1" aria-label="Ảnh trước">&lsaquo;</button><button type="button" class="ds-gal__nav next" data-dir="1" aria-label="Ảnh sau">&rsaquo;</button></div></div>';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_gallery($block_config);
}
