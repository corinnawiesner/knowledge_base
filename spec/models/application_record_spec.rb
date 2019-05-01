require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  context "instance methods" do
    describe "#cache_key" do
      let(:object) { FactoryBot.create(:article) }

      it "returns the cache key with the Globalize locale" do
        expect(object.cache_key).to eq("articles/#{object.id}-#{I18n.locale}/article/translations/#{object.translation.id}")
      end
    end
  end
end
