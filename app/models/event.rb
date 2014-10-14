class Event < ActiveRecord::Base
  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  has_many :invitations
  belongs_to :definitive_date, foreign_key: 'definitive_date_id', class_name: 'SpoodleDate'
  belongs_to :deadline, foreign_key: 'deadline_id', class_name: 'SpoodleDate'

end
