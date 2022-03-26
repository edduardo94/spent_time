module Users
  class ShowOperation < Operation
    include Dry::Transaction

    step :validate_contract
    step :list
    step :result

    def validate_contract(context)
      if context[:contract].success?
        Success(context)
      else
        Failure(:invalid_contract)
      end
    end

    def list(context)
      contract = context[:contract]
      id = contract[:id]
      user = User.find_by(id: id)

      if user.nil?
        Failure(:not_found)
      else
        context[:user] = user
        Success(context)
      end
    end

    def result(context)
      user = context[:user]
      result = { user: user.attributes.except("password_digest") }
      Success(result)
    end
  end
end
