FactoryGirl.define do
  factory :group do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.phrase }
  end
end
