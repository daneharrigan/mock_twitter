require 'yaml'
require 'active_support/core_ext/array/conversions'
require 'active_support/json/encoders/object'

require 'mock_twitter/httparty_overwrite'
require 'mock_twitter/mock_twitter'
require 'mock_twitter/response'
#require 'mock_twitter/api'

MockTwitter.template_path File.expand_path(File.dirname(__FILE__) + '/templates')