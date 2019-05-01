RSpec.configure do |config|
  config.include Features::ArticleHelpers, type: :feature
  config.include Features::QuestionHelpers, type: :feature
end
