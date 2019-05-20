# frozen_string_literal: true

class PicturesController < ApplicationController
  def index
    @pictures = current_user.pictures.all.with_attached_image
  end

  def new; end

  def upload
    @picture = create_new_picture
    if @picture.persisted?
      redirect_to user_url(session[:user_id])
    else
      flash.now[:danger] = @picture.errors.full_messages.join('. ')
      render :new
    end
  end

  private

  def create_new_picture
    Picture.create(permitted_upload_params)
  end

  def current_user
    User.find_by_user_id(session[:user_id])
  end

  def permitted_upload_params
    params.require(:picture)
          .permit(:title, :image)
          .merge(user: current_user)
  end
end
