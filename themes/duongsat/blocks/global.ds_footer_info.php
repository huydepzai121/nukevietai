<?php
/* Duongsat - Thông tin chân trang - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_footer_info')) {
    function nv_block_ds_footer_info_fields()
    {
        return ['heading' => ['Tiêu đề', 'text'],'html' => ['Nội dung (HTML)', 'textarea']];
    }
    function nv_block_ds_footer_info_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_footer_info_fields(), $data_block);
    }
    function nv_block_ds_footer_info_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_footer_info_fields());
    }
    function nv_block_ds_footer_info($block_config)
    {
        global $home;
        $cfg = $block_config;
        $title = $block_config['title'] ?? '';

    return '<div class="ds-footer__info"><h3>' . nv_htmlspecialchars($cfg['heading'] ?? '') . '</h3>' . ($cfg['html'] ?? '') . '</div>';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_footer_info($block_config);
}
