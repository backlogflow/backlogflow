// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
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

$(".button.new-epic").live("click",function(){
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

$(".newStory").live("click",function(){
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

$(".editStory").live("click",function(){
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

//quando pressionar esc fecha todos os popins
document.onkeyup=function(e) {
	if(e.which == 27 /*esc*/){
		$("div.popin").addClass("hidden");
		$("#description").slideUp("fast");
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

//Para fazer com que todos as colunas fiquem com a mesma altura.
window.onload = function(){
	$('div[id^="board_"]').height($('div[id^="board_"]').height());
	$(".postit").draggable({
		revert: true
	});
	$('div[id^="board_"]').droppable({
		     drop: function(event, ui) {
		    	 $(ui.draggable).appendTo($(this));
		    	 var id_project = $("#project_id").html();
		    	 var id_story   = $(ui.draggable).find("input").val(); 
		    	 var story_status = $.trim($(this).find(".name_column").html());
		    	 var path = "/project/"+id_project+"/story/"+id_story+"/update_status/"+story_status;
		    	 $.ajax(path);
		     }
	});
}


$('.postit').live('click',function(){
	 var id = $(this).find("input").val(); 
	 var path = "/project/"+id+"/story/description";
	 $.ajax(path);
});
