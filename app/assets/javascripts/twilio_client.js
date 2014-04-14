$(document).ready(function(){


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
			});
			Twilio.Device.disconnect(function (conn) {
				$("#log").text("Call ended");
			});
			Twilio.Device.incoming(function (conn) {
				$("#log").text("Incoming connection from " + conn.parameters.From);
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

		$.ajaxSetup({
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
		});
});

function extend_call(){
	console.log("Test@@@@@@@@@@@@@@@@@@@@")
	$("#time_extension").data("time-extension",$("#time_extension_text_box").val());
}

function twilio_client_call() {
	// get the phone number or client to connect the call to
	//alert($("#number").val())
	params = {"PhoneNumber": $("#number").val()};
	if (Twilio.Device.status()!="open")
		{
			Twilio.Device.connect(params);	
		}
	var count_down_time = $('#count_down_time').data("count_down_time");
	console.log("%%%%%%%%%%%%%%%%%%%%%%%%%%%555")
	console.log(count_down_time)
	$('#countdown').timeTo({
		seconds: parseInt(count_down_time),
		countdown: true
	},function(){ 
		if($("#time_extension").data("time-extension")!=0)
			{
				$("#count_down_time").data("count_down_time",($("#time_extension").data("time-extension")));
				twilio_client_call();
			}
			else
				{
					twilio_client_hangup();
				}
	});
}
function twilio_client_hangup() {
	Twilio.Device.disconnectAll();
	$("#countdown").timeTo("stop");
	$( ".nav_bar_side" ).css( "background-image", "linear-gradient(to bottom,#428bca 0,#357ebd 100%)" );
}

