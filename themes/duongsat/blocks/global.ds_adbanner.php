<?php
/* Duongsat - Banner quảng cáo (ảnh) - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_adbanner')) {
    function nv_block_ds_adbanner_fields()
    {
        return ['image' => ['Đường dẫn ảnh', 'text'], 'link' => ['Link khi bấm', 'text'], 'alt' => ['Mô tả ảnh', 'text']];
    }
    function nv_block_ds_adbanner_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_adbanner_fields(), $data_block);
    }
    function nv_block_ds_adbanner_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_adbanner_fields());
    }
    function nv_block_ds_adbanner($block_config)
    {
        $title = $block_config['title'] ?? '';
        $img = trim((string) ($block_config["image"] ?? ""));
        if ($img === "") {
            $img = NV_BASE_SITEURL . "themes/duongsat/images/ds-ad.jpg";
        }
        $link = trim((string) ($block_config["link"] ?? ""));
        $alt = nv_htmlspecialchars($block_config["alt"] ?? $title);
        $tag = "<img src=\"" . nv_htmlspecialchars($img) . "\" alt=\"" . $alt . "\" width=\"760\" height=\"115\" loading=\"lazy\">";
        if ($link !== "") {
            $tag = "<a href=\"" . nv_htmlspecialchars($link) . "\">" . $tag . "</a>";
        }
        return "<div class=\"ds-adbanner\">" . $tag . "</div>";
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_adbanner($block_config);
}
