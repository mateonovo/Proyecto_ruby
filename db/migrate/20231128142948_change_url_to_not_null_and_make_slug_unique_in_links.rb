class ChangeUrlToNotNullAndMakeSlugUniqueInLinks < ActiveRecord::Migration[7.1]
  def change
    # Modifica la columna url para que sea no nula
    change_column :links, :url, :string, null: false

    # Agrega una restricción de unicidad a la columna slug
    add_index :links, :slug, unique: true
  end
end
