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
            a.add_child h.children
            h.add_child a
          end
        end
      end
      doc
    end

    private
    # Super lame, but awesome way to get CSS options CSS selector.
    def css
      options.fetch :css, CSS_SELECTOR
    end

    def seperator
      options.fetch :seperator, SEPERATOR
    end

    def link?
      options.fetch :link, LINK
    end

    def dom_id(el)
      id = el.content.downcase.gsub(/[^\d\w\s_]/m, '').strip.gsub(' ', seperator)
      [id, id_count(id)].compact.join(seperator)
    end

    def id_count(id)
      @id_counts ||= Hash.new{ |h,k| h[k] = 0 }
      @id_counts[id] += 1
      @id_counts[id] if @id_counts[id] > 1
    end
  end
end
