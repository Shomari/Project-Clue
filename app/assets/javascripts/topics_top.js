function raise_up(jquery) {
		$("#topic_list").on("click",".topic", function(){
		
			$(".topic").removeClass( "highlighted" );
			$(this).addClass( "highlighted" );

	});
}

$(document).ready(raise_up);
alert("dready taht yuo want")
$(document).on("page:load", raise_up);
alert("page load that you want")
