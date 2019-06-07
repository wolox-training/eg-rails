module Api
  module V1
    class RentsController < Api::ApiController
      include Wor::Paginate

      def index
        rents = Rent.where(user_id: current_api_v1_user.id)
        render_paginated(rents)
      end

      def create
        @rent = Rent.new(rent_params)

        if @rent.save
          RentMailer.new_rent(rent: @rent).deliver_later

          render json: @rent, status: :created
        else
          render json: { errors: @rent.errors }, status: :unprocessable_entity
        end
      end

      private

      def rent_params
        params.require(:rent).permit(:user_id, :book_id, :start_at, :end_at)
      end
    end
  end
end
