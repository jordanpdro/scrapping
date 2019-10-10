require 'rubygems'
require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))


def endget_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))
  townhall_mail = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()')
  townhall_mail = townhall_mail.to_s
  return townhall_mail
end

def get_townhall_urls(page)
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  array_urls = page.xpath("//a[@class='lientxt']/@href")
  array_urls = array_urls.map { |url| url.to_s }
  array_urls = array_urls.map { |url| url = url[1..-1] }
  array_urls = array_urls.map { |url| url.prepend("http://annuaire-des-mairies.com") }
  return array_urls
end

def city_mail_association(page)
  array_urls = get_townhall_urls(page)
  array_mails = []
  final_array = []

  for townhall_url in array_urls
    array_mails << endget_townhall_email(townhall_url)
  end

  array_urls = array_urls.map { |url| url[35..-6] }

  for i in 0...array_urls.size
    final_array << {array_urls[i] => array_mails[i]}
  end

puts final_array
end

city_mail_association(page)
