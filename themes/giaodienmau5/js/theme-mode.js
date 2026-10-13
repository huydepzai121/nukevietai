/* AI Today - chế độ sáng/tối. Nạp đồng bộ trong <head> để tránh nháy màu. */
(function (d, w) {
    var KEY = 'ai-theme-mode', root = d.documentElement;
    function stored() { try { return w.localStorage.getItem(KEY); } catch (e) { return null; } }
    function prefers() { return w.matchMedia && w.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark'; }
    function apply(m) {
        root.setAttribute('data-theme', m);
        root.style.colorScheme = m;
        var b = d.querySelectorAll('.theme-toggle');
        for (var i = 0; i < b.length; i++) {
            b[i].setAttribute('aria-pressed', m === 'dark' ? 'true' : 'false');
            b[i].setAttribute('title', m === 'dark' ? 'Chuyển sang giao diện sáng' : 'Chuyển sang giao diện tối');
        }
    }
    apply(stored() || prefers());
    if (w.matchMedia) {
        var mq = w.matchMedia('(prefers-color-scheme: light)');
        var onChange = function () { if (!stored()) apply(prefers()); };
        mq.addEventListener ? mq.addEventListener('change', onChange) : mq.addListener && mq.addListener(onChange);
    }
    d.addEventListener('click', function (e) {
        var t = e.target.closest ? e.target.closest('.theme-toggle') : null;
        if (!t) return;
        e.preventDefault();
        var next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
        try { w.localStorage.setItem(KEY, next); } catch (er) {}
        apply(next);
    });
    d.addEventListener('DOMContentLoaded', function () { apply(root.getAttribute('data-theme') || 'dark'); });
})(document, window);
