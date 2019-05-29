class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :year, presence: true
  validates :editor, presence: true
  validates :gender, presence: true
  validates :image, presence: true
end
