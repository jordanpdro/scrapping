require 'rubygems'
require 'nokogiri'
require 'open-uri'

# défini la page de départ
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

# Défini le chemin à suivre pour récupérer la valeur (ici adresse mail) qui nous intéresse
def endget_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))
  # localise où trouver l'information dans le fichier HTML
  townhall_mail = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()')
  # passe l'information en String
  townhall_mail = townhall_mail.to_s
  return townhall_mail
end

def get_townhall_urls(page)
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  # localise l'information à chercher
  array_urls = page.xpath("//a[@class='lientxt']/@href")
  # converti chaque information en String
  array_urls = array_urls.map { |url| url.to_s }
  # les 2 lignes suivantes permettent de modifier l'information de façon retourner une URL
  array_urls = array_urls.map { |url| url = url[1..-1] }
  array_urls = array_urls.map { |url| url.prepend("http://annuaire-des-mairies.com") }
  return array_urls
end

def city_mail_association(page)
  array_urls = get_townhall_urls(page)
  # créer un array vide pour accueillir les adresses mails scrappées
  array_mails = []
  # créer un array vide pour accueillir les hashes {nom de ville => adresse mail}
  final_array = []

  for townhall_url in array_urls
    # récupère les adressses mails scrappée avec la méthode endget_townhall_email
    array_mails << endget_townhall_email(townhall_url)
  end

  # modification du String URL pour ne garder que le nom de la ville
  array_urls = array_urls.map { |url| url[35..-6] }

 # Pour chaque ville dans la liste, insérer dans un array le hash {ville => adresse mail correspondant}
  for i in 0...array_urls.size
    final_array << {array_urls[i] => array_mails[i]}
  end

# retourne 10 résultats pour ne pas encombrer ton terminal lors de la correction :)
puts final_array[0..10]
end

city_mail_association(page)
