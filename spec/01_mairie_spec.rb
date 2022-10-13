require_relative '../lib/01_mairie'

describe "test 2 Cities" do
  it "trouve combrit" do
    expect(city_array).to include("combrit")
  end

  it "trouve fouesnant" do
    expect(mapping_hash(array_name, city_email_text)).to include("fouesnant")
  end

end