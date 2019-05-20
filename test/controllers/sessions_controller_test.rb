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

  # test 'redirects to pictures if login success' do
  # end

  # test 'show message if login fails' do 
  # end

  test 'can logout successfully' do
    delete '/sessions'
    follow_redirect!
    assert_equal response.status, 200
    assert_equal '/', path
  end
end
