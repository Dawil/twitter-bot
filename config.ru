require 'rubygems'
require 'bundler'

Bundler.require

dir  = File.join(File.expand_path(File.dirname(__FILE__)), 'app')
glob = File.join(dir, '**', '*.rb')

Dir[glob].each do |file|
	require file
end
run TwitterBot
