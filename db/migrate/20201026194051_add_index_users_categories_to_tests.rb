class AddIndexUsersCategoriesToTests < ActiveRecord::Migration[6.0]
  
  def change
    # already exist
    # add_index :tests, :author_id
    # add_index :tests, :category_id
    # add_index :tests, %i[title level], unique: true
  end

end
