require 'bundler/setup'
require_relative('../lib/Codebreaker_ML')

RSpec.configure do |c|
  c.formatter = :documentation
  c.color = true
end
