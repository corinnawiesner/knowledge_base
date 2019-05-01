require 'rails_helper'

RSpec.describe Translate::Base, type: :lib do
  let(:object) { FactoryBot.create(:article) }

  context "class methods" do
    describe ".run" do
      it "calls the run method for the newly created instance" do
        expect { described_class.run(object) }.to raise_error(RuntimeError, "implement update_object in sub class")
      end
    end
  end

  context "instance methods" do
    describe "#initialize" do
      subject(:base_translator) { described_class.new(object, translate_from: :en, translate_to: :de) }

      it "initializes object, translate_from and translate_to with the given values" do
        expect(base_translator.object).to eq(object)
        expect(base_translator.translate_from).to eq(:en)
        expect(base_translator.translate_to).to eq(:de)
      end
    end

    describe "#run" do
      subject(:base_translator) do
        described_class.new(object, translate_from: :en, translate_to: :de)
      end

      it "creates a new translation for 'de'" do
        expect { base_translator.run }.to raise_error(RuntimeError, "implement update_object in sub class")
      end
    end
  end
end
