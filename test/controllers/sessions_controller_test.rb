# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @valid_attrs = { user_id: 'test', password: 'testtest' }
    @invalid_attrs = { user_id: 'test', password: 'wrong_password' }
    @existing_user = User.create @valid_attrs.merge(password_confirmation: @valid_attrs[:password])
  end

  test 'can access login page' do
    assert_equal get(root_url), 200
  end

  test 'redirects to pictures if login success' do
    post '/sessions', params: { session: @valid_attrs }
    follow_redirect!
    assert_equal path, "/user/#{@valid_attrs[:user_id]}"
  end

  test 'show message if login fails' do
    post '/sessions', params: { session: @invalid_attrs }
    assert_includes response.body, 'Invalid email/password combination'
  end

  test 'can logout successfully' do
    delete '/sessions'
    follow_redirect!
    assert_equal response.status, 200
    assert_equal '/', path
  end
end
