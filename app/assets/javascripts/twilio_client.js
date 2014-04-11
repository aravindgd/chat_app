read = function(){
  $("#fountainG").hide();
  $("#movingBallG").hide();

  	if ($("#twilio_client_token").length > 0)
  {
	var twilio_token = $("#twilio_client_token").data("token-id") 
  var twilio_client_name = $("#twilio_client_name").data("client-name") 
	console.log("%%%%%%%%%%%%%%%%%%%%%%%%5")
	console.log(twilio_token)
  
	Twilio.Device.setup(twilio_token, {debug: true});
	/* Let us know when the client is ready. */
	Twilio.Device.ready(function (device) {
		$("#log").text("Client "+twilio_client_name+" is ready");
	});
	/* Report any errors on the screen */
	Twilio.Device.error(function (error) {
		$("#log").text("Error: " + error.message);
	});
	Twilio.Device.connect(function (conn) {
		$("#log").text("Successfully established call");
		$("#movingBallG").show();
		$("#fountainG").hide();
	});
	Twilio.Device.disconnect(function (conn) {
		$("#log").text("Call ended");
		$("#fountainG").hide();
		 $("#movingBallG").hide();
	});
	
	Twilio.Device.incoming(function (conn) {
		$("#log").text("Incoming connection from " + conn.parameters.From);
		$("#fountainG").show();
      setInterval(function(){blink()}, 4000);            
      function blink() {
        $(".nav_bar_side").fadeTo(100, 0.1).fadeTo(200, 1.0);
        $( ".nav_bar_side" ).css( "background-image", "linear-gradient(to bottom,#47a447 0,#47a447 100%)" );
        
        }
    // accept the incoming connection and start two-way audio
     // conn.accept(function(){
    // $( ".nav_bar_side" ).css( "background-image", "linear-gradient(to bottom,#428bca 0,#357ebd 100%)" );
    // });
      conn.accept();
	});
	/* Connect to Twilio when we call this function. */
}
}

$(document).ready(read);
$(document).on('page:load', read);


function twilio_client_call() {
	// get the phone number or client to connect the call to
	//alert($("#number").val())
  params = {"PhoneNumber": $("#number").val()};
	Twilio.Device.connect(params);
	var count_down_time = $('#count_down_time').val();
	console.log("%%%%%%%%%%%%%%%%%%%%%%%%%%%555")
	console.log(count_down_time)
	
	$("#fountainG").show();
	$('#countdown').timeTo({
		seconds: 100,
		countdown: true
	},function(){ 
		twilio_client_hangup();
	});
}
function twilio_client_hangup() {
	Twilio.Device.disconnectAll();
	$("#countdown").timeTo("stop");
  // $( ".nav_bar_side" ).css( "background-image", "linear-gradient(to bottom,#428bca 0,#357ebd 100%)" );
}

