# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :development do
  guard 'livereload', apply_css_live: true, apply_js_live:true, grace_period: 0.05 do
    watch(%r{app/views/.+\.(erb|haml|slim)$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{config/locales/.+\.yml})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
  end
end