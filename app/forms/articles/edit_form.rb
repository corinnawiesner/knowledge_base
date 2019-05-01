class Articles::EditForm < BaseForm
  extend ActiveModel::Callbacks

  attr_accessor :article,
                :title,
                :abstract

  validates :article, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :abstract, presence: true

  define_model_callbacks :update
  after_update :create_translation_job

  def initialize(attributes = {})
    @article = attributes[:article]

    if @article.present?
      @title    = @article.title
      @abstract = @article.abstract
    end

    super
  end

  private

    def persist!
      run_callbacks :update do
        article.update_attributes(
          title:    title,
          abstract: abstract,
        )
      end
    end

    def create_translation_job
      ArticleTranslationJob.perform_later(id: article.id)
    end
end
