module ApplicationHelper
  def page_is_subpath_of path, output = nil
  	if request.path.starts_with? path
  		output.nil? ? true : output.html_safe
  	end
  end

  def include_payment_assets
  	content_for :footer do
  		javascript_include_tag("https://js.stripe.com/v2/") +
      javascript_include_tag(:payments) +
  		javascript_tag("Stripe.setPublishableKey('#{Rails.configuration.stripe[:publishable_key]}');")
  	end
  end

  def nav_link_to(name, options, html_options = {})
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
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

end
