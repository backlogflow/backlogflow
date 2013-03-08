// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function removeEmptyOptionFromSelect(popin){
	var select = $("select#story_points", popin);
	select.each(function(i, value){
		if(value[0].value == ""){
			value[0] = null;
		}
	});
}

function adjustGrid(){
  if( window.innerWidth > 640 && window.innerWidth <= 980 ){
    $(".grid-940").css("width", window.innerWidth - 40);
  }
}

function positionPopin(){
	var visiblePopin = $('.popin:not(.hidden)');
	if(visiblePopin.length > 0){
		var windowSize = window.innerWidth;
		var popinSize = visiblePopin.width();
		var popinPos = windowSize/2 - popinSize/2;
		visiblePopin.css("left",popinPos);
		var pageScroll = window.pageYOffset;
		visiblePopin.css("top", pageScroll+100);
	}
}
window.onresize = function(e){
	positionPopin();
	adjustGrid();
}
window.onscroll = function(){
	positionPopin();
}

$(".button.new-story").live("click",function(){
	var $popin = $( ".new-story.popin", $(this).parent() );
	if($popin.hasClass("hidden")){		
		$('div.popin').addClass("hidden");
		$popin.removeClass("hidden");

		$('input#story_title', $popin).focus();
		var select = $("select", $popin)[0];
		select.selectedIndex = 0;
		removeEmptyOptionFromSelect($popin);
		positionPopin();
	}
});

$(".button.edit").live("click",function(){
	var $popin = $( ".edit.popin", $(this).parent() );

	if($popin.hasClass("hidden")){
		var $story = $popin.parents('li.story').eq(0);
		var $attributes = $('> .attributes', $story);
		$('div.popin').addClass("hidden");
		$popin.removeClass("hidden");

		$("#story_title", $popin).val($(".title", $story).eq(0).text());
		$("#story_description", $popin).val($(".user-story", $attributes).eq(0).text());
		$("#story_details", $popin).val($(".details", $attributes).eq(0).text());
		$("#story_value", $popin).val($(".value", $attributes).eq(0).text());

		$('input#story_title', $popin).focus();
		removeEmptyOptionFromSelect($popin);
		positionPopin();
	}
});

document.onkeyup=function(e) {
	if(e.which == 27 /*esc*/){
		$("div.popin").addClass("hidden");
	}
}

$('.button.cancel').live('click', function(){
	$("div.popin").addClass("hidden");
});

$(".story-header .status").live("mouseover", function(){
	$(".popin-edit-status", $(this).parent()).removeClass("hidden");
});
$(".story-header .status").live("mouseout", function(){
	$(".popin-edit-status", $(this).parent()).addClass("hidden");
});
$(".story-header .popin-edit-status").live("mouseover", function(){
	$(this).removeClass("hidden");
});
$(".story-header .popin-edit-status").live("mouseout", function(){
	$(this).addClass("hidden");
});


 