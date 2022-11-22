# frozen_string_literal: true

require "mini_magick"
require "kmeans-clusterer"

module Boje
  class Extractor
    def self.load_image_from_url(url)
      @image = MiniMagick::Image.open(url)
      @image.resize('150x150')
    end
    
    def self.load_image_from_blob(blob)
      @image = MiniMagick::Image.read(blob)
      @image.resize('150x150')
    end
    
    def self.extract_colors(n)
      raise "No Image: load image before extracting using load_image_from_url or load_image_from_blob" if @image == nil

      pixels = @image.get_pixels.flatten(1)
      clusters = KMeansClusterer.run(n, pixels, runs: 3, max_iter: 300).clusters
      centroids = clusters.map { |cluster| cluster.centroid.to_a}

      return centroids.map { |centroid| centroid.map { |n| n.round() }}
    end

    def self.extract_most_vibrant_color()
      colors = self.extract_colors(6)

      # Here we sort by "colorfulness", using the following formula:
      # (max + min) * (max - min)) / max
      # max and min represent one of the rgb values
      # More about this here: http://changingminds.org/explanations/perception/visual/colourfulness.htm
      return colors.sort_by { |color| ((color.max + color.min) * (color.max - color.min)) / color.max }.last()
    end

  end
end