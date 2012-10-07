require 'nokogiri'
require 'open-uri'

class HomeController < ApplicationController
  def index

  end

  def crawl
  	#validate user input
  	if params[:site] && !params[:site].blank? && self.validUrl?(params[:site])
  		@site = params[:site]
  	else
  		flash[:notice] = "Please enter a valid site (must begin with http:// or https://) to count words from."
  		redirect_to :action => "index"
  		return
  	end
  	
  	#retrieve words for the site, then display the top 10 by count in descending order in the view
  	tokens = self.tokenizeSiteText(@site)
  	site = self.indexOrRetrieveWords(@site.downcase, tokens)
  	@words = Word.all(:conditions => ["site_id = ?", site.id], :limit => 10, :order => "count desc")
	render :action => "display"
  end

  
  #website string regex checker
  def validUrl? (url)
  	return /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/.match(url)
  end

  #get all non-html text on page as a string, then split it up
  def tokenizeSiteText (url)
	doc = Nokogiri::HTML(open(url))
  	doc.css('script').remove
  	doc.xpath("//@*[starts-with(name(), 'on')]").remove
	urlString = doc.xpath("//text()").to_s
	urlString = urlString.gsub(/[^A-Za-z].-/, ' ')
  	return urlString.split(" ")
  end

  def indexOrRetrieveWords (url, tokens)
  	site = Site.find_by_name(url)
  	unless site.nil?
		#just return the site. the words are already there
		return site
	else
		#create site, then create or increment each word, return site
		site = Site.new(:name => url)
		site.save
		tokens.each do |token|
  			token = token.downcase
  			word = Word.find_by_name(token) || Word.new(:name => token, :site_id => site.id)
  			word.increment!(:count)
  			word.save
  		end
  		return site
  	end
  end

  def display
  end

end
