FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'passw0rd'
  end
end
