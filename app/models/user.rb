class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  include DeviseTokenAuth::Concerns::User

  # Associations
  has_many :sleep_records, dependent: :destroy

  # Following associations
  has_many :active_followings, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :followeds, through: :active_followings, source: :followed

  has_many :passive_followings, class_name: 'Following', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_followings, source: :follower

  has_many :friends_sleep_records, through: :followeds, source: :sleep_records

  # Validations
  validates :name, presence: true

  def friends_weekly_record
    friends_sleep_records.past_week.ordered_by_duration
  end
end
