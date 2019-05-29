class Book < ApplicationRecord
  validates_presence_of :title, :author, :year, :editor, :gender, :image
end