# encoding: utf-8

module Api
  module V1
    class ContentsController < Api::V1::ApiController
      skip_before_action :check_json_request, only: [:create]
      before_action :check_file_type, only: [:create]

      helper_method :content

      def index
        @contents = constellation.contents.allowed
                    .newest.page(params['page']).required_information
      end

      def create
        collection = content_class.constantize
        @content = collection.create!(content_params.merge(user: current_user))
      end

      def update_constellations
        params[:constellation_ids].map do |constellation|
          content.content_constellations.find_or_create_by!(constellation_id: constellation)
        end
      end

      def flag
        content.flags.create!(user: current_user)
        render :show
      end

      def favorite
        params[:favorited].to_b ? content.favorite(current_user) : content.unfavorite(current_user)
        render :show
      end

      def favorites
        @contents = current_user.hearted_contents.allowed.order('hearts.id DESC')
                    .page(params['page']).required_information
      end

      private

      def content
        @content ||= Content.find(params[:id])
      end

      def constellation
        @constellation ||= Constellation.find(params[:constellation_id])
      end

      def check_file_type
        fail ActionController::BadRequest unless %w(Video Audio).include?(content_class)
      end

      def content_params
        params.require(:content).permit(:file, :shooting_star, constellation_ids: [])
      end

      def content_class
        @content_class ||= content_params[:file].content_type.split('/')[0].capitalize
      end
    end
  end
end
