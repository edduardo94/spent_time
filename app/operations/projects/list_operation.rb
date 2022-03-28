module Projects
  class ListOperation < Operation
    include Dry::Transaction
    DEFAULT_PAGE_VALUE = 1
    DEFAULT_PER_PAGE_VALUE = 10

    step :validate_contract
    step :build_request_params
    step :list
    step :result

    def build_request_params(context)
      contract = context[:contract]
      contract.values[:page] = DEFAULT_PAGE_VALUE if !contract.key?(:page)
      contract.values[:per_page] = DEFAULT_PER_PAGE_VALUE if !contract.key?(:per_page)
      Success(context)
    end

    def list(context)
      contract = context[:contract]
      current_user = context[:current_user]
      projects = current_user.projects.page(context[:contract][:page]).per(context[:contract][:per_page])
      context[:projects] = projects
      Success(context)
    end

    def result(context)
      projects = context[:projects]
      result = { page: context[:contract][:page], projects: projects.as_json(:include => { :users => { except: :password_digest } }) }
      Success(result)
    end
  end
end
