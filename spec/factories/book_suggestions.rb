FactoryBot.define do
  factory :book_suggestion do
    synopsis { Faker::Lorem.sentence }
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
