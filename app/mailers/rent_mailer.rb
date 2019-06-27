class RentMailer < ApplicationMailer
  def new_rent(params)
    @rent = params[:rent]
    @book = @rent.book

    mail(to: @rent.user.email, subject: I18n.t('rent_mailer.new_rent.subject'))
  end

  def expired_rent(rent_id)
    @rent = Rent.find(rent_id)
    @book = @rent.book

    mail(to: @rent.user.email, subject: I18n.t('rent_mailer.expired_rent.subject'))
  end
end
