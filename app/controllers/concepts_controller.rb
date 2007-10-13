class ConceptsController < ApplicationController
  def index
    Concept
    @concepts = request.request_uri[1..-1].singularize.capitalize.constantize.send(:find, :all)
    @concepts = Concept.find :all if @concepts.empty?
  end
  
  def show
    @concept = Concept.find params[:id]
  end
  
  def new
    @concept = Concept.new
    @types = %w[dependency combination trait compatibility directory library api feature release version license script file klass project revision incompatibility block line mojule keyword tool command recipe routine methid variable constant expression strin statement join snippet example argument structure symbl alias query output route word dataset datapoint assignment return
      interaction debate history convention syntax language regularexpression title capability behavior bounty bug tracker spec log report duration outofdate answer question goal prediction expertise group event vehicle place plan moment day year gig company offer picture audio vid series presentation refactor critique compliment opinion strategy aggregator blog post comment site link resource search correction optimization
      contribution suggestion recommendation reference book topic pattern course chapter page tip thought idea summary extension tesst decision conclusion reason disagreement experiment lesson exercise template abstraction implementation wish preference alternative frustratedattempt email message listserv forum irc phone call visit host traffic metaphordefinition translation equivalence].map { |w| [w, w.capitalize.constantize] }
  end
  
  def create
    @concept = Concept.new params[:concept]
    @concept.type = params[:class][:name]
    @concept.save
    redirect_to @concept
  end
  
  def edit
    @concept = Concept.find params[:id]
  end
  
  def update
    @concept = Concept.find params[:id]
    @concept.update_attributes params[:concept]
    redirect_to @concept
  end
  
  def destroy
    @concept = Concept.find params[:id]
    @concept.destroy
  end
end
