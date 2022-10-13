require_relative '../lib/00_crypto'
#not an error if return empty
#verify presence of 2 or 3 cryptos

describe "test 3 currencies" do
  it "knows BTC" do
    expect(crypto(scrapper)).to include("BTC")
  end

  it "knows ETH" do
    expect(crypto(scrapper)).to include("ETH")
  end

  it "knows HBAR" do
    expect(crypto(scrapper)).to include("HBAR")
  end

end