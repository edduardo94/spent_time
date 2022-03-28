module Projects
  class CreateOperation < Operation
    include Dry::Transaction

    step :validate_contract
    step :execute_query
    step :create_relations
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

      project = Project.new(title: contract[:title], description: contract[:description])
      begin
        project.save!
        context[:project] = project
        Success(context)
      rescue => e
        Failure(e)
      end
    end

    def create_relations(context)
      project = context[:project]
      user_ids = context[:contract][:user_id]
      user_ids.each do |id|
        project.users << User.find_by(id: id)
      end
      context[:project] = project
      Success(context)
    end

    def result(context)
      project = context[:project]
      result = { project: project.as_json(:include => { :users => { except: :password_digest } }) }
      Success(result)
    end
  end
end
