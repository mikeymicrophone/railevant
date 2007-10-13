class CreateRailevances < ActiveRecord::Migration
  def self.up
    create_table :railevances do |t|
      t.integer :rail_id
      t.integer :tie_id
      t.integer :railser_id
      t.datetime :deleted_at

      t.timestamps 
    end
  end

  def self.down
    drop_table :railevances
  end
end
