xml.instruct! :xml, :version => "1.0"
xml.rss(
  "version" => "2.0",
  "xmlns:dc"  => "http://purl.org/dc/elements/1.1/",
  "xmlns:content" => "http://purl.org/rss/1.0/modules/content/") do
  xml.channel do
    xml.title "The Manual"
    xml.description "A design journal for the web"
    xml.language "en"
    xml.link root_url
    xml.copyright "Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License"

    xml.image do
      xml.title   "The Manual"
      xml.link    root_url
      xml.url     image_url("identity/logo-white-padded@2x.png")
      xml.width   320
      xml.height  320
    end

    @issues.each do |issue|
      issue.pieces.each do |piece|
        cache [issue, piece] do
          xml.item do
            xml.title piece.freestanding_title
            xml.description piece.synopsis
            xml.category "Issue #{issue.number}"
            xml.tag!("dc:creator", piece.author.name)
            xml.pubDate issue.published_on.to_s(:rfc822)
            xml.link piece_url(issue.number, piece.author.slug, piece.type_sym)
            xml.guid piece_url(issue.number, piece.author.slug, piece.type_sym), "isPermalink" => "true"
            xml.tag!("content:encoded", markdown(piece.body))
          end
        end
      end
    end

  end
end