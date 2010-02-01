require 'rubygems'
require 'yaml'
require 'active_support'
require 'lorem'
#require 'json'

require File.expand_path(File.dirname(__FILE__) + '/mock_twitter/httparty_overwrite')
require File.expand_path(File.dirname(__FILE__) + '/mock_twitter/mock_twitter')
require File.expand_path(File.dirname(__FILE__) + '/mock_twitter/response')

MockTwitter.template_path File.expand_path(File.dirname(__FILE__) + '/templates')