require "spec_helper"

RSpec.describe Petitest::Assertions do
  it "has a version number" do
    expect(Petitest::Assertions::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
