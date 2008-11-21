# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def login_stuff
    if logged_in?
      link_to 'logout', logout_path
    else
      link_to('signup', signup_path) +
      link_to('login', login_path)
    end
  end
end
