require_relative "MTAParser/DataParser"
require_relative "MTAParser/DataSaver"
require_relative "MTAParser/version"
require 'open-uri'
require 'nokogiri'
require 'thread'

class MTAParser
  include DataParser
  include DataSaver

  def initialize(url, pageCount)
    @url = url
    @pageCount = pageCount
    @items = []
  end

  def parse_and_save()
    parse_pages()
    save()
  end

  def save()
    saveCSV()
    saveJSON()
  end
end