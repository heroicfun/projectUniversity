require_relative "lib/MTAParser"

parser = MTAParser::DataParser.new('https://mta.ua/noutbuki', 3)
parser.parse_pages()
parser.save()