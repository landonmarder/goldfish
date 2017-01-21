FactoryGirl.define do
  factory :activity do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.phrase }
  end
end
