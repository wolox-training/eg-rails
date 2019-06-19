class BookSuggestionPolicy
  attr_reader :user, :book_suggestion

  def initialize(user, book_suggestion)
    @user = user
    @book_suggestion = book_suggestion
  end

  def create?
    book_suggestion.user_id == user.id
  end
end
