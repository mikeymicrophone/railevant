class RailsersController < ApplicationController

  def index
    @railsers = Railser.find :all
  end

  def show
    @railser = Railser.find_by_login params[:id]
  end
  
  def verify
    @railser = Railser.find_by_login params[:id]
    @railser.verified_by current_railser if @railser.verify params[:code], current_railser
  end

  def new
  end

  def create
    @railser = Railser.new params[:railser]
    @railser.save!
    self.current_railser = @railser
    redirect_back_or_default concepts_path
    flash[:notice] = "plenty ready to rock"
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def activate
    self.current_railser = Railser.find_by_activation_code params[:activation_code]
    if logged_in? && !current_railser.activated?
      current_railser.activate
      flash[:notice] = "was that so hard"
    end
    redirect_back_or_default concepts_path
  end

end
