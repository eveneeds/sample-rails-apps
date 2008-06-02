class Post < ActiveRecord::Base
  has_many :comments
  
  def self.find_for_index
    find(:all, :order => 'created_at DESC')
  end
end
