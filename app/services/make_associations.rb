class MakeAssociations

  def initialize(participants, event)
    @participants = participants
    @event = event
  end

  def generationAssociation
    participants_list = []

    @participants.each do |participant|
      participants_list << participant
    end

    participants_list.shuffle!

    peoples_association_list = participants_list.each_slice(2).to_a

    peoples_association_list.each do |association|
      send_mail(association)
    end
  end

  def send_mail(association)
    if association.size > 1
      ParticipantMailer.with(giver: association[0], receiver: association[1], event: @event).send_notification.deliver_now
      ParticipantMailer.with(giver: association[1], receiver: association[0], event: @event).send_notification.deliver_now
    else
      ParticipantMailer.with(user: association[0], event: @event).send_notification_alone.deliver_now
    end
  end

end
