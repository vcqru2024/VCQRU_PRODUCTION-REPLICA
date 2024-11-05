/*
	Credits
	Author: Shane Strong
	Website: http://www.shanestrong.com
	Email: shane@shanestrong.com
	License: Free to use and edit as you see fit. Only thing I ask is if you find something to 
	make this better please let me know.
*/

//Setting up the popup
//0 is disabled; 1 is enabled;
var popupStatus = 0;

function loadPopup(){
	//Will only be loaded if the status is 0
	if(popupStatus==0){
		$(".backgroundPopup").css({"opacity": "0.8"});
		$(".backgroundPopup").fadeIn("slow");
		$(".popupContent").fadeIn("slow");
		popupStatus = 1;
	}
}

//This will disable the popup when needed
function disablePopup(){
	//Will only disable if status is 1
	if(popupStatus==1){
		$(".backgroundPopup").fadeOut("slow");
		$(".popupContent").fadeOut("slow");
		popupStatus = 0;
	}
}

//Centers the popup to your window size 
function centerPopup(){
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $(".popupContent").height();
	var popupWidth = $(".popupContent").width();
	$(".popupContent").css({
		"position": "absolute",
		"top": windowHeight/7-popupHeight/7,
		"left": windowWidth/4-popupWidth/4
	});
	//this is needed for ie6
	$(".backgroundPopup").css({ "height": windowHeight });
}


//Click event controller
$(document).ready(function(){
	//Open the popup and center
	$(".button").click(function(){
		centerPopup();
		loadPopup();
	});
	
	
	//Close popup by clicking the x
	$(".popupClose").click(function(){ disablePopup(); });
	//Close popup by clicking outside the box
	$(".backgroundPopup").click(function(){ disablePopup(); });
	//Close popup by clicking escape
	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus==1){
			disablePopup();
		}
	});
});




//for Login----------------------------------------------------------------------

function loadPopup1(){
	//Will only be loaded if the status is 0
	
	if(popupStatus==0){
		$(".backgroundPopup1").css({"opacity": "0.8"});
		$(".backgroundPopup1").fadeIn("slow");
		$(".popupContent_loin").fadeIn("slow");
		popupStatus = 1;
	}
}


//This will disable the popup when needed
function disablePopup1(){
	//Will only disable if status is 1
	if(popupStatus==1){
		$(".backgroundPopup1").fadeOut("slow");
		$(".popupContent_loin").fadeOut("slow");
		popupStatus = 0;
	}
}

//Centers the popup to your window size for login 
function centerPopup1(){
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $(".popupContent_loin").height();
	var popupWidth = $(".popupContent_loin").width();
	$(".popupContent_loin").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});	
	//this is needed for ie6
	$(".backgroundPopup1").css({ "height": windowHeight });
}
//Click event controller
$(document).ready(function(){
	
	//login popup
	$(".loginpop").click(function(){
		centerPopup1();
		loadPopup1();
	});

	
	//Close popup by clicking the x
	$(".popupClose1").click(function(){ disablePopup1(); });
	//Close popup by clicking outside the box
	$(".backgroundPopup1").click(function(){ disablePopup1(); });
	//Close popup by clicking escape
	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus==1){
			disablePopup1();
		}
	});
});




//for Login Small----------------------------------------------------------------------

function loadPopup1_v(){
	//Will only be loaded if the status is 0
	
	if(popupStatus==0){
		$(".backgroundPopup_v").css({"opacity": "0.8"});
		$(".backgroundPopup_v").fadeIn("slow");
		$(".popupContent_loin_v").fadeIn("slow");
		popupStatus = 1;
	}
}


//This will disable the popup when needed
function disablePopup1_v(){
	//Will only disable if status is 1
	if(popupStatus==1){
		$(".backgroundPopup_v").fadeOut("slow");
		$(".popupContent_loin_v").fadeOut("slow");
		popupStatus = 0;
	}
}

//Centers the popup to your window size for login 
function centerPopup1_v(){
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $(".popupContent_loin_v").height();
	var popupWidth = $(".popupContent_loin_v").width();
	$(".popupContent_loin_v").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});	
	//this is needed for ie6
	$(".backgroundPopup_v").css({ "height": windowHeight });
}
//Click event controller
$(document).ready(function(){
	
	//login popup
	$(".loginpop_v").click(function(){
		centerPopup1_v();
		loadPopup1_v();
	});

	
	//Close popup by clicking the x
	$(".popupClose1_v").click(function(){ disablePopup1_v(); });
	//Close popup by clicking outside the box
	$(".backgroundPopup_v").click(function(){ disablePopup1_v(); });
	//Close popup by clicking escape
	$(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus==1){
			disablePopup1_v();
		}
	});
});



