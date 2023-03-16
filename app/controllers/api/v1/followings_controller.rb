module Api
  module V1
    class FollowingsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        following = current_api_v1_user.active_followings.build(followed_id: params[:followed_id])
        if following.save
          render json: { message: 'Following created successfully' }, status: :created
        else
          render json: { errors: following.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        following = current_api_v1_user.active_followings.find(params[:id])
        if following.destroy
          render json: { message: 'Following removed successfully' }, status: :ok
        else
          render json: { errors: following.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
