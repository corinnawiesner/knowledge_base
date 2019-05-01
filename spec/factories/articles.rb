FactoryBot.define do
  factory :article do
    title    { "How to become a programmer" }
    abstract { "This is a quick tutorial on how to become a programmer." }

    trait :with_question do
      questions { [FactoryBot.create(:question, :with_article)] }
    end
  end
end
