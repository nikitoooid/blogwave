FactoryBot.define do
  sequence :name do |n|
    "User ##{n}"
  end

  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    name
    email
    password { 'password' }
    password_confirmation { 'password' }
  end
end
