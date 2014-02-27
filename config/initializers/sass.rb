require 'sass'
require 'base64'

Sass::Script::Number.precision = [10, ::Sass::Script::Number.precision].max

module Sass::Script::Functions
  def base64(string)
    assert_type string, :String
    Sass::Script::String.new(Base64.encode64(string.value))
  end
  declare :base64, :args => [:string]

  def url_encode(string)
    assert_type string, :String
    Sass::Script::String.new(URI.escape(string.value))
  end
  declare :url_encode, :args => [:string]
end