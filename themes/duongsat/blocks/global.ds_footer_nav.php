<?php
/* Duongsat - Thanh liên kết chân trang - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_footer_nav')) {
    function nv_block_ds_footer_nav_fields()
    {
        return ['links' => ['Liên kết (mỗi dòng: Tiêu đề|URL)', 'textarea']];
    }
    function nv_block_ds_footer_nav_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_footer_nav_fields(), $data_block);
    }
    function nv_block_ds_footer_nav_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_footer_nav_fields());
    }
    function nv_block_ds_footer_nav($block_config)
    {
        global $home;
        $cfg = $block_config;
        $title = $block_config['title'] ?? '';

    $h = '';
    foreach (preg_split('/\r?\n/', (string) ($cfg['links'] ?? '')) as $l) {
        $p = explode('|', $l, 2);
        if (count($p) == 2 && trim($p[0]) !== '') {
            $h .= '<a href="' . nv_htmlspecialchars(trim($p[1])) . '">' . trim($p[0]) . '</a>';
        }
    }
    return $h === '' ? '' : '<div class="ds-footer__menu"><div class="ds-wrap">' . $h . '</div></div>';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_footer_nav($block_config);
}
