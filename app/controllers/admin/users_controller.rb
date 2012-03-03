# encoding: UTF-8

class Admin::UsersController < AdminController

  before_filter :find_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    @user.accessible = [:is_admin]
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, notice: "Zmiany zapisane."
    else
      flash[:error] = "Popraw błędy w formularzu."
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "Użytkownik został usunięty."
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
