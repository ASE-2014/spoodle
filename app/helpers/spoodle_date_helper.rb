module SpoodleDateHelper

  def already_assigned?(spoodle_date)
    spoodle_date.is_assigned? current_user
  end

end