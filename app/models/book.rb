class Book < ApplicationRecord
  has_many :rents

  validates :title, presence: true
  validates :author, presence: true
  validates :year, presence: true
  validates :editor, presence: true
  validates :gender, presence: true
  validates :image, presence: true
end
