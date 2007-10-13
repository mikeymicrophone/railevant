class RailserMailer < ActionMailer::Base
  def signup_notification(railser)
    setup_email(railser)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://YOURSITE/activate/#{railser.activation_code}"
  
  end
  
  def activation(railser)
    setup_email(railser)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end
  
  protected
    def setup_email(railser)
      @recipients  = "#{railser.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:railser] = railser
    end
end
