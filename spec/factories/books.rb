FactoryBot.define do
  factory :book do
    title { Faker::Book.title.truncate(25) }
    author { Faker::Book.author }
    year { 2019 }
    editor { Faker::Book.publisher }
    gender { Faker::Book.genre }
    image { '/images/random.jpg' }
  end
end
