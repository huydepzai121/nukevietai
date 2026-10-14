<?php
/* Duongsat - Điểm tin nhanh (chữ chạy) - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_ticker')) {
    function nv_block_ds_ticker_fields()
    {
        return ['numrow' => ['Số tin', 'text'],'label' => ['Nhãn', 'text']];
    }
    function nv_block_ds_ticker_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_ticker_fields(), $data_block);
    }
    function nv_block_ds_ticker_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_ticker_fields());
    }
    function nv_block_ds_ticker($block_config)
    {
        global $home;
        $cfg = $block_config;
        $title = $block_config['title'] ?? '';

    $rows = ds_rows('', ds_cfg_int($cfg, 'numrow', 8));
    $h = '<div class="ds-ticker"><strong class="ds-ticker__label"><em class="fa fa-certificate"></em> ' . nv_htmlspecialchars($cfg['label'] ?? 'Điểm tin nhanh:') . '</strong><div class="ds-ticker__track"><ul class="ds-ticker__list">';
    foreach ($rows as $r) {
        $h .= ds_li($r);
    }
    return $h . '</ul></div></div>';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_ticker($block_config);
}
