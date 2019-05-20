# frozen_string_literal: true

class User < ApplicationRecord
    validates :user_id, presence: true,
                        uniqueness: true
  
    has_secure_password
    validates :password, presence: true
  end
