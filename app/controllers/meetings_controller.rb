class MeetingsController < ApplicationController
	$default_client = "client"
	def call
		# Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{params[:ph_no]}"
		@client_name = params[:client]
		Rails.logger.info "##########ddfdfdfdf#{@client_name}#########"
		#  Rails.logger.info "top #{@client_name}"
		if @client_name.nil?
			@client_name = $default_client
		end
		# @client_phone = params[:ph_no]
		# Find these values at twilio.com/user/account
		account_sid = 'AC1e7ff5d3ece16ab5ad2f63f7e201cb00'
		auth_token = 'cb902e68e940a3457383b6c813ab68f1'
		capability = Twilio::Util::Capability.new account_sid, auth_token
		# Create an application sid at twilio.com/user/account/apps and use it here
		capability.allow_client_outgoing "AP8270d0631a20c1edddf407e99299eca6"
		#    capability.allow_client_incoming @client_name
		capability.allow_client_incoming @client_name
		Rails.logger.info "botom #{@client_name}"
		@token = capability.generate
	end

	def voice
		caller_id = "+13174268213"
		number = params[:PhoneNumber]
		response = Twilio::TwiML::Response.new do |r|
			# Should be your Twilio Number or a verified Caller ID
			if /^[\d\+\-\(\) ]+$/.match(number)
				r.Gather :numDigits => '5', :action => '/handle_calls_from_phone', :method => 'get' do |g|

				end
			else
				r.Dial :callerId => caller_id do |d|
					d.Client number
				end
			end
		end
		render :text => response.text

	end


	def phone_to_x 
		caller_id = "+13174268213"
		number = params[:PhoneNumber]
		response = Twilio::TwiML::Response.new do |r|
			# Should be your Twilio Number or a verified Caller ID
			if /^[\d\+\-\(\) ]+$/.match(number)
				r.Gather :numDigits => '5', :action => '/handle_calls_from_phone', :method => 'get' do |g|

				end
			else
				r.Dial :callerId => caller_id do |d|
					d.Client number
				end
			end
		end
		render :text => response.text
	end


	def handle_calls_from_phone
		puts params
		Twilio::TwiML::Response.new do |r|
			r.Dial '+13174268213' 
			r.Say 'The call failed or the remote party hung up. Goodbye.'
		end
	end
end
