class Availability < ActiveRecord::Base
  # A way to express "User X has time on date Y to participate in event Z"
  # The assigned user can set a weight between ]0;1] which defines how interested he is in this date.
  # 1 is totally interested, 0.00001 is not very interested
  belongs_to :spoodle_date
  belongs_to :user

  validates :weight, :numericality => {:greater_than => 0, :less_than_or_equal_to => 1}
end