class TextileCloth < RedCloth
  attr_accessor :new_page, :edit_page
  
  def self.parse(text, new_page_path, &block)
    instance = new(text)
    instance.new_page = new_page_path
    instance.edit_page = block
    
    instance
  end
  
  def inline_textile_pagelink(text)
    text.gsub!(/\[([\w ]+)\]/i) do |m|
      page = $~[1]
      database_page = Page.identify(page)

      link = database_page ? edit_page.call(database_page) : new_page + "?title=#{CGI.escape(page)}"
      "<a href='#{link}'>#{page}</a>"
    end
  end
end