ENV['RACK_ENV'] ||= 'test'

require 'rubygems'
require 'pry'

require File.expand_path '../../app.rb', __FILE__
