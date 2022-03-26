module Users
  class CreateOperation < Operation
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

      user = User.new(name: contract[:name], email: contract[:email], login: contract[:login], password: contract[:password])
      begin
        user.save!
        context[:user] = user
        Success(context)
      rescue ActiveRecord::RecordNotUnique => e
        Failure(:account_already_exists)
      rescue => e
        binding.break
        Failure(e)
      end
    end

    def result(context)
      user = context[:user]
      result = { user: user.attributes.except("password_digest") }
      Success(result)
    end
  end
end
