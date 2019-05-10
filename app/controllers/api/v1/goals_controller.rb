
module Api
  module V1
    class GoalsController < Api::V1::ApiController
      helper_method :goal

      def show
        json_response({ goal: goal })
      end

      def index

        if params[:is_deleted]
          @goals = Goal.where(:is_deleted => params[:is_deleted])
          json_response({ goals: @goals })
        else
          @goals = Goal.where(:is_deleted => false)
          json_response({ goals: @goals })
        end

      end

      def create
        @goal = Goal.create!(goal_params)
        json_response({ goal: @goal })
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
