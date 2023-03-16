# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { expect(subject).to be_valid }

  describe 'associations' do
    it { should have_many(:sleep_records).dependent(:destroy) }

    it { should have_many(:active_followings).class_name('Following').with_foreign_key('follower_id') }
    it { should have_many(:followeds).through(:active_followings).source(:followed) }

    it { should have_many(:passive_followings).class_name('Following').with_foreign_key('followed_id') }
    it { should have_many(:followers).through(:passive_followings).source(:follower) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  it 'returns sleep records of friends in the past week ordered by duration' do
    user = create(:user)
    friend1 = create(:user)
    friend2 = create(:user)
    create(:following, follower: user, followed: friend1)
    create(:following, follower: user, followed: friend2)

    friend1_record = create(:sleep_record, user: friend1, start_time: 2.days.ago, end_time: 2.days.ago + 9.hours)
    friend2_record = create(:sleep_record, user: friend2, start_time: 4.days.ago, end_time: 4.days.ago + 7.hours)
    create(:sleep_record, user: friend2, start_time: 10.days.ago, end_time: 10.days.ago + 8.hours)

    expected_result = [friend1_record, friend2_record]
    actual_result = user.friends_sleep_records_past_week_ordered_by_duration.to_a

    expect(actual_result).to eq(expected_result)
  end
end
