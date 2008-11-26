class RailevancesController < ApplicationController
  def index
    @railevances = Railevance.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @railevances }
    end
  end

  def show
    @railevance = Railevance.find params[:id]

    if last_few = Rails.cache.read('last_few')
      last_few = last_few.dup
      @last_few = Concept.find(*last_few).to_a
    else
      @last_few = []
    end


    respond_to do |format|
      format.html
      format.xml  { render :xml => @railevance }
    end
  end

  def new
    @railevance = Railevance.new :rail_id => params[:rail_id], :tie_id => params[:tie_id], :rail_r_id => params[:rail_r_id], :tie_r_id => params[:tie_r_id]
    @rails = @ties = Concept.all.map { |c| [c.content[0..55], c.id] }
    @railevances = Railevance.all.map { |r| [r.content, r.id] } if params[:rail_r_id] || params[:tie_r_id]

    respond_to do |format|
      format.html
      format.xml  { render :xml => @railevance }
    end
  end

  def edit
    @railevance = Railevance.find params[:id]
  end

  def create
    @railevance = Railevance.new params[:railevance]

    respond_to do |format|
      if @railevance.save
        flash[:notice] = 'railevance was created. very successfully indeed.'
        format.html { redirect_to @railevance }
        format.xml  { render :xml => @railevance, :status => :created, :location => @railevance }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @railevance.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @railevance = Railevance.find params[:id]

    respond_to do |format|
      if @railevance.update_attributes params[:railevance]
        flash[:notice] = 'Railevance was successfully updated.'
        format.html { redirect_to @railevance }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @railevance.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @railevance = Railevance.find params[:id]
    @railevance.destroy

    respond_to do |format|
      format.html { redirect_to railevances_url }
      format.xml  { head :ok }
    end
  end
end
