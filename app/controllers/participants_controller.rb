class ParticipantsController < ApplicationController

  before_action :set_event, only: [:create]
  before_action :set_participant, only: [:destroy]

  def create
    @participant = @event.participants.build(participant_params)
    if @participant.save!
      flash[:notice] = "#{@participant.user_name.capitalize!} a bien été ajouté à l'événement !"
      redirect_to event_path(@participant.event)
    else
      flash[:alert] = "Le participant n'a pas pu être ajouté à l'événement !"
    end
  end

  def destroy
    @participant.destroy
    flash[:notice] = "Le participant a bien été suprimé !"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
    params.require(:participant).permit(:user_name, :email)
  end


end
