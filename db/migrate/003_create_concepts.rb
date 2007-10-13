class CreateConcepts < ActiveRecord::Migration
  def self.up
    create_table :concepts do |t|
      t.string :type
      t.text :content
      t.text :character
      t.integer :bits
      t.integer :railser_id
      t.datetime :deleted_at

      t.timestamps 
    end
  end

  def self.down
    drop_table :concepts
  end
end
