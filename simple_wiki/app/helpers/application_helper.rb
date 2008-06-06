# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def textilize(text)
    TextileCloth.parse(text, new_page_path) {|page| url_for(page_path(page)) }.to_html(*(TextileCloth::DEFAULT_RULES << :inline_textile_pagelink))
  end
end
