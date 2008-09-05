class ConceptsController < ApplicationController
  def index
    Concept # this loads the names of all the subclasses defined in the file concept.rb
    @concepts = request.request_uri[1..-1].singularize.capitalize.constantize.send(:all, :limit => params[:population])
    rescue NameError
      []
    @concepts = Concept.all :limit => params[:population] if @concepts.blank?
  end
  
  def show
    @concept = Concept.find_by_effective_uri params[:id]
    @concepts = @concept.ambiguities
    # generate link to mark the last concepts seen as railevant to this one
    @last_few = Concept.find(*Rails.cache.read('last_few')) || []
    last_few = Rails.cache.read('last_few').dup || []
    unless last_few.include? @concept.id
      last_few.shift if last_few.length >= 5
      last_few.push @concept.id
    end
    Rails.cache.write('last_few', last_few)
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
      # debugger
      @concept = Concept.new params[:concept]
      @concept.type = params[:class][:name]
      respond_to do |format|
        if @concept.save
          flash[:notice] = 'concept was created. very successfully indeed.'
          format.html { redirect_to @concept }
          format.xml  { render :xml => @concept, :status => :created, :location => @concept }
        else
          format.html { render :action => 'new' }
          format.xml  { render :xml => @concept.errors, :status => :unprocessable_entity }
        end
      end
    end
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
