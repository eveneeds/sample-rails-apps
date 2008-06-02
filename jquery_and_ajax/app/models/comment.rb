class Comment < ActiveRecord::Base
  validates_presence_of :text
  
  def name_or_anon
    name.blank? ? 'Anonymous' : name
  end
  
  def url_with_http
    (url =~ /^http/) ? url : "http://#{url}"
  end
end
