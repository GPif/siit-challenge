require 'test/unit'

Dir[File.expand_path('../lib/**/*.rb', __dir__)].sort.each do |file|
  require file
end
