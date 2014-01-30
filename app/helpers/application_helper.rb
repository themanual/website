module ApplicationHelper
  def page_is_subpath_of path, output = nil
  	if request.path.starts_with? path
  		output.nil? ? true : output.html_safe
  	end
  end
end
