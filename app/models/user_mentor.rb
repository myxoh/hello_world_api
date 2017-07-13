class UserMentor < ApplicationRecord
  belongs_to :mentor
  belongs_to :mentee
end
