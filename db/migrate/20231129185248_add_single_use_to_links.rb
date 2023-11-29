class AddSingleUseToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :single_use, :boolean, default: false, null: false
  end
end
