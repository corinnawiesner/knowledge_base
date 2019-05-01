class ArticleTranslationJob < TranslationJob
  private

    def translate_class
      Translate::Article
    end

    def object(id)
      @_object ||= Article.find(id)
    end
end
