require 'rails_helper'

RSpec.describe Translators::Aws, type: :lib do
  subject(:translator) { described_class.new(text, translate_from: :en, translate_to: :de) }

  let(:text) { "This is a translated text" }

  # INFO: if no live translation requests should be used use these lines and replace returned translated texts with "String"
  # before do
  #   allow_any_instance_of(Translators::Aws).to receive(:client).and_return(Aws::Translate::Client.new(stub_responses: true))
  # end

  context "class methods" do
    describe ".run" do
      subject(:run_translator) { described_class.run(text) }

      context "when creating new instance of #{described_class}" do
        it "initializes with the given text and default values for translate_from and translate_to", network: true do
          expect(described_class).to receive(:new).with(text, translate_from: :en, translate_to: :de).and_call_original

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
      it "initializes text, translate_from and translate_to with the given values", network: true do
        expect(translator.text).to eq(text)
        expect(translator.translate_from).to eq(:en)
        expect(translator.translate_to).to eq(:de)
      end
    end

    describe "#run" do
      context "with live translation" do
        it "translates the given text from the source language (en) to the target language (de)", network: true do
          expect(translator.run).to eq("Dies ist ein übersetzter Text")
        end
      end

      context "without live translation" do
        before { allow(translator).to receive(:client).and_return(Aws::Translate::Client.new(stub_responses: true)) }

        it "returns a stubbed string" do
          expect(translator.run).to eq("String")
        end
      end
    end
  end
end
