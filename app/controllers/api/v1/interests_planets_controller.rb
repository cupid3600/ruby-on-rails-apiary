module Api
  module V1
    class InterestsPlanetsController < ApiController
      helper_method :interests_planet

      def create
        @interests_planet = InterestsPlanet.create!(interests_planet_params)
        json_response({ interests_planet: @interests_planet })
      end

      def index
        @interests_planets = InterestsPlanet.all
        json_response({ interests_planets: @interests_planets })
      end

      def update
        interests_planet.update!(interests_planet_params)
        json_response({ interests_planet: @interests_planet })
      end

      def destroy
        interests_planet.destroy
        json_response({ delete: 'success' })
      end

      private

      def interests_planet_params
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