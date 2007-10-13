class Railevance < ActiveRecord::Base
  belongs_to :rail, :class_name => 'Concept'
  belongs_to :tie, :class_name => 'Concept'
  belongs_to :railser
end
