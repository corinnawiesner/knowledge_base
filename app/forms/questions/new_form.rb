class Questions::NewForm < BaseForm
  extend ActiveModel::Callbacks

  attr_reader :question
  attr_accessor :article,
                :title,
                :abstract,
                :answer

  validates :article, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :abstract, presence: true
  validates :answer, presence: true

  define_model_callbacks :create
  after_create :create_translation_job

  private

    def persist!
      run_callbacks :create do
        @question = Question.create(
          title:      title,
          abstract:   abstract,
          answer:     answer,
          article_id: article.id
        )
      end
    end

    def create_translation_job
      QuestionTranslationJob.perform_later(id: question.id)
    end
end
