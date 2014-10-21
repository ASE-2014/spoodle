class Event < ActiveRecord::Base
  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  has_many :invitations
  has_many :users, through: :invitations
  belongs_to :definitive_date, foreign_key: 'definitive_date_id', class_name: 'SpoodleDate'
  belongs_to :deadline, foreign_key: 'deadline_id', class_name: 'SpoodleDate'
  has_many :spoodle_dates
  accepts_nested_attributes_for :spoodle_dates, allow_destroy: true

  validates :title, presence: true
end