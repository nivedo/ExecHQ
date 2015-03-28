class EventsController < ApplicationController
  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to :back
  end

  def event_params
    params.require(:event).permit(
      :property_id,
      :manager_id,
      :renter_id,
      :title,
      :event_type,
      :start,
      :end
    )
  end
end
