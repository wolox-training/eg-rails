require 'sidekiq-scheduler'

class ExpiredRentWorker
  include Sidekiq::Worker

  def perform
    rent_ids.each do |rent_id|
      RentMailer.expired_rent(rent_id).deliver_later
    end
  end

  private

  def rent_ids
    Rent.where(end_at: Time.zone.today.all_day).ids
  end
end
