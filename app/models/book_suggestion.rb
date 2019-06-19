class BookSuggestion < ApplicationRecord
  belongs_to :user, optional: true

  validates :author, presence: true
  validates :title, presence: true
  validates :link, presence: true
  validates :editor, presence: true
  validates :year, presence: true
end
