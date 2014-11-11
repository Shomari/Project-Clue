require 'rubygems'
require 'active_record'
require 'pg'
require_relative '../PopularitySearch'
require_relative '../../app/models/article'


ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:database => 'Clue_development'
	)

module RSS_topic_search

	def find_articles_by_topic(topic)
		puts "inside method"
		matches = []
		self.articles.each do |article|
			if article.abstract == nil
       	article[:abstract] = "a"
      end
			matches << article if article.title.downcase.include?(topic.downcase) || article.abstract.downcase.include?(topic.downcase)
		end
		return matches
	end

	def convert(raw_articles)
		raw_articles.each do |story|
			article = Article.new
			article.title = story[:title]
			article.url = story[:guid]
			article.abstract = story[:description].match(/.*[.][&]/).to_s
			article.published_at = story[:pubDate]
			popularity_client = PopularitySearch.new
		  popularity_client.set_params(article.url)
		  article.twitter_popularity = popularity_client.get_twitter_popularity
		  article.facebook_popularity = popularity_client.get_facebook_popularity
			
		end
	end
end

