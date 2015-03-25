class SessionsController < ApplicationController
  #before_filter :direct_to_home, only:[:new]

  def new
  end
  
  def create
    m = Manager.find_by_email(params[:email])
    if m && m.authenticate(params[:password])
      session[:user_id] = m.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
