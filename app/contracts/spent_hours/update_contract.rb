module SpentHours
  class UpdateContract < Dry::Validation::Contract
    params do
      required(:id).value(:integer)
      required(:user_id).value(:integer)
      required(:project_id).value(:integer)
      required(:started_at).value(:string)
      required(:ended_at).value(:string)
    end

    rule(:id) do
      key.failure("id must not to be null") if value.nil? || value == 0
    end

    rule(:user_id) do
      key.failure("user_id must not to be null") if value.nil? || value == 0
    end

    rule(:project_id) do
      key.failure("project_id must not to be null") if value.nil? || value == 0
    end

    rule(:started_at) do
      key.failure("started_at must not to be null") if value.nil? || value.empty?
    end

    rule(:ended_at) do
      key.failure("ended_at must not to be null") if value.nil? || value.empty?
    end
  end
end
