class User < ActiveRecord::Base

  after_create :create_user_on_cyber_coach, only: :create
  before_destroy :destroy_user_on_cyber_coach, only: :delete

  has_many :invitations
  has_many :availabilities
  has_many :own_events, foreign_key: :owner_id, class_name: 'Event'
  has_many :invited_events, through: :invitations, :source => :event, class_name: 'Event'
  has_and_belongs_to_many :spoodle_dates
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships

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
    self.save!
    response = CybercoachUser.create(self.cyber_coach_username, { email: self.email,
                                                                  password: self.cyber_coach_password,
                                                                  publicvisible: '2',
                                                                  realname: self.cyber_coach_username })
    raise 'RegisterError' unless response.success? #TODO handle error
  end

  def destroy_user_on_cyber_coach
    response = CybercoachUser.destroy(self.cyber_coach_username, self.cyber_coach_username, self.cyber_coach_password)
    raise 'DestroyError' unless response.success? #TODO handle error
  end

  def login_on_cyber_coach
    response = CybercoachResource.login(self.cyber_coach_username, self.cyber_coach_password)
    raise 'LoginError' unless response.success? #TODO handle error
  end

  def logout_on_cyber_coach
    # Nothing to do here
  end

  def to_s
    self.username
  end

  def all_events
    self.own_events + self.invited_events
  end

  # Returns an array of all events that were created by the user
  def created_events
    self.own_events
  end

  # Returns an array of all upcoming events where the user is taking part
  def upcoming_events
    self.all_events.select{ |event| event.is_upcoming? }
  end

  # Returns an array of all passed events where the user took part
  def passed_events
    self.all_events.select{ |event| event.is_passed? }
  end

  # Returns an array of all events where the user has set his availability but the deadline has not yet passed
  def pending_events
    self.all_events.select{ |event| !event.is_deadline_over? }
  end

end