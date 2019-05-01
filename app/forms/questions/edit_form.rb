class Questions::EditForm < BaseForm
  extend ActiveModel::Callbacks

  attr_accessor :question,
                :title,
                :abstract,
                :answer

  validates :question, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :abstract, presence: true
  validates :answer, presence: true

  define_model_callbacks :update
  after_update :create_translation_job

  def initialize(attributes = {})
    @question = attributes[:question]

    if @question.present?
      @title    = @question.title
      @abstract = @question.abstract
      @answer = @question.answer
    end

    super
  end

  private

    def persist!
      run_callbacks :update do
        question.update_attributes(
          title:    title,
          abstract: abstract,
          answer:   answer,
        )
      end
    end

    def create_translation_job
      QuestionTranslationJob.perform_later(id: question.id)
    end
end
