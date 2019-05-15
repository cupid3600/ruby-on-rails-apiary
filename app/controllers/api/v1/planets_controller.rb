module Api
  module V1
    class PlanetsController < Api::V1::ApiController
      helper_method :planet

      def show
      end

      def index
        query = Planet.order(:id)
        query = query.is_deleted(params[:is_deleted]) if params[:is_deleted].present?
        query = query.is_approved(params[:is_approved]) if params[:is_approved].present?
        query = query.both(true, false ) if !params[:is_approved].present? && !params[:is_deleted].present?
        query = query.constellation_id(query_params) if query_params.present?
        @planets = query.all

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

      def query_params
        if params[:constellation_id].present?
          params[:constellation_id].is_a?(Array) ? params[:constellation_id] : params[:constellation_id].split(",")
        end
      end

    end
  end
end