require 'rails_helper'

describe "Delete article", type: :feature do
  before do
    create_article
    click_on I18n.t("articles.show.delete")
  end

  it "redirects to the articles overview page" do
    expect(page).to have_current_path(articles_path)
  end

  it "does not contain the deleted article's title and abstract" do
    expect(page).to_not have_content("How to become a programmer")
    expect(page).to_not have_content("This is a quick tutorial on how to become a programmer.")
  end
end
