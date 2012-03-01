# encoding: UTF-8

class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_if_admin?

  layout 'admin'

  private

  def check_if_admin?
    redirect_to root_path, alert: "Nie posiadasz wystarczających uprawnień." unless current_user.is_admin?
  end
end
