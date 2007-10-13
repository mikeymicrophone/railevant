class RailevancesController < ApplicationController
  # GET /railevances
  # GET /railevances.xml
  def index
    @railevances = Railevance.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @railevances }
    end
  end

  # GET /railevances/1
  # GET /railevances/1.xml
  def show
    @railevance = Railevance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @railevance }
    end
  end

  # GET /railevances/new
  # GET /railevances/new.xml
  def new
    @railevance = Railevance.new
    @railsers = Railser.find(:all).map { |r| [r.name, r.id] }
    @rails = @ties = Concept.find(:all).map { |c| [c.content, c.id] }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @railevance }
    end
  end

  # GET /railevances/1/edit
  def edit
    @railevance = Railevance.find(params[:id])
  end

  # POST /railevances
  # POST /railevances.xml
  def create
    @railevance = Railevance.new(params[:railevance])

    respond_to do |format|
      if @railevance.save
        flash[:notice] = 'Railevance was successfully created.'
        format.html { redirect_to(@railevance) }
        format.xml  { render :xml => @railevance, :status => :created, :location => @railevance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @railevance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /railevances/1
  # PUT /railevances/1.xml
  def update
    @railevance = Railevance.find(params[:id])

    respond_to do |format|
      if @railevance.update_attributes(params[:railevance])
        flash[:notice] = 'Railevance was successfully updated.'
        format.html { redirect_to(@railevance) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @railevance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /railevances/1
  # DELETE /railevances/1.xml
  def destroy
    @railevance = Railevance.find(params[:id])
    @railevance.destroy

    respond_to do |format|
      format.html { redirect_to(railevances_url) }
      format.xml  { head :ok }
    end
  end
end
