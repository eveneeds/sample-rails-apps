require 'test_helper'

class PageTest < ActiveSupport::TestCase
  def setup
    @page = pages(:rails)
  end
  
  def test_creating_revision
    old_title = @page.title.dup
    
    assert_difference('@page.revisions.count') do
      @page.update_attributes(:title => 'New title')
    end
    
    assert_equal old_title, @page.latest_revision.title
  end
  
  def test_not_creating_revision_if_told_to_skip
    @page.skip_revision = true
    
    assert_no_difference('@page.revisions.count') do
      @page.update_attributes(:title => "New title")
    end
  end
  
  def test_not_creating_revisions_if_no_changes_were_made
    assert_no_difference('@page.revisions.count') do
      5.times { @page.save }
    end
  end
end
