require_relative '../lib/dark_trader'

describe "the list_names method" do
  it "should return an array of currencies names not nil" do
    expect(list_names(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))).not_to be_nil
  end
end

describe "the list_prices method" do
  it "should return an array of currencies prices not nil" do
    expect(list_prices(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))).not_to be_nil
  end
end

describe "the currency_value method" do
  it "should return an array of hashes with currencies names and value not nil" do
    expect(currency_value(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))).not_to be_nil
  end
end
