module Api
  module V1
    class InterestsConstellationsController < ApiController
      helper_method :interests_constellation

      def create
        @interests_constellation = InterestsConstellation.create!(interests_constellation_params)
      end

      def index
        @interests_constellations = InterestsConstellation.all
      end

      def update
        interests_constellation.update!(interests_constellation_params)
      end

      def destroy
        interests_constellation.destroy
        json_response({ delete: 'success' })
      end

      private

      def interests_constellation_params
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