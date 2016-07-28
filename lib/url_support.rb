# frozen_string_literal: true
require 'cgi'

class UrlSupport
  def initialize(url)
    @uri = URI.parse(url)
  end

  def override_query_variable(key, value)
    params = uri.query ? CGI.parse(uri.query) : {}
    params[key] = value
    uri.query = URI.encode_www_form(params)
  end

  def to_s
    uri.to_s
  end

  private

  attr_accessor :uri
end
