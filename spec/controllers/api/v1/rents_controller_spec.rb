require 'rails_helper'

describe Api::V1::RentsController do
  include_context 'Auth User'

  describe 'GET #index' do
    context 'Exists rents' do
      let!(:rent) { create(:rent_with_user_and_book, user: user) }

      subject! { get :index }

      it 'responses with json array of rents' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          [rent], each_serializer: RentSerializer
        ).to_json
        expect(response.body) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }
    let!(:book) { create(:book) }

    context 'with valid attributes' do
      before do
        @rent_params = {
          rent: {
            user_id: user.id,
            book_id: book.id,
            start_at: 1.day.after,
            end_at: 1.week.after
          }
        }
      end

      it 'creates a rent' do
        expect { post :create, params: @rent_params }.to change(Rent, :count).by(1)
      end

      it 'responds with created status' do
        post :create, params: @rent_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      before do
        @rent_params = {
          rent: {
            user_id: user.id,
            book_id: book.id,
            start_at: 1.day.after
          }
        }
      end

      it 'does not save the new contact' do
        expect { post :create, params: @rent_params }.to_not change(Rent, :count)
      end

      it 'responds with unprocessable_entity status' do
        post :create, params: @rent_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'responds with errors' do
        post :create, params: @rent_params
        body_parse = JSON.parse(response.body)

        expect(body_parse).to include('errors')
        expect(body_parse['errors']).to include('end_at')
      end
    end
  end
end
