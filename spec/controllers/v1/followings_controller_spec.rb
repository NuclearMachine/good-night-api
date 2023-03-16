require 'rails_helper'

RSpec.describe "Api::V1::Followings", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'POST #create' do
    context 'when user is not signed in' do
      it 'returns unauthorized status' do
        post api_v1_followings_path, params: { followed_id: other_user.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is signed in' do
      it 'creates a new following' do
        expect {
          post api_v1_followings_path, params: { followed_id: other_user.id }, headers: auth_headers_for(user)
        }.to change(Following, :count).by(1)
      end

      it 'returns http success' do
        post api_v1_followings_path, params: { followed_id: other_user.id }, headers: auth_headers_for(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:following) { create(:following, follower: user, followed: other_user) }

    context 'when user is not signed in' do
      it 'returns unauthorized status' do
        delete api_v1_following_path(following)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is signed in' do
      it 'deletes the following' do
        expect {
          delete api_v1_following_path(following), headers: auth_headers_for(user)
        }.to change(Following, :count).by(-1)
      end

      it 'returns http success' do
        delete api_v1_following_path(following), headers: auth_headers_for(user)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
