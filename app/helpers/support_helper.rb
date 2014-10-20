module SupportHelper
  def custom_country_select form, field_name, html_options = {}

    options = []

    country_to_option = Proc.new do |country|
      html_attributes = {}

      html_attributes[:selected] = form.object.country_id == country.id
      html_attributes[:value] = country.id
      html_attributes[:'data-code'] = country.code2

      content_tag_string(:option, country.name, html_attributes)
    end

    countries = Hash[Shoppe::Country.ordered.map{|c| [c.code2, c]}]

    options << content_tag(:optgroup, label: 'Top Countries') do
      ['US','CA', 'GB', 'AU', 'DE'].collect do |code|
        country_to_option.call(countries[code])
      end.join.html_safe
    end

    options << content_tag(:optgroup, label: 'All Countries') do
      countries.collect do |code, country|
        country_to_option.call(country)
      end.join.html_safe
    end

    form.select field_name, options.join.html_safe, {}, html_options
  end
end
