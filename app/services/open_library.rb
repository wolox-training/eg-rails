class OpenLibrary
  include HTTParty
  base_uri 'https://openlibrary.org/api'

  def initialize(isbn)
    @isbn = isbn
    @isbn_key = "ISBN:#{@isbn}"
    @params = { format: 'json', jscmd: 'data', bibkeys: @isbn_key }
  end

  def self.call(isbn)
    new(isbn).call
  end

  def call
    handle_errors do
      raise ArgumentError, I18n.t('open_library.no_isbn') if @isbn.blank?

      self.class.get('/books', query: @params).body
    end
  end

  private

  def handle_errors
    yield
  rescue StandardError
    {}
  end
end
