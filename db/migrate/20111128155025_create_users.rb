class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :doorkeeper_uid
      t.string :doorkeeper_access_token
      t.string :email
	  
      t.boolean :admin
	  t.string :locale, :default => :en
	  t.string :time_zone, :default => "UTC"

      t.timestamps
    end
  end
end
