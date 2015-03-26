class ManagersController < ApplicationController
  respond_to :js, :html, :json

  def new
    @manager = Manager.new
    respond_with @manager
  end

  def update
    @manager = Manager.update_attributes(params[:manager])

    respond_with @manager
  end

  def create
    @manager = Manager.new(manager_params)
    
    if @manager.save
      session[:user_id] = @manager.id
    end

    respond_with @manager
  end

  def show
    @manager = Manager.find(params[:id])
    respond_with @manager
  end

  def index
    @managers = Manager.order(:last_name);
    @title = "Manager Directory";

    respond_with(@managers) do |format|
      format.json {
        @mList = @managers.map { |u| { :id => u.id, :name => u.first_name + " " + u.last_name } }
        @mList = @mList.find_all{ |u| u[:name].downcase.include?(params[:q].downcase) } if params[:q]
        render :json => @mList
      }
    end
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy
    redirect_to :back
  end
  private

  def manager_params
    params.require(:manager).permit(
      :email,
      :first_name, 
      :last_name,      
      :password, 
      :password_confirmation
    )
  end
end
