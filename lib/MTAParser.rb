require_relative "MTAParser/version"
require_relative "save"

module MTAParser
  class DataParser
    def initialize(url, pageCount)
      @url = url
      @pageCount = pageCount
      @items = []
    end
  
    def parse()
        items = []

        for id in 1..48
            title = @doc.search("/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[3]/a").text
            price = @doc.search("/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[3]/div/div[1]").text
            discount = @doc.search("/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[2]/span[1]").text
            cashback = @doc.search("/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id.to_s}]/div/div[5]/button/span").text
            items.push(Title: title, Price: price, Discount: discount, Cashback: cashback)
        end

        puts 'Parse - Done'
        return items
    end
    
    def parse_pages()
        threads = []
        mutex = Mutex.new

        for page in 1..pageCount
            threads << Thread.new {
              html = URI.open("#{url}/page=#{page}")
              doc = Nokogiri::HTML(html)
              mutex.synchronize do
                @items.concat(parse_doc(doc))
              end
            }
        end
        
        threads.each(&:join)
        puts 'Parse - Done'
    end

    def save
        s = Save.new(@items)
        s.saveCSV()
        s.saveJSON()
    end
  end
end
