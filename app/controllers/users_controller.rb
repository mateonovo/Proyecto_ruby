class UsersController < ApplicationController
  def index
  end

  def create
  end

  def new
  end

  def destroy
  end

  def show
    @user = current_user
  end
end
