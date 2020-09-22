class Category < ApplicationRecord
  has_many :tests

  default_scope { order(title: :asc) }
  # scope :list, -> { order(:title) } # order(title: :asc) or order("title ASC") + .pluck(:title)

  validates :title, presence: true
  validates_uniqueness_of :title, on: [ :create, :update ]
end
