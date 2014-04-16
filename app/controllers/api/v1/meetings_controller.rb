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

        api_id = ApiKey.find_by(access_token: @tok).id

        Rails.logger.info "/////////////////////------------------------------#{api_id}"
        Rails.logger.info "/////////////////////------------------------------#{@opt[:non]}"

				if caller_obj = User.find_by(uniq_id: params[:user][:uid_caller])
					Rails.logger.info "caller user already present"
				else
					caller_obj = User.create(uniq_id: params[:user][:uid_caller],
                                   name: params[:caller][:name],
                                   number: params[:caller][:number],
                                   api_key_id: api_id)
				end
				
				if receiver_obj = User.find_by(uniq_id: params[:user][:uid_receiver])
					Rails.logger.info "receiver user already present"
				else
					receiver_obj = User.create(uniq_id: params[:user][:uid_receiver],
                                     name: params[:receiver][:name],
                                     number: params[:receiver][:number],
                                     api_key_id: api_id)
				end

				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{@meeting_param}"
				Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$asdasdasdasdasdasd1@@@@@@"

				#Rails.logger.info user_caller
				#Rails.logger.info user_caller.id
				#Rails.logger.info user_caller.caller
				#Rails.logger.info user_receiver
				#Rails.logger.info user_receiver.id
				#Rails.logger.info user_receiver.receiver
        
        start_time = params[:meeting][:start_at].to_time

				meeting = Meeting.create(caller_id: caller_obj.id,
																		receiver_id: receiver_obj.id,
																		duration: meeting_params[:duration],
																		order_id: meeting_params[:order_id],
                                    start_time: start_time,
                                    start_date: start_time,
                                    api_key_id: api_id
                                    )

				encrypted_caller_id = VERIFIER.generate(caller_obj.uniq_id)
				encrypted_receiver_id = VERIFIER.generate(receiver_obj.uniq_id)

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
				params.require(:meeting).permit(:order_id, :call_type, :duration, :start_at)
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
          @tok = token
          @opt = options
					ApiKey.exists?(access_token: token)
				end
			end

		end
	end
end
