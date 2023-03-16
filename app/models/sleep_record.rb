class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :end_time_after_start_time

  before_save :calculate_duration

  scope :past_week, -> { where('start_time >= ?', 1.week.ago) }
  scope :ordered_by_duration, -> { order(duration: :desc) }

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    return unless end_time < start_time

    errors.add(:end_time, 'must be after the start time')
  end

  def calculate_duration
    self.duration = end_time - start_time
  end
end
