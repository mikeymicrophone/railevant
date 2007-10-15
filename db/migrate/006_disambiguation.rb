class Disambiguation < ActiveRecord::Migration
  def self.up
    add_column :concepts, :ambiguous, :text
  end

  def self.down
    remove_column :concepts, :ambiguous
  end
end
