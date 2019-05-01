require 'rails_helper'

RSpec.describe Translate::Article, type: :lib do
  let(:article) { FactoryBot.create(:article) }

  # INFO: if no live translation requests should be used use these lines and replace returned translated texts with "String"
  # before do
  #   allow_any_instance_of(Translators::Aws).to receive(:client).and_return(Aws::Translate::Client.new(stub_responses: true))
  # end

  context "class methods" do
    describe ".run" do
      subject(:run_translator) { described_class.run(article) }

      context "when creating new instance of #{described_class}" do
        it "initializes with the given article and default values for translate_from and translate_to", network: true do
          expect(described_class).to receive(:new).with(article, translate_from: :en, translate_to: :de).and_call_original

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
      subject(:article_translator) { described_class.new(article, translate_from: :it, translate_to: :es) }

      it "initializes object, translate_from and translate_to with the given values", network: true do
        expect(article_translator.object).to eq(article)
        expect(article_translator.translate_from).to eq(:it)
        expect(article_translator.translate_to).to eq(:es)
      end
    end

    describe "#run" do
      subject(:article_translator) do
        described_class.new(article, translate_from: translate_from, translate_to: translate_to)
      end

      let(:title)    { "How to become a programmer" }
      let(:abstract) { "Introduction on how to become a programmer" }
      let(:article) do
        Globalize.with_locale(translate_from) { FactoryBot.create(:article, title: title, abstract: abstract) }
      end
      let(:translate_from) { :en }
      let(:translate_to)   { :de }

      it "creates a new translation for 'de'", network: true do
        expect { article_translator.run }.to change{ article.translations.count }.from(1).to(2)
      end

      it "does not overwrite the 'en' translations", network: true do
        article_translator.run

        Globalize.with_locale(translate_from) do
          expect(article.title).to    eq(title)
          expect(article.abstract).to eq(abstract)
        end
      end

      it "translates the title and abstract to 'de'", network: true do
        article_translator.run

        Globalize.with_locale(translate_to) do
          expect(article.title).to    eq("Wie man ein Programmierer wird")
          expect(article.abstract).to eq("Einführung, wie man Programmierer wird")
        end
      end

      it "returns true if article was successfully updated", network: true do
        expect(article_translator.run).to be_truthy
      end

      it "returns false if article was not updated", network: true do
        allow(article).to receive(:update_attributes).and_return(false)

        expect(article_translator.run).to be_falsey
      end
    end
  end
end
