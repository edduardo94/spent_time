module Projects
  class UpdateOperation < Operation
    include Dry::Transaction

    step :validate_contract
    step :execute_query
    step :update_relations
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
      id = contract[:id]
      project = Project.find_by(id: id)
      if project.nil?
        Failure(:not_found)
      else
        begin
          project.update(title: contract[:title], description: contract[:description])
          context[:project] = project
          Success(context)
        rescue => e
          Failure(e)
        end
      end
    end

    def update_relations(context)
      project = context[:project]
      user_ids = context[:contract][:user_id]
      begin
        project.users.delete(project.users)
        user_ids.each do |id|
          project.users << User.find_by(id: id)
        end
        context[:project] = project
        Success(context)
      rescue => e
        Failure(e)
      end
    end

    def result(context)
      project = context[:project]
      result = { project: project.as_json(:include => { :users => { except: :password_digest } }) }
      Success(result)
    end
  end
end
