class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title, :null => false
      t.text :notes
      t.integer :issues_count, :default => 0
      t.string :public_key, :null => false, :limit => 25
      t.integer :user_id
      
      t.timestamps
    end
    
    add_index :projects, :public_key, :uniq => true
    add_index :projects, :user_id
  end

  def self.down
    drop_table :projects
  end
end
