Gem::Specification.new do |s|
  s.name = %q{oembed_links}
  s.version = "0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Indianapolis Star MD&D", "Peter Gerard"]
  s.date = %q{2008-10-16}
  s.description = %q{Easy OEmbed integration for Ruby (and Rails 3).}
  s.email = ["bugs@indy.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.md"]
  s.files = ["CREDIT", "History.txt", "Manifest.txt", "README.md", "Rakefile", "lib", "lib/oembed_links", "lib/oembed_links.rb", "lib/oembed_links/fetchers", "lib/oembed_links/fetchers/net_http.rb", "lib/oembed_links/fetchers/ruby_tubesday.rb", "lib/oembed_links/fetchers/curb.rb", "lib/oembed_links/formatters", "lib/oembed_links/formatters/json.rb", "lib/oembed_links/response.rb", "oembed_links.gemspec", "oembed_links_example.yml", "rails", "rails/init.rb", "spec", "spec/oembed_links_spec.rb", "spec/oembed_links_test.yml", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://indystar.com/}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{oembed_links}
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
      s.add_dependency(%q<json>)
    else
      s.add_dependency(%q<json>)
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<json>)
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
