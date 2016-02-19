require "anchors/version"
require "rack-plastic"

module Anchors
  class Middleware < Rack::Plastic
    CSS_SELECTOR = "body"
    SEPERATOR = "_"
    LINK = true

    def change_nokogiri_doc(doc)
      # Throw this CSS class into the HTML page where you
      # want to have linkable anchor headers.
      doc.css(css).each do |node|
        node.css("h1,h2,h3,h4,h5,h6").each do |h|
          id = dom_id(h)
          h["id"] = id
          if link?
            a = Nokogiri::XML::Node.new "a", doc
            a["href"] = "##{h["id"]}"
            a.add_child h.clone
            h.swap a
          end
        end
      end
      doc
    end

    private
    # Super lame, but awesome way to get CSS options CSS selector.
    def css
      options[:css] || CSS_SELECTOR
    end

    def seperator
      options[:seperator] || SEPERATOR
    end

    def link?
      options[:link] || LINK
    end

    def dom_id(el)
      el.content.downcase.gsub(/[^\d\w\s_]/, '').gsub(' ', '_')
    end
  end
end
