class Receiver < ActiveRecord::Base
	belongs_to :user
	has_many :meetings
end
