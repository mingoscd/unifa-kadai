# frozen_string_literal: true

require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  def setup
    @user = User.create(user_id: 'test', password: 'testtest', password_confirmation: 'testtest')
    @new_picture = Picture.new(user: @user, title: 'title')
  end

  def check_error_for_key(resource, key)
    resource.errors.details.fetch(key.to_sym).first.fetch(:error)
  end

  test 'validates presence user' do
    @new_picture.user = nil
    @new_picture.save
    assert check_error_for_key(@new_picture, :user), :blank
  end

  test 'validates presence title' do
    @new_picture.title = ''
    @new_picture.save
    assert check_error_for_key(@new_picture, :title), :blank
  end

  test 'validates length title' do
    @new_picture.title = 'a' * 31
    @new_picture.save
    assert check_error_for_key(@new_picture, :title), :too_long
  end

  test 'validates default order scope' do
    assert_includes Picture.all.to_sql, 'ORDER BY "pictures"."created_at" DESC'
  end
end
