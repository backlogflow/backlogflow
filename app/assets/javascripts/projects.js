$("#filter .button").live("click", function() {
	$("#filter .button").removeClass("clicked");
	$(this).addClass("clicked");
	$(".loading", "#filter").show();
});

function update_sortable(){
  var project_id = $("#project_id").text();
  var url = '/project/'+project_id+'/story/order';
  if ( $(".status.button.todo").hasClass("clicked") ) {
    $("#stories").addClass("sortable");
  }else{
    $("#stories").removeClass("sortable");
  }
  $(".sortable").sortable({
    update: function(event, ui){
      var order = $(this).sortable('toArray').toString();
      $.ajax({
        url: url,
        type: 'POST',
        dataType: 'json',
        data: {"order": order},
        complete: function(xhr, textStatus) {
          $('.story-header > span.position', '#stories .story').each(function(index, value){
            $(value).html(index+1);
          });
        },
        error: function(xhr, textStatus, errorThrown) {
          //called when there is an error
        }
      });
    }
  });
};


$(document).ready(function(){
  update_sortable();
});