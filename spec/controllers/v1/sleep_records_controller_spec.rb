require 'rails_helper'

RSpec.describe "Api::V1::SleepRecords", type: :request do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'when user is not signed in' do
      it 'returns unauthorized status' do
        post api_v1_sleep_records_path, params: { start_time: 1.day.ago, end_time: Time.now }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is signed in' do
      it 'creates a new sleep record' do
        expect {
          post api_v1_sleep_records_path, params: { start_time: 1.day.ago, end_time: Time.now }, headers: auth_headers_for(user)
        }.to change(SleepRecord, :count).by(1)
      end

      it 'returns http success' do
        post api_v1_sleep_records_path, params: { start_time: 1.day.ago, end_time: Time.now }, headers: auth_headers_for(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #index' do
    let!(:sleep_record1) { create(:sleep_record, user: user, start_time: 2.days.ago, end_time: 1.day.ago) }
    let!(:sleep_record2) { create(:sleep_record, user: user, start_time: 1.day.ago, end_time: Time.now) }

    context 'when user is not signed in' do
      it 'returns unauthorized status' do
        get api_v1_sleep_records_path
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is signed in' do
      it 'returns sleep records ordered by created_at' do
        get api_v1_sleep_records_path, headers: auth_headers_for(user)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to eq(2)
        expect(parsed_response.first["id"]).to eq(sleep_record2.id)
        expect(parsed_response.second["id"]).to eq(sleep_record1.id)
      end

      it 'returns http success' do
        get api_v1_sleep_records_path, headers: auth_headers_for(user)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
