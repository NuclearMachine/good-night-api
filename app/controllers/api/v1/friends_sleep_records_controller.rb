module Api
  module V1
    class FriendsSleepRecordsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def index
        friends_sleep_records = current_api_v1_user.friends_weekly_record
        render json: friends_sleep_records
      end
    end
  end
end
