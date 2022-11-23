# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "boje"
  spec.version = "0.2.0"
  spec.author = "Dino Tognon"
  spec.email = "dino.tognon@arsfutura.co"

  spec.summary = "Extract dominant colors from an image"
  spec.description = "Extract up to 10 dominant colors from an image."
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
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
  spec.add_dependency "kmeans-clusterer", "~> 0.11.4"

  spec.add_development_dependency "rspec", "~> 3.2"

end
