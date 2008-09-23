require 'digest/sha1'
class User < ActiveRecord::Base
  SALT = "a6ab20a65296b2db942944ef7820e1bc74cabb96"
  validates_length_of :password, :minimum => 4
  before_save :encrypt_password
  attr_accessor :password
  
  # Returns a User if the username and password matches, nil if not.
  def self.authenticate(username, password)
    User.find_by_username_and_password_hash(username, encrypt_password(password))
  end
  
  private
  
  # Automatically encrypt the 'password' if it's set. Don't do anything if the
  # 'password' hasn't changed, unless it's a new record (see password_required?)
  def encrypt_password
    return unless password_required?
    self.password_hash = self.class.encrypt_password(self.password)
  end
  
  # Uses Digest::SHA1 from the Ruby standard library and performs a one-way encryption
  # of the password. The password is also salted. Read more about salting here:
  # http://www.aspheute.com/english/20040105.asp
  def self.encrypt_password(password)
    Digest::SHA1.hexdigest("#{password}#{SALT}")
  end
  
  # See encrypt_password.
  def password_required?
    new_record? || !self.password.blank?
  end
end
