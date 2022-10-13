require 'nokogiri'
require 'rubygems'
require 'open-uri'


def scrapper
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))   
#puts page   # => Nokogiri::HTML::Document
end

def fusiontab(tab1,tab2)
    return Hash[tab1.zip(tab2)]
end

def crypto(page)
    array_name=[]
    array_value=[]
    name_of_crypto=page.xpath('//tr//td[3]')
    # ne prends que les 20 premières valeurs. A la 21 classe style change de display:table-row à display: table-row

    value_of_crypto=page.xpath('//tr//td[5]')
    hash={}
    name_of_crypto.each{ |name|
        array_name<<name.text
    }
    value_of_crypto.each{|price|
    array_value << price.text
    }
    hash=fusiontab(array_name,array_value)
    return hash
end

puts crypto(scrapper)