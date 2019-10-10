require 'rubygems'
require 'nokogiri'
require 'open-uri'

# défini la page qui regroupe les noms des députés et liens vers leurs informations
main_url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

def get_depute_name(main_url)
  page = Nokogiri::HTML(open(main_url))
  # récupérer le nom et prénom de chaque député, et les inserer dans un array, au format String
  fullname = []
  fullname = page.xpath('//*[@id="deputes-list"]/div/ul/li/a/text()')
  fullname = fullname.map { |depute| depute.to_s }
  return fullname
end

# Modifier le array pour ne garder que le prénom
def get_firstname(fullname)
  # pour chaque itération du array, réduire en lower case et séparer en sous arrays [m.][prénom][nom][nom composé]
  fullname = fullname.map { |depute| depute.downcase.split }
  # on obtient array des prenoms
  firstname = fullname.map { |depute| depute = depute[1] }
  return firstname
end

# Même principe que méthode précédente mais pour garder seulement le nom de famille
def get_lastname(fullname)
  fullname = fullname.map { |depute| depute.downcase.split }
  # on obtient array des noms de famille
  lastname = fullname.map { |depute| depute = depute[2..-1].join(" ") }
  lastname = lastname.flatten
  return lastname
end

# On cherche à recréer les adresses email qui sont au format prenom.nom@assemblee-nationale.fr
def get_email(firstname, lastname)

# Créer array vide qui va recevoir les adresses mails
depute_mail = []

  for i in 0...firstname.size
    # Pour chaque depute scrappé, on concatène pour avoir un String recréant son adresse mail
    depute_mail[i] = (firstname[i] + "." + lastname[i].delete(" ") + "@assemblee-nationale.fr")
  end

# Pour retirer les accents
  depute_mail = depute_mail.map { |mail| mail.tr(
"ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
"AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz") }

return depute_mail
end

# On va regrouper toutes ces information dans un array de hashes
def full_identity(firstname, lastname, depute_mail)
  final_array = []

  for i in 0...firstname.size
    final_array << {:first_name => firstname[i], :lastname => lastname[i], :email => depute_mail[i]}
  end

puts final_array
return final_array
end

# Executons toutes les méthodes !
def perform()
  main_url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
  fullname = get_depute_name(main_url)
  firstname = get_firstname(fullname)
  lastname = get_lastname(fullname)
  depute_mail = get_email(firstname, lastname)
  full_identity(firstname, lastname, depute_mail)
end

perform()
