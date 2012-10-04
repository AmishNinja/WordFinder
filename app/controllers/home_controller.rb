require 'nokogiri'
require 'open-uri'

class HomeController < ApplicationController
  def index

  end

  def crawl
  	@site = params[:site]
  	
  	doc = Nokogiri::HTML(open(@site))
	@output = doc.xpath("//text()").to_s
  	
  	
	render :action => "display"
  end

  def display
  end


end
