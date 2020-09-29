$(document).ready(function(){
  $('.ajax-load').on('click', function(e){
    e.preventDefault();
    $('.ajax-content').load($(this).attr('href'));
  });
});
