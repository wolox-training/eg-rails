module Api
  class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken

    before_action :authenticate_api_v1_user!

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    private

    def render_not_found_response
      render json: {
        message: "Not found with id #{params[:id]}",
        code: :not_found
      }, status: :not_found
    end
  end
end
