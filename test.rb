require 'csv'
require 'json'
require 'open-uri'
require 'nokogiri'


print 'Введіть сайт який хочете спарсити: '
url = gets.chomp
page = 1

url = url + page.to_s
html = open(url)
doc = Nokogiri::HTML(html)
iteams = []

for id in 1..24
    title = doc.search("/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[3]/a").text
    price = doc.search("/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[3]/div/div[1]").text
    discount = doc.search("/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[2]/span[1]").text
    cashback = doc.search("/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[5]/button/span").text
    iteams.push(Title: title, Price: price, Discount: discount, Cashback: cashback)
end

CSV.open("iteamMTA.csv", "w") do |csv|
    csv << iteams.first.keys 
    iteams.each do |row|
      csv << row.values
    end
    puts 'Save csv - Done'
end


json = iteams.to_json
File.write('iteamMTA.json', json)
puts 'Save json - Done'