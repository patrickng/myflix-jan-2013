class InvitationsController < AuthenticatedController
  def new
  	@invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user

    if @invitation.save
      InvitationMailer.delay.registration_email(@invitation.id, register_with_invite_url(@invitation.token))
      @invitation.update_attribute("sent_at", Time.zone.now)
      redirect_to new_invitation_path, flash: { success: "Invitation sent successfully!" }
    else
      render :new
    end
  end
end
