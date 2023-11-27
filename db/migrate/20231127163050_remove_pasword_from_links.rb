class RemovePaswordFromLinks < ActiveRecord::Migration[7.1]
  def change
    remove_column :links, :encrypted_password, :string
  end
end
