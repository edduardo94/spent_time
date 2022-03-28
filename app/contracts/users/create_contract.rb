module Users
  class CreateContract < Dry::Validation::Contract
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    params do
      required(:name).value(:string)
      required(:login).value(:string)
      required(:email).value(:string)
      required(:password).value(:string)
    end

    rule(:name) do
      key.failure("name must not to be null") if value.nil? || value.empty?
    end

    rule(:login) do
      key.failure("login must not to be null") if value.nil? || value.empty?
    end

    rule(:email) do
      key.failure("must be a valid email") if !EMAIL_REGEX.match(value)
    end

    rule(:password) do
      key.failure("password must not to be null") if value.nil? || value.empty?
    end
  end
end
