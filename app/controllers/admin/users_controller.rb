class Admin::UsersController < ApplicationController
  

  before_action :restrict_non_admins



  def index
    @users = User.order(:lastname).page(params[:page]).per(10)
    # redirect_to admin_users_path
    # if session[:admin_id]
    #   session[:user_id] = session[:admin_id]
    #   session[:admin_id] = nil
    # end
    # @admin = User.find(session[:user_id])
    # @users = User.all.page(params[:page]).per(10)
  end

  # def show
  #   @user = User.find(params[:id])
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
     # byebug
    if @user.save

      redirect_to admin_users_path, notice: "New user created, #{@user.firstname}!"

    else
      render 'admin/users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = "User, #{@user.email} deleted!"
    redirect_to admin_users_path
  end

  protected
  
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
    
end




