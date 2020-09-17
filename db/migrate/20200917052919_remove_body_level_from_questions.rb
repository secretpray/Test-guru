class RemoveBodyLevelFromQuestions < ActiveRecord::Migration[6.0]
  def up
    remove_column :questions, :level
    remove_column :questions, :body
  end

  def down
    add_column :questions, :level, :integer
    add_column :questions, :body, :string
  end
end
