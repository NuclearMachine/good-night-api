require 'rails_helper'

RSpec.describe "Api::V1::FriendsSleepRecords", type: :request do
  let(:user) { create(:user) }
  let(:friend1) { create(:user) }
  let(:friend2) { create(:user) }

  before do
    create(:following, follower: user, followed: friend1)
    create(:following, follower: user, followed: friend2)
    create(:sleep_record, user: friend1, start_time: 2.days.ago, end_time: 2.days.ago + 9.hours)
    create(:sleep_record, user: friend2, start_time: 4.days.ago, end_time: 4.days.ago + 7.hours)
    create(:sleep_record, user: friend2, start_time: 10.days.ago, end_time: 10.days.ago + 8.hours)
  end

  describe 'GET #index' do
    context 'when user is not signed in' do
      it 'returns unauthorized status' do
        get api_v1_friends_sleep_records_path
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is signed in' do
      before do
        get api_v1_friends_sleep_records_path, headers: auth_headers_for(user)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns friends sleep records from past week ordered by duration' do
        records = JSON.parse(response.body)
        expect(records.size).to eq(2)
        expect(records[0]['user_id']).to eq(friend1.id)
        expect(records[1]['user_id']).to eq(friend2.id)
      end
    end
  end
end
