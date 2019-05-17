module Api
  module V1
    class PlanetsController < Api::V1::ApiController
      helper_method :planet

      def show
      end

      def index
        planets = Planet.all
        planets = planets.by_deleted(params[:is_deleted]) if params[:is_deleted].present?
        planets = planets.by_approved(params[:is_approved]) if params[:is_approved].present?
        planets = planets.by_constellation_id(constellation_params) if constellation_params.present?
        @planets = planets.order(:id).page(params['page'])
      end

      def create
        @planet = Planet.create!(planet_params)
      end

      def update
        planet.update!(planet_params)
      end

      private
      def planet_params
        params.require(:planet).permit(
            :title, :constellation_id, :is_deleted, :is_approved)
      end
      def planet
        @planet = Planet.find(planet_id)
      end

      def planet_id
        params[:id]
      end

      def constellation_params
        if params[:constellation_id].present?
          params[:constellation_id].is_a?(Array) ? params[:constellation_id] : params[:constellation_id].split(",")
        end
      end

    end
  end
end