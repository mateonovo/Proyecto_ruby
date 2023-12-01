class CreateLinkAccesses < ActiveRecord::Migration[7.1]
  def change
    create_table :link_accesses do |t|
      t.references :link, foreign_key: true
      t.datetime :access_time
      t.string :ip_address
      t.timestamps
    end
  end
end
