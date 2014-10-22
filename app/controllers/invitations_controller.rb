class InvitationsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @users = User.select { |u| @event.users.exclude? u  }
    if @users.empty?
      flash[:error] = "Everybody is already invited. Srsly?!"
      redirect_to event_path(@event)
    else
      @invitation = Invitation.new
      render :new
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @invitation = @event.invitations.new(invitation_params)
    if @invitation.save
      flash[:success] = "User #{@invitation.user.username} invited"
      redirect_to event_path(@event)
    else
      flash[:error] = "Invitation was not possible"
      redirect_to new_event_invitation_path
    end
  end

  def invitation_params
    params.require(:invitation).permit(:user_id)
  end

end