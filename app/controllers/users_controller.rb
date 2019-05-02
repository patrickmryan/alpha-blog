class UsersController < ApplicationController

  self.before_action(:set_user, only: [:edit, :update, :show])
  self.before_action(:require_same_user, only: [:edit, :update, :destroy])
  before_action :require_admin, only: [:destroy]

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    #debugger
    @user = User.new(user_params)
    if (@user.save)
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      self.redirect_to(self.articles_path)
    else
      render 'edit'
    end
  end

  def show
    #@user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user = User.find(params[:id])
    name = @user.username
    @user.destroy
    flash[:danger] = "Account #{name} and articles deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if (!(logged_in? && (current_user == @user || current_user.admin?)))
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only an admin user may perform that action"
      redirect_to root_path
    end
  end

end
