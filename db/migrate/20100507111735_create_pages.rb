class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string    :title, :null=>false
      t.string    :slug, :limit => 30, :null => false
      t.text      :content
      
      t.timestamps
    end
    
    add_index :pages, :slug, :uniq => true
  end

  def self.down
    drop_table :pages
  end
end
