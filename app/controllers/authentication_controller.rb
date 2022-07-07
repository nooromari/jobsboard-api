# frozen_string_literal: true

# This class is to handle authontication controller
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password], auth_params[:is_admin]).call
    json_response(auth_token:)
  end

  private

  def auth_params
    params.permit(:email, :password, :is_admin)
  end
end
