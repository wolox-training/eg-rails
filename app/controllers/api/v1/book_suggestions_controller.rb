module Api
  module V1
    class BookSuggestionsController < Api::ApiController
      skip_before_action :authenticate_api_v1_user!, only: [:create]

      def create
        @book_suggestion = BookSuggestion.new(book_suggestion_params)

        if current_api_v1_user.present?
          @book_suggestion.user = current_api_v1_user
          authorize @book_suggestion
        end

        if @book_suggestion.save
          render json: @book_suggestion, status: :created
        else
          render json: { errors: @book_suggestion.errors }, status: :unprocessable_entity
        end
      end

      private

      def book_suggestion_params
        params.require(:book_suggestion).permit(
          :synopsis, :price, :author, :title, :link, :editor, :year
        )
      end
    end
  end
end
