class Book < ApplicationRecord
  has_many :rents, dependent: :destroy

  validates :title, presence: true, length: { maximum: 25 }
  validates :author, presence: true
  validates :year, presence: true
  validates :editor, presence: true
  validates :gender, presence: true
  validates :image, presence: true
end
