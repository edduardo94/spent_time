module Auth
  class AuthContract < Dry::Validation::Contract
    params do
      required(:login).value(:string)
      required(:password).value(:string)
    end
  end
end
