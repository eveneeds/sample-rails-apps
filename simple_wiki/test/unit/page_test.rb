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
  
  def test_latest_revision
    assert !@page.latest_revision
    
    old_title = @page.title.dup
    @page.update_attributes :title => "Changed"
    assert_equal old_title, @page.latest_revision.title
    
    @page.update_attributes :title => 'Another change'
    assert_equal 'Changed', @page.latest_revision.title
  end
  
  def test_revision_numbers
    @page.update_attributes :title => "Changed"
    assert_equal 1, @page.latest_revision.number
    
    @page.update_attributes :title => "Changed again"
    assert_equal 2, @page.latest_revision.number
    
    5.times {|i| @page.update_attributes :title => "Update #{i}" }
    assert_equal 7, @page.latest_revision.number
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
