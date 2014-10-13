class Availability < ActiveRecord::Base
  #A way to express "User X has time on date Y to participate in event Z"
  belongs_to :spoodle_date
  belongs_to :user
  belongs_to :event
end
