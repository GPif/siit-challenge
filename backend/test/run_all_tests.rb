# test/run_all_tests.rb
require 'test/unit'

Dir.glob(File.join(File.dirname(__FILE__), '**/*_test.rb')) do |file|
  require File.expand_path(file)
end
