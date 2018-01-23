class WelcomeController < ApplicationController
  def index
  require 'nokogiri'
	require 'open-uri'
	
	request_uri=URI.parse('https://www.shopinle.com/')
	output = open(request_uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE})
	
	
	page = Nokogiri::HTML(output)  
	page=page.at('ul[class="slides owl-carousel"]')
	
	
	lis=page.search('li')
	a_resim=Array.new
	a_aciklama=Array.new
	a_fiyat_ilk=Array.new
	a_fiyat_son=Array.new
	
	lis.each do |liis|
		
		res=liis.css('img').map{ |i| i['src'] }
		aciklama=liis.css('img').map{ |i| i['alt'] }
		fiyat_ilk=liis.search('span[class="price-discounted"]').text
		fiyat_son=liis.search('span[class="price-current"]').text
		
		
		
		a_resim.push(res)
		a_aciklama.push(aciklama)
		a_fiyat_ilk.push(fiyat_ilk)
		a_fiyat_son.push(fiyat_son)
		
	  
	end
	
	@resimler=a_resim
	@aciklamalar=a_aciklama
	@fiyatlar_ilk=a_fiyat_ilk
	@fiyatlar_son=a_fiyat_son
	
	
  end
end
