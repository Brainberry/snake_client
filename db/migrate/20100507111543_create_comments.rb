class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string   :user_name,        :limit => 50
      t.string   :user_email,       :limit => 50
      t.text     :content,                                        :null => false
      t.text     :content_html
      t.integer  :user_id
      t.integer  :commentable_id,                 :default => 0,  :null => false
      t.string   :commentable_type, :limit => 15, :default => "", :null => false
      t.boolean  :is_follow,                      :default => false
      
      t.timestamps
    end
    
    add_index :comments, :user_id
    add_index :comments, [:commentable_type, :commentable_id]
  end

  def self.down
    drop_table :comments
  end
end
