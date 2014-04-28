class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  #before_filter :restrict_access, only: [:create]

  def create
    begin
      uid = VERIFIER.verify(params[:session][:acc_tok])
      Rails.logger.info "#############################################################{uid}"
      if user = User.find_by(uniq_id: uid)
        sign_in user
        Rails.logger.info "##################################################################{user}"
        redirect_to meetings_path
      else
        flash[:alert] = "Invalid access_token"
        redirect_to meetings_path
      end
    rescue
      flash[:alert] = "Invalid access_token"
        redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @tok = token
      ApiKey.exists?(access_token: token)
    end
  end
end
