class ParticipantMailer < ApplicationMailer
  def send_notification
    @giver = params[:giver]
    @receiver = params[:receiver]
    @event = params[:event]
    @url  = 'http://santaclaus.com'
    mail(to: @giver.email, subject: "Un beau cadeau pour #{@event.title}")
  end

  def send_notification_alone
    @user = params[:user]
    @url  = 'http://santaclaus.com'
    mail(to: @user.email, subject: "Pas de chance pour cette fois !")
  end
end
