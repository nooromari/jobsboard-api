FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Job.description }
  end
end
