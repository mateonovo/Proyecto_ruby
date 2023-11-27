class AddUniqueUrlToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :unique_url, :string
  end
end
