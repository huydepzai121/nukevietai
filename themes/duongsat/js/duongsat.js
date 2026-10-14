/* Duongsat theme: slider, ticker, notices pager, gallery */
document.addEventListener('DOMContentLoaded',function(){
  function rot(items,setter,ms){var i=0;if(items.length<2)return null;var t=setInterval(function(){i=(i+1)%items.length;setter(i)},ms);return {go:function(n){i=(n+items.length)%items.length;setter(i)},cur:function(){return i}}}
  var sl=document.getElementById('dsSlider');
  if(sl){var s=sl.querySelectorAll('.ds-slide'),d=sl.querySelectorAll('.ds-dots button');
    var set=function(n){s.forEach(function(e,k){e.classList.toggle('active',k==n)});d.forEach(function(e,k){e.classList.toggle('active',k==n)})};
    var r=rot(s,set,5000);d.forEach(function(b){b.addEventListener('click',function(){r&&r.go(+b.dataset.i)})});}
  var tl=document.querySelector('.ds-ticker__list');
  if(tl){var n=tl.children.length;rot(tl.children,function(i){tl.style.transform='translateY('+(-22*i)+'px)'},3500);}
  var nl=document.getElementById('dsNotice');
  if(nl){var li=nl.children,p=0,per=+nl.dataset.per||4,pages=Math.ceil(li.length/per);
    document.querySelectorAll('.ds-pager button').forEach(function(b){b.addEventListener('click',function(){p=(p+ +b.dataset.dir+pages)%pages;for(var k=0;k<li.length;k++)li[k].classList.toggle('on',k>=p*per&&k<(p+1)*per)})});}
  var g=document.getElementById('dsGal');
  if(g){var it=g.querySelectorAll('.ds-gal__item');var setg=function(n){it.forEach(function(e,k){e.classList.toggle('active',k==n)})};var rg=rot(it,setg,4000);
    g.querySelectorAll('.ds-gal__nav').forEach(function(b){b.addEventListener('click',function(){rg&&rg.go(rg.cur()+ +b.dataset.dir)})});}
});
