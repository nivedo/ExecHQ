class PropertiesController < ApplicationController
  respond_to :js, :html, :json

  def new
    @property = Property.new
    @use_gmap = true
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
    @nowrap = true
    respond_with @property
  end

  def update

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