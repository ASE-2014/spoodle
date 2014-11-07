class Availability < ActiveRecord::Base
  # Allows a user to assign to a specific spoodle_date
  # The assigned user can set a weight between [0.1;1] which defines how interested he is in this date.
  # 1 is totally interested, 0.1 is not very interested
  belongs_to :spoodle_date
  belongs_to :user

  validates :weight, :numericality => {:greater_than_or_equal_to => 0.1, :less_than_or_equal_to => 1}
end