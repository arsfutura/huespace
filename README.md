# Huespace

A ruby gem that extracts representative colors from images.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add huespace

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install huespace

## Usage

### image_source

In the following text `image_source` means one of the following:
- path to the image stored locally
- url of the image
- image as a stream of bytes (so you can fetch it once on the backend)

### Extracting a palette of colors
Returns an array of colors, exp. [[47, 48, 62], [91, 92, 117], [218, 154, 95]]

`Huespace.get_palette(image_source, n_colors)`

### Extracting the dominant color
Returns the color that best represents the image

`Huespace.get_dominant_color(image_source)`

### Extracting the most colorful color
Returns the most colorful (probably best described as most vibrant) color from a palette of 6 colors

`Huespace.get_most_colorful_color(image_source)`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
