class Test < ApplicationRecord
  belongs_to :category
  # for test -> Test.by_category(:frontend) or Test.by_category('backend') 
  def self.by_category(category)
    Test.joins(:category).where(categories: {title: category.to_s}).order(title: :desc).pluck(:title) # sort by name
    #Test.joins(:category).where(categories: {title: category.to_s}).order(id: :desc) # sort by id
  end
end
