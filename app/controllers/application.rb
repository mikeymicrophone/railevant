class ApplicationController < ActionController::Base
  helper :all
  filter_parameter_logging 'password'
  include AuthenticatedSystem
  protect_from_forgery
end