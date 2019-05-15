module Api
  module V1
    class ConstellationRequestsController < Api::V1::ApiController
      skip_before_action :check_json_request, only: :create
      before_action :check_constellation, only: :create

      def create
        @constellation_request = current_user.constellation_requests.create!(
          constellation_request_params
        )
        AdminMailer.new_constellation_request(@constellation_request).deliver_later
      end

      private

      def constellation_request_params
        content_attributes = params[:constellation_request][:content_attributes]
        content_attributes[:user_id] = current_user.id
        content_attributes[:type] = cont_type
        params.require(:constellation_request).permit(
          :name, :reason, content_attributes: [:file, :type, :user_id]
        )
      end

      def cont_type
        params[:constellation_request][:content_attributes][:file].content_type
          .split('/')[0]
          .capitalize
      end

      def check_constellation
        constellation = Constellation.find_by(name: constellation_request_params[:name])
        return unless constellation

        json_response({ errors: 'A constellation already exists with that name' }, status: bad_request)
      end
    end
  end
end
