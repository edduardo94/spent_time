module SpentHours
  class ShowContract < Dry::Validation::Contract
    params do
      required(:project_id).value(:integer)
      optional(:user_id).value(:integer)
    end

    rule(:project_id) do
      key.failure("project id must higher than") if value == 0
    end

    rule(:user_id) do
      key.failure("must higher than 0 ") if key? && (value < 1)
    end
  end
end
