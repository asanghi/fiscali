$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
require 'fiscali'

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
end
