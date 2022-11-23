# frozen_string_literal: true
require 'boje'

RSpec.describe Boje do
  it "Loads image from url" do
    expect(Boje::Extractor.load_image_from_url('test.jpeg')).to eq("JPEG")
  end

end
