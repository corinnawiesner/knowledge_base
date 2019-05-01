require 'rails_helper'

describe "Edit question", type: :feature do
  before do
    create_article
    click_on I18n.t("global.edit")
  end

  it "is on edit question page" do
    expect(page).to have_content(I18n.t("questions.edit.headline"))
  end

  it "cancels edit and returns to the article page" do
    click_on I18n.t("global.cancel")

    expect(page).to have_current_path(article_path(Article.last))
  end

  context "when form filled out correctly" do
    before do
      fill_in I18n.t('activemodel.attributes.questions/edit_form.title'),
        with: "Edited question title"
      fill_in I18n.t('activemodel.attributes.questions/edit_form.abstract'),
        with: "Edited question abstract"
      fill_in I18n.t('activemodel.attributes.questions/edit_form.answer'),
        with: "Edited question answer"

      click_button I18n.t("questions.edit.submit")
    end

    it "redirects to the article page" do
      expect(page).to have_current_path(article_path(Article.last))
    end

    it "changes the question title and abstract" do
      expect(page).to have_content("Edited question title")
      expect(page).to have_content("Edited question abstract")
    end

    it "does not contain the question's old title and abstract" do
      expect(page).to_not have_content("How to get started?")
      expect(page).to_not have_content("Learn the basic elements to get started.")
    end
  end

  it "fills out form with errors and shows errors" do
    fill_in I18n.t('activemodel.attributes.questions/edit_form.title'),
      with: "How"
    fill_in I18n.t('activemodel.attributes.questions/edit_form.abstract'),
      with: ""

    click_button I18n.t("questions.edit.submit")

    expect(page).to have_content(I18n.t("questions.update.error"))
    expect(page).to have_content("#{I18n.t('activemodel.attributes.questions/edit_form.title')} #{I18n.t('errors.messages.too_short', count: 5)}")
    expect(page).to have_content("#{I18n.t('activemodel.attributes.questions/edit_form.abstract')} #{I18n.t('errors.messages.blank')}")
  end
end
