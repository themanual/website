module ApplicationHelper

  def page_is_subpath_of path, output = nil
    if request.path.starts_with? path
      output.nil? ? true : output.html_safe
    end
  end

  def page_is path, output = nil
    if current_page?(path)
      output.nil? ? true : output.html_safe
    end
  end

  def page_namespace
    request.path.split('/').reject(&:blank?).first
  end

  def srcset options
    attribute = options[:sizes].map { |size|
      image_path("#{options[:base]}-#{size}w.#{options[:format]}") + " " + "#{size}w"
    }
    attribute << "#{image_path("pixel.png")} 1w" if options[:blank]
    attribute.join(", ")
  end

  def include_payment_assets
    content_for :footer do
      javascript_include_tag("https://js.stripe.com/v2/") +
      javascript_include_tag(:payments) +
      javascript_tag("Stripe.setPublishableKey('#{Rails.configuration.stripe[:publishable_key]}');")
    end
  end

  def legacy_store_issue_url(issue_no = nil)
    return "http://buy.alwaysreadthemanual.com/products/issue-#{issue_no}" if issue_no
    "http://buy.alwaysreadthemanual.com/"
  end

  def link_to_current(name, options, html_options = {})
    if current_page?(options)
      html_options[:class] ||= ""
      html_options[:class] += " current"
    end
    link_to name, options, html_options
  end

  # From https://coderwall.com/p/d1vplg
  def inline_svg filename, options={}
    path = "app/assets/images/#{filename}".split('/')
    file = File.read(Rails.root.join(*path))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    options.each { |k,v|
      svg[k] ||= ""
      svg[k] = (svg[k] + " " + v).strip
    }
    doc.to_html.html_safe
  end

end
