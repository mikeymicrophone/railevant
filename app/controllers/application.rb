class ApplicationController < ActionController::Base
  helper :all
  filter_parameter_logging 'password'
  include AuthenticatedSystem
  protect_from_forgery
  helper_method :current_railser_id

  before_filter :load_railser_id_into_ar
  def load_railser_id_into_ar; ActiveRecord::Base.instance_variable_set('@railser_id', current_railser_id) ;end
  def current_railser_id; session[:railser] ;end
end

class ActiveRecord::Base
  def dom_id prefix = nil; ActionView::Base.new.dom_id self, prefix; end
  # def self.all conditions = {}; find :all, :conditions => conditions;end
  def self.random amount = 1; find :all, :limit => amount, :order => 'rand()' ;end
  def age; Time.now - created_at ;end  
  before_create :credit_creator
  def credit_creator; self.railser_id ||= current_railser_id || 1 if respond_to?(:railser_id) ;end
  def current_railser_id; @railser_id ;end
end
class Array
  def randomize; sort_by { rand } ;end
  def not_blank?; not blank? ;end
end
class String; 
  UNSAFE_CHARS = /[$+:;?!\[\]^\\\/'*&=#(){}@.><,]/
  
  def urlize
    str = downcase.gsub(' ','-').gsub(UNSAFE_CHARS, '-')
    str.gsub!('--','-') while str =~ /--/
    str
  end
  
  # def urlize; gsub(/\s+/, '_').gsub(/\.\?,\//, '~') unless blank? ;end
  def wrap_for_code first
    return self[/#{first.to_s}[*,]\d+[*,]\d+/].gsub(/[*,]/, '') if self[/#{first.to_s}[*,]\d+[*,]\d+/]
    return self[/#{first.to_s}[*,]\d+/].concat(self[/^\d+/]).gsub(/[*,]/, '') if self[/#{first.to_s}[*,]\d+/]
    return self[/#{first.to_s}/].concat(self[/^\d+[*,]\d+/]).gsub(/[*,]/, '') if self[/#{first.to_s}[*,]?$/]
  end
  def not_blank?; not blank? ;end
end
class NilClass
  def not_blank?; not blank? ;end
end
class FixNum
  def not_blank?; not blank? ;end
end