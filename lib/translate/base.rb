class Translate::Base
  attr_accessor :object,
                :translate_from,
                :translate_to

  class << self
    def run(object, translate_from: :en, translate_to: :de)
      new(object, translate_from: translate_from, translate_to: translate_to).run
    end
  end

  def initialize(object, translate_from:, translate_to:)
    @object         = object
    @translate_from = translate_from
    @translate_to   = translate_to
  end

  def run
    Globalize.with_locale(translate_to) { update_object }
  end

  private

    def original_texts
      @_original_texts ||= Globalize.with_locale(translate_from) { original_attributes }
    end

    def original_attributes
      raise "implement #{__method__} in sub class with a returning hash"
    end

    def update_object
      raise "implement #{__method__} in sub class"
    end
end
