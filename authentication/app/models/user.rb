require 'digest/sha1'
class User < ActiveRecord::Base
  SALT = "a6ab20a65296b2db942944ef7820e1bc74cabb96"
  validates_length_of :password, :minimum => 4
  before_save :encrypt_password
  attr_accessor :password
  
  def self.authenticate(username, password)
    User.find_by_username_and_password_hash(username, encrypt_password(password))
  end
  
  private
  
  def encrypt_password
    return unless password_required?
    self.password_hash = self.class.encrypt_password(self.password)
  end
  
  def self.encrypt_password(password)
    Digest::SHA1.hexdigest("#{password}#{SALT}")
  end
  
  def password_required?
    new_record? || !self.password.blank?
  end
end
