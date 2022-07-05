FactoryBot.define do
  factory :user do
    # email { Faker::Internet.email }

    email { "MyString@test.com" }
    password_digest { "MyString" }
  end
end
