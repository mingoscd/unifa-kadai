# frozen_string_literal: true

class Picture < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :user, foreign_key: :user_id
  validates :title, presence: true,
                    length: { maximum: 30 }

  has_one_attached :image, dependent: :destroy
end
