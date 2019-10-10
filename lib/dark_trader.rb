require 'rubygems'
require 'nokogiri'
require 'open-uri'

# définir la page à scrapper
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def list_names(page)
  # lister dans un array toutes les valeurs trouvée dans la 3e colonne (symbol) du tableau HTML
  arr_crypto_names = page.xpath('//tr/td[3]/text()')
  return arr_crypto_names
end

def list_prices(page)
  # lister dans un array toutes les valeurs trouvée dans la 5e colonnes(price) du tableau HTML
  arr_crypto_prices1 = page.xpath('//tr/td[5]/a/text()')
  # transformer cette valeur en string pour pouvoir retirer le '$' puis la reconvertir en float
  arr_crypto_prices = arr_crypto_prices1.map { |price| price.to_s.delete("$").to_f}
  return arr_crypto_prices
end

def currency_value(page)
  currency_name = list_names(page)
  currency_value = list_prices(page)
  # créer un array vide qui va accueillir les hashes de noms/prix
  final_array = []

# pour chaque element de la liste, on crée un hash {nom monnaie => valeur monnaie} puis on l'insère dans notre array
  for i in 0...currency_name.size
    final_array << {currency_name[i].to_s => currency_value[i]}
  end

  # Pour éviter de faire tourner ton ordi trop longtemps je limite l'affichage aux 10 premières valeurs de cet array :)
  puts final_array[0..10]
  return final_array
end

currency_value(page)
