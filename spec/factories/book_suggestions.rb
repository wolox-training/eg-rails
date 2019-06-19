FactoryBot.define do
  factory :book_suggestion do
    synopsis { Faker::String.random }
    price { Faker::Commerce.price }
    author { Faker::Book.author }
    title { Faker::Book.title }
    link { Faker::Internet.url }
    editor { Faker::Book.publisher }
    year { 2019 }

    trait :with_user do
      association :user
    end
  end
end
