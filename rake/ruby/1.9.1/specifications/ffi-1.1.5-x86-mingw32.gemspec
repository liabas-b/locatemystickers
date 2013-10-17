# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ffi"
  s.version = "1.1.5"
  s.platform = "x86-mingw32"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wayne Meissner"]
  s.date = "2012-09-14"
  s.description = "Ruby-FFI is a ruby extension for programmatically loading dynamic\nlibraries, binding functions within them, and calling those functions\nfrom Ruby code. Moreover, a Ruby-FFI extension works without changes\non Ruby and JRuby. Discover why should you write your next extension\nusing Ruby-FFI here[http://wiki.github.com/ffi/ffi/why-use-ffi]."
  s.email = "wmeissner@gmail.com"
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "LICENSE"]
  s.homepage = "http://wiki.github.com/ffi/ffi"
  s.require_paths = ["lib"]
  s.rubyforge_project = "ffi"
  s.rubygems_version = "1.8.16"
  s.summary = "Ruby-FFI is a ruby extension for programmatically loading dynamic libraries, binding functions within them, and calling those functions from Ruby code"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
