# frozen_string_literal: true

require 'test_helper'

class PicturesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_attrs = { user_id: 'test', password: 'testtest' }
    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    @picture_attrs = { title: 'picture', image: file }
    User.create @user_attrs.merge(password_confirmation: @user_attrs[:password])

    # login
    post '/sessions', params: { session: @user_attrs }
    follow_redirect!
  end

  test 'can access pictures index page' do
    assert_equal path, "/user/#{@user_attrs[:user_id]}"
  end

  test 'can access pictures upload page' do
    get(user_upload_url(@user_attrs[:user_id]))
    assert_equal path, "/user/#{@user_attrs[:user_id]}/upload"
  end

  test 'shows error and return to upload page' do
    post user_upload_url(@user_attrs[:user_id]), params: { picture: @picture_attrs.merge(title: '') }
    assert_equal path, "/user/#{@user_attrs[:user_id]}/upload"
    assert_includes response.body, 'Title can&#39;t be blank'
  end

  test 'uploads file' do
    file_count_before_upload = ActiveStorage::Attachment.count
    post user_upload_url(@user_attrs[:user_id]), params: { picture: @picture_attrs }
    assert ActiveStorage::Attachment.count, file_count_before_upload + 1
  end
end
