FactoryBot.define do
  factory :rent do
    start_at { 1.day.after }
    end_at { 1.week.after }

    trait :with_user do
      association :user
    end

    trait :with_book do
      association :book
    end

    factory :rent_with_user_and_book, traits: %i[with_user with_book]
  end
end
