# frozen_string_literal: true

module ControllerSpecHelper
  def token_generator(user_id)
    JsonWebToken.encode(user_id:)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: }, (Time.now.to_i - 10))
  end

  def valid_headers
    {
      'Authorization' => token_generator(user.id),
      'Content-Type' => 'application/json'
    }
  end

  def invalid_headers
    {
      'Authorization' => nil,
      'Content-Type' => 'application/json'
    }
  end

  def valid_admin_headers
    {
      'Authorization' => token_generator(admin.id),
      'Content-Type' => 'application/json'
    }
  end
end
