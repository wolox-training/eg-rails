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

      data = self.class.get('/books', query: @params).body
      data = JSON.parse(data)
      return parsed_data(data) if data.present?

      data
    end
  end

  private

  def parsed_data(data)
    data = data[@isbn_key]
    {
      isbn: @isbn,
      title: data['title'],
      subtitle: data['subtitle'],
      pages: data['number_of_pages'],
      authors: data['authors'].map { |author| author['name'] }
    }
  end

  def handle_errors
    yield
  rescue StandardError => e
    { message: e.message }
  end
end
