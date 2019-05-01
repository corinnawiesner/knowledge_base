require 'rails_helper'

describe "Edit article", type: :feature do
  before do
    create_article
    click_on I18n.t("articles.show.edit")
  end

  it "is on edit article page" do
    expect(page).to have_content(I18n.t("articles.edit.headline"))
  end

  it "cancels edit and returns to the articles overview page" do
    click_on I18n.t("global.cancel")

    expect(page).to have_current_path(article_path(Article.last))
  end

  context "when form filled out correctly" do
    before do
      fill_in I18n.t('activemodel.attributes.articles/edit_form.title'),
        with: "New title"
      fill_in I18n.t('activemodel.attributes.articles/edit_form.abstract'),
        with: "New abstract"

      click_button I18n.t("articles.edit.submit")
    end

    it "redirects to the article page" do
      expect(page).to have_current_path(article_path(Article.last))
    end

    it "saves the article" do
      expect(page).to have_content("New title")
      expect(page).to have_content("New abstract")
    end

    it "does not contain the article's old title and abstract" do
      expect(page).to_not have_content("How to become a programmer")
      expect(page).to_not have_content("This is a quick tutorial on how to become a programmer.")
    end
  end

  it "fills out form with errors and shows errors" do
    fill_in I18n.t('activemodel.attributes.articles/edit_form.title'),
      with: "How"
    fill_in I18n.t('activemodel.attributes.articles/edit_form.abstract'),
      with: ""

    click_button I18n.t("articles.edit.submit")

    expect(page).to have_content(I18n.t("articles.update.error"))
    expect(page).to have_content("#{I18n.t('activemodel.attributes.articles/edit_form.title')} #{I18n.t('errors.messages.too_short', count: 5)}")
    expect(page).to have_content("#{I18n.t('activemodel.attributes.articles/edit_form.abstract')} #{I18n.t('errors.messages.blank')}")
  end
end
