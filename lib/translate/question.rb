class Translate::Question < Translate::Base
  private

    def original_attributes
      {
        title:    object.title,
        abstract: object.abstract,
        answer:   object.answer,
      }
    end

    def update_object
      object.update_attributes(
        title:    Translators::Aws.run(original_texts[:title]),
        abstract: Translators::Aws.run(original_texts[:abstract]),
        answer:   Translators::Aws.run(original_texts[:answer]),
      )
    end
end
