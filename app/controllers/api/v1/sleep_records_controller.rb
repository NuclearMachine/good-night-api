module Api
  module V1
    class SleepRecordsController < ApplicationController
      before_action :authenticate_user!

      def create
        sleep_record = current_user.sleep_records.build(sleep_record_params)
        if sleep_record.save
          render json: sleep_record, status: :created
        else
          render json: { errors: sleep_record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        sleep_records = current_user.sleep_records.order(created_at: :desc)
        render json: sleep_records
      end

      private

      def sleep_record_params
        params.require(:sleep_record).permit(:start_time, :end_time)
      end
    end
  end
end
