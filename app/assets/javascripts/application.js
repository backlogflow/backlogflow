// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery-ui

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

$(".new-story").live("click",function(){
	$(this).parent().children(".new-story.form").find(".popin.new-story").show();
});

$(".button.new-epic").live("click",function(){
	$(this).parent().children(".form").find(".popin.new-story").show();
});


$(".attributes").live("click",function(){
	$(this).parent().children(".edit.form").find(".popin.edit").show();
});

document.onkeyup=function(e) {
	if(e.which == 27 /*esc*/){
		$(".popin").hide();
		$("#description").slideUp("fast");
	}
}

$('.button.cancel').live('click', function(){
	$(".popin").hide();
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


$('.title').live('click',function(){
	if($(this).parent().siblings('.story-body:not(:visited)').css('display') == "none"){
		$(this).parent().siblings('.story-body').slideDown();
	}else{
		if($(this).parent().parent().hasClass('epic')){
			$(this).parent().parent().find('.story-body').slideUp();
		}else{
			$(this).parent().parent().children('.story-body').slideUp();
		}
	}
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


 