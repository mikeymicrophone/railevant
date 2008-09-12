class RecursiveRailevances < ActiveRecord::Migration
  def self.up
    add_column :railevances, :rail_r_id, :integer
    add_column :railevances, :tie_r_id, :integer
    add_column :railevances, :rail_rs_ids, :string
    add_column :railevances, :tie_rs_ids, :string
    add_column :railevances, :rails_ids, :string
    add_column :railevances, :ties_ids, :string
    add_column :concepts, :rail_rs_ids, :string
    add_column :concepts, :tie_rs_ids, :string
  end

  def self.down
    remove_column :railevances, :rail_r_id
    remove_column :railevances, :tie_r_id
    remove_column :railevances, :rail_rs_ids
    remove_column :railevances, :tie_rs_ids
    remove_column :railevances, :rails_ids
    remove_column :railevances, :ties_ids
    remove_column :concepts, :rail_rs_ids
    remove_column :concepts, :tie_rs_ids
  end
end
