class AuthenticateUser
  def call(login, password)
    user = user(login, password)
    token = JsonWebToken.encode(user_id: user.id) if user
    if token
      { token: token, user: user }
    else
      nil
    end
  end

  private

  attr_reader :email, :password

  def user(login, password)
    user = User.find_by(login: login)
    return user if user&.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
