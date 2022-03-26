module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        Users::CreateOperation.new.call(create_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Users::CreateContract.new.(params)
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

      def update
        Users::UpdateOperation.new.call(update_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Users::UpdateContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 404,
                           status: Message.not_found("note"),
                           error: failure }, status: 404
          end
        end
      end

      def list
        Users::ListOperation.new.call(list_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Users::ListContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 404,
                           status: Message.not_found("Users"),
                           error: failure }, status: 404
          end
        end
      end

      def show
        Users::ShowOperation.new.call(show_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Users::ShowContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 404,
                           status: Message.not_found("note"),
                           error: failure }, status: 404
          end
        end
      end

      def search
        Users::SearchOperation.new.call(search_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Users::SearchContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 404,
                           status: Message.not_found("Users"),
                           error: failure }, status: 404
          end
        end
      end

      def destroy
        Users::DeleteOperation.new.call(delete_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = Users::DeleteContract.new.(params)
            render json: { code: 400,
                           status: Message.bad_request,
                           error: contract.errors }, status: 400
          end

          op.failure do |failure|
            render json: { code: 404,
                           status: Message.not_found("note"),
                           error: failure }, status: 404
          end
        end
      end

      private

      def search_dependencies
        {
          contract: Users::SearchContract.new.(params),
          current_user: @current_user,
        }
      end

      def list_dependencies
        {
          contract: Users::ListContract.new.(params),
          current_user: @current_user,
        }
      end

      def create_dependencies
        {
          contract: Users::CreateContract.new.(params),
          current_user: @current_user,
        }
      end

      def update_dependencies
        {
          contract: Users::UpdateContract.new.(params),
          current_user: @current_user,
        }
      end

      def delete_dependencies
        {
          contract: Users::DeleteContract.new.(params),
          current_user: @current_user,
        }
      end

      def free_Users_dependencies
        {
          contract: Users::ListContract.new.(params),
          current_user: User.find_by(id: 1),
        }
      end

      def show_dependencies
        {
          contract: Users::ShowContract.new.(params),
          current_user: @current_user,
        }
      end
    end
  end
end
