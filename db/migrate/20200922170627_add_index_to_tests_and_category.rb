class AddIndexToTestsAndCategory < ActiveRecord::Migration[6.0]
  def change
    add_index :tests, [:title, :level], unique: true
    add_index :categories, :title, unique: true
  end
end
