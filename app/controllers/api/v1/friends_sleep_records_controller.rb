module Api
  module V1
    class FriendsSleepRecordsController < ApplicationController
      before_action :authenticate_user!

      def index
        friends_sleep_records = current_user.friends_sleep_records_past_week_ordered_by_duration
        render json: friends_sleep_records
      end
    end
  end
end