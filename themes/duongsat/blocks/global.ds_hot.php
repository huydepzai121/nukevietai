<?php
/* Duongsat - Slider + tab tin (trang chủ) - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_hot')) {
    function nv_block_ds_hot_fields()
    {
        return ['numslide' => ['Số tin slider', 'text'],'tab1' => ['Tên tab 1', 'text'],'tab2' => ['Tên tab 2', 'text'],'numtab' => ['Số tin mỗi tab', 'text'],'homeonly' => ['Chỉ hiện ở trang chủ (1/0)', 'text']];
    }
    function nv_block_ds_hot_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_hot_fields(), $data_block);
    }
    function nv_block_ds_hot_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_hot_fields());
    }
    function nv_block_ds_hot($block_config)
    {
        global $home;
        $cfg = $block_config;
        $title = $block_config['title'] ?? '';

    if (ds_cfg_int($cfg, 'homeonly', 1) && empty($home)) {
        return '';
    }
    $ns = ds_cfg_int($cfg, 'numslide', 5);
    $nt = ds_cfg_int($cfg, 'numtab', 5);
    $all = ds_rows('', max($ns, $nt) + $nt);
    if (empty($all)) {
        return '';
    }
    $h = '<div class="ds-home"><div class="ds-box ds-hot"><div class="row"><div class="col-sm-12"><div class="ds-slider" id="dsSlider">';
    $sl = array_slice($all, 0, $ns);
    foreach ($sl as $i => $r) {
        $h .= '<a class="ds-slide' . ($i == 0 ? ' active' : '') . '" href="' . $r['link'] . '" title="' . $r['title'] . '"><img src="' . $r['img'] . '" alt="' . $r['title'] . '"><span class="ds-slide__cap">' . $r['title'] . '</span></a>';
    }
    $h .= '<div class="ds-dots">';
    foreach ($sl as $i => $r) {
        $h .= '<button type="button" class="' . ($i == 0 ? 'active' : '') . '" data-i="' . $i . '" aria-label="Tin ' . ($i + 1) . '"></button>';
    }
    $h .= '</div></div></div><div class="col-sm-12"><ul class="ds-tabs" role="tablist"><li class="active"><a href="#ds-tab1" data-toggle="tab">' . nv_htmlspecialchars($cfg['tab1'] ?? 'Tin tiêu điểm') . '</a></li><li><a href="#ds-tab2" data-toggle="tab">' . nv_htmlspecialchars($cfg['tab2'] ?? 'Tin mới nhất') . '</a></li></ul><div class="tab-content"><ul class="tab-pane active ds-arrowlist" id="ds-tab1">';
    foreach (array_slice($all, $ns, $nt) as $r) {
        $h .= ds_li($r);
    }
    $h .= '</ul><ul class="tab-pane ds-arrowlist" id="ds-tab2">';
    foreach (array_slice($all, 0, $nt) as $r) {
        $h .= ds_li($r);
    }
    return $h . '</ul></div></div></div></div></div>';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_hot($block_config);
}
