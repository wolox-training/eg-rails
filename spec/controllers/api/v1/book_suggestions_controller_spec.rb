require 'rails_helper'

describe Api::V1::BookSuggestionsController do
  describe 'POST #create' do
    describe 'as a visit' do
      context 'with valid attributes' do
        before do
          @suggestion_params = {
            book_suggestion: {
              synopsis: Faker::String.random,
              price: Faker::Commerce.price,
              author: Faker::Book.author,
              title: Faker::Book.title,
              link: Faker::Internet.url,
              editor: Faker::Book.publisher,
              year: 2019
            }
          }
        end

        it 'creates a book suggestion' do
          expect { post :create, params: @suggestion_params }
            .to change(BookSuggestion, :count).by(1)
        end

        it 'responds with created status' do
          post :create, params: @suggestion_params
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid attributes' do
        before do
          @suggestion_params = {
            book_suggestion: {
              synopsis: Faker::String.random,
              price: Faker::Commerce.price,
              author: Faker::Book.author,
              link: Faker::Internet.url,
              editor: Faker::Book.publisher,
              year: 2019
            }
          }
        end

        it 'does not save the new contact' do
          expect { post :create, params: @suggestion_params }
            .to_not change(BookSuggestion, :count)
        end

        it 'responds with unprocessable_entity status' do
          post :create, params: @suggestion_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'responds with errors' do
          post :create, params: @suggestion_params
          body_parse = JSON.parse(response.body)

          expect(body_parse).to include('errors')
          expect(body_parse['errors']).to include('title')
        end
      end
    end

    describe 'as a register user' do
      include_context 'Auth User'

      context 'with valid attributes' do
        before do
          @suggestion_params = {
            book_suggestion: {
              synopsis: Faker::String.random,
              price: Faker::Commerce.price,
              author: Faker::Book.author,
              title: Faker::Book.title,
              link: Faker::Internet.url,
              editor: Faker::Book.publisher,
              year: 2019,
              user: user.id
            }
          }
        end

        it 'creates a book suggestion' do
          expect { post :create, params: @suggestion_params }
            .to change(BookSuggestion, :count).by(1)
        end

        it 'responds with created status' do
          post :create, params: @suggestion_params
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid attributes' do
        before do
          @suggestion_params = {
            book_suggestion: {
              synopsis: Faker::String.random,
              price: Faker::Commerce.price,
              author: Faker::Book.author,
              link: Faker::Internet.url,
              editor: Faker::Book.publisher,
              year: 2019,
              user: user.id
            }
          }
        end

        it 'does not save the new contact' do
          expect { post :create, params: @suggestion_params }
            .to_not change(BookSuggestion, :count)
        end

        it 'responds with unprocessable_entity status' do
          post :create, params: @suggestion_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'responds with errors' do
          post :create, params: @suggestion_params
          body_parse = JSON.parse(response.body)

          expect(body_parse).to include('errors')
          expect(body_parse['errors']).to include('title')
        end
      end
    end
  end
end
