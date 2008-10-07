require 'digest/sha1'
class User < ActiveRecord::Base
  validates_length_of :password, :minimum => 4, :if => :password_required?
  before_save :encrypt_password
  attr_accessor :password
  
  # Returns a User if the username and password matches, nil if not.
  def self.authenticate(username, password)
    user = User.find_by_username(username)
    user ? (user.password_hash == encrypt_password(password, user.password_salt) && user) : nil
  end
  
  private
  
  def encrypt_password
    return unless password_required?
    self.password_salt = generate_salt
    self.password_hash = self.class.encrypt_password(password, password_salt)
  end
  
  # Uses Digest::SHA1 from the Ruby standard library and performs a one-way encryption
  # of the password. The password is also salted. Read more about salting here:
  # http://www.aspheute.com/english/20040105.asp
  def self.encrypt_password(password, salt)
    Digest::SHA1.hexdigest("--#{password}--||--#{salt}--")
  end
  
  # Generates a fairly random salt string.
  def generate_salt
    Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by { rand }.join)
  end
  
  # See encrypt_password.
  def password_required?
    new_record? || !self.password.blank?
  end
end
