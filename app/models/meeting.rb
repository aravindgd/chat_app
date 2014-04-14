class Meeting < ActiveRecord::Base
  belongs_to :caller, class_name: "User", foreign_key: "caller_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  attr_accessor :call_type
 	after_create :create_pin
	def create_pin
		puts "***************************"
		puts "#{self.caller.id}"
		puts "#{self.id}"
		puts "#{Random.rand(10000...99999)}"
		self.pin = "#{self.caller.id}#{self.id}#{Random.rand(10000...99999)}"
		self.save!
		puts self.pin
	end
end
