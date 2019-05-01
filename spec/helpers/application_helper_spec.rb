require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "render_form_field_errors(errors)" do
    let(:empty_errors) { [] }
    let(:errors) { ["This is an error", "This is another error"] }

    it "returns nil if the given errors are blank" do
      expect(helper.render_form_field_errors(empty_errors)).to be_nil
    end

    it "returns the given errors joined with '. ' in a div with the class 'error-list'" do
      expect(helper.render_form_field_errors(errors)).to eq(
        "<div class=\"error-list\">This is an error. This is another error</div>"
      )
    end
  end
end
