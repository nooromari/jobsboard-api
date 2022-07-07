# frozen_string_literal: true

# User model
class User < ApplicationRecord
  # encrypt password
  has_secure_password

  has_many :applications, foreign_key: :user_id, dependent: :destroy
  validates_presence_of :email, :password_digest
  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
            if: -> { email.present? }, uniqueness: true

  validate :admin_exists

  def admin?
    is_admin
  end

  def admin_exists
    admins = User.where(is_admin: true)
    return unless is_admin && !admins.empty?

    errors.add(email, 'Admin account already exists')
  end
end
