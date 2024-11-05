(function($){ 
	'use strict';

	/**=========================
        LOADER
    =========================**/
    $(window).on('load', function() {
        $('.loader-fix').fadeOut('slow',function(){$(this).remove();});
    });

    /**=========================
        HEADER FIXED SCROLL
    =========================**/
    $(window).on('scroll', function () {
        if($(window).scrollTop() > 200){
            $("#header").addClass('header-fixed');
        }else{
            $("#header").removeClass('header-fixed');
        }
    });

    /**=========================
        NAVBAR
    =========================**/
    $(function(){
        if($(window).width() > 768){
            $(".dropdown").hover(
            function(){
                $(this).find('.dropdown-menu').first().stop(true, true).slideDown(400);
                $(this).toggleClass('open');
                $(this).find('.dropdown-menu').parent('.nav-item.dropdown').addClass("dropdown-active");
            },
            function(){
                $(this).find('.dropdown-menu').first().stop(true, true).slideUp(100);
                $(this).toggleClass('open');
                $(this).find('.dropdown-menu').parent('.nav-item.dropdown').removeClass("dropdown-active");
            });
        };
    });

    /**=========================
        SLICK CAROUSEL
    =========================**/
    // Slider
    $(".carousel").carousel({
        pause: false,
    });
    // Swipe
    $(".carousel .carousel-inner").swipe({
        swipeLeft: function (event, direction, distance, duration, fingerCount) {
            this.parent().carousel("next");
        },
        swipeRight: function () {
            this.parent().carousel("prev");
        },
        threshold: 0,
        tap: function (event, target) {
            window.location = $(this).find(".carousel-item.active a").attr("href");
        },
        excludedElements: "label, button, input, select, textarea, .noSwipe",
    });

    $(".carousel .carousel-inner").on("dragstart", "a", function () {
        return false;
    });

    /**=========================
        CAROUSEL
    =========================**/
    // trusted Brand carousel
    $(".brand-carousel").not('.slick-initialized').slick({
        slidesToShow: 4,
        dots: false,
        autoplay: true,
        responsive: [
            {
                breakpoint: 900,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });


    // clients carousel
    $(".clients-carousel").not('.slick-initialized').slick({
        slidesToShow: 5,
        dots: false,
        autoplay: true,
        responsive:[
            {
                breakpoint: 900,
                settings:{
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });
    // labels-carousel
    $(".labels-carousel").not('.slick-initialized,.industries-serving-carousel').slick({
        slidesToShow: 3,
        dots: true,
        autoplay: true,
        responsive: [
            {
                breakpoint: 900,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });
    // product-carousel
    $(".product-carousel").not('.slick-initialized').slick({
        slidesToShow: 1,
        dots: false,
        autoplay: true,
        responsive: [
            {
                breakpoint: 900,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });

    // product-carousel
    $(".toures-carousel").not('.slick-initialized').slick({
        slidesToShow: 3,
        dots: false,
        autoplay: true,
        responsive: [
            {
                breakpoint: 900,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });
    // client says
    $(".client-says-carousel").not('.slick-initialized').slick({
        slidesToShow: 2,
        dots: false,
        autoplay: true,
        responsive:[
            {
                breakpoint: 900,
                settings:{
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });
    
    //counterfeit slider
        // client says
    $(".counterfeit-slider").not('.slick-initialized').slick({
        slidesToShow: 5,
        dots: false,
        autoplay: true,
        loop: false,
        zoom: true,
        responsive:[
            {
                breakpoint: 900,
                settings:{
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    infinite: true,
                }
            },
            {
                breakpoint: 480,
                settings:{
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });

    
        //counterfeit slider
        // client says
    $(".indutries-slider").not('.slick-initialized').slick({
        slidesToShow: 5,
        dots: false,
        autoplay: true,
        loop: false,
        zoom: true,
        responsive:[
            {
                breakpoint: 900,
                settings:{
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    infinite: true,
                }
            },
            {
                breakpoint: 680,
                settings:{
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });

    //industries serving
    $(".industries-serving-carousel").not('.slick-initialized').slick({
        slidesToShow: 4,
        dots: false,
        autoplay: true,
        responsive: [
            {
                breakpoint: 900,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    infinite: true,
                }
            }
        ]
    });
    
    //select box

    $(".selectBox").on("click", function (e) {
        $(this).toggleClass("show");
        var dropdownItem = e.target;
        var container = $(this).find(".selectBox__value");
        container.text(dropdownItem.text);
        $(dropdownItem)
            .addClass("active")
            .siblings()
            .removeClass("active");
    });

    $(window).scroll(function () {
        if ($(this).scrollTop() > 210) {
            $('#dynamic').addClass('newClass');
        } else {
            $('#dynamic').removeClass('newClass');
        }
    });
    /**=========================
        MAGANIFIC POPUP
    =========================**/
    $('a.mfpclick').click(function(m) {
        m.preventDefault();
        var gallery = $(this).attr('href');
        $(gallery).magnificPopup({
            delegate: 'a',
            type:'image',
            mainClass: 'mfp-fade',
            gallery: {
                enabled: true
            }
        }).magnificPopup('open');
    });

    /**=========================
        EASING
    =========================**/
    // Smooth scrolling using jQuery easing
    $(".easing-click").on('click', function(e) {
    var target = $(this.hash);
    target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
        if (target.length) {
        $('html, body').animate({
            scrollTop: (target.offset().top - 72)
        }, 1000, "easeInOutExpo");
            return false;
        }
    });

  
    /**=========================
        BACK TO TOP
    =========================**/
    $(window).on('scroll', function() {
        if ($(this).scrollTop() > 300) {
            $('#backtotop').fadeIn(2000);
        } else {
            $('#backtotop').fadeOut(2000);
        }
    });

})(jQuery);





 /**=========================
    Login & SignUp
=========================**/   
$('.forgot_passwerd label input[type=radio], .forgot_passwerd label input[type=checkbox]').click(function() {
  $('label:has(input:checked)').addClass('active');
  $('label:has(input:not(:checked))').removeClass('active');
});


    
$(document).ready(function(){
  $('.sign_in').click(function(){
    $('.login').addClass('active')
    $('.welcome').addClass('active')
    $('.sign_in').addClass('active')
    $('.btn').addClass('active')
    $('.sign_up').addClass('active')
  }),
  $('.btn').click(function(){
    $('.sign_up').removeClass('active')
    $('.login').removeClass('active')
    $('.welcome').removeClass('active')
    $('.sign_up').removeClass('active')
    $('.btn').removeClass('active')
    $('.sign_in').removeClass('active')
  })
})



/**============
codeCheck Page start
================**/

;(function($) {
    "use strict";  
    
    //* Form js
    function verificationForm(){
        //jQuery time
        var current_fs, next_fs, previous_fs; //fieldsets
        var left, opacity, scale; //fieldset properties which we will animate
        var animating; //flag to prevent quick multi-click glitches

        $(".next").click(function () {
            if (animating) return false;
            animating = true;

            current_fs = $(this).parent();
            next_fs = $(this).parent().next();

            //activate next step on progressbar using the index of next_fs
            $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

            //show the next fieldset
            next_fs.show();
            //hide the current fieldset with style
            current_fs.animate({
                opacity: 0
            }, {
                step: function (now, mx) {
                    //as the opacity of current_fs reduces to 0 - stored in "now"
                    //1. scale current_fs down to 80%
                    scale = 1 - (1 - now) * 0.2;
                    //2. bring next_fs from the right(50%)
                    left = (now * 50) + "%";
                    //3. increase opacity of next_fs to 1 as it moves in
                    opacity = 1 - now;
                    current_fs.css({
                        'transform': 'scale(' + scale + ')',
                        'position': 'absolute'
                    });
                    next_fs.css({
                        'left': left,
                        'opacity': opacity
                    });
                },
                duration: 800,
                complete: function () {
                    current_fs.hide();
                    animating = false;
                },
                //this comes from the custom easing plugin
                easing: 'easeInOutBack'
            });
        });

        $(".previous").click(function () {
            if (animating) return false;
            animating = true;

            current_fs = $(this).parent();
            previous_fs = $(this).parent().prev();

            //de-activate current step on progressbar
            $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

            //show the previous fieldset
            previous_fs.show();
            //hide the current fieldset with style
            current_fs.animate({
                opacity: 0
            }, {
                step: function (now, mx) {
                    //as the opacity of current_fs reduces to 0 - stored in "now"
                    //1. scale previous_fs from 80% to 100%
                    scale = 0.8 + (1 - now) * 0.2;
                    //2. take current_fs to the right(50%) - from 0%
                    left = ((1 - now) * 50) + "%";
                    //3. increase opacity of previous_fs to 1 as it moves in
                    opacity = 1 - now;
                    current_fs.css({
                        'left': left
                    });
                    previous_fs.css({
                        'transform': 'scale(' + scale + ')',
                        'opacity': opacity
                    });
                },
                duration: 800,
                complete: function () {
                    current_fs.hide();
                    animating = false;
                },
                //this comes from the custom easing plugin
                easing: 'easeInOutBack'
            });
        });

        $(".submit").click(function () {
            return false;
        })
    }; 
    
    //* Add Phone no select
    function phoneNoselect(){
        if ( $('#msform').length ){   
            $("#phone").intlTelInput(); 
            $("#phone").intlTelInput("setNumber", "+880"); 
        };
    }; 
    //* Select js
    function nice_Select(){
        if ( $('.product_select').length ){ 
            $('select').niceSelect();
        };
    }; 
    /*Function Calls*/  
    verificationForm ();
    phoneNoselect ();
    nice_Select ();
})(jQuery); 
