class User < ApplicationRecord
  has_many :user_interests
  has_many :interests, through: :user_interests

  has_many :user_skills
  has_many :skills, through: :user_skills

  has_many :mentee_connections, foreign_key: :mentor_id, class_name: "UserMentor"
  has_many :mentor_connections, foreign_key: :mentee_id, class_name: "UserMentor"

  has_many :mentors, through: :mentor_connections,  class_name: "User"
  has_many :mentees, through: :mentee_connections,  class_name: "User"
end
