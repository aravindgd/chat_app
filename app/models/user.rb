class User < ActiveRecord::Base
	has_many :call_sessions, class_name: "Meeting", foreign_key: "caller_id"
	has_many :receive_sessions, class_name: "Meeting", foreign_key: "receiver_id"
end
