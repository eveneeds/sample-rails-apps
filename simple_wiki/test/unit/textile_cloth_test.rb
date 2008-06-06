require 'test_helper'

class TextileClothTest < Test::Unit::TestCase
  def test_page_syntax
    input = <<-eof
    'Go see [Does not exist]! 
    code. oh hai'
    eof
    
    assert TextileCloth.parse(input, '/pages/new').to_html(:inline_textile_pagelink) =~ /\/pages\/new/
  end
end
