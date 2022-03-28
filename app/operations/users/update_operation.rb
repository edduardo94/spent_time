module Users
  class UpdateOperation < Operation
    include Dry::Transaction

    step :validate_contract
    step :execute_query
    step :result

    def validate_contract(context)
      if context[:contract].success?
        Success(context)
      else
        Failure(:invalid_contract)
      end
    end

    def execute_query(context)
      contract = context[:contract]
      user = User.find_by(id: contract[:id])
      if user.nil?
        Failure(:not_found)
      else
        begin
          user.update(name: contract[:name], email: contract[:email], login: contract[:login], password: contract[:password])
          context[:user] = user
          Success(context)
        rescue => e
          Failure(e)
        end
      end
    end

    def result(context)
      user = context[:user]
      result = { user: user }
      Success(result)
    end
  end
end
