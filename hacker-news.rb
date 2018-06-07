require 'httparty'

def call_api(num)
	top_stories_url = "https://clone-hackernews.herokuapp.com/articles/api?count=#{num}&type=topstories"
	articles = JSON.parse(HTTParty.get(top_stories_url).body)
	return articles
end
p 'enter a topic or browse hacker news'
input = STDIN.gets.chomp

topic_found = false
num = 30

unless input == 'browse'
	while topic_found == false do
	articles = call_api(num)
		articles.each do |article|
			if article['title'] == topic.capitalize
				topic_found = true
			else
				num += 30 
				call_api(num)
			end
		end
	end
end

if input == 'browse'
	articles = call_api(num)
	articles.each do |article|
		p "*" * article['title'].length
		puts article['title']
		puts article['url']
		if article['kids']
			puts "#{article['kids'].length} comments"
		end
		puts "points: #{article['score']}"
		p "-" * article['title'].length
	end
end
