# frozen_string_literal: true

# This class is to handle users.
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password, user.is_admin).call
    response = { message: Message.account_created, auth_token: }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      :is_admin
    )
  end
end
