class UsersController < ApplicationController
  before_action :authenticate_user!         
  def index
  end

  def create
  end

  def new
  end

  def destroy
    @user.destroy!
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: "Usuario was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show
    @user = current_user
  end
end
