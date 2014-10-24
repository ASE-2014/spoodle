class SpoodleDate < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :users

  validates :datetime, presence: true

  def is_assigned?(user)
    self.users.include? user
  end

end