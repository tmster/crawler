# frozen_string_literal: true
ENV['RACK_ENV'] ||= 'test'

require 'rubygems'
require 'pry'
require 'fakeweb'

require File.expand_path '../../app.rb', __FILE__

Dir[File.join(__dir__, 'support/**/*.rb')].each do |file|
  require file
end
