# frozen_string_literal: true

module ApplicationHelper
  def active_session?(session)
    session[:user_id].present? && controller.controller_name != 'sessions'
  end

  def pictures_or_upload_title
    current_page?(user_path) ? 'Upload' : 'Picture List'
  end

  def pictures_or_upload_path
    current_page?(user_path) ? user_upload_path : user_path
  end
end
