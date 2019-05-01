FactoryBot.define do
  factory :question do
    title    { "How to get started?" }
    abstract { "Learn the basic elements to get started." }
    answer   { "To get started in programming you need to..." }

    trait :with_article do
      association :article, factory: :article
    end
  end
end
