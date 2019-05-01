class Translate::Article < Translate::Base
  private

    def original_attributes
      {
        title:    object.title,
        abstract: object.abstract,
      }
    end

    def update_object
      object.update_attributes(
        title:    Translators::Aws.run(original_texts[:title], translate_from: translate_from, translate_to: translate_to),
        abstract: Translators::Aws.run(original_texts[:abstract], translate_from: translate_from, translate_to: translate_to),
      )
    end
end
