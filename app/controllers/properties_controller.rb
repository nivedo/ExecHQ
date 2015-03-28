class PropertiesController < ApplicationController
  respond_to :js, :html, :json
  before_filter :require_login

  def new
    @property = Property.new
    @use_gmap = true
    @use_calendar = true
    @nowrap = true
    respond_with @property
  end

  def create
    @property = Property.new(property_params)
    @property.manager = current_user
    @property.save
    respond_with @property
  end

  def show
    @property = Property.find(params[:id])
    @use_gmap = true
    @use_calendar = true
    @nowrap = true

    @event = Event.new

    respond_with @property
  end

  def index
    @properties = Property.order(:title);
    @title = "My Properties"
  end

  def update
    Property.update(params[:id],property_params)
    redirect_to :back
  end

  def property_params
    params.require(:property).permit(
      :location,
      :description,
      :title,
      :bedrooms,
      :bathrooms,
      :accomodates,
      :hometype
    )
  end
end