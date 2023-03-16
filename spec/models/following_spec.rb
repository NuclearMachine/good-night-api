# spec/models/following_spec.rb

require 'rails_helper'

RSpec.describe Following, type: :model do
  let(:following) { build(:following) }

  context 'associations' do
    it 'belongs to follower' do
      expect(following).to belong_to(:follower).class_name('User')
    end

    it 'belongs to followed' do
      expect(following).to belong_to(:followed).class_name('User')
    end
  end

  context 'validations' do
    it 'validates uniqueness of follower scoped to followed' do
      expect(following).to validate_uniqueness_of(:follower_id).scoped_to(:followed_id)
    end

    it 'does not allow users to follow themselves' do
      user = create(:user)
      invalid_following = build(:following, follower: user, followed: user)
      expect(invalid_following).not_to be_valid
      expect(invalid_following.errors[:follower_id]).to include("can't follow oneself")
    end
  end
end
