class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :event_attendings, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_attendings, source: :attendee, dependent: :destroy

  # def self.past
  #   where(date: ..Time.now.midnight-1.day)
  # end

  # def self.upcoming
  #   where(date: Time.now ..)
  # end
  #
  # Refactor to scope
  scope :past, -> { where(date: ..Time.now.midnight-1.day) }
  scope :upcoming, -> { where(date: Time.now ..) }
end
