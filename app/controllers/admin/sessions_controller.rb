
class Admin::SessionsController < ApplicationController

  def update
    user = User.find(params[:id])
    session[:admin_id] = current_user.id
    session[:id] = user.id
    flash[:notice] = "Now viewing as #{user.full_name}"

    redirect_to admin_users_path
  end

  def destroy
    session[:user_id] = session[:admin_id]
    session[:admin_id] = nil
    redirect_to admin_users_path
  end

end