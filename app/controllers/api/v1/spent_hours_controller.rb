module Api
  module V1
    class SpentHoursController < ApplicationController
      def create
        SpentHours::CreateOperation.new.call(create_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = SpentHours::CreateContract.new.(params)
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

      def show
        SpentHours::ShowOperation.new.call(show_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = SpentHours::ShowContract.new.(params)
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
        SpentHours::UpdateOperation.new.call(update_dependencies) do |op|
          op.success do |context|
            render json: context, status: 200
          end

          op.failure :validate_contract do |failure|
            contract = SpentHours::UpdateContract.new.(params)
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
          contract: SpentHours::CreateContract.new.(params),
          current_user: @current_user,
        }
      end

      def show_dependencies
        {
          contract: SpentHours::ShowContract.new.(params),
          current_user: @current_user,
        }
      end

      def update_dependencies
        {
          contract: SpentHours::UpdateContract.new.(params),
          current_user: @current_user,
        }
      end
    end
  end
end
