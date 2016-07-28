# frozen_string_literal: true
ENV['RACK_ENV'] ||= 'test'

require 'rubygems'
require 'pry'
require 'fakeweb'

require File.expand_path '../../app.rb', __FILE__
