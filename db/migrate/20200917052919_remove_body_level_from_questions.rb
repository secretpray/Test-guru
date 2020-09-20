class RemoveBodyLevelFromQuestions < ActiveRecord::Migration[6.0]
  def up
    remove_column :questions, :level
  end

  def down
    add_column :questions, :level, :integer
  end
end
