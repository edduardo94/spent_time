module Users
  class UpdateContract < Dry::Validation::Contract
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    params do
      required(:id).value(:integer)
      required(:name).value(:string)
      required(:login).value(:string)
      required(:email).value(:string)
      required(:password).value(:string)
    end

    rule(:id) do
      key.failure("id must higher than 0") if value == 0
    end

    rule(:name) do
      key.failure("name must not to be null") if value.nil?
    end

    rule(:login) do
      key.failure("login must not to be null") if value.nil?
    end

    rule(:email) do
      key.failure("must be a valid email") if !EMAIL_REGEX.match(value)
    end

    rule(:password) do
      key.failure("password must not to be null") if value.nil?
    end
  end
end
