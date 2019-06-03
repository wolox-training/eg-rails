module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_api_v1_user!

      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

      include Wor::Paginate

      def index
        render_paginated Book.all
      end

      def show
        if params[:id].present?
          @book = Book.find(params[:id])

          render json: @book
        else
          render json: {
            errors: "ID can't be blank",
            error_code: :bad_request
          }, status: :bad_request
        end
      end

      private

      def render_not_found_response
        render json: {
          message: "Not found with id #{params[:id]}",
          code: :not_found
        }, status: :not_found
      end
    end
  end
end
