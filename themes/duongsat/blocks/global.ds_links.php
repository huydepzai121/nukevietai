<?php
/* Duongsat - Liên kết website (dropdown) - theme block (duongsat) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
require_once NV_ROOTDIR . '/themes/duongsat/ds_lib.php';

if (!nv_function_exists('nv_block_ds_links')) {
    function nv_block_ds_links_fields()
    {
        return ['links' => ['Danh sách liên kết (mỗi dòng: Tên|URL)', 'textarea']];
    }
    function nv_block_ds_links_config($module, $data_block, $lang_block)
    {
        return ds_cfg_form(nv_block_ds_links_fields(), $data_block);
    }
    function nv_block_ds_links_submit($module, $lang_block)
    {
        return ds_cfg_submit(nv_block_ds_links_fields());
    }
    function nv_block_ds_links($block_config)
    {
        $title = $block_config['title'] ?? '';
        $h = "";
        foreach (preg_split("/\r?\n/", (string) ($block_config["links"] ?? "")) as $ln) {
            $p = array_map("trim", explode("|", $ln, 2));
            if (count($p) == 2 && preg_match("#^https?://#i", $p[1])) {
                $h .= "<option value=\"" . nv_htmlspecialchars($p[1]) . "\">" . nv_htmlspecialchars($p[0]) . "</option>";
            }
        }
        if ($h === "") {
            return "";
        }
        return "<div class=\"ds-links\"><label>" . $title . "</label><select class=\"form-control input-sm\" onchange=\"if(this.value)window.open(this.value,\x27_blank\x27,\x27noopener\x27);this.selectedIndex=0\"><option value=\"\">Lựa chọn website...</option>" . $h . "</select></div>";
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_ds_links($block_config);
}
