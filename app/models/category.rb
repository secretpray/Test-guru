class Category < ApplicationRecord
  has_many :tests, dependent: :destroy

  default_scope { order(title: :asc) }

  validates :title, presence: true, uniqueness: true

end
