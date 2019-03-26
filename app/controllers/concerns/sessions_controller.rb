class SessionsController < ApplicationController
  def new
  end

  def create
    user_input = params[:session][:email].downcase
    pwd_input = params[:session][:password]
    user = User.find_by(email: user_input)
    #user = User.find_by(username: user_input)

    if (!user)
      flash.now[:danger] = "email #{user_input} is bogus"
      render 'new'
    elsif (!user.authenticate(pwd_input))
      #flash.now[:danger] = "user #{user.username}, invalid password #{pwd_input}"
      flash.now[:danger] = "invalid password"
      render 'new'
    else
      session[:user_id] = user.id
      flash[:success] = "You have logged in"
      redirect_to user_path(user)
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
