class VotesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  def index
    @votes = if params[:concept_id]
      Concept.find_by_effective_uri(params[:concept_id]).votes
    else
      Vote.all
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @votes }
    end
  end

  def show
    @vote = Vote.find params[:id]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @vote }
    end
  end

  def new
    @vote = Vote.new
    @concepts = Concept.all.map { |c| [c.content[0..30], c.id] } unless params[:concept_id]
    @railevances = (params[:concept_id] ? Concept.find_by_effective_uri(params[:concept_id]).railevances : Railevance.all).map { |r| [r.content, r.id] }
    respond_to do |format|
      format.html
      format.xml  { render :xml => @vote }
    end
  end

  def create
    params[:vote] ||= {}
    params[:vote][:rating] ||= params[:rating]
    params[:vote][:concept_id] ||= params[:concept_id] || params[:id]
    params[:vote][:railevance_id] ||= params[:railevance_id]
    params[:vote][:characteristic_id] ||= params[:characteristic_id]
    params[:vote][:characteristic_id] = nil if params[:vote][:characteristic_id] == ''
    @vote = Vote.new params[:vote]

    respond_to do |format|
      if @vote.save
        @vote.destroy_previous_if_exists
        format.html { redirect_to @vote }
        format.xml  { render :xml => @vote, :status => :created, :location => @vote }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @vote = Vote.find params[:id]
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.xml  { head :ok }
    end
  end
end
