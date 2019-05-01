require 'rails_helper'

RSpec.describe Question, type: :model do
  context "associations" do
    it { should belong_to(:article) }
  end
end
