class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :rating
      t.integer :concept_id
      t.integer :railevance_id
      t.string :characteristic_id
      t.integer :railser_id
      t.datetime :deleted_at

      t.timestamps 
    end
  end

  def self.down
    drop_table :votes
  end
end
