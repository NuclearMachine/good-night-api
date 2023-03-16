require 'rails_helper'

RSpec.describe Api::V1::SleepRecordsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { sleep_record: attributes_for(:sleep_record) } }

      it 'creates a new sleep record' do
        expect {
          post :create, params: valid_params
        }.to change(SleepRecord, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { sleep_record: attributes_for(:sleep_record, start_time: nil) } }

      it 'does not create a new sleep record' do
        expect {
          post :create, params: invalid_params
        }.not_to change(SleepRecord, :count)
      end

      it 'returns an unprocessable_entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    let!(:sleep_record) { create(:sleep_record, user: user) }

    it 'returns sleep records for the current user' do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.first['id']).to eq(sleep_record.id)
    end
  end
end
