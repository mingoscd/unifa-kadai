# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

    private

  def require_login
    redirect_to root_url unless current_user?
  end

  def current_user?
    User.find_by_user_id(session[:user_id])
  end
  end
