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

    respond_to do |format|
      format.html
      format.xml  { render :xml => @railevance }
    end
  end

  def new
    @railevance = Railevance.new
    @railsers = Railser.all.map { |r| [r.name, r.id] }
    @rails = @ties = Concept.all.map { |c| [c.content, c.id] }

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
