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

      def list
        Projects::ListOperation.new.call(list_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Projects::ListContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 404,
                           status: Message.not_found("project"),
                           error: failure }, status: 404
          end
        end
      end

      def show
        Projects::ShowOperation.new.call(show_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Projects::ShowContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 404,
                           status: Message.not_found("project"),
                           error: failure }, status: 404
          end
        end
      end

      def update
        Projects::UpdateOperation.new.call(update_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Projects::UpdateContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 404,
                           status: Message.not_found("project"),
                           error: failure }, status: 404
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

      def list_dependencies
        {
          contract: Projects::ListContract.new.(params),
          current_user: @current_user,
        }
      end

      def show_dependencies
        {
          contract: Projects::ShowContract.new.(params),
          current_user: @current_user,
        }
      end

      def update_dependencies
        {
          contract: Projects::UpdateContract.new.(params),
          current_user: @current_user,
        }
      end
    end
  end
end
