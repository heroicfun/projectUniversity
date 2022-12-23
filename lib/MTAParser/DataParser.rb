require 'open-uri'
require 'nokogiri'
require 'thread'

require_relative "Saver"

module MTAParser
    class DataParser
      def initialize(url, pageCount)
        @url = url
        @pageCount = pageCount
        @items = []
      end
  
      attr_accessor :items
  
      def parse(doc)
          items = []
  
          for id in 1..48
              title = doc.search(MTAParser.title(id)).text
              price = doc.search(MTAParser.price(id)).text
              discount = doc.search(MTAParser.discount(id)).text
              cashback = doc.search(MTAParser.cashback(id)).text
              items.push(Title: title, Price: price, Discount: discount, Cashback: cashback)
          end
  
          return items
      end
      
      def parse_pages()
          threads = []
          mutex = Mutex.new
  
          for page in 1..@pageCount
              threads << Thread.new {
                html = URI.open("#{@url}/page=#{page}")
                doc = Nokogiri::HTML(html)
                items = parse(doc)
  
                mutex.synchronize do
                  @items.concat(items)
                end
              }
          end
          
          threads.each(&:join)
          puts 'Parse - Done'
      end
  
      def save()
          s = Saver.new(@items)
          s.saveCSV()
          s.saveJSON()
      end
    end
  end