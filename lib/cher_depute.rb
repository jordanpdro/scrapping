require 'rubygems'
require 'nokogiri'
require 'open-uri'

main_url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

def get_depute_name(main_url)
  page = Nokogiri::HTML(open(main_url))
  fullname = []
  fullname = page.xpath('//*[@id="deputes-list"]/div/ul/li/a/text()')
  fullname = fullname.map { |depute| depute.to_s }
  #puts fullname[1]
  return fullname
end

def get_firstname(fullname)
  fullname = fullname.map { |depute| depute.downcase.split }
  firstname = fullname.map { |depute| depute = depute[1] } # on obtient array des prenoms
  #puts firstname[0..10]
  return firstname
end

def get_lastname(fullname)
  fullname = fullname.map { |depute| depute.downcase.split }
  lastname = fullname.map { |depute| depute = depute[2..-1].join(" ") } # on obtient array des noms de famille
  lastname = lastname.flatten
  return lastname
end

def get_email(firstname, lastname)

depute_mail = []
  for i in 0...firstname.size
    depute_mail[i] = (firstname[i] + "." + lastname[i].delete(" ") + "@assemblee-nationale.fr")
  end

  depute_mail = depute_mail.map { |mail| mail.tr(
"ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
"AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz") }

puts depute_mail[500..5]
puts depute_mail.size
return depute_mail
end

def full_identity(firstname, lastname, depute_mail)
  final_array = []

  for i in 0...firstname.size
    final_array << {:first_name => firstname[i], :lastname => lastname[i], :email => depute_mail[i]}
  end

  puts final_array[3..10]
  puts final_array.size
end

def perform()
  main_url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
  fullname = get_depute_name(main_url)

  firstname = get_firstname(fullname)
  lastname = get_lastname(fullname)
  depute_mail = get_email(firstname, lastname)

  full_identity(firstname, lastname, depute_mail)
end

perform()
