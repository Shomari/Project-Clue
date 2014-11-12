require_relative '../TwitterWordSearch'
require_relative 'RSSGrabber'
require_relative 'RSSsearch'

class CbsNewsArticleSearch < RSSGrabber
	include RSS_topic_search

	attr_reader :articles, :followers

	def initialize
		search = TwitterWordSearch.new
		@articles = get_response("http://www.cbsnews.com/latest/rss/main")
		@followers = search.get_follower_count("CBSNews")/1000000
		@articles = convert(self.articles)
		@articles.map! do |article|
   			article[:source] = "CBS"
 		end 
	end

end
