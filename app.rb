require 'rubygems'
require 'bundler/setup'

require 'mechanize'

Dir[File.dirname(__FILE__) + "/app/**/*.rb"].each do |file|
  require file
end
