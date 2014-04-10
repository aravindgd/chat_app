class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  
  #Call action for chatting
  
  	def call
      # Rails.logger.info "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{params[:ph_no]}"
      #@client_name = params[:client]
      meeting = Meeting.find(params[:meeting_id])
      @receiver = meeting.receiver
      @caller = meeting.caller
      @client_name = @caller.name
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
      #capability.allow_client_incoming @client_name
      capability.allow_client_incoming @client_name
      Rails.logger.info "botom #{@client_name}"
      @token = capability.generate
    end
    
# Twilio call back method

		def voice
      #default_client = "jenny"
      caller_id = "+13174268213"
      number = params[:PhoneNumber]
      response = Twilio::TwiML::Response.new do |r|
        # Should be your Twilio Number or a verified Caller ID
        r.Dial :callerId => caller_id do |d|
          # Test to see if the PhoneNumber is a number, or a Client ID. In
          # this case, we detect a Client ID by the presence of non-numbers
          # in the PhoneNumber parameter.
            if /^[\d\+\-\(\) ]+$/.match(number)
                d.Number(CGI::escapeHTML number)
            else
                d.Client number
            end
        end
      end
        render :text => response.text
  	end 
    
  
  
  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meeting }
      else
        format.html { render action: 'new' }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:caller_id, :receiver_id, :order_id, :call_type, :duration)
    end
end
