module Projects
  class CreateContract < Dry::Validation::Contract
    params do
      required(:title).value(:string)
      required(:description).value(:string)
      required(:user_id).value(:array)
    end

    rule(:title) do
      key.failure("title must not to be null") if value.nil? || value.empty?
    end

    rule(:description) do
      key.failure("description must not to be null") if value.nil? || value.empty?
    end

    rule(:user_id) do
      key.failure("users array must not to be empty") if value.nil? || value.empty?
    end
  end
end
