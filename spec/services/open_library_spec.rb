require 'rails_helper'

describe OpenLibrary do
  describe '#call' do
    context 'with correct params' do
      before do
        @response_data = { data: 'correct' }

        stub_request(:get, 'https://openlibrary.org/api/books')
          .with(query:
            {
              bibkeys: 'ISBN:test',
              format: 'json',
              jscmd: 'data'
            })
          .to_return(status: 200, body: @response_data.to_json)
      end

      it 'make a call to open library api' do
        OpenLibrary.call('test')

        WebMock.should have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query:
            {
              bibkeys: 'ISBN:test',
              format: 'json',
              jscmd: 'data'
            })
      end

      it 'return a hash with data' do
        data = OpenLibrary.call('test')
        expect(data).to eq(@response_data.to_json)
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
        expect(data).to eq({})
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

      it 'return empty hash with not send isbn' do
        data = OpenLibrary.call('test')
        expect(data).to eq({})
      end
    end
  end
end
