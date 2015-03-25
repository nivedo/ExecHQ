class PropertiesController < ApplicationController
  respond_to :js, :html, :json

  def new
    @property = Property.new
    @use_gmap = true
    respond_with @property
  end

  def create
    @property = Property.new(property_params)
    @property.manager = current_user
    @property.save
    respond_with @property
  end

  def property_params
    params.require(:property).permit(
      :location,
      :description
    )
  end
end