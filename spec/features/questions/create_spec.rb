require 'rails_helper'

describe "Creating an question", type: :feature do
  before do
    create_article
    click_on I18n.t("articles.show.new_question")
  end

  it "clicks on create article button" do
    expect(page).to have_content(I18n.t("questions.new.headline"))
  end

  it "cancels creation and returns to the article page" do
    click_on I18n.t("global.cancel")

    expect(page).to have_current_path(article_path(Article.last))
  end

  context "when form filled out correctly" do
    before { create_question }

    it "redirects to the article page" do
      expect(page).to have_current_path(article_path(Article.last))
    end

    it "content contains the question's title and abstract" do
      expect(page).to have_content("How to get started?")
      expect(page).to have_content("Learn the basic elements to get started.")
    end
  end

  it "fills out form with errors" do
    fill_in I18n.t('activemodel.attributes.questions/new_form.title'),
      with: "How"
    fill_in I18n.t('activemodel.attributes.questions/new_form.abstract'),
      with: ""

    click_button I18n.t("questions.new.submit")

    expect(page).to have_content(I18n.t("questions.create.error"))
    expect(page).to have_content("#{I18n.t('activemodel.attributes.questions/new_form.title')} #{I18n.t('errors.messages.too_short', count: 5)}")
    expect(page).to have_content("#{I18n.t('activemodel.attributes.questions/new_form.abstract')} #{I18n.t('errors.messages.blank')}")
  end
end
