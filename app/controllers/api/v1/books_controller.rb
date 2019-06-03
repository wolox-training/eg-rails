module Api
  module V1
    class BooksController < ApiController
      include Wor::Paginate

      def index
        render_paginated Book.all
      end

      def show
        @book = Book.find(show_params[:id])

        render json: @book
      end

      private

      def show_params
        params.permit(:id)
      end
    end
  end
end
