require 'rails_helper'

RSpec.describe Api::V1::FollowingsController, type: :controller do
  let(:user) { create(:user) }
  let(:followed) { create(:user) }
  before { sign_in user }

  describe 'POST #create' do
    it 'creates a new following relationship' do
      expect {
        post :create, params: { user_id: followed.id }
      }.to change(Following, :count).by(1)
    end

    it 'returns a created status' do
      post :create, params: { user_id: followed.id }
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE #destroy' do
    let!(:following) { create(:following, follower: user, followed: followed) }

    it 'destroys the requested following relationship' do
      expect {
        delete :destroy, params: { user_id: followed.id }
      }.to change(Following, :count).by(-1)
    end

    it 'returns a no_content status' do
      delete :destroy, params: { user_id: followed.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
