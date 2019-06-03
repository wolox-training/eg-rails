class BookSerializer < ActiveModel::Serializer
  attributes :author, :title
  attribute :gender, key: :genre
end
