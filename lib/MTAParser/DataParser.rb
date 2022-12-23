module DataParser
    def parse(doc)
        items = []
  
        for id in 1..48
            title = doc.search(title(id)).text
            price = doc.search(price(id)).text
            discount = doc.search(discount(id)).text
            cashback = doc.search(cashback(id)).text
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

    def title(id)
      return "/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id}]/div/div[3]/a"
    end
  
    def price(id)
        return "/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id}]/div/div[3]/div/div[1]"
    end
  
    def discount(id)
        return "/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id}]/div/div[2]/span[1]"
    end
  
    def cashback(id)
        return "/html/body/div[3]/div/div[1]/main/div/div[2]/div/div[#{id}]/div/div[5]/button/span"
    end
end