# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "huespace"
  spec.version = "0.3.0"
  spec.author = "Dino Tognon, Ivan Božić"
  spec.email = "dino.tognon@arsfutura.co"

  spec.summary = "Extract a color palette from any image"
  spec.description = "Huespace can extract a color palette from local images, url-s or images as byte-streams. 
                      Besides palettes, it can also extract the most dominant color and the most colorful color!"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mini_magick"

  spec.add_development_dependency "rspec", "~> 3.2"

end
