class Question < ApplicationRecord
  belongs_to :test
  has_many  :answers

  validates :body, presence: true
  validates_uniqueness_of :body, on: [ :create, :update ]
end
