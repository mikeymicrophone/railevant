module ConceptsHelper
  def railser_link railser = current_railser
    railser = railser.railser if railser.is_a?(ActiveRecord::Base) && !railser.is_a?(Railser)
    link_to railser.name, railser, :class => 'railser', :id => railser.dom_id('visit_' + railser.login)
  end
  
  def collection_path concept = Concept.new
    controller.send(concept.class.name.downcase.pluralize + '_path', :class => 'collection', :id => concept.class.name.downcase.pluralize + ' gathered')
  end
  
  def links_to_rails concept
    concept.cached_rails.map { |r| link_to r.content, r, :class => 'rail', :id => r.dom_id('scrutinize') }.join('*~._.~*')
  end
  
  def links_to_ties concept
    concept.cached_ties.map { |t| link_to t.content, t, :class => 'tie', :id => t.dom_id('scrutinize') }.join('\|/|\|/')
  end
end
