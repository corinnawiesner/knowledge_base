require 'rails_helper'

RSpec.describe Articles::NewForm, type: :form do
  context "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to validate_presence_of(:abstract) }
    it { is_expected.to validate_presence_of(:question_title) }
    it { is_expected.to validate_length_of(:question_title).is_at_least(5) }
    it { is_expected.to validate_presence_of(:question_abstract) }
    it { is_expected.to validate_presence_of(:question_answer) }
  end

  context "instance methods" do
    subject(:empty_form) { described_class.new }
    subject(:form) do
      described_class.new(
        title:             "How to become a programmer",
        abstract:          "This is a quick tutorial on how to become a programmer.",
        question_title:    "How to get started?",
        question_abstract: "Learn the basic elements to get started.",
        question_answer:   "To get started in programming you need to...",
      )
    end

    describe "#save" do
      context "when object is valid" do
        it "creates a new article" do
          expect{ form.save }.to change { Article.count }.by(1)
        end

        it "creates a new question" do
          expect{ form.save }.to change { Question.count }.by(1)
        end

        it "creates an article with a question" do
          form.save
          article = form.article
          question = article.questions.first

          expect(article.title).to eq(form.title)
          expect(article.abstract).to eq(form.abstract)
          expect(question.title).to eq(form.question_title)
          expect(question.abstract).to eq(form.question_abstract)
          expect(question.answer).to eq(form.question_answer)
        end

        it "returns true" do
          expect(form.save).to be_truthy
        end

        it "creates a QuestionTranslationJob" do
          form.save

          expect { QuestionTranslationJob.perform_later(id: form.article.id) }.to have_enqueued_job
        end

        it "creates a ArticleTranslationJob" do
          form.save

          expect { ArticleTranslationJob.perform_later(id: form.article.questions.first.id) }.to have_enqueued_job
        end
      end

      context "when object is invalid" do
        it "returns false" do
          expect(empty_form.save).to be_falsey
        end
      end
    end
  end
end
