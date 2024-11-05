document.getElementById("fixItems").innerHTML =
    '<!-- backtotop -->' +
    '<button type="button" onclick="topFunction()" title="Top" id="top-btn" class="btn top-btn">' +
        '<i class="fa fa-arrow-up"></i>' +
    '</button>' +
    '<!-- talks -->' +
    '<div class="talks-btn">' +
        '<a href="../../contact-us.aspx#contact-us">' +
            '<img src="../front-assets/img/talks.jpg" alt="Let\'s talk">' +
        '</a>' +
    '</div>';    
// top-btn
var mybutton = document.getElementById("top-btn"); function scrollFunction() { document.body.scrollTop > 20 || document.documentElement.scrollTop > 20 ? mybutton.style.visibility = "visible" : mybutton.style.visibility = "hidden" } function topFunction() { document.body.scrollTop = 0, document.documentElement.scrollTop = 0 } window.onscroll = function () { scrollFunction() };