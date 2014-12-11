class User < ActiveRecord::Base

  after_create :create_user_on_cyber_coach, only: :create
  before_destroy :destroy_user_on_cyber_coach, only: :delete

  has_many :invitations
  has_many :availabilities
  has_many :own_events, foreign_key: :owner_id, class_name: 'Event'
  has_many :invited_events, through: :invitations, :source => :event, class_name: 'Event'
  has_and_belongs_to_many :spoodle_dates
  has_many :friendships_one, foreign_key: :friend_one_id, class_name: 'Friendship' # hacky - but the model demands it
  has_many :friendships_two, foreign_key: :friend_two_id, class_name: 'Friendship'

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

  # Creates an entry on cybercoach
  def create_entry_on_cyber_coach(sport, content)
    # Creates subscription on cybercoach (if one exists an update is sent but nothing should actually change)
    self.create_subscription_on_cyber_coach(sport)
    CybercoachEntry.create("#{self.cyber_coach_username}/#{sport}",
                           content,
                           self.cyber_coach_username,
                           self.cyber_coach_password,
                           :post,
                           "entry#{sport}")
  end

  # Creates, or updates if it already exists, a sport subscription on cybercoach
  def create_subscription_on_cyber_coach(sport)
    CybercoachSubscription.create("#{self.cyber_coach_username}/#{sport}",
                                  {publicvisible: '2'},
                                  self.cyber_coach_username,
                                  self.cyber_coach_password)
  end

  def to_s
    self.username
  end

  def friends_with(user)
    self.friendships.each do |friendship|
      return true if friendship.includes? user
    end
    false
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

  # Combines all existing friendships
  def friendships
    self.friendships_one.all + self.friendships_two.all
  end

  def friends
    friends = Array.new
    self.friendships.each do |f|
      friends << (f.friend_of self)
    end
    friends
  end

end