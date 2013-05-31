 $(document).ready(function() {

 	// Animation for the languages and currency dropdown
$('.switcher').hover(function() {
$(this).find('.option').stop(true, true).slideDown(300);
},function() {
$(this).find('.option').stop(true, true).slideUp(150);
}); 
  
  
 });



