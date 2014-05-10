# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'googleplus/reader/version'

Gem::Specification.new do |spec|
  spec.name     = 'googleplus-reader'
  spec.version  = GooglePlus::Reader::VERSION
  spec.authors  = [ 'Ivan Ukhov' ]
  spec.email    = [ 'ivan.ukhov@gmail.com' ]
  spec.summary  = 'A jQuery-based library for reading public posts of a Google+ user'
  spec.homepage = 'https://github.com/IvanUkhov/googleplus-reader'
  spec.license  = 'MIT'

  spec.files    = Dir[ 'lib/**/*.js.coffee', 'lib/**/*.rb', 'README.md', 'LICENSE.txt' ]
end
