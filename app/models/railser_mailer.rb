class RailserMailer < ActionMailer::Base
  def identity_verification identity, address, railser, code
    @recipients = railser.email
    @from       = 'identitfier@railevant.com'
    @subject    = "identity of #{identity.content}"
    @sent_on    = Time.now
    @body[:railser] = railser
    @body[:identity] = identity
    @body[:code] = code
    @body[:address] = address
  end
  
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
      @from        = "the_vortexx@railevant.com"
      @subject     = "railevant.stuff.."
      @sent_on     = Time.now
      @body[:railser] = railser
    end
end
