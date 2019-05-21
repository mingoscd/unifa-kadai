# frozen_string_literal: true

class OauthController < ApplicationController
  ACCESS_TOKEN_REQUEST_URL = 'https://arcane-ravine-29792.herokuapp.com/oauth/token'
  TWEET_REQUEST_URL = 'https://arcane-ravine-29792.herokuapp.com/api/tweets'

  def callback
    return manage_errors if response.code.to_i != 200

    access_token_request
  end

  def tweet
    return unless session[:access_token]

    res = perform_tweet_post
  end

  private

  def access_token_request
    res = Net::HTTP.post_form(URI(ACCESS_TOKEN_REQUEST_URL),
                              access_token_params.merge(code: params['code']))
    access_token_management(res)
  end

  def access_token_management(response)
    data = JSON.parse(response.body)
    session[:access_token] = data['access_token']
    redirect_to user_path(session[:user_id])
  end

  def manage_errors
    # error management not covered by the test
  end

  def access_token_params
    {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      redirect_uri: 'http://localhost:3000/oauth/callback',
      grant_type: 'authorization_code'
    }
  end

  def perform_tweet_post
    url = URI(TWEET_REQUEST_URL)
    body = { text: params['text'], url: params['url'] }

    request = Net::HTTP::Post.new(url)
    request.content_type = 'application/json'
    request['Accept'] = 'application/json'
    request['Authorization'] = "Bearer #{session[:access_token]}"
    request.body = JSON.dump(body)

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == 'https') do |http|
      http.request(request)
    end
  end
end
