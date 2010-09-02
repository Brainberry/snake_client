class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.string :message
      t.string :namespace
      t.string :url
      t.string :controller_name
      t.string :action_name
      t.string :host
      
      t.text :environment
      t.text :request
      t.text :session
      t.text :backtrace
      
      t.integer :state, :limit => 1, :default => 0
      t.integer :comments_count, :default => 0
      t.integer :copies_count, :default => 0
      
      t.integer :parent_id
      t.integer :project_id, :null => false
      t.string  :public_key, :limit => 40, :null => false
      t.integer :member_id
      
      t.timestamps
    end
    
    add_index :issues, [:project_id, :public_key], :uniq => true
    add_index :issues, :state
  end

  def self.down
    drop_table :issues
  end
end
