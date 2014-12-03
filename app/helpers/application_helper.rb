module ApplicationHelper

  def amount_upcoming
    current_user.upcoming_events.count
  end

  def amount_passed
    current_user.passed_events.count
  end

  def amount_pending
    current_user.pending_events.count
  end

  def amount_own
    current_user.created_events.count
  end

end