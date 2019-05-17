module Api
  module V1
    class InterestsConstellationsController < ApiController
      helper_method :interests_constellation

      def create
        @interests_constellation = InterestsConstellation.create!(interests_constellation_params)
      end

      def index
        @interests_constellations = InterestsConstellation.all.page(params['page'])
      end

      def destroy
        interests_constellation.destroy
        render json: { delete: 'success' }, staus: :ok
      end

      private

      def interests_constellation_params
        if params[:interests_constellation]
          params[:interests_constellation][:user_id] = current_user.id
        end
        params.require(:interests_constellation).permit(
            :constellation_id, :user_id)
      end
      def interests_constellation
        @interests_constellation = InterestsConstellation.find(interests_constellation_id)
      end

      def interests_constellation_id
        params[:id]
      end
    end
  end
end