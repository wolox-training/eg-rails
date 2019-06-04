class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  before_action :authenticate_api_v1_user!

  private

  def render_not_found_response
    render json: {
      message: "Not found with id #{params[:id]}",
      code: :not_found
    }, status: :not_found
  end
end
