class AuthenticateUser
  def call(email, password)
    user = user(email, password)
    token = JsonWebToken.encode(user_id: user.id) if user
    if token
      { token: token, user: user.attributes.except("password_digest") }
    else
      nil
    end
  end

  private

  attr_reader :email, :password

  def user(email, password)
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
