class Page < ActiveRecord::Base
  has_many :revisions, :order => 'created_at DESC'
  
  attr_accessor :skip_revision, :message
  after_update :create_revision
  
  def latest_revision
    revisions.find(:first)
  end
  
  private
  
  def create_revision
    return if skip_revision == true
    revisions.create! :title => title_was, :content => content_was, :created_by => updated_by_was, :message => message
  end
end
