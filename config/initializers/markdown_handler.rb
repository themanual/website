module Kramdown
  module Converter
    class Html
      include ActionView::Helpers::AssetTagHelper

      def convert_img(el, indent)
        attrs = el.attr.dup
        link = attrs.delete 'src'
        image_tag ActionController::Base.helpers.asset_path(link), attrs
      end
    end
  end
end

module MarkdownHandler
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  def self.call(template)
    compiled_source = erb.call(template)
    "Kramdown::Document.new(begin;#{compiled_source};end, auto_ids: false).to_html.html_safe"
  end
end

ActionView::Template.register_template_handler :md, MarkdownHandler