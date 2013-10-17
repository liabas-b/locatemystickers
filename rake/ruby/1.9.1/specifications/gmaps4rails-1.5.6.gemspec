# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gmaps4rails"
  s.version = "1.5.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Benjamin Roth", "David Ruyer"]
  s.date = "2012-10-21"
  s.description = "Enables easy display of items (taken from a Rails 3 model) on a Google Maps (JS API V3), OpenLayers, Mapquest and Bing. Geocoding + Directions included."
  s.email = ["apnea.diving.deep@gmail.com", "david.ruyer@gmail.com"]
  s.homepage = "http://github.com/apneadiving/Google-Maps-for-Rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.16"
  s.summary = "Maps made easy for Rails 3"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rails>, ["~> 3.2.1"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<mongoid>, ["~> 3"])
      s.add_development_dependency(%q<jquery-rails>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<jasmine>, [">= 0"])
      s.add_development_dependency(%q<guard>, ["~> 1.0.1"])
      s.add_development_dependency(%q<guard-spork>, [">= 0"])
      s.add_development_dependency(%q<guard-coffeescript>, [">= 0"])
      s.add_development_dependency(%q<guard-jasmine>, [">= 0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
      s.add_development_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.2.1"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<mongoid>, ["~> 3"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<jasmine>, [">= 0"])
      s.add_dependency(%q<guard>, ["~> 1.0.1"])
      s.add_dependency(%q<guard-spork>, [">= 0"])
      s.add_dependency(%q<guard-coffeescript>, [">= 0"])
      s.add_dependency(%q<guard-jasmine>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.2.1"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<mongoid>, ["~> 3"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<jasmine>, [">= 0"])
    s.add_dependency(%q<guard>, ["~> 1.0.1"])
    s.add_dependency(%q<guard-spork>, [">= 0"])
    s.add_dependency(%q<guard-coffeescript>, [">= 0"])
    s.add_dependency(%q<guard-jasmine>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<factory_girl_rails>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
