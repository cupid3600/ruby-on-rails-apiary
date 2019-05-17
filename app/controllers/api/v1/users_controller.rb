# encoding: utf-8

module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :authenticate_user!, except: [:codes, :update_password, :verify_code]
      before_action :verify_codes_params, only: [:codes]
      before_action :verify_update_password_params, only: [:update_password]
      before_action :set_user, only: [:codes, :update_password, :verify_code]
      before_action :get_code, only: [:update_password, :verify_code]

      helper_method :user

      def show
      end

      def profile
        render :show
      end

      def update
        user.update!(user_params)
        render :show
      end

      def codes
        @code = @user.send_reset_password_code_email(
          code: params[:code]
        )
      end

      def update_password
        if @code.expires_at > Time.current
          @user.password = params[:password]
          if @user.save(validate: false)
            render json: {
              status: true,
              message: "Your password was successfully updated."
            }
          else
            raise ActiveRecord::RecordInvalid, @user
          end
        else
          render_verify_error
        end
      end

      def verify_code
        render_verify_error unless @code.expires_at > Time.current
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :picture)
      end

      def user
        @user ||= user_id.present? ? User.find(user_id) : current_user
      end

      def user_id
        params[:id]
      end

      def set_user
        @user, params_type = if params[:email]
          [User.where(uid: params[:email]).first, 'email']
        elsif params[:user_id]
          [User.find_by_id(params[:user_id]), 'user_id']
        else
          params_missing(":email or :user_id")
        end
        return render_not_found(params_type) unless @user
      end

      def get_code
        @code = @user.codes.where(code: params[:code]).last
        render_verify_error unless @code
      end

      def verify_codes_params
        params_missing(":email, :code") if !params[:email] || !params[:code]
      end

      def verify_update_password_params
        params_missing(":password, :code") if !params[:password] || !params[:code]
      end

      def params_missing(params_str)
        raise ActionController::ParameterMissing, "Required parameter missing #{params_str}"
      end

      def render_not_found(params_type)
        render json: {
          status: false,
          error: "Unable to find user with #{params_type} #{params[params_type.to_sym]}."
        }, status: :not_found
      end

      def render_verify_error
        render json: {
          status: false,
          error: "Reset password code doesn't match or expired. Please try again."
        }, status: :not_found
      end
    end
  end
end
