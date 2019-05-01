require 'rails_helper'

describe "Creating a article", type: :feature do
  before do
    visit root_path
    within(".page-layout") do
      click_on I18n.t("articles.index.new_article")
    end
  end

  it "clicks on create article button and is on the new article page" do
    expect(page).to have_current_path(new_article_path)
  end

  it "cancels creation and returns to the articles overview page" do
    click_on I18n.t("global.cancel")

    expect(page).to have_current_path(articles_path)
  end


  context "when form filled out correctly" do
    before { create_article }

    it "redirects to the article page" do
      expect(page).to have_current_path(article_path(Article.last))
    end

    it "content contains the article's and question's title and abstract" do
      expect(page).to have_content("How to become a programmer")
      expect(page).to have_content("This is a quick tutorial on how to become a programmer.")
      expect(page).to have_content("How to get started?")
      expect(page).to have_content("Learn the basic elements to get started.")
    end
  end

  it "fills out form with errors" do
    fill_in I18n.t('activemodel.attributes.articles/new_form.title'),
      with: "How"
    fill_in I18n.t('activemodel.attributes.articles/new_form.abstract'),
      with: ""

    click_button I18n.t("articles.new.submit")

    expect(page).to have_content(I18n.t("articles.create.error"))
    expect(page).to have_content("#{I18n.t('activemodel.attributes.articles/new_form.title')} #{I18n.t('errors.messages.too_short', count: 5)}")
    expect(page).to have_content("#{I18n.t('activemodel.attributes.articles/new_form.abstract')} #{I18n.t('errors.messages.blank')}")
  end
end
