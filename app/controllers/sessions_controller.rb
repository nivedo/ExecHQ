class SessionsController < ApplicationController
  #before_filter :direct_to_home, only:[:new]

  def new
    @splash_override = true;
    @manager = Manager.new
  end
  
  def create
    m = Manager.find_by_email(params[:email])
    if m && m.authenticate(params[:password])
      session[:user_id] = m.id
      redirect_to root_url, :notice => "Logged in!"
    else
      @splash_override = true;
      redirect_to login_url, :alert => "Invalid email or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
