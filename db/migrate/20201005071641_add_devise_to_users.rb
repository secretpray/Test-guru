# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[6.0]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
    end

    remove_column(:users, :password_digest)
    change_column_default(:users, :email, '')

    # add_index :users, :email,                unique: true # already present
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # All existing user accounts should be able to log in after this.
    User.update_all confirmed_at: DateTime.now
    # add_index :users, :unlock_token,         unique: true
  end

  def self.down
    remove_columns(:users, :encrypted_password, :reset_password_token, :reset_password_sent_at,
                           :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at,
                           :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at,
                           :confirmation_sent_at, :unconfirmed_email)
    add_column :users, :password_digest, :string
    remove_index(:users, :email)
    change_column_default(:users, :email, nil)
  end
end
