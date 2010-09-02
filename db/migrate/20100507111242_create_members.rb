class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer :role_type_id, :limit => 1, :default => 0
      t.integer :user_id, :null => false
      t.integer :project_id, :null => false
      t.integer :state, :default => 0
      
      t.timestamps
    end
    
    add_index :members, [:project_id, :user_id], :uniq => true
    add_index :members, :state
  end

  def self.down
    drop_table :members
  end
end
