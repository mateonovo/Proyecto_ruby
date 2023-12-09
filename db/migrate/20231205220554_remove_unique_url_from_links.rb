class RemoveUniqueUrlFromLinks < ActiveRecord::Migration[7.1]
  def change
    remove_column :links, :unique_url, :string
  end
end
