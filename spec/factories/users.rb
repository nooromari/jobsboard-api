# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:is_admin_user] do
    email { Faker::Internet.email }
    password { 'MyString' }
    is_admin { false }
  end
end
