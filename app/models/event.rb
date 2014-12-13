class Event < ActiveRecord::Base

  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'

  belongs_to :definitive_date, foreign_key: 'definitive_date_id', class_name: 'SpoodleDate'

  has_one :event_data

  has_many :spoodle_dates
  accepts_nested_attributes_for :spoodle_dates, allow_destroy: true

  has_many :invitations
  accepts_nested_attributes_for :invitations, allow_destroy: true

  has_many :users, through: :invitations

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

  # Returns all users that have assigned to the definitive_date, WITHOUT the owner
  # If the definitive_date is not yet set, an empty array is returned
  def participants
    if definitive_date
      participants = definitive_date.users
      participants.delete self.owner if participants.include? self.owner
      participants
    else
      Array.new
    end
  end

  # Returns all users that have assigned to the definitive_date WITH the owner
  # If the definitive_date is not yet set, only the owner is returned
  def participants_with_owner
    participants << self.owner
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
  alias_method :original_definitive_date, :definitive_date
  def definitive_date
    if is_deadline_over?
      select_definitive_date if self.original_definitive_date.nil?
    end
    super
  end

  def sport
    # Stores sports_name in db because of performance issues (Cybercoach queries take time). "Hacky".
    # Memcached alternative didn't work well in dev environment.
    if self.sports_name.nil?
      sport = CybercoachSport.find_by(:id, self.sport_id)[0]
      self.sports_name = sport.name
      self.save!
      return sport
    else
      sport = CybercoachSport.new({name: self.sports_name})
      return sport
    end
  end


  # Creates a icalendar object from the event
  def to_ical(url)
    ical_event = Icalendar::Event.new
    ical_event.dtstart = self.definitive_date.from.strftime("%Y%m%dT%H%M%S")
    ical_event.dtend = self.definitive_date.to.strftime("%Y%m%dT%H%M%S")
    ical_event.summary = self.title
    ical_event.location = self.location
    ical_event.created = self.created_at
    ical_event.url = url
    ical_event.description = self.description if self.description?
    self.participants_with_owner.each do |user|
      ical_event.append_attendee "mailto:#{user.email}"
    end
    ical_event
  end

  private

  # Selects the spoodle_date with the most and strongest votes
  # Sets definitive_date to the first date if nobody assigned to any date
  def select_definitive_date
    self.spoodle_dates.each do |spoodle_date|
      if @definitive_date.nil? or spoodle_date.votes > @definitive_date.votes
        @definitive_date = spoodle_date
      end
    end

    self.definitive_date = @definitive_date
    self.save!
    create_entries_on_cybercoach
  end

  def create_entries_on_cybercoach
    participants_with_owner.each do |participant|
      participant.create_entry_on_cyber_coach(self.sport.name.downcase,
                                              {publicvisible: '2',
                                               entrylocation: self.location,
                                               comment: "Spoodle "+self.title})
    end
  end

end