# Preview all emails at http://localhost:3000/rails/mailers/rent_mailer
class RentMailerPreview < ActionMailer::Preview
  def new_rent
    RentMailer.new_rent(rent: Rent.first)
  end

  def expired_rent
    RentMailer.expired_rent(Rent.first.id)
  end
end
