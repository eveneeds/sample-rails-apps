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

      if database_page
        link = edit_page.call(database_page)
        klass = 'existing_page'
      else
        link = new_page + "?title=#{CGI.escape(page)}"
        klass = 'new_page'
      end
      
      "<a href='#{link}' class='#{klass}'>#{page}</a>"
    end
  end
end