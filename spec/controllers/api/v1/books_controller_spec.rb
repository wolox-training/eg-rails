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
end
