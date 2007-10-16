class RailserObserver < ActiveRecord::Observer
  def after_create railser
    RailserMailer.deliver_signup_notification railser
  end

  def after_save railser
    RailserMailer.deliver_activation railser if railser.recently_activated?
  end
end
