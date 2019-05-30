class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
end
