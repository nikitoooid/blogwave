FactoryBot.define do
  sequence :title do |n|
    "Article ##{n}"
  end

  factory :article do
    title
    content { 'Content of article' }

    trait :invalid do
      title { nil }
    end
  end
end
