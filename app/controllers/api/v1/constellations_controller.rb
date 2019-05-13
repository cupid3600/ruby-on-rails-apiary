module Api
  module V1
    class ConstellationsController < Api::V1::ApiController
      def index
        @constellations = Constellation.order(:id).page(params[:page])
        if params[:is_deleted].present? && params[:show_on_sign_up].present?
          @constellations = @constellations.both(params[:show_on_sign_up], params[:is_deleted])
        elsif params[:is_deleted].present?
          @constellations = @constellations.is_deleted(params[:is_deleted])
        elsif params[:show_on_sign_up].present?
          @constellations = @constellations.show_on_sign_up(params[:show_on_sign_up])
        else
          @constellations = @constellations.is_deleted(false)
        end
      end

      def search
          @constellations = Constellation.search(params[:constellation]).page(params[:page])
      end

      def summary
        @about_to_expire = allowed_contents.about_to_expire.limit(5)
                           .required_information

        @popular = allowed_contents.popular_not_about_to_expire.limit(8).required_information

        @common = allowed_contents.common.limit(15).required_information
      end

      def about_to_expire
        @contents = allowed_contents.about_to_expire.page(params[:page]).required_information
        render 'api/v1/contents/index'
      end

      def popular
        @contents = allowed_contents.popular_not_about_to_expire.page(params[:page])
                    .required_information
        render 'api/v1/contents/index'
      end

      def common
        @contents = allowed_contents.common.page(params[:page]).required_information
        render 'api/v1/contents/index'
      end

      private

      def allowed_contents
        constellation.contents.allowed
      end

      def constellation
        @constellation ||= Constellation.find(params[:id])
      end
    end
  end
end
