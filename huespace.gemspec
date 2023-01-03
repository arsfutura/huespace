# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "huespace"
  spec.version = "0.3.2"
  spec.author = "Dino Tognon, Ivan Božić"
  spec.email = "dino.tognon@arsfutura.co"
  spec.homepage = 'https://github.com/arsfutura/huespace'
  spec.summary = "Extract a color palette from any image"
  spec.description = "Huespace can extract a color palette from local images, url-s or images as byte-streams. 
                      Besides palettes, it can also extract the most dominant color and the most colorful color!"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5.7"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = ["lib/huespace.rb", "lib/huespace/median_cut.rb"]
  spec.bindir = "exe"
  spec.require_paths = ["lib"]

  spec.add_dependency "mini_magick", "~> 4.11.0"

  spec.add_development_dependency "rspec", "~> 3.2"

end
