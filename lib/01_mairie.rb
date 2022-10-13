require 'nokogiri'
require 'rubygems'
require 'open-uri'

def scrapper
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/95/ableiges.html"))   
       # => Nokogiri::HTML::Document
end

def fusion_mairie_mail(tab1,tab2)
    return Hash[tab1.zip(tab2)]
end

def mairie(page)
    array_name=[]
    array_mail=[]
    #each do
    #url_array = url_href_array.map {|href| "http://annuaire-des-mairies.com" + href[1..-1]}
    city_name=page.xpath('/html/body/div[1]/main/section[1]/div/div/div/h1')

    # ne prends que les 20 premières valeurs. A la 21 classe style change de display:table-row à display: table-row

    mail=page.xpath('/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]')

    hash={}
    city_name.each{ |c|
        array_name<<c.text
    }
    mail.each{|m|
    array_mail << m.text
    }
    hash=fusion_mairie_mail(city_name,array_mail)
    return hash
end

puts mairie(scrapper)