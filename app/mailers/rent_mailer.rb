class RentMailer < ApplicationMailer
  def new_rent(params)
    @rent = params[:rent]
    @book = @rent.book

    mail(to: @rent.user.email, subject: I18n.t('rent_mailer.subject'))
  end
end
