class AddEncryptedPasswordToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :encrypted_password, :string
  end
end
