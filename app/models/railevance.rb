class Railevance < ActiveRecord::Base
  belongs_to :rail, :class_name => 'Concept'
  belongs_to :tie, :class_name => 'Concept'
  belongs_to :rail_r, :class_name => 'Railevance'
  belongs_to :tie_r, :class_name => 'Railevance'
  belongs_to :railser
  serialize :rails_ids, Array
  serialize :ties_ids, Array
  serialize :rail_rs_ids, Array
  serialize :tie_rs_ids, Array
  has_many :votes
  
  after_create :cache_in_components
  
  def cache_in_components
    extant_connections.each do |name, number|
      send(name).cache_connections extant_connections.delete_if { |k, v| k == name }
    end
  end
  
  def cache_connections set
    set.each { |k, v| cache_connection((k.to_s + 's_ids').to_sym, v) }
  end
  
  def cache_connection collection, connected_id
    existing = send(collection) || []
    update_attribute collection, existing.push(connected_id) unless existing.include?(connected_id)
  end
  
  def extant_connections
    full_set = {:rail => rail_id, :tie => tie_id, :rail_r => rail_r_id, :tie_r => tie_r_id}
    full_set.delete_if { |key, value| value.blank? }
  end
  
  def cached_rails
    rails_ids.blank? ? [] : Concept.find(*rails_ids).to_a
  end
  
  def cached_ties
    ties_ids.blank? ? [] : Concept.find(*ties_ids).to_a    
  end
  
  def cached_rail_rs
    rail_rs_ids.blank? ? [] : Railevance.find(*rail_rs_ids).to_a
  end
  
  def cached_tie_rs
    tie_rs_ids.blank? ? [] : Railevance.find(*tie_rs_ids).to_a
  end
end
