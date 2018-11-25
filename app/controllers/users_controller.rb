class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :backup_notes]

  def index
    @users = User.all
  end

  def show
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def backup_notes
    begin
      DropboxService.new(@user).back_up_notes(@user.notes)
    rescue => err
      @errors = err.message
    end

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:dropbox_auth_token)
    end
end
