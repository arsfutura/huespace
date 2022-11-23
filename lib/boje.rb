# frozen_string_literal: true

require "mini_magick"
require "kmeans-clusterer"
require "base64"

module Boje

  def Boje.get_palette(image_source, n_colors)

    # image = MiniMagick::Image.open(image_source)
    # image.resize('150x150')
    
    # Extract from stream or blob
    image = MiniMagick::Image.read(image_source) # 
    image.resize('150x150')
    
    pixels = image.get_pixels.flatten(1)
    clusters = KMeansClusterer.run(n_colors, pixels, runs: 3, max_iter: 300).clusters
    centroids = clusters.map { |cluster| cluster.centroid.to_a}

    return centroids.map { |centroid| centroid.map { |n| n.round() }}
  end

  # Returns most colorfull color from the palette
  # This is achieved by sorting using the following formula:
  # (max + min) * (max - min)) / max
  # max and min represent one of the rgb values
  # More about this here: http://changingminds.org/explanations/perception/visual/colourfulness.htm
  def Boje.get_most_colorfull_color(image_source)
    colors = get_palette(image_source, 6)

    return colors.sort_by { |color| ((color.max + color.min) * (color.max - color.min)) / color.max }.last()
  end

  # Returns most representative color from the image
  def Boje.get_dominant_color(image_source)
    puts "Not Implemented!"
  end
end