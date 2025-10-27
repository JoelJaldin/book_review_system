FactoryBot.define do
  factory :review do
    association :book
    association :user
    rating { Faker::Number.between(from: 1, to: 5) }
    content { Faker::Lorem.paragraph(sentence_count: 3) }
    reviewer_name { Faker::Name.name }
  end
end
