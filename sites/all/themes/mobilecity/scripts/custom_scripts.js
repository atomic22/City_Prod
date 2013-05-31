/* (function ($){
		$(document).ready(function(){
		var test = document.querySelector(".menutoggle");
		test.addEventListener('gesturedoubletap', function() {
		if($(test).text() == "Hide Menu")
		{
			$(test).text("Show Menu");
		}
		else
		{
			$(test).text("Hide Menu");
		}
		});
		});
})(jQuery); */

(function ($){
		$(document).ready(function(){
		jQuery(".menutoggle").bind("click",(function(){
		if($(".menutoggle").text() == "Hide Menu")
		{
			$(".menutoggle").text("Show Menu");
			$(".themenu").toggle('slow');
		}
		else
		{
			$(".menutoggle").text("Hide Menu");
			$(".themenu").toggle('slow');
		}
		}));
		});
})(jQuery);

// $(".menutoggle").toggle('slow');

/* (function ($){
		$(document).ready(function(){
		$(".menutoggle").bind("click",(function(){
		alert ("hello");
		}));
		});
})(jQuery); */