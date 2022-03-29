module SpentHours
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
      project_id = contract[:project_id]
      user_id = contract[:user_id]
      if user_id.nil?
        times = SpentHour.where(project_id: project_id)
      else
        times = SpentHour.where(project_id: project_id).where(user_id: user_id)
      end

      if times.nil?
        Failure(:not_found)
      else
        context[:times] = times
        Success(context)
      end
    end

    def result(context)
      times = context[:times]
      result = { time: times }
      Success(result)
    end
  end
end
