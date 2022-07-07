# frozen_string_literal: true

# This class is used to authenticate a user.
class AuthenticateUser
  def initialize(email, password, is_admin)
    @email = email
    @password = password
    @is_admin = is_admin
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password, :is_admin

  def user
    user = User.find_by(email:)
    return user if user&.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
