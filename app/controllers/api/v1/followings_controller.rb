module Api
  module V1
    class FollowingsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_followed, only: [:create, :destroy]

      def create
        following = current_user.active_followings.build(followed: @followed)
        if following.save
          render json: following, status: :created
        else
          render json: { errors: following.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        following = current_user.active_followings.find_by(followed: @followed)
        if following&.destroy
          head :no_content
        else
          render json: { error: "Unable to unfollow the user" }, status: :unprocessable_entity
        end
      end

      private

      def set_followed
        @followed = User.find(params[:user_id])
      end
    end
  end
end
