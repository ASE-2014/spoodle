class InvitationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_event!, only: [:new, :create]
  before_filter :deadline_not_over!

  def new
    @event = Event.find(params[:event_id])
    @users = User.select{ |user| @event.users.exclude? user and not @event.belongs_to? user }
    if @users.empty?
      flash[:error] = "All Spoodle Users are already invited to this event!"
      redirect_to @event
    else
      @invitation = Invitation.new
      render :new
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @invitation = @event.invitations.new(invitation_params)
    if @invitation.save
      flash[:success] = "Successfully invited #{@invitation.user.username}."
      redirect_to @event
    else
      flash[:error] = "#{@invitation.user.username} could not be invited!"
      redirect_to new_event_invitation_path
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:user_id)
  end

end