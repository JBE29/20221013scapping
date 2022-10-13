require 'nokogiri'
require 'rubygems'
require 'open-uri'
require 'json'


def scrapper
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))   
#puts page   # => Nokogiri::HTML::Document
end

def fusiontab(tab1,tab2)
    return Hash[tab1.zip(tab2)]
end

def crypto(page)
    my_json = JSON.parse(page.css('script[type="application/json"]').first.inner_html)
    cryptos = my_json["props"]["initialState"]["cryptocurrency"]["listingLatest"]["data"]
  
    hash = cryptos.each_with_object({}) do |crypto, hsh|
      hsh[crypto["name"]] = crypto["quote"]["USD"]["price"]
    end
end

puts crypto(scrapper)