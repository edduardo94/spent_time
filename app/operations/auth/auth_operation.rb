module Auth
  class AuthOperation
    include Dry::Transaction

    step :validate_contract
    step :authenticate

    def validate_contract(context)
      if context[:contract].success?
        Success(context)
      else
        Failure(:invalid_contract)
      end
    end

    def authenticate(context)
      contract = context[:contract]
      auth_token = context[:auth].new.call(contract[:email], contract[:password])
      if auth_token
        Success(auth_token)
      else
        Failure(:unauthorized)
      end
    end
  end
end
