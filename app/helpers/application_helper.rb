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

  def oauth_request_uri
    uri = URI('https://arcane-ravine-29792.herokuapp.com/oauth/authorize')
    uri.query = Rack::Utils.build_query(oauth_request_params)
    uri.to_s
  end

  # the client id should be fetched from a ENV variable
  # just hardcode it just to keep it simple for the test
  def oauth_request_params
    {
      response_type: 'code',
      client_id: ENV['CLIENT_ID'],
      redirect_uri: 'http://localhost:3000/oauth/callback'
    }
  end

  def fake_tweeter_linked?
    session[:access_token].present?
  end
end
