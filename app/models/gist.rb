
class Gist < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :gist_url, presence: true
  validates :user, presence: true
  validates :question, presence: true
end
