<?php
/* Duongsat theme: shared data helpers for theme blocks (site 2) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}
if (!function_exists('ds_rows')) {
function ds_rows($where = '', $limit = 10, $offset = 0)
{
    global $db, $global_config;
    static $cats = null;
    if ($cats === null) {
        $cats = [];
        $r = $db->query('SELECT catid, title, alias FROM ' . NV_PREFIXLANG . '_news_cat');
        while ($c = $r->fetch()) {
            $cats[$c['catid']] = $c;
        }
    }
    $sql = 'SELECT id, catid, title, alias, hometext, homeimgfile, homeimgthumb, publtime FROM ' . NV_PREFIXLANG . '_news_rows WHERE status=1' . ($where ? ' AND ' . $where : '') . ' ORDER BY publtime DESC LIMIT ' . (int) $offset . ',' . (int) $limit;
    $out = [];
    $r = $db->query($sql);
    while ($row = $r->fetch()) {
        $cat = $cats[$row['catid']] ?? ['alias' => 'tin-tuc-ai', 'title' => ''];
        $row['link'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=news&amp;' . NV_OP_VARIABLE . '=' . $cat['alias'] . '/' . $row['alias'] . '-' . $row['id'] . $global_config['rewrite_exturl'], true);
        $row['cat_title'] = $cat['title'];
        $row['cat_link'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=news&amp;' . NV_OP_VARIABLE . '=' . $cat['alias'], true);
        $row['img'] = '';
        $row['thumb'] = '';
        if (!empty($row['homeimgfile'])) {
            $row['img'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/news/' . $row['homeimgfile'];
            $row['thumb'] = ($row['homeimgthumb'] == 1 && file_exists(NV_ROOTDIR . '/' . NV_ASSETS_DIR . '/news/' . $row['homeimgfile'])) ? NV_BASE_SITEURL . NV_ASSETS_DIR . '/news/' . $row['homeimgfile'] : $row['img'];
        }
        $row['title'] = nv_htmlspecialchars($row['title']);
        $row['desc'] = nv_clean60(strip_tags($row['hometext']), 220);
        $row['date'] = nv_date('d/m/Y', $row['publtime']);
        $out[] = $row;
    }
    return $out;
}

}
if (!function_exists('ds_li')) {
function ds_li($r, $cls = '')
{
    return '<li' . ($cls ? ' class="' . $cls . '"' : '') . '><a href="' . $r['link'] . '" title="' . $r['title'] . '">' . $r['title'] . '</a></li>';
}
}

if (!function_exists('ds_cfg_int')) {
function ds_cfg_int($cfg, $k, $d)
{
    return isset($cfg[$k]) && $cfg[$k] !== '' ? (int) $cfg[$k] : $d;
}
function ds_cfg_form($fields, $data)
{
    $h = '';
    foreach ($fields as $k => $f) {
        $v = isset($data[$k]) ? $data[$k] : '';
        $h .= '<div class="form-group"><label class="control-label col-sm-6">' . $f[0] . ':</label><div class="col-sm-18">';
        if ($f[1] == 'textarea') {
            $h .= '<textarea name="config_' . $k . '" class="form-control" rows="6">' . nv_htmlspecialchars($v) . '</textarea>';
        } else {
            $h .= '<input type="text" name="config_' . $k . '" class="form-control" value="' . nv_htmlspecialchars($v) . '"/>';
        }
        $h .= '</div></div>';
    }
    return $h;
}
function ds_cfg_submit($fields)
{
    global $nv_Request;
    $r = ['error' => [], 'config' => []];
    foreach ($fields as $k => $f) {
        $r['config'][$k] = $f[1] == 'textarea' ? $nv_Request->get_string('config_' . $k, 'post', '') : $nv_Request->get_title('config_' . $k, 'post', '');
    }
    return $r;
}
function ds_ids($s)
{
    return implode(',', array_filter(array_map('intval', explode(',', (string) $s))));
}
}
