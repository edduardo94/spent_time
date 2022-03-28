module Api
  module V1
    class ProjectsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        Projects::CreateOperation.new.call(create_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Projects::CreateContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 400,
                           status: Message.bad_request,
                           error: failure }, status: 400
          end
        end
      end

      private

      def create_dependencies
        {
          contract: Projects::CreateContract.new.(params),
          current_user: @current_user,
        }
      end
    end
  end
end
