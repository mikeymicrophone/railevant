class Railevance < ActiveRecord::Base
  belongs_to :rail, :class_name => 'Concept'
  belongs_to :tie, :class_name => 'Concept'
  belongs_to :railser
  has_many :votes
  
  after_create :cache_in_rail_and_tie
  
  def cache_in_rail_and_tie
    rail.cache_tie tie_id
    tie.cache_rail rail_id
  end
end
