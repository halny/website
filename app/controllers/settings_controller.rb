# encoding: UTF-8

class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to edit_settings_path, notice: 'Dane konta zostały zmienione.'
    else
      render action: "edit"
    end
  end
end
