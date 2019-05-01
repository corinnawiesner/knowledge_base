class TranslationJob < ApplicationJob
  queue_as :default

  def perform(id:, translate_from: :en, translate_to: :de)
    translate_class.run(
      object(id),
      translate_from: translate_from,
      translate_to: translate_to
    )
  rescue ActiveRecord::RecordNotFound
    # TODO: check logging output
    logger.warn "#{self.class.name} with id #{id} was skipped"
  end

  private

    def translate_class
      raise "implement #{__method__} in sub class and return a translate class"
    end

    def object(id)
      raise "implement #{__method__} in sub class"
    end
end
