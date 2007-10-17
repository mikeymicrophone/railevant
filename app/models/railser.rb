require 'digest/sha1'
class Railser < ActiveRecord::Base
  has_one :person
  has_many :concepts
  has_many :railevances
  has_many :votes
  
  def name
    login
  end
  
  def to_param
    login
  end
  
  def is_person which
    which = which.id if which.is_a? ActiveRecord::Base
    update_attribute :person_id, which
  end
  
  attr_accessor :password
  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..200
  validates_length_of       :email,    :within => 3..200
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  before_create :make_activation_code 
  attr_accessible :login, :email, :password, :password_confirmation
  
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  def activated?
    activation_code.nil?
  end

  def recently_activated?
    @activated
  end

  def self.authenticate login, password
    u = find :first, :conditions => ['login = ? and activated_at is not null', login]
    u && u.authenticated?(password) ? u : nil
  end

  def self.encrypt password, salt
    Digest::SHA1.hexdigest "--#{salt}--#{password}--"
  end

  def encrypt password
    self.class.encrypt password, salt
  end

  def authenticated? password
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for time
    remember_me_until time.from_now.utc
  end

  def remember_me_until time
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  protected
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
    
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    def make_activation_code
      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end 
end
