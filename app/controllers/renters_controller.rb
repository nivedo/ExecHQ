class RentersController < ApplicationController
  respond_to :js, :html, :json

  def new
    @renter = Renter.new
    respond_with @renter
  end

  def create
    @renter = Renter.new(renter_params)
    @renter.save
    respond_with @renter
  end

  def index
    @renters = Renter.order(:last_name);
    @title = "Renter Directory";

    respond_with(@renters) do |format|
      format.json {
        @mList = @renters.map { |u| { :id => u.id, :name => u.first_name + " " + u.last_name } }
        @mList = @mList.find_all{ |u| u[:name].downcase.include?(params[:q].downcase) } if params[:q]
        render :json => @mList
      }
    end
  end

  private

  def renter_params
    params.require(:renter).permit(
      :email,
      :phone,
      :first_name, 
      :last_name
    )
  end
end
