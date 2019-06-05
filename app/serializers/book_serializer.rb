class BookSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :gender, :editor, :year, :image
end
