require 'rails_helper'

describe OpenLibrary do
  describe '#call' do
    context 'with correct params' do
      before do
        @response_data = File.read('./spec/support/fixtures/open_library_search.json')

        stub_request(:get, 'https://openlibrary.org/api/books')
          .with(query:
            {
              bibkeys: 'ISBN:0385472579',
              format: 'json',
              jscmd: 'data'
            })
          .to_return(status: 200, body: @response_data)

        @data = OpenLibrary.call('0385472579')
      end

      it 'make a call to open library api' do
        WebMock.should have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query:
            {
              bibkeys: 'ISBN:0385472579',
              format: 'json',
              jscmd: 'data'
            })
      end

      it 'return a hash with data' do
        hash_data = {
          isbn: '0385472579',
          title: 'Zen speaks',
          subtitle: 'shouts of nothingness',
          pages: 159,
          authors: ['Zhizhong Cai']
        }

        expect(@data).to eq(hash_data)
      end
    end

    context 'handle no isbn' do
      before do
        stub_request(:get, 'https://openlibrary.org/api/books')
          .with(query:
            {
              bibkeys: 'ISBN:',
              format: 'json',
              jscmd: 'data'
            })
          .to_return(status: 200, body: {}.to_json)
      end

      it 'return empty hash with not send isbn' do
        data = OpenLibrary.call(nil)
        expect(data).to eq(message: 'Falta ISBN para la busqueda')
      end
    end

    context 'handle timeout' do
      before do
        stub_request(:get, 'https://openlibrary.org/api/books')
          .with(query:
            {
              bibkeys: 'ISBN:test',
              format: 'json',
              jscmd: 'data'
            })
          .to_timeout
      end

      it 'return the message error when exists' do
        data = OpenLibrary.call('test')
        expect(data).to eq(message: 'execution expired')
      end
    end
  end
end
