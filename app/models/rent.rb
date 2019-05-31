class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

  validate :end_at_after_start_at
  validate :dates_are_not_passed

  private

  def end_at_after_start_at
    return if end_at.blank? || start_at.blank?

    errors.add(:end_at, 'must be after the start date') if end_at < start_at
  end

  def dates_are_not_passed
    errors.add(:start_at, 'must be after today') unless start_at && start_at >= Time.zone.now
    errors.add(:end_at, 'must be after today') unless end_at && end_at >= Time.zone.now
  end
end
