# encoding: utf-8

module Api
  module V1
    class ShootingStarsController < Api::V1::ApiController
      def count
        json_response({ shooting_stars_count: shooting_stars.count })
      end

      def show_one
        @new_star = shooting_stars.first
        @new_star.try :expire!
      end

      private

      def shooting_stars
        @shooting_stars ||= Content.shooting_stars
      end
    end
  end
end
