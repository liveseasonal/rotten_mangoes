class Admin::UsersController < ApplicationController
  

  before_action :restrict_non_admins

  def index
    @users = User.order(:lastname).page(params[:page])
  end

  def users
  end

end
