# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "hairtrigger"
  s.version = "0.1.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jon Jensen"]
  s.date = "2012-10-23"
  s.description = "allows you to declare database triggers in ruby in your models, and then generate appropriate migrations as they change"
  s.email = "jenseng@gmail.com"
  s.extra_rdoc_files = ["LICENSE.txt", "README.rdoc"]
  s.files = ["LICENSE.txt", "README.rdoc"]
  s.homepage = "http://github.com/jenseng/hair_trigger"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.16"
  s.summary = "easy database triggers for active record"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.3.0"])
      s.add_runtime_dependency(%q<ruby_parser>, ["= 2.0.6"])
      s.add_runtime_dependency(%q<ruby2ruby>, ["= 1.2.5"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<mysql>, [">= 2.8.1"])
      s.add_development_dependency(%q<mysql2>, ["< 0.3", ">= 0.2.7"])
      s.add_development_dependency(%q<pg>, [">= 0.10.1"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 1.3.2"])
      s.add_development_dependency(%q<ruby-debug>, ["= 0.10.4"])
      s.add_runtime_dependency(%q<activerecord>, [">= 2.3.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.3.0"])
      s.add_dependency(%q<ruby_parser>, ["= 2.0.6"])
      s.add_dependency(%q<ruby2ruby>, ["= 1.2.5"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<mysql>, [">= 2.8.1"])
      s.add_dependency(%q<mysql2>, ["< 0.3", ">= 0.2.7"])
      s.add_dependency(%q<pg>, [">= 0.10.1"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 1.3.2"])
      s.add_dependency(%q<ruby-debug>, ["= 0.10.4"])
      s.add_dependency(%q<activerecord>, [">= 2.3.0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.3.0"])
    s.add_dependency(%q<ruby_parser>, ["= 2.0.6"])
    s.add_dependency(%q<ruby2ruby>, ["= 1.2.5"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<mysql>, [">= 2.8.1"])
    s.add_dependency(%q<mysql2>, ["< 0.3", ">= 0.2.7"])
    s.add_dependency(%q<pg>, [">= 0.10.1"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 1.3.2"])
    s.add_dependency(%q<ruby-debug>, ["= 0.10.4"])
    s.add_dependency(%q<activerecord>, [">= 2.3.0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
  end
end
