require 'open-uri'
require 'nokogiri'
require 'thread'

require "./save.rb"
require "./IteamToS.rb"

class DataParser
    include IteamToS
    def initialize(url, page = 1)
      @url = url + page.to_s
      @html = open(url)
      @doc = Nokogiri::HTML(@html)
      @page = page
      @iteams = []
    end
  
    def parse()
        for id in 1..24
            title = @doc.search(IteamToS.title(id)).text
            price = @doc.search(IteamToS.price(id)).text
            discount = @doc.search(IteamToS.discount(id)).text
            cashback = @doc.search(IteamToS.cashback(id)).text
            @iteams.push(Title: title, Price: price, Discount: discount, Cashback: cashback)
        end
        puts 'Parse - Done'
    end
    
    def parse_pages()
        items = []
        threads = []
        mutex = Mutex.new
        for page in 1..@page.to_i
            threads << Thread.new {
                @url = url + @page.to_s
                @html = open(@url)
                @doc = Nokogiri::HTML(@html)
                mutex.synchronize do
                    items.concat(parse())
                end
            }
        end
        threads.each(&:join)
        puts 'Parse - Done'
    end

    def save
        s = Save.new(@iteams)
        s.saveCSV()
        s.saveJSON()
    end
end