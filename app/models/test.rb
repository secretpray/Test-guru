class Test < ApplicationRecord
  belongs_to :category
  has_many  :questions, dependent: :destroy
  has_many :tests_users
  # has_and_belongs_to_many :users
  has_many :users, through: :tests_users
  belongs_to :author, class_name: 'User', foreign_key: 'author_id' # pp Test.where(author_id: 2)

  def self.by_category(category)
    Test.joins(:category).where(categories: {title: category.to_s}).order(title: :desc).pluck(:title) # sort by name
    #Test.joins(:category).where(categories: {title: category.to_s}).order(id: :desc) # sort by id
  end
end
