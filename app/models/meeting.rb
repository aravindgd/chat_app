class Meeting < ActiveRecord::Base
  belongs_to :callers
  belongs_to :receivers
end
