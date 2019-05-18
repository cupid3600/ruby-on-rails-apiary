module Api
  module V1
    class InterestsGoalsController < ApiController
      helper_method :interests_goal

      def create
        @interests_goal = InterestsGoal.create!(interests_goal_params)
      end

      def index
        @interests_goals = InterestsGoal.all.page(params['page'])
      end

      def destroy
        interests_goal.destroy
        render json: { delete: 'success' }, status: :ok
      end

      private

      def interests_goal_params
        if params[:interests_goal]
          params[:interests_goal][:user_id] = current_user.id
        end
        params.require(:interests_goal).permit(
            :goal_id, :user_id)
      end

      def interests_goal
        @interests_goal = InterestsGoal.find(interests_goal_id)
      end

      def interests_goal_id
        params[:id]
      end
    end
  end
end