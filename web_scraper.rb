require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

page = HTTParty.get('https://losangeles.craigslist.org/search/lac/apa')
# HTTParty parsing options:
# puts page.body, page.code, page.message, page.headers.inspect
parse_page = Nokogiri::HTML(page)

# push houses to this array
houses_array = []

parse_page.css('.content').css('.row').css('.hdrlnk').map do |a|
	post_name = a.text
	houses_array.push(post_name)
end
# push array to CSV file
CSV.open('houses.csv', 'w') do |csv|
	csv << houses_array
end
#Pry.start(binding)
