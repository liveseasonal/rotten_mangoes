class UsersController < ApplicationController
  #whats initilaly generated

  # before_action :restrict_non_admins

  def index
    @users = User.order(:lastname).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     redirect_to movies_path
  #   else
  #     render :new
  #   end
  # end

   # def create
   #      @user = User.new(user_params)

   #      if @user.save
   #        session[:user_id] = @user.id # auto log in
   #        redirect_to movies_path
   #      else
   #        render :new
   #      end
   #    end

#Added flash code

    def create
        @user = User.new(user_params)

        if @user.save
          session[:user_id] = @user.id
          UserMailer.signup_confirmation(@user).deliver
          redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
        else
          render :new
        end
      end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end
   
end
