$(".popin.new-story .button.cancel").live("click", function(){
	$("form input.string", $(this)).val("");
});