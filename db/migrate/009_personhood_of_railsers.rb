class PersonhoodOfRailsers < ActiveRecord::Migration
  def self.up
    add_column :railsers, :person_id, :integer
  end

  def self.down
    remove_column :railsers, :person_id
  end
end
