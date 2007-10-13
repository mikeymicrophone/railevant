class ConceptsController < ApplicationController
  def index
    Concept
    @concepts = request.request_uri[1..-1].singularize.capitalize.constantize.send(:all)
    @concepts = Concept.all if @concepts.empty?
  end
  
  def show
    @concept = Concept.find params[:id]
  end
  
  def new
    @concept = Concept.new
    @types = RESOURCES.map { |w| [ w, w.capitalize ] }
  end
  
  def create
    @concept = Concept.new params[:concept]
    @concept.type = params[:class][:name]
    @concept.save
    redirect_to @concept
  end
  
  def edit
    @concept = Concept.find params[:id]
    @types = RESOURCES.map { |w| [ w, w.capitalize ] }
  end
  
  def update
    @concept = Concept.find params[:id]
    @concept.update_attributes params[:concept]
    @concept.update_attribute :type, params[:class][:name]
    redirect_to @concept
  end
  
  def destroy
    @concept = Concept.find params[:id]
    @concept.destroy
  end
end
