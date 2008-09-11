class ConceptsController < ApplicationController
  def index
    Concept # this loads the names of all the subclasses defined in the file concept.rb
    path = request.request_uri[1..-1]
    @category = path.blank? ? Concept : path.singularize.capitalize.constantize
    @concepts = @category.send(:all, :limit => params[:population])
    @types = RESOURCES.map { |w| [ w, w.capitalize ] }
    rescue NameError
    @concepts = Concept.all :limit => params[:population] if @concepts.blank?
  end
  
  def show
    @concept = Concept.find_by_effective_uri params[:id]
    @concepts = @concept.ambiguities
    # generate link to mark the last concepts seen as railevant to this one
    if last_few = Rails.cache.read('last_few')
      last_few = last_few.dup
      @last_few = Concept.find(*last_few).to_a
    else
      @last_few = []
      last_few = []
    end
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
    params[:concept] ||= params[params[:class][:name].downcase.to_sym]
    @concept = Concept.find_by_content_and_type params[:concept][:content], params[:class][:name]
    unless @concept
      @concept = Concept.new params[:concept]
      @concept.type = params[:class][:name]
      respond_to do |format|
        if @concept.save
          params[:characteristic].select { |k, v| k =~ /key/ }.each do |k, v|
            k =~ /key_(\d+)/
            identifier = $1
            @concept.characterize params[:characteristic]["key_#{identifier}"] => params[:characteristic]["value_#{identifier}"]
          end
          format.html { redirect_to @concept }
          format.js   { render :partial => @concept }
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
  
  def characteristic
    the_time = Time.now
    identifier = the_time.hour.to_s + the_time.min.to_s + the_time.sec.to_s
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
