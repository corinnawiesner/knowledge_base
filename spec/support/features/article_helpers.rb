module Features
  module ArticleHelpers
    def create_article
      visit new_article_path

      fill_in I18n.t('activemodel.attributes.articles/new_form.title'),
        with: "How to become a programmer"
      fill_in I18n.t('activemodel.attributes.articles/new_form.abstract'),
        with: "This is a quick tutorial on how to become a programmer."
      fill_in I18n.t('activemodel.attributes.articles/new_form.question_title'),
        with: "How to get started?"
      fill_in I18n.t('activemodel.attributes.articles/new_form.question_abstract'),
        with: "Learn the basic elements to get started."
      fill_in I18n.t('activemodel.attributes.articles/new_form.question_answer'),
        with: "To get started in programming you need to..."

      click_button I18n.t("articles.new.submit")
    end
  end
end
