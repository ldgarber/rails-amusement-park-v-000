class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| 
      t.string :name
      t.integer :password_digest
      t.integer :nausea
      t.integer :happiness
      t.integer :tickets
      t.integer :height
      t.integer :role
    end
  end
end
