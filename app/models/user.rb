class User < ActiveRecord::Base
	has_many :call_sessions, class_name: "Meeting", foreign_key: "caller_id"
	has_many :receive_sessions, class_name: "Meeting", foreign_key: "receiver_id"
  belongs_to :api_key

  before_create :create_remember_token


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private

  def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
  end
end
