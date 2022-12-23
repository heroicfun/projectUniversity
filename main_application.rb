require "./DataParser.rb"

class Main_application
  def initialize(url)
    @url = url
  end

  def start(page = 1)
    parser = DataParser.new(@url, page)
    parser.parse()
    parser.save()
  end

end
