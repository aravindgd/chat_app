class Meeting < ActiveRecord::Base
  belongs_to :caller
  belongs_to :receiver
end
