class CreateUsersBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :users_badges do |t|
      t.references :badge, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
