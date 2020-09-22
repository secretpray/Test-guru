class Test < ApplicationRecord
  belongs_to :category
  has_many  :questions, dependent: :destroy
  has_many :tests_users
  has_many :users, through: :tests_users
  belongs_to :author, class_name: 'User', foreign_key: 'author_id' # pp Test.where(author_id: 2)

  validates :title, presence: true
  validates :level, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0 } # unless less_than: 0
  validates :category_id, presence: true,
                    numericality: { only_integer: true }
  validates_uniqueness_of :title, scope: :level # validates :title, uniqueness: { scope: :level }

  scope :easy, -> { by_level(0..1) } # where(level: [0,1])
  scope :medium, -> { by_level(2..4) } # where(level: [2,3,4])
  scope :hard, -> { by_level(5..Float::INFINITY) } # where(level: [5..Float::INFINITY]) or where(level: (5..))
  scope :by_level, -> (level) { where(level: level) }
  scope :by_category, -> (category) { joins(:category).where(categories: {title: category.to_s}).order(title: :desc) } # Test.by_category(:backend).pluck(:title)
end