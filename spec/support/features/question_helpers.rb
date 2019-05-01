module Features
  module QuestionHelpers
    def create_question
      create_article
      click_on I18n.t("articles.show.new_question")

      fill_in I18n.t('activemodel.attributes.questions/new_form.title'),
        with: "How to get started?"
      fill_in I18n.t('activemodel.attributes.questions/new_form.abstract'),
        with: "Learn the basic elements to get started."
      fill_in I18n.t('activemodel.attributes.questions/new_form.answer'),
        with: "To get started in programming you need to..."

      click_button I18n.t("questions.new.submit")
    end
  end
end
