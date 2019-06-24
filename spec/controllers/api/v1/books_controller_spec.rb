require 'rails_helper'

describe Api::V1::BooksController do
  include_context 'Auth User'

  describe 'GET #index' do
    context 'Exists books' do
      let!(:books) { create_list(:book, 3) }

      before do
        get :index
      end

      it 'responses with json array of books' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(response.body) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When fetching a book' do
      context 'Exists a book' do
        let!(:book) { create(:book) }

        before do
          get :show, params: { id: book.id }
        end

        it 'responses with the book json' do
          expected = BookSerializer.new(book).to_json
          expect(response.body).to eq(expected)
        end

        it 'responds with ok status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'When not exists a book' do
        before do
          get :show, params: { id: 10 }
        end

        it 'responses with the message and code' do
          expected_message = 'Not found with id 10'
          expected_code = 'not_found'
          parsed_body = JSON.parse(response.body)

          expect(parsed_body['message']).to eq(expected_message)
          expect(parsed_body['code']).to eq(expected_code)
        end

        it 'responds with not found status' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe 'GET #search' do
    context 'with valid attributes' do
      before do
        @search_params = {
          isbn: '0385472579'
        }

        @mock_response = {
          isbn: '0385472579',
          title: 'Zen speaks',
          subtitle: 'shouts of nothingness',
          pages: 159,
          authors: ['Zhizhong Cai']
        }.to_json

        allow_any_instance_of(OpenLibrary)
          .to receive(:call)
          .and_return(@mock_response)

        get :search, params: @search_params
      end

      it 'find a book' do
        expect(response.body).to eq(@mock_response)
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      context 'no isbn in params' do
        before do
          @search_params = {
            isbn: nil
          }

          get :search, params: @search_params
        end

        it 'responses with the message' do
          expected_message = I18n.t('open_library.no_isbn')
          parsed_body = JSON.parse(response.body)

          expect(parsed_body['message']).to eq(expected_message)
        end

        it 'responds with bad_request status' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
