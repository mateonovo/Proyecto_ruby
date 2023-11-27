class ChangeexpireAtTypeToString < ActiveRecord::Migration[7.1]
  def change
    change_column :links, :expires_at, :string
  end
end
