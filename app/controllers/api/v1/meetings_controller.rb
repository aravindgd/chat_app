module Api
	module V1
		class MeetingsController < ApplicationController
			skip_before_filter  :verify_authenticity_token
			before_filter :restrict_access


			def create
				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{params}"

				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{meeting_params}"
				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{caller_params}"
				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{receiver_params}"
				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{user_params}"

				user_caller = User.find_by(external_caller_id: params[:user][:uid_caller])

				if user_caller 
					caller_obj = user_caller.caller
				else
					user_caller = User.create(external_caller_id: params[:user][:uid_caller])
					caller_obj = user_caller.build_caller(caller_params)
					caller_obj.save!
				end
				
				user_receiver = User.find_by(external_receiver_id: params[:user][:uid_receiver])

				if user_receiver
					receiver = user_receiver.receiver
					Rails.logger.info "receiver user already present"
					Rails.logger.info receiver
				else
					user_receiver = User.create(external_receiver_id: params[:user][:uid_receiver])
					receiver = user_receiver.build_receiver(receiver_params)
					receiver.saved!
				end

				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{@meeting_param}"
				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$asdasdasdasdasdasd1@@@@@@"

				Rails.logger.info user_caller
				Rails.logger.info user_caller.id
				Rails.logger.info user_caller.caller
				Rails.logger.info user_receiver
				Rails.logger.info user_receiver.id
				Rails.logger.info user_receiver.receiver

				meeting = Meeting.create(caller_id: caller_obj.id,
																		receiver_id: receiver.id,
																		duration: meeting_params[:duration],
																		order_id: meeting_params[:order_id])

				encrypted_receiver_id = VERIFIER.generate(user_receiver.external_receiver_id)
				encrypted_caller_id = VERIFIER.generate(user_caller.external_caller_id)

				return_array= {"meeting_id" => meeting.id,"encrypted_caller_id" => encrypted_caller_id,"encrypted_receiver_id" => encrypted_receiver_id}

			respond_to do |format|
				format.json {render json: return_array}
			end
				#respond_to do |format|
				#if @meeting.save
				#format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
				#format.json { render action: 'show', status: :created, location: @meeting }
				#else
				#format.html { render action: 'new' }
				#format.json { render json: @meeting.errors, status: :unprocessable_entity }
				#end
				#end
			end

			private

			def meeting_params
				params.require(:meeting).permit(:order_id, :call_type, :duration)
			end

			def caller_params
				params.require(:caller).permit(:name, :number)
			end

			def receiver_params
				params.require(:receiver).permit( :name, :number)
			end

			def user_params
				params.require(:user).permit(:uid_receiver,:uid_caller)
			end

			def restrict_access
				authenticate_or_request_with_http_token do |token, options|
					ApiKey.exists?(access_token: token)
				end
			end

		end
	end
end
