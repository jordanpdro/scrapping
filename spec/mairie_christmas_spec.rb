require_relative '../lib/mairie_christmas'

describe "endget_townhall_email method" do
  it "should return an email adress from an url" do
    expect(endget_townhall_email(Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/argenteuil.html")))).not_to be_nil
  end
end

describe "get_townhall_urls method" do
  it "should return an array of all cityhall in Val D'Oise urls " do
    expect(get_townhall_urls(Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")))).not_to be_nil
  end
end

describe "city_mail_association method" do
  it "should return an array of hashes with cityhall in Val D'Oise names and email adresses as a value" do
    expect(city_mail_association(Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")))).not_to be_nil
  end
end
