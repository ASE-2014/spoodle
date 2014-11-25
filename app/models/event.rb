class Event < ActiveRecord::Base

  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'

  has_one :definitive_date, foreign_key: 'definitive_date_id', class_name: 'SpoodleDate'

  has_one :event_data
  has_one :document


  has_many :spoodle_dates
  accepts_nested_attributes_for :spoodle_dates, allow_destroy: true

  has_many :invitations
  accepts_nested_attributes_for :invitations, allow_destroy: true

  has_many :users, through: :invitations #TODO :users are not unique! Solution searched! Please help!

  validates :title, presence: true
  validates :deadline, presence: true
  validates :location, presence: true
  validate :minimal_one_spoodle_date
  validate :spoodle_dates_after_deadline

  # Validates that there is at least one spoodle_date set to choose from
  def minimal_one_spoodle_date
    errors.add(:spoodle_dates, 'At least one date must be set!') if self.spoodle_dates.size <= 0
  end

  # Validates that every spoodle_date takes place after the deadline
  def spoodle_dates_after_deadline
    errors.add(:spoodle_dates, 'must take place after the deadline!') if self.spoodle_dates.any?{ |spoodle_date| spoodle_date.from < self.deadline }
  end

  # Checks if there is a invitation for the given user
  def is_invited?(user)
    self.invitations.each do |invitation|
      return true if invitation.user.eql? user
    end
    return false
  end

  # Checks if the given user is the owner of the event
  def belongs_to?(user)
    user.eql? self.owner
  end

  # Returns all users that have assigned a value to the definitive Spoodle date
  # If the definitive date is not yet set, an empty array is returned
  def participants
    if definitive_date
      definitive_date.users
    else
      Array.new
    end
  end

  # Checks if the deadline is over yet
  def is_deadline_over?
    self.deadline < DateTime.now
  end

  # Checks if the event is definitive and not passed yet
  def is_upcoming?
    if is_deadline_over?
      return self.definitive_date.from > DateTime.now
    end
    return false
  end

  def is_passed?
    if is_deadline_over?
      return self.definitive_date.from < DateTime.now
    end
    return false
  end

  # Overwrites getter
  # Updates the definitive date if the deadline is over and it hasn't been selected yet
  def definitive_date
    if is_deadline_over?
      select_definitive_date if @definitive_date.nil?
    end
    @definitive_date
  end

  def sport
    CybercoachSport.find_by(:id, self.sport_id)[0]
  end

  # Overrides getter
  # Returns only the attributes which make sense for the sport which belongs to the event
  alias_method :event_data_original, :event_data
  def event_data
    attributes = {}
    event_data_original.attributes.each do |attribute|
      attributes[attribute] = event_data_original.send(attribute)
    end
    attributes
  end

  # Creates a icalendar object from the event
  def to_ical
    ical_event = Icalendar::Event.new
    ical_event.dtstart = self.definitive_date.from.strftime("%Y%m%dT%H%M%S")
    ical_event.dtend = self.definitive_date.to.strftime("%Y%m%dT%H%M%S")
    ical_event.summary = self.title
    ical_event.location = self.location
    ical_event.created = self.created_at
    if self.description?
      ical_event.description = self.description
    end
    self.participants.each do |user|
      ical_event.append_attendee "mailto:#{user.email}"
    end
    ical_event
  end

  private

  # Selects the spoodle_date with the most and strongest votes
  # Sets definitive_date to nil if nobody assigned to any date
  def select_definitive_date
    self.spoodle_dates.each do |spoodle_date|
      if @definitive_date.nil? or spoodle_date.votes > @definitive_date.votes
        @definitive_date = spoodle_date
      end
    end
  end

  # Returns an array of all upcoming events where the user is taking part
  def self.get_upcoming(user) #TODO move to user
    Event.select{ |event| (event.is_upcoming? and (event.is_invited? user or event.belongs_to? user)) }
  end

  # Returns an array of all passed events where the user took part
  def self.get_passed(user) #TODO move to user
    Event.select{ |event| (event.is_passed? and (event.is_invited? user or event.belongs_to? user)) }
  end

  # Returns an array of all events that were created by the user
  def self.get_own(user) #TODO move to user
    Event.select{ |event| (event.belongs_to? user) }
  end

  # Returns an array of all events where the user has set his availability but the deadline has not yet passed
  def self.get_pending(user) #TODO move to user
    Event.select{ |event| (!event.is_deadline_over? and (event.is_invited? user or event.belongs_to? user)) }
  end

end