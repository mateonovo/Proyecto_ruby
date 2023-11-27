class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :slug
      t.string :url
      t.string :link_category
      t.datetime :expires_at
      t.string :password
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
class ChangeLinkCategoryTypeToString < ActiveRecord::Migration[7.1]
  def change
    change_column :links, :link_category, :string
  end
end
