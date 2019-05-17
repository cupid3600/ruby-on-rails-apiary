
module Api
  module V1
    class GoalsController < Api::V1::ApiController
      helper_method :goal

      def show
      end

      def index
        @goals = if params[:is_deleted]
          Goal.is_deleted(params[:is_deleted])
        else
          Goal.is_deleted(false)
        end
        @goals = @goals.page(params['page'])
      end

      private
      def goal_params
        params.require(:goal).permit(
            :title, :slug)
      end
      def goal
        @goal = Goal.find(goal_id)
      end

      def goal_id
        params[:id]
      end
    end
  end
end
