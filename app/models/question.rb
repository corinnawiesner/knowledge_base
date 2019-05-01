# Question is a part of an Article
class Question < ApplicationRecord
  translates :title, :abstract, :answer

  belongs_to :article, required: true, touch: true
end
