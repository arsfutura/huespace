# frozen_string_literal: true
require 'boje'

RSpec.describe Boje do
  it "has a version number" do
    expect(Boje::VERSION).not_to be nil
  end

  it "Prints Something" do
    expect(Boje.print_something).to eq("Something")
  end

end
