module SpentHours
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
      user_id = context[:contract][:user_id]
      project_id = context[:contract][:project_id]
      begin
        time = SpentHour.new(started_at: contract[:started_at], ended_at: contract[:ended_at], user_id: user_id, project_id: project_id)
        time.save!
        context[:time] = time
        Success(context)
      rescue => e
        Failure(e)
      end
    end

    def result(context)
      time = context[:time]
      result = { time: time }
      Success(result)
    end
  end
end
