module ApplicationHelper
  def page_is_subpath_of path, output = nil
  	if request.path.starts_with? path
  		output.nil? ? true : output.html_safe
  	end
  end

  def payment_assets
  	content_for :footer do
  		javascript_include_tag(:payments) +
  		javascript_include_tag("https://js.stripe.com/v2/") +
  		javascript_tag("Stripe.setPublishableKey('#{Rails.configuration.stripe[:publishable_key]}');")
  	end
  end
end
