<?php
/* Duongsat theme: homepage + ticker data (site 2) */
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

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

function ds_li($r, $cls = '')
{
    return '<li' . ($cls ? ' class="' . $cls . '"' : '') . '><a href="' . $r['link'] . '" title="' . $r['title'] . '">' . $r['title'] . '</a></li>';
}

function ds_home_html()
{
    $all = ds_rows('', 12);
    if (empty($all)) {
        return '';
    }
    $h = '<div class="ds-home">';
    // Row 1: slider + tabs | notices
    $h .= '<div class="row ds-row"><div class="col-md-17"><div class="ds-box ds-hot"><div class="row">';
    $h .= '<div class="col-sm-12"><div class="ds-slider" id="dsSlider">';
    foreach (array_slice($all, 0, 5) as $i => $r) {
        $h .= '<a class="ds-slide' . ($i == 0 ? ' active' : '') . '" href="' . $r['link'] . '" title="' . $r['title'] . '"><img src="' . $r['img'] . '" alt="' . $r['title'] . '"><span class="ds-slide__cap">' . $r['title'] . '</span></a>';
    }
    $h .= '<div class="ds-dots">';
    for ($i = 0; $i < min(5, count($all)); $i++) {
        $h .= '<button type="button" class="' . ($i == 0 ? 'active' : '') . '" data-i="' . $i . '" aria-label="Tin ' . ($i + 1) . '"></button>';
    }
    $h .= '</div></div></div><div class="col-sm-12"><ul class="ds-tabs" role="tablist"><li class="active"><a href="#ds-tab1" data-toggle="tab">Tin tiêu điểm</a></li><li><a href="#ds-tab2" data-toggle="tab">Tin mới nhất</a></li></ul><div class="tab-content">';
    $h .= '<ul class="tab-pane active ds-arrowlist" id="ds-tab1">';
    foreach (array_slice($all, 5, 5) as $r) {
        $h .= ds_li($r);
    }
    $h .= '</ul><ul class="tab-pane ds-arrowlist" id="ds-tab2">';
    foreach (array_slice($all, 0, 5) as $r) {
        $h .= ds_li($r);
    }
    $h .= '</ul></div></div></div></div></div>';
    // notices
    $h .= '<div class="col-md-7"><div class="ds-box ds-notice"><h2 class="ds-box__title">Thông báo mới</h2><ul class="ds-dotlist" id="dsNotice">';
    foreach (ds_rows('', 12, 0) as $i => $r) {
        $h .= ds_li($r, ($i < 4 ? 'on' : '') . ($i % 3 == 2 ? ' blue' : ''));
    }
    $h .= '</ul><div class="ds-pager"><button type="button" class="btn btn-default btn-sm" data-dir="-1">&lsaquo; Trước</button> <button type="button" class="btn btn-default btn-sm" data-dir="1">Sau &rsaquo;</button></div></div></div></div>';

    // Row 2: section boxes + gallery
    $sec = function ($title, $link, $rows) {
        if (empty($rows)) {
            return '';
        }
        $f = array_shift($rows);
        $s = '<div class="ds-box ds-sec"><div class="ds-sec__head"><a href="' . $link . '">' . $title . '</a></div><div class="ds-sec__body">';
        $s .= '<div class="ds-lead"><a class="ds-lead__img" href="' . $f['link'] . '"><img src="' . $f['thumb'] . '" alt="' . $f['title'] . '" loading="lazy"></a><h3><a href="' . $f['link'] . '">' . $f['title'] . '</a></h3><p>' . $f['desc'] . '</p></div><ul class="ds-sqlist">';
        foreach ($rows as $r) {
            $s .= ds_li($r);
        }
        return $s . '</ul></div></div>';
    };
    $c1 = ds_rows('catid=1', 5);
    $c1l = $c1 ? $c1[0]['cat_link'] : '#';
    $c2 = ds_rows('catid IN (2,3)', 5);
    $c2l = $c2 ? $c2[0]['cat_link'] : '#';
    $c3 = ds_rows('catid IN (4,6)', 5);
    $c3l = $c3 ? $c3[0]['cat_link'] : '#';
    $c4 = ds_rows('catid=5', 5);
    $c4l = $c4 ? $c4[0]['cat_link'] : '#';
    $h .= '<div class="row ds-row"><div class="col-md-17"><div class="row"><div class="col-sm-12">' . $sec('Tin tức - Sự kiện', $c1l, $c1) . '</div><div class="col-sm-12">' . $sec('Hoạt động', $c2l, $c2) . '</div></div>';
    $h .= '<div class="row"><div class="col-sm-12">' . $sec('Thị trường &amp; Phần cứng', $c3l, $c3) . '</div><div class="col-sm-12">' . $sec('Đạo đức &amp; Pháp lý', $c4l, $c4) . '</div></div></div>';
    // gallery
    $h .= '<div class="col-md-7"><div class="ds-box ds-gallery"><h2 class="ds-box__title">Sự kiện qua ảnh</h2><div class="ds-gal" id="dsGal">';
    foreach (ds_rows("homeimgfile<>''", 8, 3) as $i => $r) {
        $h .= '<a class="ds-gal__item' . ($i == 0 ? ' active' : '') . '" href="' . $r['link'] . '" title="' . $r['title'] . '"><img src="' . $r['thumb'] . '" alt="' . $r['title'] . '" loading="lazy"><span>' . $r['title'] . '</span></a>';
    }
    $h .= '<button type="button" class="ds-gal__nav prev" data-dir="-1" aria-label="Ảnh trước">&lsaquo;</button><button type="button" class="ds-gal__nav next" data-dir="1" aria-label="Ảnh sau">&rsaquo;</button></div></div>';
    $h .= '<div class="ds-box ds-notice"><h2 class="ds-box__title">Tin khác</h2><ol class="ds-numlist">';
    foreach (ds_rows('', 6, 4) as $r) {
        $h .= ds_li($r);
    }
    $h .= '</ol></div></div></div></div>';
    return $h;
}
