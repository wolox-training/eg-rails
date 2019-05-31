class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

  validate :end_at_after_start_at

  private

  def end_at_after_start_at
    return if end_at.blank? || start_at.blank?

    errors.add(:end_at, 'must be after the start date') if end_at < start_at
  end
end
