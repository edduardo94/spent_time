module Users
  class ShowContract < Dry::Validation::Contract
    params do
      required(:id).value(:integer)
    end

    rule(:id) do
      key.failure("id must higher than") if value == 0
    end
  end
end
