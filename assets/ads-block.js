var iframes = document.getElementsByTagName('iframe');

for (var i = 0; i < iframes.length; i++) {
    var ifr = document.getElementsByTagName('iframe')[i];
    ifr.style.display = 'none';
    if (ifr.title == 'reCAPTCHA') { ifr.style.display = 'block'; }
}