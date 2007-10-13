class ApplicationController < ActionController::Base
  helper :all
  filter_parameter_logging 'password'
  include AuthenticatedSystem
  protect_from_forgery

  before_filter :load_railser_id_into_ar

  def current_railser_id
    session[:railser]
  end

  def load_railser_id_into_ar
    ActiveRecord::Base.instance_variable_set('@railser_id', current_railser_id)
  end

end

class ActiveRecord::Base
  
  def self.all
    find :all
  end
  
  def age
    Time.now - created_at
  end
  
  before_create :credit_creator
  
  def current_railser_id
    @railser_id
  end
  
  def credit_creator
    self.railser_id ||= current_railser_id
  end
end