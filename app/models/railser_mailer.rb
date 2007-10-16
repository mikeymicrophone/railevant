class RailserMailer < ActionMailer::Base
  def signup_notification railser
    setup_email railser
    @subject    += 'promotion to railevance'
    @body[:url]  = "http://railevant.com/activate/#{railser.activation_code}"
  end
  
  def activation railser
    setup_email railser
    @subject    += 'you.active'
    @body[:url]  = "http://railevant.com/"
  end
  
  protected
    def setup_email railser
      @recipients  = "#{railser.email}"
      @from        = "the_vortexx"
      @subject     = "railevant.stuff.."
      @sent_on     = Time.now
      @body[:railser] = railser
    end
end
