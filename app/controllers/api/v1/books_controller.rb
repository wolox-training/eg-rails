module Api
  module V1
    class BooksController < Api::ApiController
      include Wor::Paginate

      def index
        render_paginated Book.all
      end

      def show
        @book = Book.find(show_params[:id])

        render json: @book
      end

      def search
        if search_params[:isbn].present?
          data = OpenLibrary.call(search_params[:isbn])

          render json: data, status: :ok
        else
          render json: { message: I18n.t('open_library.no_isbn') }, status: :bad_request
        end
      end

      private

      def show_params
        params.permit(:id)
      end

      def search_params
        params.permit(:isbn)
      end
    end
  end
end
