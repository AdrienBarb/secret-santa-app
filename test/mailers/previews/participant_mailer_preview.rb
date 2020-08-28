# Preview all emails at http://localhost:3000/rails/mailers/participant_mailer
class ParticipantMailerPreview < ActionMailer::Preview
  ParticipantMailer.with(user: User.first, gift: User.last).send_notification
end
