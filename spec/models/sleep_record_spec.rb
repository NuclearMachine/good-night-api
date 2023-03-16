require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  subject { build(:sleep_record) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }

  describe 'end_time_after_start_time validation' do
    context 'when end_time is before start_time' do
      it 'is not valid' do
        subject.start_time = Time.current
        subject.end_time = Time.current - 1.hour
        expect(subject).not_to be_valid
        expect(subject.errors[:end_time]).to include('must be after the start time')
      end
    end

    context 'when end_time is after start_time' do
      it 'is valid' do
        subject.start_time = Time.current
        subject.end_time = Time.current + 1.hour
        expect(subject).to be_valid
      end
    end
  end

  describe 'duration calculation' do
    it 'calculates duration before save' do
      sleep_record = build(:sleep_record, start_time: Time.current, end_time: Time.current + 7.hours)
      expect(sleep_record.duration).to be_nil

      sleep_record.save!
      expect(sleep_record.duration).to eq(7.hours.to_i)
    end
  end
end
