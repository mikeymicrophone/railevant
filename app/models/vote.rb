class Vote < ActiveRecord::Base
  belongs_to :railser
  belongs_to :concept
  belongs_to :railevance
  validates_presence_of :rating
  
  def characteristic
    concept.characteristic characteristic_id if concept && characteristic
  end
  
  def other_votes_by_railser
    railser.votes
  end
  
  def other_votes_on_concept
    concept.votes if concept
  end
  
  def other_votes_on_railevance
    railevance.votes if railevance
  end
  
  # deletes an earlier vote on the same stuff by the same person
  def destroy_previous_if_exists
    votes_on_this_object = Vote.find :all, :conditions => {:railser_id => railser_id, :concept_id => concept_id, :railevance_id => railevance_id, :characteristic_id => characteristic_id}
    if votes_on_this_object.length > 1
      (votes_on_this_object - self).each &:destroy
    end
  end
  
  # what that user thought of that thing before they changed their mind
  def previous
    all = Vote.find_with_deleted :all, :conditions => {:railser_id => railser_id, :concept_id => concept_id, :railevance_id => railevance_id, :characteristic_id => characteristic_id}
    all.sort_by(&:created_at)[-2]
  end

end
