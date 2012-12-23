$(document).ready(function(){
  $("table tbody tr").each(function(index, value){
    if(index % 2 == 0){
        $(this).css("background", "#eeeeff");
    }
  });
});