module ConceptsHelper
  def railser_link(railser = current_railser)
    if railser.is_a?(ActiveRecord::Base) && !railser.is_a?(Railser)
      railser = railser.railser # if the object passed in is a concept or a vote or a railevance
    end
    link_to railser.name, railser
  end
end
