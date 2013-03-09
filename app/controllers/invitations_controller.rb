class InvitationsController < ApplicationController
  before_filter :require_user
  def new
  	@invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user

    if @invitation.save
      InvitationMailer.registration_email(@invitation, register_with_invite_url(@invitation.token)).deliver
      @invitation.update_attribute("sent_at", Time.zone.now)
      redirect_to new_invitation_path, flash: { success: "Invitation sent successfully!" }
    else
      render :new
    end
  end
end
