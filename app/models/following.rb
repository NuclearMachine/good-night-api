class Following < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :not_following_self

  private

  def not_following_self
    return unless follower_id == followed_id

    errors.add(:follower_id, "can't follow oneself")
  end
end
