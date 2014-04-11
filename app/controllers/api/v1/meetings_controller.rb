module Api
  module V1
    class MeetingsController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      before_filter :restrict_access

      respond_to :json

      def create
        Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{params}"

        Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{meeting_params}"
        Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{caller_params}"
        Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{receiver_params}"

        @caller = Caller.find_by(caller_id: caller_params[:caller_id]) || Caller.create(caller_params)
        @receiver = Receiver.find_by(receiver_id: receiver_params[:receiver_id]) || Receiver.create(receiver_params)
        
        Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{@meeting_param}"
        
        respond_with Meeting.create(caller_id: @caller.id,
                                    receiver_id: @receiver.id,
                                    duration: meeting_params[:duration],
                                    order_id: meeting_params[:order_id])

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
        params.require(:caller).permit(:caller_id, :name, :number)
      end

      def receiver_params
        params.require(:receiver).permit(:receiver_id, :name, :number)
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

    end
  end
end
