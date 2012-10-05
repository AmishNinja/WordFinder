require 'nokogiri'
require 'open-uri'

class HomeController < ApplicationController
  def index

  end

  def crawl
  	@site = params[:site]
  	
  	#get all non-html text on page as a string, then split it up
  	doc = Nokogiri::HTML(open(@site))
  	doc.css('script').remove
  	doc.xpath("//@*[starts-with(name(), 'on')]").remove
	urlString = doc.xpath("//text()").to_s
	urlString = urlString.gsub(/[^A-Za-z].-/, ' ')
  	tokenized = urlString.split(" ")

  	#create or increment each word
  	tokenized.each do |token|
  		token = token.downcase
  		word = Word.find_by_name(token) || Word.new(:name => token)
  		word.increment!(:count)
  		word.save
  	end

  	# get top 10 words by count
  	@words = Word.all(:limit => 10, :order => "count desc")

	render :action => "display"
  end

  def display
  end


end
