class EventsController < ApplicationController
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_event, only: [:show, :edit, :update, :generator]

  def index
    @events = Event.where(user: @user)
  end

  def new
    @event = @user.events.build
  end

  def show
    @participant = Participant.new
  end

  def create
    @event = @user.events.build(event_params)
    if @event.save!
      event_creator_is_participant(@user, @event)
      flash[:notice] = "L'évènement à bien été créé !"
      redirect_to event_path(@event)
    else
      flash[:alert] = "L'évènement n'a pas pu être créé !"
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Vos modifications ont bien été prisent en compte !"
      redirect_to event_path(@event)
    else
      flash[:alert] = "Vos modifications n'ont pas bien été prisent en compte !"
      render :edit
    end
  end

  def generator
    participants = @event.participants
    MakeAssociations.new(participants, @event).generationAssociation

    flash[:notice] = "Un email a été envoyé à chaques utilisateurs !"
    redirect_to event_path(@event)
  end

  private

  def set_user
    @user = current_user
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :price)
  end

  def event_creator_is_participant(user, event)
    Participant.create(user_name: user.user_name, email: user.email, event: event)
  end
end
