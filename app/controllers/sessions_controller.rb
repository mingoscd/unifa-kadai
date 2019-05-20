# frozen_string_literal: true

class SessionsController < ApplicationController
    skip_before_action :require_login
  
    def new; end
  
    def create
      @user = User.find_by_user_id user_session(:user_id)
  
      if @user&.authenticate(user_session(:password))
        session[:user_id] = @user.user_id
        redirect_to user_url(session[:user_id])
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render :new
      end
    end
  
    def destroy
      session.delete(:user_id)
      redirect_to root_path
    end
  
    private
  
    def permitted_session_params
      params.require(:session).permit(:user_id, :password)
    end
  
    def user_session(param)
      permitted_session_params.dig(param.to_sym)
    end
  end
  
