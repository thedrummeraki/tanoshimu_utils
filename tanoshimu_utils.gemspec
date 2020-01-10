$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require 'tanoshimu_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'tanoshimu_utils'
  spec.version     = TanoshimuUtils::VERSION
  spec.authors     = ['Akinyele Cafe-Febrissy']
  spec.email       = ['me@akinyele.ca']
  spec.homepage    = 'https://github.com/thedrummeraki/tanoshimu_utils'
  spec.summary     = 'YourAnime.moe utilities'
  spec.description = 'Just a couple of utilities shared accross the apps to make development much easier.'
  spec.license     = 'MIT'

=begin
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
    spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
=end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'pry'
end
