require_relative '../TwitterWordSearch'
require_relative 'RSSGrabber'
require_relative 'RSSsearch'
require 'pry'

class NbcNewsArticleSearch < RSSGrabber
	include RSS_topic_search

	attr_reader :articles, :followers

	def initialize
		search = TwitterWordSearch.new
		# @articles = get_response("http://rss.cnn.com/rss/cnn_topstories.rss")
		@articles = get_response("http://feeds.nbcnews.com/feeds/topstories")
		@followers = search.get_follower_count("NBCNews")/1000000
		@articles = convert(self.articles)
		@articles.each do |article|
   			article[:source] = "NBC"
   			article[:abstract] = article[:abstract].gsub(/&lt.*/, "")
 		end
	end

end

# nbc = NbcNewsArticleSearch.new

