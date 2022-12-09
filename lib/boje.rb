# frozen_string_literal: true


module Boje
  require "mini_magick"
  require "./lib/boje/median_cut.rb"

  # Returns n_colors most representative colors from given image
  def Boje.get_palette(image_source, n_colors)
    pixels = Boje.load_image(image_source)
    
    sampled_pixels, hist = Boje.sample_pixels(pixels, 10)
    Boje::MedianCut.process(sampled_pixels, n_colors, hist)
  end

  # Returns most colorful color from the palette
  # This is achieved by sorting using the following formula:
  # (max + min) * (max - min)) / max
  # max and min represent one of the rgb values
  # More about this here: http://changingminds.org/explanations/perception/visual/colourfulness.htm
  def Boje.get_most_colorful_color(image_source)
    colors = Boje.get_palette(image_source, 6)

    return colors.sort_by { |color| ((color.max + color.min) * (color.max - color.min)) / color.max }.last()
  end

  # Returns most representative color from the image
  def Boje.get_dominant_color(image_source)
    colors = Boje.get_palette(image_source, 5)

    return colors[0]
  end

  private
    def Boje.load_image(image_source)
      begin
        image = MiniMagick::Image.open(image_source)
      rescue TypeError
        # Extract from stream
        image = MiniMagick::Image.read(image_source) # 
      rescue StandardError => e
        raise "Invalid URL!"
      end

      image.get_pixels.flatten(1)
    end

    # Higher number = lower quality
    def Boje.sample_pixels(pixels, quality=20)
      sampled_pixels = [];
      hist = Hash.new(0)

      (0..pixels.length - 1).step(quality).each do |i|
          # If pixel is not white
          sampled_pixels << pixels[i] unless (pixels[i][0] > 250 && pixels[i][1] > 250 && pixels[i][2] > 250)
          hist[get_pixel_index(pixels[i])] += 1
      end

      [sampled_pixels, hist]
    end

    def Boje.get_pixel_index(pixel)
      return pixel[0] << 10 + pixel[1] << 5 + pixel[2]
    end

    # Round to 5x5x5 pixel block
    # def Boje.get_pixel_index(pixel)
    #   return (pixel[0] / 5) + (pixel[1] / 5) + (pixel[2] / 5)
    # end
end