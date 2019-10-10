require 'rubygems'
require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def list_names(page)
  arr_crypto_names = page.xpath('//tr/td[3]/text()')
  return arr_crypto_names
end

def list_prices(page)
  arr_crypto_prices1 = page.xpath('//tr/td[5]/a/text()')
  arr_crypto_prices = arr_crypto_prices1.map { |price| price.to_s.delete("$").to_f}
  return arr_crypto_prices
end

def currency_value(page)
  currency_name = list_names(page)
  currency_value = list_prices(page)
  final_array = []

  for i in 0...currency_name.size
    final_array << {currency_name[i].to_s => currency_value[i]}
  end
  return final_array
end

list_names(page)
