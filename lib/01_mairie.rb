require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'pry'

def scraper
    return page = Nokogiri::HTML(URI.open("https://annuaire-des-mairies.com/finistere.html")) 
end
#Cities url
def get_city_url (page)

    scrap_url = page.xpath('//a[@class="lientxt"]')
    url_array_link = []
    scrap_url.each do |link|
        url_array_link.push(link['href'])
    end
    url_array = url_array_link.map{|href| "http://annuaire-des-mairies.com" + href[1..-1] }
    return url_array
end

#Cities names
def get_city_name(scrap_url)
    city_array_link = []
    scrap_url.each do |name|
        city_array_link.push(name)
    end
    city_array = city_array_link.map{|name|name.gsub('http://annuaire-des-mairies.com/29/', '')}.map {|name| name.gsub('.html', '')}
    return city_array
end

# Cities mails
def get_city_mail(url_array)
    city_email = []
    url_array.each do |email_link|
      email_page = Nokogiri::HTML(URI.open("#{email_link}"))
      scrap_all_email_commune = email_page.xpath('//section[2]/div/table/tbody/tr[4]/td[2]')
      city_email.push(scrap_all_email_commune)
    end 
  
    mail_array = []
  
    city_email.each do |email_link_text|
      mail_array.push(email_link_text.text)
    end  
  return mail_array
end 

def mapping_hash (city_array, mail_array)
    annuaire = []
    array_length = city_array.length

    for i in 0 ..(array_length -1)
        hash = {city_array[i] => mail_array[i]}
        annuaire.push(hash)
    end
    puts annuaire
    return annuaire
    
end

def perform
    url_array = get_city_url(scraper)
    array_name = get_city_name(url_array)
    city_email_text = get_city_mail(url_array)
    mapping_hash(array_name, city_email_text)
end

perform

