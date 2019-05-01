require 'rails_helper'

RSpec.describe Translate::Question, type: :lib do
  let(:question) { FactoryBot.create(:question, :with_article) }

  # INFO: if no live translation requests should be used use these lines and replace returned translated texts with "String"
  # before do
  #   allow_any_instance_of(Translators::Aws).to receive(:client).and_return(Aws::Translate::Client.new(stub_responses: true))
  # end

  context "class methods" do
    describe ".run" do
      subject(:run_translator) { described_class.run(question) }

      context "when creating new instance of #{described_class}" do
        it "initializes with the given question and default values for translate_from and translate_to", network: true do
          expect(described_class).to receive(:new).with(question, translate_from: :en, translate_to: :de).and_call_original

          run_translator
        end
      end

      it "calls the run method for the newly created instance", network: true do
        expect_any_instance_of(described_class).to receive(:run).and_call_original

        run_translator
      end
    end
  end

  context "instance methods" do
    describe "#initialize" do
      subject(:question_translator) { described_class.new(question, translate_from: :it, translate_to: :es) }

      it "initializes object, translate_from and translate_to with the given values", network: true do
        expect(question_translator.object).to eq(question)
        expect(question_translator.translate_from).to eq(:it)
        expect(question_translator.translate_to).to eq(:es)
      end
    end

    describe "#run" do
      subject(:question_translator) do
        described_class.new(question, translate_from: translate_from, translate_to: translate_to)
      end

      let(:title)    { "How do you become a programmer?" }
      let(:abstract) { "Learn how to become a programmer" }
      let(:answer)   { "Become a programmer by following these advices" }
      let(:question) do
        Globalize.with_locale(translate_from) do
          FactoryBot.create(:question, :with_article, title: title, abstract: abstract, answer: answer)
        end
      end
      let(:translate_from) { :en }
      let(:translate_to)   { :de }

      it "creates a new translation for 'de'", network: true do
        expect { question_translator.run }.to change{ question.translations.count }.from(1).to(2)
      end

      it "does not overwrite the 'en' translations", network: true do
        question_translator.run

        Globalize.with_locale(translate_from) do
          expect(question.title).to    eq(title)
          expect(question.abstract).to eq(abstract)
          expect(question.answer).to   eq(answer)
        end
      end

      it "translates the title and abstract to 'de'", network: true do
        question_translator.run

        Globalize.with_locale(translate_to) do
          expect(question.title).to    eq("Wie werden Sie Programmierer?")
          expect(question.abstract).to eq("Erfahren Sie, wie Sie Programmierer werden")
          expect(question.answer).to   eq("Werden Sie ein Programmierer, indem Sie diesen Ratschlägen folgen")
        end
      end

      it "returns true if question was successfully updated", network: true do
        expect(question_translator.run).to be_truthy
      end

      it "returns false if question was not updated", network: true do
        allow(question).to receive(:update_attributes).and_return(false)

        expect(question_translator.run).to be_falsey
      end
    end
  end
end
