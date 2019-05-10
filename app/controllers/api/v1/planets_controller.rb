module Api
  module V1
    class PlanetsController < Api::V1::ApiController
      helper_method :planet

      def show
        json_response({ planet: planet })
      end

      def index
        if params[:is_deleted].present? && params[:is_approved].present?
          @planets = Planet.where({:is_deleted => params[:is_deleted], :is_approved => params[:is_approved]})
          json_response({ planets: @planets })
        elsif query_params.present?
          @planets = Planet.where(:constellation_id => query_params)
          json_response({ planets: @planets })
        else
          @planets = Planet.where({:is_deleted => false, :is_approved => true})
          json_response({ planets: @planets })
        end

      end

      def create
        @planet = Planet.create!(planet_params)
        json_response({ planet: @planet })
      end

      def update
        planet.update!(planet_params)
        json_response({ planet: planet })
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

      def query_params
        if params[:constellation_id].present?
          params[:constellation_id].is_a?(Array) ? params[:constellation_id] : params[:constellation_id].split(",")
        end
      end

    end
  end
end