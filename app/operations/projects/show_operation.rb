module Projects
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
      project = Project.find_by(id: id)

      if project.nil?
        Failure(:not_found)
      else
        context[:project] = project
        Success(context)
      end
    end

    def result(context)
      project = context[:project]
      result = { project: project.as_json(:include => { :users => { except: :password_digest } }) }
      Success(result)
    end
  end
end
