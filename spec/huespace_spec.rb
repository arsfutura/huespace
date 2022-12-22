# frozen_string_literal: true
require 'huespace'

RSpec.describe Huespace do
  it "Loads image from url" do
    expect(Huespace::Extractor.load_image_from_url('test.jpeg')).to eq("JPEG")
  end

end
