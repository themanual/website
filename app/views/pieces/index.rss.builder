xml.instruct! :xml, :version => "1.0"
xml.rss(
  "version"       => "2.0",
  "xmlns:dc"      => "http://purl.org/dc/elements/1.1/",
  "xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
  "xmlns:atom"    => "http://www.w3.org/2005/Atom") do
  xml.channel do
    xml.title "The Manual"
    xml.description "A design journal for the web"
    xml.language "en"
    xml.link root_url
    xml.copyright "Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License"
    xml.atom :link, :rel => "self", :href => feed_url, :type => "application/rss+xml"

    xml.image do
      xml.title   "The Manual"
      xml.link    root_url
      xml.url     image_url("identity/logo-rss.png")
      xml.width   144
      xml.height  144
    end

    @issues.each do |issue|
      issue.pieces.each do |piece|
        cache [issue, piece] do
          xml.item do
            xml.title piece.freestanding_title
            xml.description piece.synopsis
            xml.category "Issue #{issue.number}"
            xml.dc :creator, piece.author.name
            xml.pubDate issue.published_on.to_datetime.to_s(:rfc822)
            xml.link piece_url(issue.number, piece.author.slug, piece.type_sym)
            xml.guid piece_url(issue.number, piece.author.slug, piece.type_sym), :isPermaLink => "true"
            xml.content :encoded, markdown(piece.body)
          end
        end
      end
    end

  end
end