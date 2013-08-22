/* 
	author: istockphp.com
*/
jQuery(function($) {
	$(document).on("click", ".topopup", function(){
	//$("a.topopup").click(function() {
			loading(); // loading
			clickRel = $(this).attr("rel");
			setTimeout(function(){ // then show popup, deley in .5 second
				loadPopup(clickRel); // function show popup 
			}, 500); // .5 second
	return false;
	});
	
	/* event for close the popup */
	$("a.close").hover(
					function() {
						$('span.ecs_tooltip').show();
					},
					function () {
    					$('span.ecs_tooltip').hide();
  					}
				);
	
	$("a.close").click(function() {
		disablePopup();  // function close pop up
	});
	
	$(document).on("click", "a.avgrund-close", function(){ 
		popupId = $(this).parents("div").attr('id');
	disablePopup(popupId);  // function close pop up
	 });
	
	$(this).keyup(function(event) {
		if (event.which == 27) { // 27 is 'Ecs' in the keyboard
			disablePopup(popupId);  // function close pop up
		}  	
	});
	
	// $("div#backgroundPopup").click(function() {
		// disablePopup();  // function close pop up
	// });
	
	$('a.livebox').click(function() {
		alert('Are you sure???');
	return false;
	});
	

	 /************** start: functions. **************/
	function loading() {
		$("div.loader").show();  
	}
	function closeloading() {
		$("div.loader").fadeOut('normal');  
	}
	
	var popupStatus = 0; // set value
	
	function loadPopup(clickRel) {
		if(popupStatus == 0) { // if value is 0, show popup
			closeloading(); // fadeout loading
			$("#" + clickRel).fadeIn(0500); // fadein popup div
			$("#backgroundPopup").css("opacity", "0.7"); // css opacity, supports IE7, IE8
			$("#backgroundPopup").fadeIn(0001); 
			popupStatus = 1; // and set value to 1
		}	
	}
		
	function disablePopup(popupId) {
		if(popupStatus == 1) { // if value is 1, close popup
			
			$("#" + popupId).fadeOut("normal");  
			$("#backgroundPopup").fadeOut("normal");  
			popupStatus = 0;  // and set value to 0
		}
	}
	/************** end: functions. **************/
}); // jQuery End