class QuestionTranslationJob < TranslationJob
  private

    def translate_class
      Translate::Question
    end

    def object(id)
      @_object ||= Question.find(id)
    end
end
