class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :username

      t.index [:email], name: "index_users_on_email", unique: true
      t.index [:reset_password_token], name: "index_users_on_reset_password_token", unique: true
      t.index [:username], name: "index_users_on_username", unique: true
    end
  end
end
