FactoryBot.define do
  factory :application do
    seen { false }
    user { nil }
    job { nil }
  end
end
