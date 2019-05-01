require 'rails_helper'

RSpec.describe BaseForm, type: :form do

  context "instance methods" do
    subject(:form) { described_class.new }

    describe "#save" do
      context "when object is valid" do
        it "raises an error" do
          expect{ form.save }.to raise_error(RuntimeError, "implement persist! in sub class")
        end
      end

      context "when object is invalid" do
        it "returns false" do
          allow(form).to receive(:valid?).and_return(false)

          expect(form.save).to be_falsey
        end
      end
    end
  end
end
