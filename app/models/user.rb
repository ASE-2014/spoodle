class User < ActiveRecord::Base

  after_create :create_user_on_cyber_coach, only: :create
  before_destroy :destroy_user_on_cyber_coach, only: :delete

  has_many :events
  has_many :invitations
  has_many :availabilities
  has_many :events, through: :invitations
  has_and_belongs_to_many :spoodle_dates
  has_many :active_relationships, class_name:  "Relationship",
           foreign_key: "follower_id",
           dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  validates :username,
            :uniqueness => { :case_sensitive => false }

  def self.all_except(user)
    where.not(id: user)
  end

  # OVERWRITE to use username and email for login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def create_user_on_cyber_coach
    self.cyber_coach_username = self.username + Time.now.strftime('%Y%m%d%H%M%S%L')
    self.cyber_coach_password = Random.rand(99999).to_s
    self.save

    response = CybercoachUser.create(self.cyber_coach_username, {email: self.email, password: self.cyber_coach_password, publicvisible: '2', realname: self.cyber_coach_username})
    raise 'RegisterError' unless response.success?
  end

  def destroy_user_on_cyber_coach
    response = CybercoachUser.destroy(self.cyber_coach_username, self.cyber_coach_username, self.cyber_coach_password)
    raise 'DestroyError' unless response.success?
  end

  def login_on_cyber_coach
    response = CybercoachResource.login(self.cyber_coach_username, self.cyber_coach_password)
    raise 'LoginError' unless response.success?
  end

  def logout_on_cyber_coach
    # Nothing to do here
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
end