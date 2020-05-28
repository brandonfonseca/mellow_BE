# frozen_string_literal: true

# helper functions related to API response
module Response
  # simple function to return json
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
