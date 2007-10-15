module ConceptsHelper
  def railser_link(railser = current_railser)
    if railser.is_a?(ActiveRecord::Base) && !railser.is_a?(Railser)
      railser = railser.railser # if the object passed in is a concept or a vote or a railevance
    end
    link_to railser.name, railser
  end
  
  def collection_path(concept = Concept.new)
    controller.send(concept.class.name.downcase.pluralize + '_path')
  end
  
  def links_to_rails(concept)
    concept.cached_rails.map { |r| link_to r.content, r }.join('*~._.~*')
  end
  
  def links_to_ties(concept)
    concept.cached_ties.map { |t| link_to t.content, t }
  end
end
