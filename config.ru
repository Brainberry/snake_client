# This file is used by Rack-based servers to start the application.
if Object.const_defined?("PhusionPassenger")
  ENV["GEM_PATH"] = ::File.expand_path('../vendor/bundle/ruby/1.8',  __FILE__)
  
  require 'rubygems'
  Gem.clear_paths

  require ::File.expand_path('../vendor/bundle/ruby/1.8/gems/rack-1.2.1/lib/rack',  __FILE__)
end

require ::File.expand_path('../config/environment',  __FILE__)
run SnakeClient::Application
