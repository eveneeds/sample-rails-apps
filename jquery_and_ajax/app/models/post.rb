class Post < ActiveRecord::Base
  def self.find_for_index
    find(:all, :order => 'created_at DESC')
  end
end
