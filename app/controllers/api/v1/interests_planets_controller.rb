module Api
  module V1
    class InterestsPlanetsController < ApiController
      helper_method :interests_planet

      def create
        @interests_planet = InterestsPlanet.create!(interests_planet_params)
      end

      def index
        @interests_planets = InterestsPlanet.all.page(params['page'])
      end

      def destroy
        interests_planet.destroy
        render json: { delete: 'success' }, status: :ok
      end

      private

      def interests_planet_params
        if params[:interests_planet]
          params[:interests_planet][:user_id] = current_user.id
        end
        params.require(:interests_planet).permit(
            :planet_id, :user_id)
      end

      def interests_planet
        @interests_planet = InterestsPlanet.find(interests_planet_id)
      end

      def interests_planet_id
        params[:id]
      end
    end
  end
end