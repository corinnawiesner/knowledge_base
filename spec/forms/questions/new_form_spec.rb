require 'rails_helper'

RSpec.describe Questions::NewForm, type: :form do
  context "validations" do
    it { is_expected.to validate_presence_of(:article) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to validate_presence_of(:abstract) }
    it { is_expected.to validate_presence_of(:answer) }
  end

  context "instance methods" do
    subject(:empty_form) { described_class.new }
    subject(:form) do
      described_class.new(
        article:  article,
        title:    "How to get started?",
        abstract: "Learn the basic elements to get started.",
        answer:   "To get started in programming you need to...",
      )
    end

    let(:article) { FactoryBot.create(:article) }

    describe "#save" do
      context "when object is valid" do
        it "creates a new question for the given article" do
          expect{ form.save }.to change { article.questions.count }.from(0).to(1)
        end

        it "creates a new question" do
          expect{ form.save }.to change { Question.count }.by(1)
        end

        it "creates a question" do
          form.save
          question = form.question

          expect(question.title).to eq(form.title)
          expect(question.abstract).to eq(form.abstract)
          expect(question.answer).to eq(form.answer)
          expect(question.article_id).to eq(article.id)
        end

        it "returns true" do
          expect(form.save).to be_truthy
        end

        it "creates a QuestionTranslationJob" do
          form.save

          expect { QuestionTranslationJob.perform_later(id: form.question.id) }.to have_enqueued_job
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
