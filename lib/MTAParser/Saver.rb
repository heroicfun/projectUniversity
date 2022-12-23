require 'csv'
require 'json'

module MTAParser
  class Saver
      def initialize(data)
        @data = data
      end
    
      def saveCSV()
          CSV.open("iteamMTA.csv", "w") do |csv|
              csv << @data.first.keys 
              @data.each do |row|
                csv << row.values
              end
              puts 'Save csv - Done'
            end
      end
    
      def saveJSON()
          json = @data.to_json
          File.write('iteamMTA.json', json) 
          puts 'Save json - Done'
      end
  end
end
