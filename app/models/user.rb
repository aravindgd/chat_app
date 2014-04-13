class User < ActiveRecord::Base
	has_one :caller
	has_one :receiver
end
