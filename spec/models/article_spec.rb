require 'rails_helper'

RSpec.describe Article, type: :model do
  context "associations" do
    it { should have_many(:questions) }
  end

  context "when creating with question attributes" do
    subject(:article) do
      FactoryBot.create(
        :article,
        questions_attributes: [
          {
            title:    "",
            abstract: "Question 1 abstract",
            answer:   "Question 1 answer",
          },
          {
            title:    "Question 2 title",
            abstract: "",
            answer:   "Question 2 answer",
          },
          {
            title:    "Question 3 title",
            abstract: "Question 3 abstract",
            answer:   "",
          },
          {
            title:    "Question 4 title",
            abstract: "Question 4 abstract",
            answer:   "Question 4 answer",
          },
        ]
      )
    end
    subject(:question) { article.questions.first }

    it "rejects questions with empty title, abstract or answer" do
      expect(article.questions.count).to eq(1)
    end

    it "only creates questions with an existing title, abstract or answer" do
      expect(question.title).to    eq("Question 4 title")
      expect(question.abstract).to eq("Question 4 abstract")
      expect(question.answer).to   eq("Question 4 answer")
    end
  end
end
