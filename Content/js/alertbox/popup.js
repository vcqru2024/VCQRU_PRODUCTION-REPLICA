/***************************/
//@Author: Adrian "yEnS" Mato Gondelle
//@website: www.yensdesign.com
//@email: yensamg@gmail.com
//@license: Feel free to use it, but keep this credits please!					
/***************************/

//SETTING UP OUR POPUP
//0 means disabled; 1 means enabled;

//for cart
var popupStatus = 0;

//for compare
var popupStatus_compare = 0;

//for wishlist
var popupStatus_wishlist = 0;

var popupStatus_login = 0;
//loading popup with jQuery magic!

//for add to cart
function loadPopup(){
	//loads popup only if it is disabled
	if(popupStatus==0){
		$("#backgroundPopup").css({
			"opacity": "0.7"
		});
		$("#backgroundPopup").fadeIn("slow");
		$("#popupContact").fadeIn("slow");
		popupStatus = 1;
	}
}

//for compare
function loadPopup_compare(){
	//loads popup only if it is disabled
	if(popupStatus_compare==0){
		$("#backgroundPopup_compare").css({
			"opacity": "0.7"
		});
		$("#backgroundPopup_compare").fadeIn("slow");
		$("#popupContact_compare").fadeIn("slow");
		popupStatus_compare = 1;
	}
}

//for wishlist
function loadPopup_wishlist(){
	//loads popup only if it is disabled
	if(popupStatus_wishlist==0){
		$("#backgroundPopup_wishlist").css({
			"opacity": "0.7"
		});
		$("#backgroundPopup_wishlist").fadeIn("slow");
		$("#popupContact_wishlist").fadeIn("slow");
		popupStatus_wishlist = 1;
	}
}

//for login & register
function loadPopup_login(){
	//loads popup only if it is disabled
	if(popupStatus_login==0){
		$("#backgroundPopup_login").css({
			"opacity": "0.7"
		});
		$("#backgroundPopup_login").fadeIn("slow");
		$("#popupContact_login").fadeIn("slow");
		popupStatus_login = 1;
	}
}
//disabling popup with jQuery magic!

//for cart
function disablePopup(){
	//disables popup only if it is enabled
	if(popupStatus==1){
		$("#backgroundPopup").fadeOut("slow");
		$("#popupContact").fadeOut("slow");
		popupStatus = 0;
	}
}

//for compare
function disablePopup_compare(){
	//disables popup only if it is enabled
	if(popupStatus_compare==1){
		$("#backgroundPopup_compare").fadeOut("slow");
		$("#popupContact_compare").fadeOut("slow");
		popupStatus_compare = 0;
	}
}

//for wishlist
function disablePopup_wishlist(){
	//disables popup only if it is enabled
	if(popupStatus_wishlist==1){
		$("#backgroundPopup_wishlist").fadeOut("slow");
		$("#popupContact_wishlist").fadeOut("slow");
		popupStatus_wishlist = 0;
	}
}

//for login & Register
function disablePopup_login(){
	//disables popup only if it is enabled
	if(popupStatus_login==1){
		$("#backgroundPopup_login").fadeOut("slow");
		$("#popupContact_login").fadeOut("slow");
		popupStatus_login = 0;
	}
}

//centering popup

//for cart
function centerPopup(){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $("#popupContact").height();
	var popupWidth = $("#popupContact").width();
	//centering
	$("#popupContact").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});
	//only need force for IE6	
	$("#backgroundPopup").css({
		"height": windowHeight
	});
	
}

//for compare
function centerPopup_compare(){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight_compare = $("#popupContact_compare").height();
	var popupWidth_compare = $("#popupContact_compare").width();
	//centering
	$("#popupContact_compare").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight_compare/2,
		"left": windowWidth/2-popupWidth_compare/2
	});
	//only need force for IE6
	
	$("#backgroundPopup_compare").css({
		"height": windowHeight
	});
	
}

//for wishlist
function centerPopup_wishlist(){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight_wishlist = $("#popupContact_wishlist").height();
	var popupWidth_wishlist = $("#popupContact_wishlist").width();
	//centering
	$("#popupContact_wishlist").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight_wishlist/2,
		"left": windowWidth/2-popupWidth_wishlist/2
	});
	//only need force for IE6
	$("#backgroundPopup_wishlist").css({
		"height": windowHeight
	});
}

//for login & register
function centerPopup_login(){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight_login = $("#popupContact_login").height();
	var popupWidth_login = $("#popupContact_login").width();
	//centering
	$("#popupContact_login").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight_login/2,
		"left": windowWidth/2-popupWidth_login/2
	});
	//only need force for IE6
	$("#backgroundPopup_login").css({
		"height": windowHeight
	});
}
//CONTROLLING EVENTS IN jQuery
$(document).ready(function(){
	
	//LOADING POPUP
	//Click the button event!
	
	//for cart
	$(".button").click(function(){
		//centering with css
		centerPopup();
		//load popup
		loadPopup();
	});
	
	//for compare
	$(".button_compare").click(function(){
		//centering with css
		centerPopup_compare();
		//load popup
		loadPopup_compare();
	});
	
	//for wishlist
	$(".button_wishlist").click(function(){
	    //centering with css
	    disablePopup_login()
		centerPopup_wishlist();
		//load popup
		loadPopup_wishlist();

	});	
	
	//for login & register
	$("a.login_popup").click(function(){
		//centering with css
		centerPopup_login();
		//load popup
		loadPopup_login();
	});				
	//CLOSING POPUP
	//Click the x event!
	
	//for cart
	$("#popupContactClose").click(function(){
		disablePopup();
	});
	
	//for  compare
	$("#popupContactClose_compare").click(function(){
		disablePopup_compare();
	});
	
	//for wishlist
	$("#popupContactClose_wishlist").click(function(){
		disablePopup_wishlist();
	});
	
	//for login & register
	$("#popupContactClose_login").click(function(){
		disablePopup_login();
	});
	//Click out event!
	
	//for cart
	$("#backgroundPopup").click(function(){		
	});
	
	//Press Escape event!
	
	//for cart
	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus==1){
			disablePopup();
		}
	});
	
	//for compare
	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus_compare==1){
			disablePopup_compare();
		}
	});
	
	//for wishlist
	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus_wishlist==1){
			disablePopup_wishlist();
		}
	});
	
	//for login & register
	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus_login==1){
			disablePopup_login();
		}
	});
});