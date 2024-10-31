class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, foreign_key: "creator_id", class_name: "Post"
  has_many :attending_posts, foreign_key: "attendee_id", class_name: "Post"
end
