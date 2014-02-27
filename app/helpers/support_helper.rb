module SupportHelper
  def custom_country_select form, field_name, html_options = {}

    options = [content_tag_string(:option, '', {value: nil})]


    country_to_option = Proc.new do |country|
      html_attributes = {}

      html_attributes[:selected] = form.object.country_id == country.id
      html_attributes[:value] = country.id
      html_attributes[:'data-code'] = country.code2

      content_tag_string(:option, country.name, html_attributes)
    end
    # priority countries

    Shoppe::Country.ordered.where(code2: ['GB','US','CA']).each do |country|
      options << country_to_option.call(country)
    end

    options << content_tag_string(:option, '--', {value: nil, disabled: :disabled})

    Shoppe::Country.ordered.each do |country|
      options << country_to_option.call(country)
    end

    form.select field_name, options.join.html_safe, {}, html_options
  end
end
