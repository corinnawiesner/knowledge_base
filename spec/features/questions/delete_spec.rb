require 'rails_helper'

describe "Delete question", type: :feature do
  before do
    create_article
    click_on I18n.t("global.delete")
  end

  it "redirects to the article page" do
    expect(page).to have_current_path(article_path(Article.last))
  end

  it "does not contain the deleted question's title and abstract" do
    expect(page).to_not have_content("How to get started?")
    expect(page).to_not have_content("Learn the basic elements to get started.")
  end
end
