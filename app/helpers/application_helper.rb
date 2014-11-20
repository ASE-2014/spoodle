module ApplicationHelper

  def amount_upcoming
    Event.get_upcoming(current_user).count
  end

  def amount_passed
    Event.get_passed(current_user).count
  end

  def amount_pending
    Event.get_pending(current_user).count
  end

  def amount_own
    Event.get_own(current_user).count
  end

end