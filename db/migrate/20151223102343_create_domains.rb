class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.integer :user_id
      t.string :name
      t.integer :words, default: 0
      t.integer :requests, default: 0

      t.timestamps
    end
  end
end
