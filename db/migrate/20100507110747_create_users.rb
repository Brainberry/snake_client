class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :null => false, :limit => 50      
      t.string :name, :limit => 150
      t.integer :role_type_id, :limit => 1
      
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :time
      
      t.string :identifier, :limit => 150
            
      t.timestamps
    end
    
    add_index :users, :login,                :unique => true
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :role_type_id
  end

  def self.down
    drop_table :users
  end
end
