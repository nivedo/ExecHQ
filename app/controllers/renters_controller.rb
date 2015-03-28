class RentersController < ApplicationController
  respond_to :js, :html, :json
  before_filter :require_login

  def new
    @renter = Renter.new
    respond_with @renter
  end

  def update
    Renter.update(params[:id],renter_params)

    redirect_to :back
  end

  def create
    @renter = Renter.new(renter_params)
    @renter.save
    respond_with @renter
  end

  def index
    @renter = Renter.new
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
  
  def show
    @renter = Renter.find(params[:id])
    respond_with @renter
  end

  def destroy
    @renter = Renter.find(params[:id])
    @renter.destroy
    redirect_to :back
  end

  private

  def renter_params
    params.require(:renter).permit(
      :email,
      :phone,
      :first_name, 
      :last_name,
      :company_name
    )
  end
end
