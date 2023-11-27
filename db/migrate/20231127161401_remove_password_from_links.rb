class RemovePasswordFromLinks < ActiveRecord::Migration[7.1]
  def change
    remove_column :links, :password, :string
  end
end
