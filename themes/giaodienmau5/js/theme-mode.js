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
/* AI Today newspaper UI: ngày, ô tìm kiếm, carousel tiêu điểm */
document.addEventListener('DOMContentLoaded', function () {
    var d = document.getElementById('np-date');
    if (d) {
        var days = ['Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'], n = new Date();
        d.textContent = days[n.getDay()] + ', ' + ('0' + n.getDate()).slice(-2) + '/' + ('0' + (n.getMonth() + 1)).slice(-2) + '/' + n.getFullYear();
    }
    var st = document.getElementById('np-search-toggle'), sp = document.getElementById('np-search');
    if (st && sp) st.addEventListener('click', function () {
        var open = sp.hasAttribute('hidden');
        if (open) { sp.removeAttribute('hidden'); var i = sp.querySelector('input'); i && i.focus(); } else { sp.setAttribute('hidden', ''); }
        st.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
    var c = document.querySelector('[data-np-carousel]');
    if (c) {
        var s = c.querySelectorAll('.np-slide'), dots = c.querySelector('.np-hero-dots'), k = 0, timer;
        function go(i) {
            k = (i + s.length) % s.length;
            for (var j = 0; j < s.length; j++) { s[j].classList.toggle('is-active', j === k); if (dots.children[j]) dots.children[j].classList.toggle('is-active', j === k); }
        }
        for (var j = 0; j < s.length; j++) (function (j) {
            var b = document.createElement('button'); b.type = 'button'; b.setAttribute('aria-label', 'Tin ' + (j + 1));
            b.addEventListener('click', function () { go(j); restart(); }); dots.appendChild(b);
        })(j);
        function restart() { clearInterval(timer); timer = setInterval(function () { go(k + 1); }, 6000); }
        c.querySelector('.np-prev').addEventListener('click', function () { go(k - 1); restart(); });
        c.querySelector('.np-next').addEventListener('click', function () { go(k + 1); restart(); });
        c.addEventListener('mouseenter', function () { clearInterval(timer); });
        c.addEventListener('mouseleave', restart);
        go(0); if (s.length > 1) restart();
    }
});
