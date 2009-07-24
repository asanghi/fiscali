# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fiscali}
  s.version = "1.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aditya Sanghi"]
  s.date = %q{2009-07-24}
  s.email = %q{aditya.sanghi@risingsunbilling.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "fiscali.gemspec",
     "init.rb",
     "install.rb",
     "lib/fiscali.rb",
     "lib/rising_sun/fiscali.rb",
     "test/fiscali_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://asanghi.github.com/fiscali}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Fiscal Year Date Functions}
  s.test_files = [
    "test/fiscali_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
  end
end
