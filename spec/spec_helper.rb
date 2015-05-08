$:.unshift File.expand_path('../lib', __FILE__)
$load_god = true

require 'god'
God::EventHandler.load

require 'minitest/autorun'
require 'minitest/unit'
require 'set'

include God