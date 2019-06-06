class RentMailer < ApplicationMailer
  def new_rent(params)
    @rent = params[:rent]
    @book = @rent.book

    mail(to: @rent.user.email, subject: 'New rent')
  end
end
