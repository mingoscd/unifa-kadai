# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @existing_user = User.create(user_id: 'test', password: 'testtest', password_confirmation: 'testtest')
    @new_user = User.new(user_id: 'test', password: 'testtest', password_confirmation: 'testtest')
  end

  def check_error_for_key(resource, key)
    resource.errors.details.fetch(key.to_sym).first.fetch(:error)
  end

  test 'validates presence user_id' do
    @new_user.user_id = ''
    @new_user.save
    assert check_error_for_key(@new_user, :user_id), :blank
  end

  test 'validates uniqueness user_id' do
    @new_user.user_id = @existing_user.user_id
    @new_user.save
    assert check_error_for_key(@new_user, :user_id), :taken
  end

  test 'validates authentication with wrong password' do
    result = @existing_user.authenticate('wrong_password')
    assert_not result, 'Failed validation'
  end

  test 'validates authentication with correct password' do
    result = @existing_user.authenticate('testtest')
    assert result, @existing_user
  end
end

