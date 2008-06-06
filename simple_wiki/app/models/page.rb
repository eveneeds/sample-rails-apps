class Page < ActiveRecord::Base
  has_many :revisions, :order => 'created_at DESC', :dependent => :destroy
  validates_presence_of :title, :content
  
  attr_accessor :skip_revision, :message
  after_update :create_revision
  
  def latest_revision
    revisions.find(:first, :order => 'id DESC')
  end
  
  def self.home
    find(:first)
  end
  
  def self.revision(id, revision = nil)
    instance = find(id)
    revision ? instance.revisions.find_by_number(revision) : instance
  end
  
  private
  
  def create_revision
    return if skip_revision?
    revisions.create! :title => title_was, :content => content_was, :created_by => updated_by_was, :message => message, :number => next_revision_number
  end
  
  def skip_revision?
    skip_revision == true || !changed?
  end
  
  def next_revision_number
    revisions.count + 1
  end
end
