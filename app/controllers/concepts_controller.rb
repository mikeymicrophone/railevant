class ConceptsController < ApplicationController
  def index
    Concept
    @concepts = request.request_uri[1..-1].singularize.capitalize.constantize.send(:all, :limit => params[:population])
    rescue NameError
      []
    @concepts = Concept.all :limit => params[:population] if @concepts.blank?
  end
  
  def show
    @concept = Concept.find_by_effective_uri params[:id]
    @concepts = @concept.ambiguities
  end
  
  def submit
    @existing = Concept.find_by_content params[:concept][:content]
    @types = RESOURCES.map { |w| [ w, w.capitalize ] }
    @concept = Concept.new :content => params[:concept][:content] unless @existing
  end
  
  def new
    @concept = Concept.new
    @types = RESOURCES.map { |w| [ w, w.capitalize ] }
  end
  
  def create
    @concept = Concept.find_by_content_and_type params[:concept][:content], params[:class][:name]
    unless @concept
      @concept = Concept.new params[:concept]
      @concept.type = params[:class][:name]
      @concept.save
    end
    redirect_to @concept
  end
  
  def reconceptualize
    @c = Concept.find_by_effective_uri(params[:id])
    @concept = Concept.new :content => @c.content, :uri => @c.uri, :ambiguous => @c.ambiguous
    @concept.type = params[:name]
    @concept.save
    @concept.disambiguate_with @c
    redirect_to @concept
  end
  
  def characterize
    @concept = Concept.find_by_effective_uri params[:id]
    key, value = params[:characteristic].split(':')
    @concept.characterize key => value
    render :partial => 'characteristic', :object => @concept.characteristic(key), :locals => {:key => key}
  end
  
  def edit
    @concept = Concept.find_by_effective_uri params[:id]
    @types = RESOURCES.map { |w| [ w, w.capitalize ] }
  end
  
  def update
    @concept = Concept.find_by_effective_uri params[:id]
    @concept.update_attributes params[:concept]
    @concept.update_attribute :type, params[:class][:name]
    redirect_to @concept
  end
  
  def destroy
    @concept = Concept.find_by_effective_uri params[:id]
    @concept.destroy
  end
end
