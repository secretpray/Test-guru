class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'Admin', foreign_key: 'author_id'
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  validates :title, presence: true, uniqueness: { case_sensitive: false,
                                                  scope: :level,
                                                  message: 'Test title and level not unique' }
  validates :level, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0 } # unless less_than: 0

  scope :easy, -> { by_level(0..1) } 
  scope :medium, -> { by_level(2..4) }
  scope :hard, -> { by_level(5..Float::INFINITY) } 
  scope :by_level, -> (level) { where(level: level) }
  scope :by_category, -> (category) { joins(:category).where(categories: {title: category.to_s}) }

  def self.sorted_names_by_category(category, sort = :asc)
    by_category(category).order(title: sort.to_sym).pluck(:title)
  end

  def self.name_sorted(sort = :asc)
    order(title: sort.to_sym).pluck(:title)
  end
end

