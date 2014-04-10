class Meeting < ActiveRecord::Base
  belongs_to :caller, dependent: :destroy
  belongs_to :receiver, dependent: :destroy
end
