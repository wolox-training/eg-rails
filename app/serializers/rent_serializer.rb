class RentSerializer < ActiveModel::Serializer
  attributes :id, :start_at, :end_at

  belongs_to :book
  belongs_to :user
end
