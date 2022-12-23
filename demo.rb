require_relative "lib/MTAParser"

parser = MTAParser.new('https://mta.ua/noutbuki', 3)
parser.parse_and_save()