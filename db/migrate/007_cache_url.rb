class CacheUrl < ActiveRecord::Migration
  def self.up
    add_column :concepts, :uri, :string
  end

  def self.down
    remove_column :concepts, :uri
  end
end
