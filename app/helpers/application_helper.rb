module ApplicationHelper
  def page_is_subpath_of path, output = nil
  	if /^#{path}/ =~ request.original_url
  		output.nil? ? true : output.html_safe!
  	end
  end
end
