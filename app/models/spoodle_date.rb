class SpoodleDate < ActiveRecord::Base
  belongs_to :event
  has_many :availabilities
end
