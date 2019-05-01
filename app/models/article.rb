# Article is a container for multiple questions
class Article < ApplicationRecord
  translates :title, :abstract

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, reject_if: proc { |attributes|
    [attributes["title"], attributes["abstract"], attributes["answer"]].any? { |attribute| attribute.blank? }
  }
end
