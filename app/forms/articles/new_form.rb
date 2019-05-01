class Articles::NewForm < BaseForm
  extend ActiveModel::Callbacks

  attr_reader :article
  attr_accessor :title,
                :abstract,
                :question_title,
                :question_abstract,
                :question_answer

  validates :title, presence: true, length: { minimum: 5 }
  validates :abstract, presence: true
  validates :question_title, presence: true, length: { minimum: 5 }
  validates :question_abstract, presence: true
  validates :question_answer, presence: true

  define_model_callbacks :create
  after_create :create_translation_job

  private

    def persist!
      run_callbacks :create do
        @article = Article.create(
          title:                title,
          abstract:             abstract,
          questions_attributes: [
            {
              title:    question_title,
              abstract: question_abstract,
              answer:   question_answer,
            },
          ],
        )
      end
    end

    def create_translation_job
      ArticleTranslationJob.perform_later(id: article.id)
      QuestionTranslationJob.perform_later(id: article.questions.first.id)
    end
end
