class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :slug
      t.string :url, null: false  # Hace que el campo sea obligatorio
      t.integer :user_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :link_category
      t.string :unique_url
      t.string :expires_at
      t.string :password_digest

      t.index [:user_id], name: "index_links_on_user_id"
    end

    add_foreign_key :links, :users
  end
end
