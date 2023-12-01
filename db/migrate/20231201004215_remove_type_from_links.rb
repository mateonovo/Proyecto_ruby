class RemoveTypeFromLinks < ActiveRecord::Migration[7.1]
  def change
    remove_column :links, :type, :string
  end
end
