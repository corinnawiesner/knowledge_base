require 'rails_helper'

RSpec.describe Questions::EditForm, type: :form do
  context "validations" do
    it { is_expected.to validate_presence_of(:question) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to validate_presence_of(:abstract) }
    it { is_expected.to validate_presence_of(:answer) }
  end

  context "instance methods" do
    subject(:empty_form) { described_class.new }
    subject(:form) do
      described_class.new(
        question: question,
        title:    "How to start with programming?",
        abstract: "Learn how to get started in programming",
        answer:   "Learn step by step how to...",
      )
    end

    let(:question) { FactoryBot.create(:question, :with_article) }

    describe "#save" do
      context "when object is valid" do
        it "updates the question's title, abstract and answer" do
          expect{ form.save }.to change { form.question.title }.
            and change { form.question.abstract }.
            and change { form.question.answer }
        end

        it "updates the question" do
          form.save
          form_question = form.question

          expect(form_question.title).to eq(form.title)
          expect(form_question.abstract).to eq(form.abstract)
          expect(form_question.answer).to eq(form.answer)
        end

        it "returns true" do
          expect(form.save).to be_truthy
        end

        it "creates a QuestionTranslationJob" do
          form.save

          expect { QuestionTranslationJob.perform_later(id: question.id) }.to have_enqueued_job
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
