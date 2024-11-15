class Api::V0::BaseApiController < ActionController::API
  # Common API configurations or methods can be added here
  # Example: Adding a default response format
  before_action :set_default_response_format

  private

  def set_default_response_format
    request.format = :json
  end

  def limit
    params[:limit] || 20
  end

  def offset
    params[:offset] || 0
  end
end
