module ConceptsHelper
  def railser_link railser = current_railser, opts = {}
    if railser.is_a?(ActiveRecord::Base) && !railser.is_a?(Railser)
      return '' unless railser.railser
      railser = railser.railser
    end
    link_to railser.name, railser, {:class => 'railser', :id => railser.dom_id('visit_' + railser.login)}.reverse_merge(opts)
  end
  
  def collection_path concept = Concept.new
    concept_type = concept.type || 'Concept'
    controller.send concept_type.to_s.downcase.pluralize + '_path'
  end
  
  def links_to_rails concept
    concept.cached_rails.map { |r| link_to r.content, r, :class => 'rail', :id => r.dom_id('scrutinize') }.join('*~._.~*')
  end
  
  def links_to_ties concept
    concept.cached_ties.map { |t| link_to t.content, t, :class => 'tie', :id => t.dom_id('scrutinize') }.join('\|/|\|/')
  end
  
  def link_to_concept concept
    link_to concept.effective_uri, concept, :id => concept.dom_id('link_to'), :class => concept.class.name.downcase
  end
end
