require 'rails_helper'

RSpec.describe Articles::EditForm, type: :form do
  context "validations" do
    it { is_expected.to validate_presence_of(:article) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to validate_presence_of(:abstract) }
  end

  context "instance methods" do
    subject(:empty_form) { described_class.new }
    subject(:form) do
      described_class.new(
        article:  article,
        title:    "How do you become a programmer?",
        abstract: "Learn how to become a programmer",
      )
    end

    let(:article) { FactoryBot.create(:article, :with_question) }

    describe "#save" do
      context "when object is valid" do
        it "updates the article's title and abstract" do
          expect{ form.save }.to change { article.title }.
          and change { article.abstract }
        end

        it "updates the question" do
          form.save
          form_article = form.article

          expect(form_article.title).to eq(form.title)
          expect(form_article.abstract).to eq(form.abstract)
        end

        it "returns true" do
          expect(form.save).to be_truthy
        end

        it "creates a ArticleTranslationJob" do
          form.save

          expect { ArticleTranslationJob.perform_later(id: article.id) }.to have_enqueued_job
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
