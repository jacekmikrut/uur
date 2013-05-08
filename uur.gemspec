$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")
require "uur/version"

Gem::Specification.new do |s|
  s.name          = "uur"
  s.version       = Uur::VERSION
  s.author        = "Jacek Mikrut"
  s.email         = "jacekmikrut.software@gmail.com"
  s.homepage      = "http://github.com/jacekmikrut/uur"
  s.summary       = "Command line time log reporting tool."
  s.description   = "Generates simple reports from time log entries stored in human-readable text file."

  s.files         = Dir["lib/**/*", "README*", "LICENSE*", "Changelog*"]
  s.require_path  = "lib"

  s.add_development_dependency "rspec", "~> 2.0"
end
