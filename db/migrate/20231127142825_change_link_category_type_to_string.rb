class ChangeLinkCategoryTypeToString < ActiveRecord::Migration[7.1]
  def change
    change_column :links, :link_category, :string
  end
end
