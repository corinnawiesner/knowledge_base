require 'aws-sdk-translate'

class Translators::Aws
  attr_reader :text,
              :translate_from,
              :translate_to

  class << self
    def run(text, translate_from: :en, translate_to: :de)
      new(text, translate_from: translate_from, translate_to: translate_to).run
    end
  end

  def initialize(text, translate_from:, translate_to:)
    @text           = text
    @translate_from = translate_from
    @translate_to   = translate_to
  end

  # TODO: catch exception
  def run
    client.translate_text(
      text: text,
      source_language_code: translate_from,
      target_language_code: translate_to
    )[:translated_text]
  end

  private

    def client
      @client ||= ::Aws::Translate::Client.new
    end
end
