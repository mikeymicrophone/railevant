class Concept < ActiveRecord::Base
end
class Library < Concept
end
class Tool < Concept
end
class Feature < Concept
end
class Directory < Concept
end
class Railevance < ActiveRecord::Base
end
class CacheRailevances < ActiveRecord::Migration
  def self.up
    add_column :concepts, :rails_ids, :text
    add_column :concepts, :ties_ids, :text
  
    Railevance.find(:all).each do |r|
      (rail = Concept.find(r.rail_id)).update_attribute(:ties_ids, (rail.ties_ids ? (rail.ties_ids + ' ') : '').concat(r.tie_id.to_s))
      (tie = Concept.find(r.tie_id)).update_attribute(:rails_ids, (tie.rails_ids ? (tie.rails_ids + ' ') : '').concat(r.rail_id.to_s))
      rail.save; tie.save
    end
    
  end

  def self.down
    remove_column :concepts, :rails_ids
    remove_column :concepts, :ties_ids
  end
end
