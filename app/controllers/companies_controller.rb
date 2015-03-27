class CompaniesController < ApplicationController
  respond_to :js, :html, :json

  def new
    @company = Company.new
    respond_with @company
  end

  def update
    Company.update(params[:id],company_params)

    redirect_to :back
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      session[:user_id] = @company.id
    end

    respond_with @company
  end

  def show
    @company = Company.find(params[:id])
    respond_with @company
  end

  def index
    @company = Company.new
    @companies = Company.order(:last_name);
    @title = "Company Directory";

    respond_with(@companies) do |format|
      format.json {
        @mList = @companies.map { |u| { :id => u.id, :name => u.first_name + " " + u.last_name } }
        @mList = @mList.find_all{ |u| u[:name].downcase.include?(params[:q].downcase) } if params[:q]
        render :json => @mList
      }
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to :back
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :mailing_address,
      :email
    )
  end

end
