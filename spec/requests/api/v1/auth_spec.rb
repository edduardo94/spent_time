require "swagger_helper"

RSpec.describe "api/v1/auth", type: :request do
  before do
    user = User.create(name: "test", login: "test", email: "test@test.com", password: "123")
  end
  path "/api/v1/authenticate" do
    post("authenticate auth") do
      parameter name: :login, in: :query, type: "string"
      parameter name: :password, in: :query, type: "string"

      response(200, "successful") do
        let(:login) { "test" }
        let(:password) { "123" }
        run_test! do |response|
          expect(response.body["token"]).not_to be(nil)
        end
      end

      response(401, "unauthorized") do
        let(:login) { "test" }
        let(:password) { "1" }
        run_test! do |response|
          expect(response.body["token"]).to be(nil)
        end
      end
    end
  end
end
